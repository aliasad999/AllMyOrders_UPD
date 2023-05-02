using {allorders.db.ORDERS as Orders} from '../db/allOrders.cds';

service srvOpenOrders {
    @readonly
    entity Results as
       select distinct  * from Orders ;

}

