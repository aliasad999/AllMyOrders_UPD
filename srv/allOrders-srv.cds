using {allorders.db as db} from '../db/allOrders.cds';


service srvOpenOrders {
  @readonly
  @cds.redirection.target: true
  entity Results    as
    select from db.SALESORDER_DETAILS {
      key null                   as id : UUID,
          *,
          delivery.VBELN_DEL     as VBELN_DEL,
          delivery.POSNR_DEL     as POSNR_DEL,
          delivery.CHARG         as CHARG,
          delivery.LFIMG         as LFIMG,
          delivery.VRKME         as VRKME_DEL,
          delivery.POSAR         as POSAR,
          delivery.VGBEL         as VGBEL,
          delivery.VGPOS         as VGPOS,
          delivery.LFART         as LFART,
          delivery.LFART_VTEXT   as LFART_VTEXT,
          delivery.LFDAT_DATE    as LFDAT_DATE,
          delivery.HSDAT_DATE    as HSDAT_DATE,
          delivery.VFDAT_DATE    as VFDAT_DATE,
          delivery.TRAID         as TRAID,
          delivery.ZZ0S2BLNR     as ZZ0S2BLNR,
          delivery.PEND_DEL_QUAN as PEND_DEL_QUAN,
          notes.NOTE_TEXT        as LAST_NOTE,
          notes.LANGUAGE        as LANGUAGE
    };

  entity valueHelps as projection on db.SALESORDER_DETAILS {
    key null                   as id : UUID,
        *,
        delivery.VBELN_DEL     as VBELN_DEL,
        delivery.POSNR_DEL     as POSNR_DEL,
        delivery.CHARG         as CHARG,
        delivery.LFIMG         as LFIMG,
        delivery.VRKME         as VRKME_DEL,
        delivery.POSAR         as POSAR,
        delivery.VGBEL         as VGBEL,
        delivery.VGPOS         as VGPOS,
        delivery.LFART         as LFART,
        delivery.LFART_VTEXT   as LFART_VTEXT,
        delivery.LFDAT_DATE    as LFDAT_DATE,
        delivery.HSDAT_DATE    as HSDAT_DATE,
        delivery.VFDAT_DATE    as VFDAT_DATE,
        delivery.TRAID         as TRAID,
        delivery.ZZ0S2BLNR     as ZZ0S2BLNR,
        delivery.PEND_DEL_QUAN as PEND_DEL_QUAN,
        notes.NOTE_TEXT        as LAST_NOTE,
        notes.LANGUAGE        as LANGUAGE
  } 

  entity notes as select from db.ST_NOTES{
    key CLIENT,
    key ID,
    key VBELN,
    key POSNR,
    *
  };
}