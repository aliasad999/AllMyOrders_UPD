const express = require('express');
const cds = require("@sap/cds");
const NodeCache = require('node-cache');
const sessionCache = new NodeCache();
const uuid = require('uuid');
const { part } = require('hdb/lib/protocol');

class srvOpenOrders extends cds.ApplicationService {
    init() {
        this.before("READ", "Results", async (req, next) => {
            req.query._suppressLocalization = true
            req.query.SELECT.distinct = true

        });

        this.on("READ", "Results", async (req, next) => {
            if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count' && req.headers?.select) {

                const db = cds.transaction(req);
                const fields = req.headers.select.split(',')
                const lt_count = await db.run(SELECT.distinct(true).from('srvOpenOrders_Results').columns(`count(*)`).groupBy(...fields).where(req.query.SELECT.where))
                let lt_result = []
                lt_result.push({ $count: lt_count.length })

            }

            // Consider also partner settings, if they are maintained
            let db = cds.transaction(req);
            let currentUser = req.headers['active-user']
            if (currentUser) {
                let partnerSettingsQuery = cds.parse.cql(`SELECT from srvOpenOrders_PartnerSettings where BASF_USER = '${currentUser}' and ACTIVE = 'X'`);
                let partnerSettings = await db.run(partnerSettingsQuery);
                if (partnerSettings.length !== 0) {
                    let VEPartners = [];
                    let ASPartners = [];
                    let AMPartners = [];
                    for (let settingsEntry of partnerSettings) {
                        let partnerNumber = settingsEntry.PARTNER_NUMBER;
                        switch (settingsEntry.PARTNER_ROLE) {
                            case 'VE':
                                VEPartners.push(`VE_PARTNER = ${partnerNumber}`);
                                break;

                            case 'AS':
                                ASPartners.push(`AS_PARTNER = ${partnerNumber}`);
                                break;

                            case 'AM':
                                AMPartners.push(`AM_PARTNER = ${partnerNumber}`);
                                break;
                            default:
                                break;
                        }
                    }

                    // Construct queries 
                    let VEQuery = VEPartners.length !== 0 ? cds.parse.expr(VEPartners.join(' or ')) : null;
                    let ASQuery = ASPartners.length !== 0 ? cds.parse.expr(ASPartners.join(' or ')) : null;
                    let AMQuery = AMPartners.length !== 0 ? cds.parse.expr(AMPartners.join(' or ')) : null;

                    // Add queries to request
                    let requestQuery = req.query.SELECT.where;
                    VEQuery && requestQuery.push('and');
                    VEQuery && requestQuery.push(VEQuery);
                    ASQuery && requestQuery.push('and');
                    ASQuery && requestQuery.push(ASQuery);
                    AMQuery && requestQuery.push('and');
                    AMQuery && requestQuery.push(AMQuery);
                }
            }

            await next();
        });

        this.after("READ", "Results", async (data, req) => {

            let sessionID = req.headers['authorization'] || req.headers['x-username'];
            if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count' && req.headers?.select) {

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
        this.on("READ", "valueHelps", async (req, next) => {
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
        this.after("READ", "valueHelps", async (data, req) => {
            if (Array.isArray(data)) {
                data.forEach((item) => {
                    item.id = uuid.v1()
                })
            }
        })


        return super.init();
    }
}

module.exports = {
    srvOpenOrders
}


// module.exports = cds.service.impl(async (service) => {
//     service.before("READ", "Results", async (req, next) => {
//         req.query._suppressLocalization = true
//         req.query.SELECT.distinct = true

//     });
//     service.on("READ", "Results", async (req, next) => {
//         if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count' && req.headers?.select) {

//             const db = cds.transaction(req);
//             const fields = req.headers.select.split(',')
//             const lt_count = await db.run(SELECT.distinct(true).from('srvOpenOrders_Results').columns(`count(*)`).groupBy(...fields).where(req.query.SELECT.where))
//             let lt_result = []
//             lt_result.push({ $count: lt_count.length })

//         }

//         // Consider also partner settings, if they are maintained
//         let db = cds.transaction(req);
//         let currentUser = req.headers['active-user']
//         if (currentUser) {
//             let partnerSettingsQuery = cds.parse.cql(`SELECT from srvOpenOrders_PartnerSettings where BASF_USER = '${currentUser}' and ACTIVE = 'X'`);
//             let partnerSettings = await db.run(partnerSettingsQuery);
//             if (partnerSettings.length !== 0) {
//                 let VEPartners = [];
//                 let ASPartners = [];
//                 let AMPartners = [];
//                 for (let settingsEntry of partnerSettings) {
//                     let partnerNumber = settingsEntry.PARTNER_NUMBER;
//                     switch (settingsEntry.PARTNER_ROLE) {
//                         case 'VE':
//                             VEPartners.push(`VE_PARTNER = ${partnerNumber}`);
//                             break;

//                         case 'AS':
//                             ASPartners.push(`AS_PARTNER = ${partnerNumber}`);
//                             break;

//                         case 'AM':
//                             AMPartners.push(`AM_PARTNER = ${partnerNumber}`);
//                             break;
//                         default:
//                             break;
//                     }
//                 }

//                 // Construct queries 
//                 let VEQuery = VEPartners.length !== 0 ? cds.parse.expr(VEPartners.join(' or ')) : null;
//                 let ASQuery = ASPartners.length !== 0 ? cds.parse.expr(ASPartners.join(' or ')) : null;
//                 let AMQuery = AMPartners.length !== 0 ? cds.parse.expr(AMPartners.join(' or ')) : null;

//                 // Add queries to request
//                 let requestQuery = req.query.SELECT.where;
//                 VEQuery && requestQuery.push('and');
//                 VEQuery && requestQuery.push(VEQuery);
//                 ASQuery && requestQuery.push('and');
//                 ASQuery && requestQuery.push(ASQuery);
//                 AMQuery && requestQuery.push('and');
//                 AMQuery && requestQuery.push(AMQuery);
//             }
//         }

//         await next();
//     });
//     service.after("READ", "Results", async (data, req) => {

//         let sessionID = req.headers['authorization'] || req.headers['x-username'];
//         if (req.query.SELECT.columns && req.query.SELECT?.columns[0].as === '$count' && req.headers?.select) {

//         } else {

//             const queryString = JSON.stringify(req.query);
//             const queryId = `${sessionID}Query`
//             sessionCache.set(queryId, queryString);
//         }
//         if (Array.isArray(data)) {
//             data.forEach((item) => {
//                 item.id = uuid.v1()

//             })

//         }




//     });
//     service.on("READ", "valueHelps", async (req, next) => {
//         let sessionID = req.headers['authorization'] || req.headers['x-username'];
//         const queryId = `${sessionID}Query`
//         const queryCount = `${sessionID}QueryCount`
//         let lt_result = []
//         if (sessionCache.get(queryId)) {
//             const queryString = sessionCache.get(queryId);
//             const query = JSON.parse(queryString);
//             query.SELECT.limit.rows.val = req.query.SELECT.limit.rows?.val;
//             query.SELECT.distinct = true;
//             query.SELECT.search = req.query.SELECT.search;
//             if (query.SELECT.limit.offset.val) query.SELECT.limit.offset.val = req.query.SELECT.limit.offset?.val || 0;
//             if (req.query.SELECT.columns[0].as !== '$count') {
//                 query.SELECT.columns.length = 0;
//                 query.SELECT.columns = req.query.SELECT.columns;
//                 query.SELECT.orderBy.length = 0;
//                 query.SELECT.orderBy = req.query.SELECT.orderBy;
//                 lt_result = await cds.run(query);
//                 const selectedField = req._query && req._query['$select']
//                 const fields = selectedField && selectedField.split(',');
//                 lt_result = removeDuplicates(fields, lt_result);
//             } else {
//                 const db = cds.transaction(req);
//                 let lt_count = await db.run(SELECT.distinct(true).from('srvOpenOrders_Results').columns(req._query["search-focus"], `count(*)`).groupBy(req._query["search-focus"]).where(query.SELECT.where))
//                 lt_count = removeDuplicates([req._query["search-focus"]], lt_count);
//                 lt_result.push({ $count: lt_count.length })
//             }

//         } else {
//             if (req.query.SELECT.columns[0].as !== '$count') {
//                 req.query.SELECT.distinct = true;
//                 lt_result = await cds.run(req.query);
//             } else {
//                 const db = cds.transaction(req);
//                 let lt_count = await db.run(SELECT.distinct(true).from('srvOpenOrders_Results').columns(req._query["search-focus"], `count(*)`).groupBy(req._query["search-focus"]))
//                 lt_count = removeDuplicates([req._query["search-focus"]], lt_count);
//                 lt_result.push({ $count: lt_count.length })
//             }
//         }
//         if (req.query.SELECT.columns[0].as !== '$count' && req.query.SELECT.search) {
//             lt_result = lt_result.filter((item) => {
//                 for (const prop in item) {
//                     if (item[prop] === null) return false;
//                     if (item[prop].includes(req.query.SELECT.search[0].val)) {
//                         return true;
//                     }
//                 }
//                 return false;

//             });
//         }
//         return lt_result;
//     })
//     service.after("READ", "valueHelps", async (data, req) => {
//         if (Array.isArray(data)) {
//             data.forEach((item) => {
//                 item.id = uuid.v1()
//             })
//         }
//     })
// })

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