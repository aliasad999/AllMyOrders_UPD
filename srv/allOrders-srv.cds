using {allorders.db as db} from '../db/allOrders.cds';


service srvOpenOrders {
  @readonly
  @cds.redirection.target: true
  entity Results    as
    select from db.SALESORDER_DETAILS {
      key null                                        as id : UUID,
          *,
          delivery.VBELN_DEL                          as VBELN_DEL,
          delivery.POSNR_DEL                          as POSNR_DEL,
          delivery.CHARG                              as CHARG,
          delivery.LFIMG                              as LFIMG,
          delivery.VRKME                              as VRKME_DEL,
          delivery.POSAR                              as POSAR,
          delivery.VGBEL                              as VGBEL,
          delivery.VGPOS                              as VGPOS,
          delivery.LFART                              as LFART,
          delivery.LFART_VTEXT                        as LFART_VTEXT,
          delivery.LFDAT_DATE                         as LFDAT_DATE,
          delivery.HSDAT_DATE                         as HSDAT_DATE,
          delivery.VFDAT_DATE                         as VFDAT_DATE,
          delivery.TRAID                              as TRAID,
          delivery.ZZ0S2BLNR                          as ZZ0S2BLNR,
          delivery.PEND_DEL_QUAN                      as PEND_DEL_QUAN,
          notes.NOTE_TEXT                             as LAST_NOTE,
          notes.LANGUAGE                              as LANGUAGE,
          shipment.TKNUM                              as TKNUM,
          shipment.VSART                              as VSART,
          shipment.VSART_BEZEI                        as VSART_BEZEI,
          shipment.EXTI1                              as EXTI1,
          shipment.TDLNR                              as TDLNR,
          shipment.TDLNR_NAME1                        as TDLNR_NAME1,
          shipment.STATUS_CODE_ELEM                   as STATUS_CODE_ELEM,
          shipment.STATUS_REASON_CODE_ELEM            as STATUS_REASON_CODE_ELEM,
          shipment.STATUS_CODE_TEXT_ELEM              as STATUS_CODE_TEXT_ELEM,
          shipment.STATUS_REASON_CODE_TEXT_ELEM       as STATUS_REASON_CODE_TEXT_ELEM,
          shipment.TRACKING_ID_ELEM                   as TRACKING_ID_ELEM,
          shipment.ALERT_STATUS_CODE_ELEM             as ALERT_STATUS_CODE_ELEM,
          shipment.ALERT_STATUS_REASON_CODE_ELEM      as ALERT_STATUS_REASON_CODE_ELEM,
          shipment.ALERT_STATUS_CODE_TEXT_ELEM        as ALERT_STATUS_CODE_TEXT_ELEM,
          shipment.ALERT_STATUS_REASON_CODE_TEXT_ELEM as ALERT_STATUS_REASON_CODE_TEXT_ELEM,
          shipment.STATUS_CODE_COMP                   as STATUS_CODE_COMP,
          shipment.REASON_CODE_COMP                   as REASON_CODE_COMP,
          shipment.STATUS_CODE_TEXT_COMP              as STATUS_CODE_TEXT_COMP,
          shipment.REASON_CODE_TEXT_COMP              as REASON_CODE_TEXT_COMP,
          shipment.TRACKING_ID_COMP                   as TRACKING_ID_COMP,
          shipment.DPTBG_DATE                         as DPTBG_DATE,
          shipment.DATBG_DATE                         as DATBG_DATE,
          shipment.DPTEN_DATE                         as DPTEN_DATE,
          shipment.DATEN_DATE                         as DATEN_DATE
    };

  entity valueHelps as projection on db.SALESORDER_DETAILS {
    key null                                        as id : UUID,
        *,
        delivery.VBELN_DEL                          as VBELN_DEL,
        delivery.POSNR_DEL                          as POSNR_DEL,
        delivery.CHARG                              as CHARG,
        delivery.LFIMG                              as LFIMG,
        delivery.VRKME                              as VRKME_DEL,
        delivery.POSAR                              as POSAR,
        delivery.VGBEL                              as VGBEL,
        delivery.VGPOS                              as VGPOS,
        delivery.LFART                              as LFART,
        delivery.LFART_VTEXT                        as LFART_VTEXT,
        delivery.LFDAT_DATE                         as LFDAT_DATE,
        delivery.HSDAT_DATE                         as HSDAT_DATE,
        delivery.VFDAT_DATE                         as VFDAT_DATE,
        delivery.TRAID                              as TRAID,
        delivery.ZZ0S2BLNR                          as ZZ0S2BLNR,
        delivery.PEND_DEL_QUAN                      as PEND_DEL_QUAN,
        notes.NOTE_TEXT                             as LAST_NOTE,
        notes.LANGUAGE                              as LANGUAGE,
        shipment.TKNUM                              as TKNUM,
        shipment.VSART                              as VSART,
        shipment.VSART_BEZEI                        as VSART_BEZEI,
        shipment.EXTI1                              as EXTI1,
        shipment.TDLNR                              as TDLNR,
        shipment.TDLNR_NAME1                        as TDLNR_NAME1,
        shipment.STATUS_CODE_ELEM                   as STATUS_CODE_ELEM,
        shipment.STATUS_REASON_CODE_ELEM            as STATUS_REASON_CODE_ELEM,
        shipment.STATUS_CODE_TEXT_ELEM              as STATUS_CODE_TEXT_ELEM,
        shipment.STATUS_REASON_CODE_TEXT_ELEM       as STATUS_REASON_CODE_TEXT_ELEM,
        shipment.TRACKING_ID_ELEM                   as TRACKING_ID_ELEM,
        shipment.ALERT_STATUS_CODE_ELEM             as ALERT_STATUS_CODE_ELEM,
        shipment.ALERT_STATUS_REASON_CODE_ELEM      as ALERT_STATUS_REASON_CODE_ELEM,
        shipment.ALERT_STATUS_CODE_TEXT_ELEM        as ALERT_STATUS_CODE_TEXT_ELEM,
        shipment.ALERT_STATUS_REASON_CODE_TEXT_ELEM as ALERT_STATUS_REASON_CODE_TEXT_ELEM,
        shipment.STATUS_CODE_COMP                   as STATUS_CODE_COMP,
        shipment.REASON_CODE_COMP                   as REASON_CODE_COMP,
        shipment.STATUS_CODE_TEXT_COMP              as STATUS_CODE_TEXT_COMP,
        shipment.REASON_CODE_TEXT_COMP              as REASON_CODE_TEXT_COMP,
        shipment.TRACKING_ID_COMP                   as TRACKING_ID_COMP,
        shipment.DPTBG_DATE                         as DPTBG_DATE,
        shipment.DATBG_DATE                         as DATBG_DATE,
        shipment.DPTEN_DATE                         as DPTEN_DATE,
        shipment.DATEN_DATE                         as DATEN_DATE
  }

  entity notes      as
    select from db.ST_NOTES {
      key CLIENT,
      key ID,
      key VBELN,
      key POSNR,
          *
    };
  
  entity PartnerSettings as projection on db.PARTNER_SETTINGS;
}
