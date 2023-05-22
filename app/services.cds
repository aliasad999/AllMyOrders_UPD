using srvOpenOrders as service from '../srv/allOrders-srv';

annotate service.Results with {
    RequestedQuantity @Measures.Unit : RequestedQuantityUnit;
    RequestedQuantityUnit @Semantics.unitOfMeasure :'unit-of-measure';
    CONFIRMED_QUANTITY @Measures.Unit : RequestedQuantityUnit;
    PENDING_DEL_QTY @Measures.Unit : PENDING_DEL_QTY_UNIT;
    PENDING_DEL_QTY_UNIT @Semantics.unitOfMeasure :'unit-of-measure';
    UNCONFIRMED_QUANTITY @Measures.Unit : PENDING_DEL_QTY_UNIT;
    DELIVERY_QTY @Measures.Unit : PENDING_DEL_QTY_UNIT;
    PENDING_DEL_QTY_UNIT  @UI : {Hidden : true };
    RequestedQuantityUnit  @UI : {Hidden : true };
    MaterialName @UI : {Hidden : true };
    SoldtoPartyName @UI : {Hidden : true };
    ShipToPartyName @UI : {Hidden : true };
    SalesOrgName @UI : {Hidden : true };
    OrderTypeDesc @UI : {Hidden : true };
    POTypeDesc @UI : {Hidden : true };
    VEPartnerName @UI : {Hidden : true };
    ASPartnerName @UI : {Hidden : true };
    SUPPLY_POINT_DESC @UI : {Hidden : true };
    AM_PARTNER_NAME @UI : {Hidden : true };
    CO_PARTNER_NAME @UI : {Hidden : true };
    NY_PARTNER_NAME @UI : {Hidden : true };
}
annotate service.valueHelps with {
    RequestedQuantity @Measures.Unit : RequestedQuantityUnit;
    RequestedQuantityUnit @Semantics.unitOfMeasure :'unit-of-measure';
    CONFIRMED_QUANTITY @Measures.Unit : RequestedQuantityUnit;
    PENDING_DEL_QTY @Measures.Unit : PENDING_DEL_QTY_UNIT;
    PENDING_DEL_QTY_UNIT @Semantics.unitOfMeasure :'unit-of-measure';
    UNCONFIRMED_QUANTITY @Measures.Unit : PENDING_DEL_QTY_UNIT;
    DELIVERY_QTY @Measures.Unit : PENDING_DEL_QTY_UNIT;
    PENDING_DEL_QTY_UNIT  @UI : {Hidden : true };
    RequestedQuantityUnit  @UI : {Hidden : true };
    MaterialName @UI : {Hidden : true };
    SoldtoPartyName @UI : {Hidden : true };
    ShipToPartyName @UI : {Hidden : true };
    SalesOrgName @UI : {Hidden : true };
    OrderTypeDesc @UI : {Hidden : true };
    POTypeDesc @UI : {Hidden : true };
    VEPartnerName @UI : {Hidden : true };
    ASPartnerName @UI : {Hidden : true };
    SUPPLY_POINT_DESC @UI : {Hidden : true };
    AM_PARTNER_NAME @UI : {Hidden : true };
    CO_PARTNER_NAME @UI : {Hidden : true };
    NY_PARTNER_NAME @UI : {Hidden : true };
}
annotate service.Results with @Capabilities: {FilterRestrictions: {FilterExpressionRestrictions: [{
    Property          : 'CREATION_DATE',
    AllowedExpressions: 'SingleRange'
}]}};

annotate service.Results with @(UI: {SelectionFields: [
    CREATION_DATE,
    SalesOrg,
    SoldtoPartyName,
    ShipToPartyName,
    SalesOrder,
    LEVEL_TYPE,
    ORDER_STATUS
],

});


annotate service.Results with @UI.LineItem: {
    ![@UI.Criticality]: 5,
    $value            : [
        {Value: SalesOrder},
        {Value: NEXT_ORDER},
        {Value: FINAL_ORDER},
        {Value: SalesOrderItem},
        {Value: CreatedOn},
        {Value: LEVEL_TYPE},
        {
            $Type                    : 'UI.DataField',
            Value                    : ORDER_STATUS,
            ![@UI.Importance]        : #High,
            Criticality              : 2,
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

annotate service.Results with {
    SUPPLY_POINT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SUPPLY_POINT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SUPPLY_POINT,
                ValueListProperty: 'SUPPLY_POINT'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SUPPLY_POINT_DESC'
            }
        ]
    }


};

annotate service.Results with {
    SalesOrder
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>salesOrder}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SalesOrder,
            ValueListProperty: 'SalesOrder'
        }]
    }
}

annotate service.Results with {
    SalesOrderItem
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>salesOrderItem}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SalesOrderItem,
            ValueListProperty: 'SalesOrderItem'
        }]
    }
}

annotate service.Results with {
    MaterialNo
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>MaterialNo}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: MaterialNo,
            ValueListProperty: 'MaterialNo'
        }]
    }
}

annotate service.Results with {
    MaterialName
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>MaterialName}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: MaterialName,
            ValueListProperty: 'MaterialName'
        }]
    }
}

annotate service.Results with {
    NEXT_ORDER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>NEXT_ORDER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: NEXT_ORDER,
            ValueListProperty: 'NEXT_ORDER'
        }]
    }
}

annotate service.Results with {
    INITIAL_ORDER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>INITIAL_ORDER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: INITIAL_ORDER,
            ValueListProperty: 'INITIAL_ORDER'
        }]
    }
}

annotate service.Results with {
    FINAL_ORDER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>FINAL_ORDER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: FINAL_ORDER,
            ValueListProperty: 'FINAL_ORDER'
        }]
    }

}

annotate service.Results with {
    DISTRIBUTION_CHANNEL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DISTRIBUTION_CHANNEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DISTRIBUTION_CHANNEL,
            ValueListProperty: 'DISTRIBUTION_CHANNEL'
        }]
    }
}

annotate service.Results with {
    SBU
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SBU}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SBU,
            ValueListProperty: 'SBU'
        }]
    }
}

annotate service.Results with {
    DELIVERY
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DELIVERY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DELIVERY,
            ValueListProperty: 'DELIVERY'
        }]
    }
}

annotate service.Results with {
    GUSCON_LEVEL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>GUSCON_LEVEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: GUSCON_LEVEL,
            ValueListProperty: 'GUSCON_LEVEL'
        }]
    }

}

annotate service.Results with {
    LEVEL_TYPE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>LEVEL_TYPE}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: LEVEL_TYPE,
            ValueListProperty: 'LEVEL_TYPE'
        }]
    }
}

annotate service.Results with {
    ORDER_STATUS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ORDER_STATUS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: ORDER_STATUS,
            ValueListProperty: 'ORDER_STATUS'
        }]
    }
}

annotate service.Results with {
    SalesOrg
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SalesOrg}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SalesOrg,
                ValueListProperty: 'SalesOrg'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'SalesOrgName'
            }
        ]
    }
}

annotate service.Results with {
    Note
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>Note}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: Note,
            ValueListProperty: 'Note'
        }]
    }
}

annotate service.Results with {
    RequestedQuantity 
	@Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>RequestedQuantity}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: RequestedQuantity,
            ValueListProperty: 'RequestedQuantity'
        },
        {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'RequestedQuantityUnit'
        }]
    }
}
annotate service.Results with {
    Plant
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>Plant}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: Plant,
            ValueListProperty: 'Plant'
        }]
    }
}
annotate service.Results with {
    OrderType
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>OrderType}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: OrderType,
            ValueListProperty: 'OrderType'
        }]
    }
}
annotate service.Results with {
    POType
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>POType}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: POType,
            ValueListProperty: 'POType'
        }]
    }
}
annotate service.Results with {
    Incoterm1
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>Incoterm1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: Incoterm1,
            ValueListProperty: 'Incoterm1'
        }]
    }}
	annotate service.Results with {
    Incoterm2
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>Incoterm2}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: Incoterm2,
            ValueListProperty: 'Incoterm2'
        }]
    }}
	annotate service.Results with {
    PaymentTerm
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PaymentTerm}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PaymentTerm,
            ValueListProperty: 'PaymentTerm'
        }]
    }}
	annotate service.Results with {
    GROUP_COMPANY
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>GROUP_COMPANY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: GROUP_COMPANY,
            ValueListProperty: 'GROUP_COMPANY'
        }]
    }}
	annotate service.Results with {
    CUSTOMER_PRIORITY
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>CUSTOMER_PRIORITY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: CUSTOMER_PRIORITY,
            ValueListProperty: 'CUSTOMER_PRIORITY'
        }]
    }}
    annotate service.Results with {
    FORWARDER_NAME
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>FORWARDER_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: FORWARDER_NAME,
            ValueListProperty: 'FORWARDER_NAME'
        }]
    }}
    annotate service.Results with {
    VESSEL_NAME
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VESSEL_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: VESSEL_NAME,
            ValueListProperty: 'VESSEL_NAME'
        }]
    }}
    annotate service.Results with {
    ShipmentETA
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ShipmentETA}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: ShipmentETA,
            ValueListProperty: 'ShipmentETA'
        }]
    }}
	
    annotate service.Results with {
    ShipmentETD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ShipmentETD}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: ShipmentETD,
            ValueListProperty: 'ShipmentETD'
        }]
    }}
    annotate service.Results with {
    CONTAINER_NO
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>CONTAINER_NO}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: CONTAINER_NO,
            ValueListProperty: 'CONTAINER_NO'
        }]
    }}
    annotate service.Results with {
    SHIPPING_TYPE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SHIPPING_TYPE}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SHIPPING_TYPE,
            ValueListProperty: 'SHIPPING_TYPE'
        }]
    }}
    annotate service.Results with {
    LC_NUMBER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>LC_NUMBER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: LC_NUMBER,
            ValueListProperty: 'LC_NUMBER'
        }]
    }}
    annotate service.Results with {
    CUSTOMER_MAT_REFERENCE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>CUSTOMER_MAT_REFERENCE}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: CUSTOMER_MAT_REFERENCE,
            ValueListProperty: 'CUSTOMER_MAT_REFERENCE'
        }]
    }}
    annotate service.Results with {
    DELIVERY_TYPE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>CUSTOMER_MAT_REFERENCE}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DELIVERY_TYPE,
            ValueListProperty: 'DELIVERY_TYPE'
        }]
    }}
    annotate service.Results with {
    STORAGE_LOCATION
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>STORAGE_LOCATION}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: STORAGE_LOCATION,
            ValueListProperty: 'STORAGE_LOCATION'
        }]
    }}
    
    annotate service.Results with {
    BILLING_DOCUMENT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BILLING_DOCUMENT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BILLING_DOCUMENT,
            ValueListProperty: 'BILLING_DOCUMENT'
        }]
    }}
    annotate service.Results with {
    CONFIRMED_QUANTITY
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>CONFIRMED_QUANTITY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: CONFIRMED_QUANTITY,
            ValueListProperty: 'CONFIRMED_QUANTITY'
        },
        {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'RequestedQuantityUnit'
        }]
    }}
    annotate service.Results with {
    PENDING_DEL_QTY
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PENDING_DEL_QTY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PENDING_DEL_QTY,
            ValueListProperty: 'PENDING_DEL_QTY'
        },
        {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            
            ValueListProperty: 'PENDING_DEL_QTY_UNIT'
        }]
    }}
    annotate service.Results with {
    UNCONFIRMED_QUANTITY
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>UNCONFIRMED_QUANTITY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: UNCONFIRMED_QUANTITY,
            ValueListProperty: 'UNCONFIRMED_QUANTITY'
        },
        {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'PENDING_DEL_QTY_UNIT'
        }]
    }}
    annotate service.Results with {
    SUPPLY_SITUATION
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SUPPLY_SITUATION}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SUPPLY_SITUATION,
            ValueListProperty: 'SUPPLY_SITUATION'
        }]
    }}
    annotate service.Results with {
    DELIVERY_QTY
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>DELIVERY_QTY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DELIVERY_QTY,
            ValueListProperty: 'DELIVERY_QTY'
        },
        {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'PENDING_DEL_QTY_UNIT'
        }]
    }}
    
    annotate service.Results with {
    PRICE_PER_UNIT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PRICE_PER_UNIT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PRICE_PER_UNIT,
            ValueListProperty: 'PRICE_PER_UNIT'
        }]
    }}
    annotate service.Results with {
    NET_AMOUNT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>NET_AMOUNT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: NET_AMOUNT,
            ValueListProperty: 'NET_AMOUNT'
        }]
    }}
    annotate service.Results with {
    ShipmentATA
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ShipmentATA}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: ShipmentATA,
            ValueListProperty: 'ShipmentATA'
        }]
    }}
    annotate service.Results with {
    ShipmentATD
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ShipmentATD}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: ShipmentATD,
            ValueListProperty: 'ShipmentATD'
        }]
    }}
    annotate service.Results with {
    BATCH_NUMBER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>BATCH_NUMBER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: BATCH_NUMBER,
            ValueListProperty: 'BATCH_NUMBER'
        }]
    }}
    annotate service.Results with {
    NOTA_FISCAL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>NOTA_FISCAL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: NOTA_FISCAL,
            ValueListProperty: 'NOTA_FISCAL'
        }]
    }}
    annotate service.Results with {
    HOM_REMARK
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>HOM_REMARK}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: HOM_REMARK,
            ValueListProperty: 'HOM_REMARK'
        }]
    }}
    annotate service.Results with {
    ITEM_CATEGORY
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ITEM_CATEGORY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: ITEM_CATEGORY,
            ValueListProperty: 'ITEM_CATEGORY'
        }]
    }}
    annotate service.Results with {
    MRP_CONTROLLER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>MRP_CONTROLLER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: MRP_CONTROLLER,
            ValueListProperty: 'MRP_CONTROLLER'
        }]
    }}
    annotate service.Results with {
    SHIP_TO_COUNTRY_NAME
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SHIP_TO_COUNTRY_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SHIP_TO_COUNTRY_NAME,
            ValueListProperty: 'SHIP_TO_COUNTRY_NAME'
        }]
    }}
    annotate service.Results with {
    DIFF_CONF_REQ_DATE
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SHIP_TO_COUNTRY_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: DIFF_CONF_REQ_DATE,
            ValueListProperty: 'DIFF_CONF_REQ_DATE'
        }]
    }}
    annotate service.Results with {
    SHIP_TO_CITY_NAME
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SHIP_TO_CITY_NAME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SHIP_TO_CITY_NAME,
            ValueListProperty: 'SHIP_TO_CITY_NAME'
        }]
    }}
    annotate service.Results with {
    PROD_ALLOC
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PROD_ALLOC}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PROD_ALLOC,
            ValueListProperty: 'PROD_ALLOC'
        }]
    }}
    annotate service.Results with {
    AM_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>AM_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: AM_PARTNER,
            ValueListProperty: 'AM_PARTNER'
        }]
    }}
    annotate service.Results with {
    VEPartner
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VEPartner}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: VEPartner,
            ValueListProperty: 'VEPartner'
        }]
    }}
    annotate service.Results with {
    CO_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>CO_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: CO_PARTNER,
            ValueListProperty: 'CO_PARTNER'
        }]
    }}
    annotate service.Results with {
    ASPartner
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ASPartner}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: ASPartner,
            ValueListProperty: 'ASPartner'
        }]
    }}
    annotate service.Results with {
    NY_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>NY_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: NY_PARTNER,
            ValueListProperty: 'NY_PARTNER'
        }]
    }}
    annotate service.Results with {
    SoldToParty
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SoldToParty}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: SoldToParty,
            ValueListProperty: 'SoldToParty'
        }]
    }}
    annotate service.Results with {
    ShipToParty
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ShipToParty}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: ShipToParty,
            ValueListProperty: 'ShipToParty'
        }]
    }}
    