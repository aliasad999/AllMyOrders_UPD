using srvOpenOrders as service from '../srv/allOrders-srv';

annotate service.Results with @Capabilities : {
   FilterRestrictions : {
      FilterExpressionRestrictions :
         [{
            Property : 'CreatedOn',
            AllowedExpressions : 'SingleRange'
         }]
      }
};

annotate service.Results with @(
	UI: {
		SelectionFields: [ CreatedOn,SalesOrgName,SoldtoPartyName,ShipToPartyName,SalesOrder,LEVEL_TYPE,ORDER_STATUS ],

	}
);
annotate service.Results with @UI.LineItem : {
			![@UI.Criticality] : 5,
			$value:  [
			{Value: SalesOrder},
			{Value: NEXT_ORDER},
			{Value: FINAL_ORDER},
			{Value: SalesOrderItem},
			{Value: CreatedOn},
			{Value: LEVEL_TYPE},
			{
            $Type             : 'UI.DataField',
            Value             : ORDER_STATUS,
            ![@UI.Importance] : #High,
			Criticality		  : 2,
			CriticalityRepresentation: #WithoutIcon
        },
			
			{Value: MaterialName},
			{Value: MaterialNo},
			{Value: BILLING_BLOCK_ITEM},
			{Value: LC_NUMBER},
			{Value: CREATION_DATE},
			{Value: CustomerReference},
			{Value: DELIVERY_TYPE},
			{Value: CUSTOMER_MAT_REFERENCE},
			{Value: STORAGE_LOCATION},
			{Value: Plant},
			{Value: BILLING_DOCUMENT},
			{Value: CONFIRMED_QUANTITY},
			{Value: PENDING_DEL_QTY},
			{Value: PENDING_DEL_QTY_UNIT},
			{Value: UNCONFIRMED_QUANTITY},
			{Value: SUPPLY_SITUATION},
			{Value: DELIVERY_QTY},
			{Value: PRICING_DATE},
			{Value: BILLING_DOCUMENT},
			{Value: CO_PARTNER},
			{Value: CO_PARTNER_NAME},
			{Value: NY_PARTNER},
			{Value: NY_PARTNER_NAME},
			{Value: PRICE_PER_UNIT},
			{Value: NET_AMOUNT},
			{Value: ShipmentATA},
			{Value: ShipmentATD},
			{Value: BATCH_NUMBER},
			{Value: NOTA_FISCAL},
			{Value: AM_PARTNER},
			{Value: AM_PARTNER_NAME},
			{Value: HOM_REMARK},
			{Value: ITEM_CATEGORY},
			{Value: MRP_CONTROLLER},
			{Value: SHIP_TO_COUNTRY_NAME},
			{Value: DIFF_CONF_REQ_DATE},
			{Value: SHIP_TO_CITY_NAME},
			{Value: PROD_ALLOC},

		]
};