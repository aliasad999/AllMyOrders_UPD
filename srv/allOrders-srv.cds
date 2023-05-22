using {allorders.db as db} from '../db/allOrders.cds';


service srvOpenOrders {
    @readonly
    entity Results as
       select distinct  * from db.ORDERS ;
    
    entity valueHelps as
       select distinct  * from db.ORDERS ;
    

}

