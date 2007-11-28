package com.rozdobudko.suvii.pysar.view.components.output
{
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryFindDataRange;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	
	import flash.text.TextFormat;
	
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.formatters.SwitchSymbolFormatter;
	import com.rozdobudko.suvii.pysar.Settings;
	import com.rozdobudko.suvii.pysar.model.SettingsProxy;
	import com.rozdobudko.suvii.pysar.PysarFacade;

	public class ItemRenderer extends DataGridItemRenderer implements IListItemRenderer
	{
		public function ItemRenderer()
		{
			super();
			
			this.alwaysShowSelection = true;
		}
		
		// -------------------- FIEDS -------------------- //
		


		// ------------------- METHODS ------------------- //
		
		override public function validateProperties():void
		{
//			trace("ItemRenderer :: validateProperties");
			
			super.validateProperties();
			
			var dataField:String = DataGridListData(this.listData).dataField;
			var logText:LogEntryText = this.data[dataField] as LogEntryText;
			
			if(!logText)
			{
				return;
			}
			
			this.text = logText.label;
			
			var beginIndex:int = LogEntry(this.data).findData.beginIndex;
			var endIndex:int = LogEntry(this.data).findData.endIndex;
			
			if(beginIndex == endIndex || LogEntry(this.data).findData.cursor.current !== logText)
			{
				this.setSelection(0, 0);
			}
			else
			{
				this.setSelection(beginIndex, endIndex);
			}
			
			var settingsProxy:SettingsProxy = PysarFacade.getInstance().retrieveProxy(SettingsProxy.NAME) as SettingsProxy;
			
			switch(LogEntry(this.data).level)
			{
				case Settings.LEVEL_DEBUG :
					this.setStyle("fontWeight", "bold");
				break;
			}
		}
		override public function validateNow():void
		{
//			trace("ItemRenderer :: validateNow");
//			super.validateNow();
		}
		
	}
}