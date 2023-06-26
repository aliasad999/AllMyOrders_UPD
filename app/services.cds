using srvOpenOrders as service from '../srv/allOrders-srv';

annotate service.Results with {
    KWMENG @Measures.Unit : VRKME;
    VRKME @Semantics.unitOfMeasure :'unit-of-measure';
    KBMENG @Measures.Unit : VRKME;
    UNCONFIRMED_QTY @Measures.Unit : VRKME;
    KBETR @Measures.ISOCurrency : 'WAERS';
    WAERS @Semantics.currencyCode;
    CO_PARTNER_NAME @UI : {Hidden : true };
    NY_PARTNER_NAME @UI : {Hidden : true };
    AS_PARTNER_NAME @UI : {Hidden : true };
    VE_PARTNER_NAME @UI : {Hidden : true };
    AM_PARTNER_NAME @UI : {Hidden : true };
    AG_PARTNER_NAME @UI : {Hidden : true };
    WE_PARTNER_NAME @UI : {Hidden : true };
}

annotate service.valueHelps with {
    KWMENG @Measures.Unit : VRKME;
    VRKME @Semantics.unitOfMeasure :'unit-of-measure';
    KBMENG @Measures.Unit : VRKME;
    UNCONFIRMED_QTY @Measures.Unit : VRKME;
    KBETR @Measures.ISOCurrency : 'WAERS';
    WAERS @Semantics.currencyCode;
    CO_PARTNER_NAME @UI : {Hidden : true };
    NY_PARTNER_NAME @UI : {Hidden : true };
    AS_PARTNER_NAME @UI : {Hidden : true };
    VE_PARTNER_NAME @UI : {Hidden : true };
    AM_PARTNER_NAME @UI : {Hidden : true };
    AG_PARTNER_NAME @UI : {Hidden : true };
    WE_PARTNER_NAME @UI : {Hidden : true };
}



annotate service.Results with {
    VBELN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>salesOrder}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: VBELN,
            ValueListProperty: 'VBELN'
        }]
    }
}

annotate service.Results with {
    POSNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>salesOrder}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: POSNR,
            ValueListProperty: 'POSNR'
        }]
    }
}
annotate service.Results with {
    AUART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>auart}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: AUART,
                ValueListProperty: 'AUART'
            }
           
        ]
    }};
annotate service.Results with {
    WERKS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>werks}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: AUART,
                ValueListProperty: 'AUART'
            }
           
        ]
    }};
annotate service.Results with {
    VTWEG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>vtweg}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: VTWEG,
                ValueListProperty: 'VTWEG'
            }
           
        ]
    }};
annotate service.Results with {
    MATNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>MaterialNo}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: MATNR,
                ValueListProperty: 'MATNR'
            }
           
        ]
    }};
annotate service.Results with {
    KDMAT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>kdmat}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: KDMAT,
                ValueListProperty: 'KDMAT'
            }
           
        ]
    }};
annotate service.Results with {
    BSTNK
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>bstnk}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: BSTNK,
                ValueListProperty: 'BSTNK'
            }
           
        ]
    }};
annotate service.Results with {
    AG_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>agPartnerNo}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: AG_PARTNER,
                ValueListProperty: 'AG_PARTNER'
            }
           
        ]
    }};
annotate service.Results with {
    WE_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>wePartnerNo}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: WE_PARTNER,
                ValueListProperty: 'WE_PARTNER'
            }
           
        ]
    }};
annotate service.Results with {
    LAND1
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>land1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: LAND1,
                ValueListProperty: 'LAND1'
            }
           
        ]
    }};
annotate service.Results with {
    ORT01
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ort1}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: ORT01,
                ValueListProperty: 'ORT01'
            }
           
        ]
    }};
annotate service.Results with {
    VKORG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>vkorg}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: VKORG,
                ValueListProperty: 'VKORG'
            }
           
        ]
    }};
annotate service.Results with {
    VBUND
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VBUND}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: VBUND,
                ValueListProperty: 'VBUND'
            }
           
        ]
    }};
annotate service.Results with {
    KWMENG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VBUND}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: KWMENG,
                ValueListProperty: 'KWMENG'
            }
           
        ]
    }};
annotate service.Results with {
    KBMENG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>CONFIRMED_QUANTITY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: KBMENG,
                ValueListProperty: 'KBMENG'
            }
           
        ]
    }};
annotate service.Results with {
    UNCONFIRMED_QTY
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>UNCONFIRMED_QUANTITY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: UNCONFIRMED_QTY,
                ValueListProperty: 'UNCONFIRMED_QTY'
            }
           
        ]
    }};
annotate service.Results with {
    REQ_TEXT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>REQ_TEXT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: REQ_TEXT,
                ValueListProperty: 'REQ_TEXT'
            }
           
        ]
    }};
annotate service.Results with {
    FAKSP
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>FAKSP}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: FAKSP,
                ValueListProperty: 'FAKSP'
            }
           
        ]
    }};
annotate service.Results with {
    LGORT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>STORAGE_LOCATION}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: LGORT,
                ValueListProperty: 'LGORT'
            }
           
        ]
    }};
annotate service.Results with {
    SUPPLY_SITUATION
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>SUPPLY_SITUATION}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SUPPLY_SITUATION,
                ValueListProperty: 'SUPPLY_SITUATION'
            }
           
        ]
    }};
    annotate service.Results with {
    KBETR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>KBETR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: KBETR,
                ValueListProperty: 'KBETR'
            }
           
        ]
    }};
annotate service.Results with @UI.LineItem: {
    ![@UI.Criticality]: 5,
    $value            : [
        { Value: VBELN },
        { Value: POSNR},
        { Value: VKORG},
        { Value: KBETR},
        { Value: KWMENG}
     
    ]
};

annotate service.Results with @(UI: {SelectionFields: [
    VBELN,
    POSNR,
    VKORG,
    MATNR,
    FAKSP

    
],

});
