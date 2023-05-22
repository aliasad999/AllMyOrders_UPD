namespace allorders.db;

@cds.persistence.exists

entity![ORDERS]{
          virtual id                : String;
       key![SalesOrder]             : String(50);
       key![SalesOrderItem]         : String(6);
       key![CreatedOn]              : Date;
              @Common.Text           : MaterialName
              @Common.TextArrangement: #TextLast
       key![MaterialNo]             : String(18);
              @Common.TextFor
       key![MaterialName]           : String(40);
              @Common.Text           : SoldtoPartyName
              @Common.TextArrangement: #TextLast
       key![SoldToParty]            : String(10);
              @Common.TextFor
       key![SoldtoPartyName]        : String(40);
              @Common.Text           : ShipToPartyName
              @Common.TextArrangement: #TextLast
       key![ShipToParty]            : String(10);
              @Common.TextFor
       key![ShipToPartyName]        : String(40);
       key![CustomerReference]      : String(35);
              @Common.Text           : SalesOrgName
              @Common.TextArrangement: #TextLast
       key![SalesOrg]               : String(4);
              @Common.TextFor
       key![SalesOrgName]           : String(20);
       key![Note]                   : String(255);
       key![RequestedDelDate]       : Date;
       key![RequestedQuantity]      : Decimal(15, 3);
          ![RequestedQuantityUnit]  : String(3);
       key![Plant]                  : String(4);
              @Common.Text           : OrderTypeDesc
              @Common.TextArrangement: #TextLast
       key![OrderType]              : String(4);
              @Common.TextFor
       key![OrderTypeDesc]          : String(20);
              @Common.Text           : POTypeDesc
              @Common.TextArrangement: #TextLast
       key![POType]                 : String(4);
              @Common.TextFor
       key![POTypeDesc]             : String(20);
       key![Incoterm1]              : String(3);
       key![Incoterm2]              : String(28);
       key![PaymentTerm]            : String(4);
              @Common.Text           : VEPartnerName
              @Common.TextArrangement: #TextLast
       key![VEPartner]              : String(8);
              @Common.TextFor
       key![VEPartnerName]          : String(40);
              @Common.Text           : ASPartnerName
              @Common.TextArrangement: #TextLast
       key![ASPartner]              : String(8);
              @Common.TextFor
       key![ASPartnerName]          : String(40);
       key![DIFF_CONF_REQ_DATE]     : String(8);
       key![GROUP_COMPANY]          : String(1);
              @Common.Text           : SUPPLY_POINT_DESC
              @Common.TextArrangement: #TextLast
       key![SUPPLY_POINT]           : String(4);
              @Common.TextFor
          ![SUPPLY_POINT_DESC]      : String(30);
       key![CUSTOMER_PRIORITY]      : String(30);
       key![TM_DOC_NO]              : String(10);
       key![FORWARDER_NAME]         : String(35);
       key![VESSEL_NAME]            : String(35);
       key![CONTAINER_NO]           : String(20);
       key![ShipmentETA]            : Date;
       key![ShipmentETD]            : Date;
       key![ConfDelDate]            : Date;
       key![SHIPPING_TYPE]          : String(2);
       key![SHIP_TYPE_DESC]         : String(20);
       key![LoadingDate]            : Date;
       key![SHIP_STAT_DESC]         : String(255);
       key![SHIP_STATR_DESC]        : String(255);
       key![REQ_TEXT]               : String(250);
       key![BILLING_BLOCK_ITEM]     : String(250);
       key![DOCUMENT_TYPE]          : String(1);
       key![GUSCON_LEVEL]           : String(2);
       key![LEVEL_TYPE]             : String(7);
       key![SORT_ORDER]             : Integer;
       key![ORDER_STATUS]           : String(12);
       key![DISTRIBUTION_CHANNEL]   : String(2);
       key![DELIVERY]               : String(10);
       key![SBU]                    : String(18);
       key![PlannedDelDate]         : Date;
       key![SORT_ORDER1]            : Integer;
       key![INITIAL_ORDER]          : String(10);
       key![NEXT_ORDER]             : String(10);
       key![FINAL_ORDER]            : String(10);
       key![STATUS_BIZAGI]          : String(100);
       key![FA_TRACKING_ID]         : String(35);
       key![TRACKING_ID]            : String(12);
       key![LC_NUMBER]              : String(10);
       key![CUSTOMER_MAT_REFERENCE] : String(100);
       key![CONFIRMED_QUANTITY]     : Decimal(15, 3);
       key![PENDING_DEL_QTY]        : Decimal(15, 3);
       key![PENDING_DEL_QTY_UNIT]   : String(3);
       key![UNCONFIRMED_QUANTITY]   : Decimal(15, 3);
       key![DELIVERY_TYPE]          : String(40);
       key![STORAGE_LOCATION]       : String(4);
       key![SUPPLYING_PLANT]        : String(4);
       key![SELLING_INVOICE]        : String(10);
       key![CREATION_DATE]          : Date;
       key![SHIP_TO_COUNTRY_NAME]   : String(25);
       key![SUPPLY_SITUATION]       : String(2);
       key![SUPPLY_SITUATION_DESC]  : String(40);
       key![DELIVERY_QTY]           : Decimal(15, 3);
       key![SUPPLIER_PO]            : String(35);
       key![COM_TRACKING_ID]        : String(50);
       key![PRICING_DATE]           : Date;
       key![BILLING_DOCUMENT]       : String(10);
       key![DEL_QTY_UNIT]           : String(3);
            @Common.Text           : CO_PARTNER_NAME
            @Common.TextArrangement: #TextLast
       key![CO_PARTNER]             : String(10);
            @Common.TextFor
       key![CO_PARTNER_NAME]        : String(40);
            @Common.Text           : NY_PARTNER_NAME
            @Common.TextArrangement: #TextLast
       key![NY_PARTNER]             : String(10);
            @Common.TextFor
       key![NY_PARTNER_NAME]        : String(40);
       key![SHIPMNT_ATA]            : Date;
       key![SHIPMNT_ATD]            : Date;
       key![ShipmentATA]            : Date;
       key![ShipmentATD]            : Date;
       key![BATCH_NUMBER]           : String(10);
       key![DATE_OF_MANUF]          : Date;
       key![SHELF_LIFE_EXP_DATE]    : Date;
       key![NOTA_FISCAL]            : String(16);
              @Common.Text           : AM_PARTNER_NAME
              @Common.TextArrangement: #TextLast
       key![AM_PARTNER]             : String(10);
              @Common.TextFor
       key![AM_PARTNER_NAME]        : String(40);
       key![NET_AMOUNT]             : String(25);
       key![PRICE_PER_UNIT]         : String(30);
       key![MRP_CONTROLLER]         : String(3);
       key![ITEM_CATEGORY]          : String(30);
       key![HOM_REMARK]             : String;
       key![SHIP_TO_CITY_NAME]      : String(40);
       key![PROD_ALLOC]             : String(18);

}

@cds.persistence.exists
entity VALUEHELPS {
      virtual id                : String;
       key![SalesOrder]             : String(50);
       key![SalesOrderItem]         : String(6);
       key![CreatedOn]              : Date;
              @Common.Text           : MaterialName
              @Common.TextArrangement: #TextLast
       key![MaterialNo]             : String(18);
              @Common.TextFor
       key![MaterialName]           : String(40);
              @Common.Text           : SoldtoPartyName
              @Common.TextArrangement: #TextLast
       key![SoldToParty]            : String(10);
              @Common.TextFor
       key![SoldtoPartyName]        : String(40);
              @Common.Text           : ShipToPartyName
              @Common.TextArrangement: #TextLast
       key![ShipToParty]            : String(10);
              @Common.TextFor
       key![ShipToPartyName]        : String(40);
       key![CustomerReference]      : String(35);
              @Common.Text           : SalesOrgName
              @Common.TextArrangement: #TextLast
       key![SalesOrg]               : String(4);
              @Common.TextFor
       key![SalesOrgName]           : String(20);
       key![Note]                   : String(255);
       key![RequestedDelDate]       : Date;
       key![RequestedQuantity]      : Decimal(15, 3);
          ![RequestedQuantityUnit]  : String(3);
       key![Plant]                  : String(4);
              @Common.Text           : OrderTypeDesc
              @Common.TextArrangement: #TextLast
       key![OrderType]              : String(4);
              @Common.TextFor
       key![OrderTypeDesc]          : String(20);
              @Common.Text           : POTypeDesc
              @Common.TextArrangement: #TextLast
       key![POType]                 : String(4);
              @Common.TextFor
       key![POTypeDesc]             : String(20);
       key![Incoterm1]              : String(3);
       key![Incoterm2]              : String(28);
       key![PaymentTerm]            : String(4);
              @Common.Text           : VEPartnerName
              @Common.TextArrangement: #TextLast
       key![VEPartner]              : String(8);
              @Common.TextFor
       key![VEPartnerName]          : String(40);
              @Common.Text           : ASPartnerName
              @Common.TextArrangement: #TextLast
       key![ASPartner]              : String(8);
              @Common.TextFor
       key![ASPartnerName]          : String(40);
       key![DIFF_CONF_REQ_DATE]     : String(8);
       key![GROUP_COMPANY]          : String(1);
              @Common.Text           : SUPPLY_POINT_DESC
              @Common.TextArrangement: #TextLast
       key![SUPPLY_POINT]           : String(4);
              @Common.TextFor
          ![SUPPLY_POINT_DESC]      : String(30);
       key![CUSTOMER_PRIORITY]      : String(30);
       key![TM_DOC_NO]              : String(10);
       key![FORWARDER_NAME]         : String(35);
       key![VESSEL_NAME]            : String(35);
       key![CONTAINER_NO]           : String(20);
       key![ShipmentETA]            : Date;
       key![ShipmentETD]            : Date;
       key![ConfDelDate]            : Date;
       key![SHIPPING_TYPE]          : String(2);
       key![SHIP_TYPE_DESC]         : String(20);
       key![LoadingDate]            : Date;
       key![SHIP_STAT_DESC]         : String(255);
       key![SHIP_STATR_DESC]        : String(255);
       key![REQ_TEXT]               : String(250);
       key![BILLING_BLOCK_ITEM]     : String(250);
       key![DOCUMENT_TYPE]          : String(1);
       key![GUSCON_LEVEL]           : String(2);
       key![LEVEL_TYPE]             : String(7);
       key![SORT_ORDER]             : Integer;
       key![ORDER_STATUS]           : String(12);
       key![DISTRIBUTION_CHANNEL]   : String(2);
       key![DELIVERY]               : String(10);
       key![SBU]                    : String(18);
       key![PlannedDelDate]         : Date;
       key![SORT_ORDER1]            : Integer;
       key![INITIAL_ORDER]          : String(10);
       key![NEXT_ORDER]             : String(10);
       key![FINAL_ORDER]            : String(10);
       key![STATUS_BIZAGI]          : String(100);
       key![FA_TRACKING_ID]         : String(35);
       key![TRACKING_ID]            : String(12);
       key![LC_NUMBER]              : String(10);
       key![CUSTOMER_MAT_REFERENCE] : String(100);
       key![CONFIRMED_QUANTITY]     : Decimal(15, 3);
       key![PENDING_DEL_QTY]        : Decimal(15, 3);
       key![PENDING_DEL_QTY_UNIT]   : String(3);
       key![UNCONFIRMED_QUANTITY]   : Decimal(15, 3);
       key![DELIVERY_TYPE]          : String(4);
       key![DELIVERY_TYPE_DESC]     : String(40);
       key![STORAGE_LOCATION]       : String(4);
       key![SUPPLYING_PLANT]        : String(4);
       key![SELLING_INVOICE]        : String(10);
       key![CREATION_DATE]          : Date;
       key![SHIP_TO_COUNTRY_NAME]   : String(25);
       key![SUPPLY_SITUATION]       : String(50);
       key![DELIVERY_QTY]           : Decimal(15, 3);
       key![SUPPLIER_PO]            : String(35);
       key![COM_TRACKING_ID]        : String(50);
       key![PRICING_DATE]           : Date;
       key![BILLING_DOCUMENT]       : String(10);
       key![DEL_QTY_UNIT]           : String(3);
          @Common.Text           : CO_PARTNER_NAME
            @Common.TextArrangement: #TextLast
       key![CO_PARTNER]             : String(10);
            @Common.TextFor
       key![CO_PARTNER_NAME]        : String(40);
            @Common.Text           : NY_PARTNER_NAME
            @Common.TextArrangement: #TextLast
       key![NY_PARTNER]             : String(10);
            @Common.TextFor
       key![NY_PARTNER_NAME]        : String(40);
       key![SHIPMNT_ATA]            : Date;
       key![SHIPMNT_ATD]            : Date;
       key![ShipmentATA]            : Date;
       key![ShipmentATD]            : Date;
       key![BATCH_NUMBER]           : String(10);
       key![DATE_OF_MANUF]          : Date;
       key![SHELF_LIFE_EXP_DATE]    : Date;
       key![NOTA_FISCAL]            : String(16);
              @Common.Text           : AM_PARTNER_NAME
              @Common.TextArrangement: #TextLast
       key![AM_PARTNER]             : String(10);
              @Common.TextFor
       key![AM_PARTNER_NAME]        : String(40);
       key![NET_AMOUNT]             : String(25);
       key![PRICE_PER_UNIT]         : String(30);
       key![MRP_CONTROLLER]         : String(3);
       key![ITEM_CATEGORY]          : String(30);
       key![ITEM_CATEGORY_DESC]     : String(30);
       key![HOM_REMARK]             : String;
       key![SHIP_TO_CITY_NAME]      : String(40);
       key![PROD_ALLOC]             : String(18);
}
