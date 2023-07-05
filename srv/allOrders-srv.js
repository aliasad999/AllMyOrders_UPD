const express = require('express');
const cds = require("@sap/cds");
const NodeCache = require('node-cache');
const sessionCache = new NodeCache();
const uuid = require('uuid');


module.exports = cds.service.impl(async (service) => {
    service.before("READ", "Results", async (req, next) => {
        req.query._suppressLocalization = true
        req.query.SELECT.distinct = true
    });
    service.after("READ", "Results", async (data, req) => {
        let lt_count = 0;
        let sessionID = req.headers['authorization'] || req.headers['x-username'];
        if (req.query.SELECT.columns[0].as === '$count' && req.headers?.select) {
            const queryCount = `${sessionID}QueryCount`
            const db = cds.transaction(req);
            const fields = req.headers.select.split(',')

            lt_count = await db.run(SELECT.distinct(true).from('srvOpenOrders_Results').columns(...fields, `count(*)`).groupBy(...fields).where(req.query.SELECT.where))
            sessionCache.set(queryCount, lt_count.length);
            if (data.length) data[0].$count = lt_count.length;
        } else {

            const queryString = JSON.stringify(req.query);
            const queryId = `${sessionID}Query`
            sessionCache.set(queryId, queryString);
        }
        if (Array.isArray(data)) {
            data.forEach((item) => {
                item.id = uuid.v1()

            })
        }
    });
    service.on("READ", "valueHelps", async (req, next) => {
        let sessionID = req.headers['authorization'] || req.headers['x-username'];
        const queryId = `${sessionID}Query`
        const queryCount = `${sessionID}QueryCount`
        let lt_result = []
        if (sessionCache.get(queryId)) {
            const queryString = sessionCache.get(queryId);
            const query = JSON.parse(queryString);
            query.SELECT.limit.rows.val = req.query.SELECT.limit.rows?.val;
            query.SELECT.distinct = true;
            query.SELECT.search = req.query.SELECT.search;
            if (query.SELECT.limit.offset.val) query.SELECT.limit.offset.val = req.query.SELECT.limit.offset?.val || 0;
            if (req.query.SELECT.columns[0].as !== '$count') {
                query.SELECT.columns.length = 0;
                query.SELECT.columns = req.query.SELECT.columns;
                query.SELECT.orderBy.length = 0;
                query.SELECT.orderBy = req.query.SELECT.orderBy;
                lt_result = await cds.run(query);
                const selectedField = req._query && req._query['$select']
                const fields = selectedField && selectedField.split(',');
                lt_result = removeDuplicates(fields, lt_result);
            } else {
                const db = cds.transaction(req);
                let lt_count = await db.run(SELECT.distinct(true).from('srvOpenOrders_Results').columns(req._query["search-focus"], `count(*)`).groupBy(req._query["search-focus"]).where(query.SELECT.where))
                lt_count = removeDuplicates([req._query["search-focus"]], lt_count);
                lt_result.push({ $count: lt_count.length })
            }
            
        } else {
            if (req.query.SELECT.columns[0].as !== '$count') {
                req.query.SELECT.distinct = true;
                lt_result = await cds.run(req.query);
            } else {
                const db = cds.transaction(req);
                let lt_count = await db.run(SELECT.distinct(true).from('srvOpenOrders_Results').columns(req._query["search-focus"], `count(*)`).groupBy(req._query["search-focus"]))
                lt_count = removeDuplicates([req._query["search-focus"]], lt_count);
                lt_result.push({ $count: lt_count.length })
            }
        }
        if (req.query.SELECT.columns[0].as !== '$count' && req.query.SELECT.search) {
            lt_result = lt_result.filter((item) => {
                for (const prop in item) {
                    if (item[prop] === null) return false;
                    if (item[prop].includes(req.query.SELECT.search[0].val)) {
                        return true;
                    }
                }
                return false;

            });
        }
        return lt_result;
    })
    service.after("READ", "valueHelps", async (data, req) => {
        if (Array.isArray(data)) {
            data.forEach((item) => {
                item.id = uuid.v1()
            })
        }
    })
})

function removeDuplicates(fields, lt_result) {
    if (fields) {
        lt_result = lt_result.map(obj => {
            const newObj = {};
            fields.forEach(field => newObj[field] = obj[field]);
            return newObj;
        });
    } else {
        // lt_result = lt_result.map((obj) => (obj));
    }
    let lt_result_final = [...new Set(lt_result.map(JSON.stringify))].map(JSON.parse);
    return lt_result_final;
}