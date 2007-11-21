package com.rozdobudko.suvii.pysar.view.components.output
{
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryFindDataRange;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	
	import flash.text.TextFormat;
	
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.IListItemRenderer;

	public class ItemRenderer extends DataGridItemRenderer implements IListItemRenderer
	{
		public function ItemRenderer()
		{
			super();
			
			this.alwaysShowSelection = true;
		}
		
		// -------------------- FIEDS -------------------- //
		
		override public function set data(value:Object):void
		{
			super.data = value;
		}
		
		override public function get data():Object
		{
			return super.data;
		}
		
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
			
			this.text = logText.text;
			
			var format:TextFormat = this.getTextFormat();
			
			var beginIndex:int = LogEntry(this.data).findData.beginIndex;
			var endIndex:int = LogEntry(this.data).findData.endIndex;
			
//			trace(this.text+" | "+LogEntry(this.data).findData.cursor.current +" - "+ logText + " === " + (LogEntry(this.data).findData.cursor.current === logText));
			
			if(beginIndex == endIndex || LogEntry(this.data).findData.cursor.current !== logText)
			{
				format.color = 0x000000;
				
				this.setSelection(0, 0);
				
				//this.setTextFormat(format);
			}
			else
			{
				format.color = 0xFF9900;
				
				this.setSelection(beginIndex, endIndex);
			}
		}
		override public function validateNow():void
		{
//			trace("ItemRenderer :: validateNow");
//			super.validateNow();
		}
		
	}
}