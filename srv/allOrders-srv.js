const cds = require("@sap/cds");

module.exports = cds.service.impl(async (service) => {
    service.on("READ", "Results", async (req, next) => {
        const db = cds.transaction(req);
        req.query._suppressLocalization = true
        req.query.distinct = true
        let results = await cds.run(req.query);
        console.log(`route is ${req.headers.referer}`)
        if (results.length != 1) {
            const selectedField = req._query && req._query['$select']
            const fields = selectedField && selectedField.split(',');
            if (fields) {
                results = results.map(obj => {
                    const newObj = {};
                    fields.forEach(field => newObj[field] = obj[field]);
                    return newObj;
                });
            } else {
                results = results.map((obj) => (obj));
            }
            const resultsCol = [...new Set(results.map(JSON.stringify))].map(JSON.parse);
            return resultsCol;
        }
        return results
        
        

    })
})