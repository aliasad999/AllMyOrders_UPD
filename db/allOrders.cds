namespace allorders.db;

@cds.persistence.exists
entity![ORDERS]{
      	KEY![SALESORDER]:String(10);
		KEY![SALESORDERITEM]:String(6);
	
}

@cds.persistence.exists
entity VALUEHELPS {
      KEY![SALESORDER]:String(10);
		KEY![SALESORDERITEM]:String(6);
	}
