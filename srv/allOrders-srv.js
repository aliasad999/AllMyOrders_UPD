const express = require('express');
const cds = require("@sap/cds");
const NodeCache = require('node-cache');
const sessionCache = new NodeCache();


module.exports = cds.service.impl(async (service) => {
    service.on("READ", "Results", async (req, next) => {
        const db = cds.transaction(req);
        req.query._suppressLocalization = true
        req.query.distinct = true
        req.query.SELECT.limit.rows.val = 100000000;
        let lt_result = await cds.run(req.query);
        let sessionID = req.headers['authorization'] || req.headers['x-username']; 
        if (req.query.SELECT.columns[0].as !== '$count' ) {
            const selectedField = req._query && req._query['$select']
            const fields = selectedField && selectedField.split(',');
            let consolidatedResults = removeDuplicates(fields, lt_result);
            let lt_result_final = [...new Set(consolidatedResults.map(JSON.stringify))].map(JSON.parse);
            const resultString = JSON.stringify(lt_result);
            const queryString = JSON.stringify(req.query);
            const queryId = `${sessionID}Query`
            sessionCache.set(sessionID, resultString);
            sessionCache.set(queryId, queryString);
            return lt_result_final;
        }
        return lt_result
    });

    service.on("READ", "valueHelps", async (req, next) => {
        let sessionID = req.headers['authorization'] || req.headers['x-username']; 
        const queryId = `${sessionID}Query`
        let lt_result = []
        if (req.query.SELECT.search) {
            req.query._suppressLocalization = true
            req.query.distinct = true
            req.query.SELECT.limit.rows.val = 100000000;
            lt_result = await cds.run(req.query);
        } else if(sessionCache.get(sessionID)) {
            const resultString = sessionCache.get(sessionID);
            lt_result = JSON.parse(resultString);
        } else {
             lt_result = await cds.run(req.query);
        }
            const selectedField = req._query && req._query['$select'] ;
            
            const fields = selectedField && selectedField.split(',');
            let lt_result_final = removeDuplicates(fields, lt_result);
            if (req.query.SELECT.columns[0].as !== '$count'  && req.query.SELECT.search) {
                 lt_result_final = lt_result_final.filter((item)=>{
                    for (const prop in item) {
                          if (item[prop] === null) return false;  
                          if (item[prop].includes(req.query.SELECT.search[0].val)) {
                            return true;
                          }
                        }
                        return false;
                      
                 });
            }
            return lt_result_final;
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
        lt_result = lt_result.map((obj) => (obj));
    }
    let lt_result_final = [...new Set(lt_result.map(JSON.stringify))].map(JSON.parse);
    return lt_result_final;
}