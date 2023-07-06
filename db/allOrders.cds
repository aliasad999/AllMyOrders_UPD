namespace allorders.db;

@cds.persistence.exists
entity![SALESORDER_DETAILS]  {
	MANDT: String(3)  @title: 'MANDT' ; 
        VBELN: String(10)  @title: 'VBELN' ; 
        POSNR: String(6)  @title: 'POSNR' ; 
        ERDAT_ORDER_DATE: Date  @title: 'ERDAT_ORDER' ; 
        ERDAT_ITEM_DATE: Date  @title: 'ERDAT_ITEM' ; 
        AUART: String(4)  @title: 'AUART' ; 
        WERKS: String(4)  @title: 'WERKS' ; 
        VTWEG: String(2)  @title: 'VTWEG' ; 
        @Common.Text           : MAKTX
        @Common.TextArrangement: #TextLast
        MATNR: String(18)  @title: 'MATNR' ; 
        @Common.TextFor
        MAKTX: String(40)  @title: 'MAKTX' ; 
        KDMAT: String(35)  @title: 'KDMAT' ; 
        BSTNK: String(20)  @title: 'BSTNK' ; 
        @Common.Text           : AG_PARTNER_NAME
        @Common.TextArrangement: #TextLast
        AG_PARTNER: String(10)  @title: 'AG_PARTNER' ; 
        @Common.Text           : WE_PARTNER_NAME
        @Common.TextArrangement: #TextLast
        WE_PARTNER: String(10)  @title: 'WE_PARTNER' ; 
        @Common.Text           : LANDX
        @Common.TextArrangement: #TextLast
        LAND1: String(3)  @title: 'LAND1' ;
        @Common.TextFor 
        LANDX: String(15)  @title: 'LANDX' ; 
        ORT01: String(35)  @title: 'ORT01' ; 
        @Common.Text           : VKORG_NAME1
        @Common.TextArrangement: #TextLast
        VKORG: String(4)  @title: 'VKORG' ; 
        @Common.TextFor 
        VKORG_NAME1: String(40)  @title: 'VKORG_NAME1' ; 
        KNREF_HEAD: String(30)  @title: 'KNREF_HEAD' ; 
        KNREF_ITM: String(30)  @title: 'KNREF_ITM' ; 
        VBUND: String(6)  @title: 'VBUND' ; 
        EDATU_REQUESTED_DATE: Date  @title: 'EDATU_REQUESTED' ; 
        KWMENG: Decimal(15, 3)  @title: 'KWMENG' ; 
        VRKME: String(3)  @title: 'VRKME' ; 
        EDATU_CONFIRMED_DATE: Date  @title: 'EDATU_CONFIRMED' ; 
        KBMENG: Decimal(15, 3)  @title: 'KBMENG' ; 
        LDDAT_DATE: Date  @title: 'LDDAT' ; 
        UNCONFIRMED_QTY: Decimal(15, 3)  @title: 'UNCONFIRMED_QTY' ; 
        REQ_TEXT: String(250)  @title: 'REQ_TEXT' ; 
        @Common.Text           : FAKSP_VTEXT
        @Common.TextArrangement: #TextLast
        FAKSP: String(2)  @title: 'FAKSP' ; 
        @Common.TextFor 
        FAKSP_VTEXT: String(20)  @title: 'FAKSP_VTEXT' ; 
        LGORT: String(4)  @title: 'LGORT' ; 
        @Common.Text           : SUPPLY_SITUATION_DESCR
        @Common.TextArrangement: #TextLast
        SUPPLY_SITUATION: Int16  @title: 'SUPPLY_SITUATION' ; 
        @Common.TextFor 
        SUPPLY_SITUATION_DESCR: String(60)  @title: 'SUPPLY_SITUATION_DESCR' ; 
        KBETR: Decimal(11, 2)  @title: 'KBETR' ; 
        WAERS: String(5)  @title: 'WAERS' ; 
        KPEIN: Decimal(5)  @title: 'KPEIN' ; 
        KMEIN: String(3)  @title: 'KMEIN' ; 
        NETWR: Decimal(15, 2)  @title: 'NETWR' ; 
        WAERK: String(5)  @title: 'WAERK' ; 
        HTEXT: String(4000)  @title: 'HTEXT' ; 
        @Common.Text           : PSTYV_VTEXT
        @Common.TextArrangement: #TextLast
        PSTYV: String(4)  @title: 'PSTYV' ; 
        @Common.TextFor 
        PSTYV_VTEXT: String(20)  @title: 'PSTYV_VTEXT' ; 
        DISPO: String(3)  @title: 'DISPO' ; 
        KOSCH: String(18)  @title: 'KOSCH' ; 
        @Common.Text           : VKBUR_BEZEI
        @Common.TextArrangement: #TextLast
        VKBUR: String(4)  @title: 'VKBUR' ; 
        @Common.TextFor 
        VKBUR_BEZEI: String(20)  @title: 'VKBUR_BEZEI' ; 
        ABGRU: String(2)  @title: 'ABGRU' ;
        ABSTA: String(1)  @title: 'ABSTA' ;
        KNUMV: String(10)  @title: 'KNUMV' ; 
        SPART: String(2)  @title: 'SPART' ; 
        @Common.Text           : CO_PARTNER_NAME
        @Common.TextArrangement: #TextLast
        CO_PARTNER: String(10)  @title: 'CO Partner' ; 
        @Common.TextFor 
        CO_PARTNER_NAME: String(70)  @title: 'CO Partner Name' ; 
        @Common.Text           : NY_PARTNER_NAME
        @Common.TextArrangement: #TextLast
        NY_PARTNER: String(10)  @title: 'NY Partner' ; 
        @Common.TextFor 
        NY_PARTNER_NAME: String(70)  @title: 'NY Partner Name' ; 
        @Common.Text           : AS_PARTNER
        @Common.TextArrangement: #TextLast
        AS_PARTNER: String(8)  @title: 'AS_PARTNER' ; 
        @Common.TextFor 
        AS_PARTNER_NAME: String(40)  @title: 'AS Partner Name' ; 
        @Common.Text           : VE_PARTNER_NAME
        @Common.TextArrangement: #TextLast
        VE_PARTNER: String(8)  @title: 'VE Partner' ; 
        @Common.TextFor 
        VE_PARTNER_NAME: String(40)  @title: 'VE Partner Name' ; 
        @Common.Text           : AM_PARTNER_NAME
        @Common.TextArrangement: #TextLast
        AM_PARTNER: String(8)  @title: 'AM Partner' ; 
        @Common.TextFor 
        AM_PARTNER_NAME: String(40)  @title: 'AM Partner Name' ; 
        @Common.TextFor 
        AG_PARTNER_NAME: String(70)  @title: 'AG Partner Name' ; 
        @Common.TextFor 
        WE_PARTNER_NAME: String(70)  @title: 'WE Partner Name' ; 
        delivery: Composition of many DELIVERY_DETAILS on $self.VBELN = delivery.VBELN and $self.POSNR = delivery.POSNR;
        notes: Composition of many CV_NOTES on $self.VBELN = notes.VBELN and $self.POSNR = notes.POSNR;
        shipment: Composition of many SHIPMENT_DETAILS on $self.VBELN = shipment.VBELN and $self.POSNR = shipment.POSNR;
        
	
    
};
@cds.persistence.exists
entity ![DELIVERY_DETAILS]{
        MANDT: String(3)  @title: 'MANDT' ; 
        VBELN: String(10)  @title: 'VBELN' ; 
        POSNR: String(6)  @title: 'POSNR' ; 
        VBELN_DEL: String(10)  @title: 'VBELN_DEL' ; 
        POSNR_DEL: String(6)  @title: 'POSNR_DEL' ; 
        CHARG: String(10)  @title: 'CHARG' ; 
        LFIMG: Decimal(13, 3)  @title: 'LFIMG' ; 
        VRKME: String(3)  @title: 'VRKME' ; 
        POSAR: String(1)  @title: 'POSAR' ; 
        VGBEL: String(10)  @title: 'VGBEL' ; 
        VGPOS: String(6)  @title: 'VGPOS' ; 
        @Common.Text           : LFART_VTEXT
        @Common.TextArrangement: #TextLast
        LFART: String(4)  @title: 'LFART' ; 
        @Common.TextFor
        LFART_VTEXT: String(20)  @title: 'LFART_VTEXT' ; 
        LFDAT_DATE: Date  @title: 'LFDAT' ; 
        HSDAT_DATE: Date @title:'HSDAT';
        VFDAT_DATE: Date @title:'HSDAT';
        TRAID: String(20)  @title: 'TRAID' ; 
        ZZ0S2BLNR: String(30)  @title: 'ZZ0S2BLNR' ; 
        PEND_DEL_QUAN: String(500)  @title: 'PEND_DEL_QUAN' ;
        salesorder: Association to one SALESORDER_DETAILS on $self.VBELN = salesorder.VBELN and $self.POSNR = salesorder.POSNR;
}

@cds.persistence.exists 
@cds.persistence.calcview 
entity ![CV_NOTES] {
        UTCTIME: Decimal(15)  @title: 'UTCTIME' ; 
        VBELN: String(10)  @title: 'VBELN' ; 
        POSNR: String(6)  @title: 'POSNR' ; 
        LANGUAGE: String(2)  @title: 'LANGUAGE' ; 
        NOTE_TEXT: String(1000)  @title: 'NOTE_TEXT' ; 
        salesorder: Association to one SALESORDER_DETAILS on $self.VBELN = salesorder.VBELN and $self.POSNR = salesorder.POSNR
}

@cds.persistence.exists 
entity ![ST_NOTES] {
        ID: Integer64  @title: 'ID' ;
        CLIENT: String(3) @title:'Client';
        VBELN: String(10)  @title: 'VBELN' ; 
        POSNR: String(6)  @title: 'POSNR' ; 
        UTCTIME: Decimal(15) not null  @title: 'UTCTIME' ; 
        LANGUAGE: String(2)  @title: 'LANGUAGE' ; 
        NOTE_TITLE: String(60)  @title: 'NOTE_TITLE' ; 
        NOTE_TEXT: String(1000)  @title: 'NOTE_TEXT' ; 
}

@cds.persistence.exists
entity ![SHIPMENT_DETAILS] {
        MANDT: String(3)  @title: 'MANDT' ; 
        VBELN: String(10)  @title: 'VBELN' ; 
        POSNR: String(6)  @title: 'POSNR' ; 
        VBELN_DEL: String(10)  @title: 'VBELN_DEL' ; 
        POSNR_DEL: String(6)  @title: 'POSNR_DEL' ; 
        TKNUM: String(10) @title: 'TKNUM';
        VSART: String(2) @title: 'VSART';
        VSART_BEZEI: String(20) @title: 'VSART_BEZEI';
        EXTI1: String(20) @title: 'EXTI1';
	TDLNR: String(10) @title: 'TDLNR';
	TDLNR_NAME1: String(35) @title: 'TDLNR_NAME1';
	STATUS_CODE_ELEM: String(3) @title: 'STATUS_CODE_ELEM';
	STATUS_REASON_CODE_ELEM: String(3) @title : 'STATUS_REASON_CODE_ELEM';
	STATUS_CODE_TEXT_ELEM: String(255) @title : 'STATUS_CODE_TEXT_ELEM';
	STATUS_REASON_CODE_TEXT_ELEM: String(255) @title : 'STATUS_REASON_CODE_TEXT_ELEM';
	TRACKING_ID_ELEM: String(12) @title : 'TRACKING_ID_ELEM';
	ALERT_STATUS_CODE_ELEM: String(3) @title : 'ALERT_STATUS_CODE_ELEM';
	ALERT_STATUS_REASON_CODE_ELEM: String(3) @title : 'ALERT_STATUS_REASON_CODE_ELEM';
	ALERT_STATUS_CODE_TEXT_ELEM: String(255) @title : 'ALERT_STATUS_CODE_TEXT_ELEM';
	ALERT_STATUS_REASON_CODE_TEXT_ELEM: String(255) @title : 'ALERT_STATUS_REASON_CODE_TEXT_ELEM';
	STATUS_CODE_COMP: String(3) @title : 'STATUS_CODE_COMP';
	REASON_CODE_COMP: String(17) @title : 'REASON_CODE_COMP';
	STATUS_CODE_TEXT_COMP: String(100) @title : 'STATUS_CODE_TEXT_COMP';
	REASON_CODE_TEXT_COMP: String(100) @title : 'REASON_CODE_TEXT_COMP';
	TRACKING_ID_COMP: String(50) @title : 'TRACKING_ID_COMP';
	DPTBG_DATE: Date @title : 'DPTBG_DATE';
        DATBG_DATE: Date @title : 'DATBG_DATE';
        DPTEN_DATE: Date @title: 'DPTEN_DATE';
        DATEN_DATE: Date @title: 'DATEN_DATE';
        salesorder: Association to one SALESORDER_DETAILS on $self.VBELN = salesorder.VBELN and $self.POSNR = salesorder.POSNR;
}