using srvOpenOrders as service from '../srv/allOrders-srv';

annotate service.Results with {
    KWMENG @Measures.Unit : VRKME ;
    VRKME @Semantics.unitOfMeasure :'unit-of-measure';
    KBMENG @Measures.Unit : VRKME;
    UNCONFIRMED_QTY @Measures.Unit : VRKME;
    KBETR @Measures.ISOCurrency : 'WAERS';
    WAERS @Semantics.currencyCode;
    KPEIN @Measures.Unit : KMEIN;
    KMEIN @Semantics.unitOfMeasure :'unit-of-measure';
    NETWR @Measures.ISOCurrency : WAERK;
    WAERK @Semantics.currencyCode;
    LFIMG @Measures.Unit : VRKME_DEL;
    VRKME_DEL @Semantics.unitOfMeasure :'unit-of-measure';
    PEND_DEL_QUAN @Measures.Unit : VRKME_DEL;
    CO_PARTNER_NAME @UI : {Hidden : true };
    NY_PARTNER_NAME @UI : {Hidden : true };
    AS_PARTNER_NAME @UI : {Hidden : true };
    VE_PARTNER_NAME @UI : {Hidden : true };
    AM_PARTNER_NAME @UI : {Hidden : true };
    AG_PARTNER_NAME @UI : {Hidden : true };
    WE_PARTNER_NAME @UI : {Hidden : true };
    MAKTX @UI : {Hidden : true };
    LANDX @UI : {Hidden : true };
    VKORG_NAME1 @UI : {Hidden : true };
    FAKSP_VTEXT @UI : {Hidden : true };
    SUPPLY_SITUATION_DESCR @UI : {Hidden : true };
    PSTYV_VTEXT @UI : {Hidden : true };
    VKBUR_BEZEI @UI : {Hidden : true };
    LFART_VTEXT @UI : {Hidden : true };
    id @UI : {Hidden : true };
    MANDT @UI : {Hidden : true };
    ABGRU @UI : {Hidden : true };
    ABSTA @UI : {Hidden : true };
    KNUMV @UI : {Hidden : true };
    SPART @UI : {Hidden : true };
    LANGUAGE @UI : {Hidden : true };
    HSDAT_DATE @UI : {Hidden : true };
    VFDAT_DATE @UI : {Hidden : true };
}

annotate service.valueHelps with {
    KWMENG @Measures.Unit : VRKME;
    VRKME @Semantics.unitOfMeasure :'unit-of-measure';
    KBMENG @Measures.Unit : VRKME;
    UNCONFIRMED_QTY @Measures.Unit : VRKME;
    KBETR @Measures.ISOCurrency : 'WAERS';
    WAERS @Semantics.currencyCode;
    KPEIN @Measures.Unit : KMEIN;
    KMEIN @Semantics.unitOfMeasure :'unit-of-measure';
    NETWR @Measures.ISOCurrency : WAERK;
    WAERK @Semantics.currencyCode;
    LFIMG @Measures.Unit : VRKME_DEL;
    VRKME_DEL @Semantics.unitOfMeasure :'unit-of-measure';
    PEND_DEL_QUAN @Measures.Unit : VRKME_DEL;
    CO_PARTNER_NAME @UI : {Hidden : true };
    NY_PARTNER_NAME @UI : {Hidden : true };
    AS_PARTNER_NAME @UI : {Hidden : true };
    VE_PARTNER_NAME @UI : {Hidden : true };
    AM_PARTNER_NAME @UI : {Hidden : true };
    AG_PARTNER_NAME @UI : {Hidden : true };
    WE_PARTNER_NAME @UI : {Hidden : true };
    MAKTX @UI : {Hidden : true };
    LANDX @UI : {Hidden : true };
    VKORG_NAME1 @UI : {Hidden : true };
    FAKSP_VTEXT @UI : {Hidden : true };
    SUPPLY_SITUATION_DESCR @UI : {Hidden : true };
    PSTYV_VTEXT @UI : {Hidden : true };
    VKBUR_BEZEI @UI : {Hidden : true };
    LFART_VTEXT @UI : {Hidden : true };
    
    ABGRU @UI : {Hidden : true };
    ABSTA @UI : {Hidden : true };
    KNUMV @UI : {Hidden : true };
    SPART @UI : {Hidden : true };
    LANGUAGE @UI : {Hidden : true };
    HSDAT_DATE @UI : {Hidden : true };
    VFDAT_DATE @UI : {Hidden : true };
}

annotate service.Results with {
    VRKME
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VRKME}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: VRKME,
            ValueListProperty: 'VRKME'
        }]
    }
}
annotate service.Results with {
    KMEIN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>KMEIN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: KMEIN,
            ValueListProperty: 'KMEIN'
        }]
    }
}
annotate service.Results with {
    VRKME_DEL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VRKME_DEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: VRKME_DEL,
            ValueListProperty: 'VRKME_DEL'
        }]
    }
}
annotate service.Results with {
    WAERK
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>WAERK}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: WAERK,
            ValueListProperty: 'WAERK'
        }]
    }
}
annotate service.Results with {
    WAERS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>WAERS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: WAERS,
            ValueListProperty: 'WAERS'
        }]
    }
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
        Label                  : '{@i18n>KWMENG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: KWMENG,
                ValueListProperty: 'KWMENG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'VRKME'
            },
           
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
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'VRKME'
            },
           
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
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'VRKME'
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
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'WAERS'
            }
           
        ]
    }};
    annotate service.Results with {
    KPEIN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>KPEIN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: KPEIN,
                ValueListProperty: 'KPEIN'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'KMEIN'
            }
           
        ]
    }};
    annotate service.Results with {
    NETWR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>NET_AMOUNT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: NETWR,
                ValueListProperty: 'NETWR' 
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'WAERK' 
            }
          
        ]
    }};
    annotate service.Results with {
    HTEXT
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>HTEXT}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: HTEXT,
                ValueListProperty: 'HTEXT'
            }
           
        ]
    }};
    annotate service.Results with {
    PSTYV
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ITEM_CATEGORY}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PSTYV,
                ValueListProperty: 'PSTYV'
            }
           
        ]
    }};
    annotate service.Results with {
    DISPO
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>MRP_CONTROLLER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DISPO,
                ValueListProperty: 'DISPO'
            }
           
        ]
    }};
    annotate service.Results with {
    KOSCH
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>KOSCH}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: KOSCH,
                ValueListProperty: 'KOSCH'
            }
           
        ]
    }};
    annotate service.Results with {
    VKBUR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VKBUR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: VKBUR,
                ValueListProperty: 'VKBUR'
            }
           
        ]
    }};
    annotate service.Results with {
    CO_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>CO_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: CO_PARTNER,
                ValueListProperty: 'CO_PARTNER'
            }
           
        ]
    }};
    annotate service.Results with {
    NY_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>NY_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: NY_PARTNER,
                ValueListProperty: 'NY_PARTNER'
            }
           
        ]
    }};
    annotate service.Results with {
    AS_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>AS_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: AS_PARTNER,
                ValueListProperty: 'AS_PARTNER'
            }
           
        ]
    }};
    annotate service.Results with {
    VE_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VE_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: VE_PARTNER,
                ValueListProperty: 'VE_PARTNER'
            }
           
        ]
    }};
    annotate service.Results with {
    AM_PARTNER
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>AM_PARTNER}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: AM_PARTNER,
                ValueListProperty: 'AM_PARTNER'
            }
           
        ]
    }};
    annotate service.Results with {
    VBELN_DEL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VBELN_DEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: VBELN_DEL,
                ValueListProperty: 'VBELN_DEL'
            }
           
        ]
    }};
annotate service.Results with {
    POSNR_DEL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>POSNR_DEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: POSNR_DEL,
                ValueListProperty: 'POSNR_DEL'
            }
           
        ]
    }};
    annotate service.Results with {
    CHARG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>CHARG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: CHARG,
                ValueListProperty: 'CHARG'
            }
           
        ]
    }};
    annotate service.Results with {
    LFIMG
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>LFIMG}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: LFIMG,
                ValueListProperty: 'LFIMG'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'VRKME_DEL'
            }
           
        ]
    }};
    annotate service.Results with {
    POSAR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>POSAR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: POSAR,
                ValueListProperty: 'POSAR'
            }
           
        ]
    }};
     annotate service.Results with {
    VGBEL
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VGBEL}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: VGBEL,
                ValueListProperty: 'VGBEL'
            }
           
        ]
    }};
annotate service.Results with {
    VGPOS
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>VGPOS}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: VGPOS,
                ValueListProperty: 'VGPOS'
            }
           
        ]
    }};
    annotate service.Results with {
    LFART
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>LFART}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: LFART,
                ValueListProperty: 'LFART'
            }
           
        ]
    }};
    annotate service.Results with {
    TRAID
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>TRAID}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: TRAID,
                ValueListProperty: 'TRAID'
            }
           
        ]
    }};
    annotate service.Results with {
    ZZ0S2BLNR
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>ZZ0S2BLNR}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: ZZ0S2BLNR,
                ValueListProperty: 'ZZ0S2BLNR'
            }
           
        ]
    }};
    annotate service.Results with {
    PEND_DEL_QUAN
    @Common.ValueList: {
        $Type                  : 'Common.ValueListType',
        Label                  : '{@i18n>PEND_DEL_QUAN}',
        CollectionPath         : 'valueHelps',
        DistinctValuesSupported: true,
        SearchSupported        : true,
        Parameters             : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: PEND_DEL_QUAN,
                ValueListProperty: 'PEND_DEL_QUAN'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'VRKME_DEL'
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
