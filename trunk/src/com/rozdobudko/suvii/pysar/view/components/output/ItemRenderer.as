package com.rozdobudko.suvii.pysar.view.components.output
{
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	
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
		
		override public function get data():Object
		{
			return super.data;
		}

		override public function set data(value:Object):void
		{
			super.data = value;
		}
		
		public function get entry():LogEntry
		{
			return this.data as LogEntry;
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
			
			this.text = logText.label;
			
			var beginIndex:int = this.entry.findData.beginIndex;
			var endIndex:int = this.entry.findData.endIndex;
			
			if(beginIndex == endIndex || this.entry.findData.cursor.current !== logText)
			{
				this.setSelection(0, 0);
			}
			else
			{
				this.setSelection(beginIndex, endIndex);
			}
			
			this.styleName = this.entry.style;
		}
		override public function validateNow():void
		{
//			trace("ItemRenderer :: validateNow");
			super.validateNow();
		}
		
	}
}