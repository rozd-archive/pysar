package com.rozdobudko.suvii.pysar.view.components.output
{
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	
	import flash.events.Event;
	
	import mx.controls.TextInput;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.IListItemRenderer;

	public class ItemEditor extends TextInput implements IListItemRenderer
	{
		private var _data:Object;
		private var _dataItem:LogEntryText;
		
		public function ItemEditor()
		{
			super();
			
			this.addEventListener(Event.REMOVED, this.removedHandler);
		}
		
		
		public function get dataItem():LogEntryText
		{
			return this._dataItem;
		}
		
		
		public function set dataItem(value:LogEntryText):void
		{
			this._dataItem = value;
		}
		
		
		override public function get data():Object
		{
			return this._data;
		}
		
		
		override public function set data(value:Object):void
		{
			this._data = value;
			
			var dataField:String = DataGridListData(this.listData).dataField;
			this.dataItem = this.data[dataField] as LogEntryText;
			
			if(!this.dataItem)
			{
				super.data = value;
				return;
			}
			
			this.text = this.dataItem.text;
		}
		
		
		override public function validateProperties():void
		{
			trace("ItemEditor :: validateProperties");
			
			super.validateProperties();
		}
		
		
		private function removedHandler(event:Event):void
		{
			trace("ItemEditor :: removedHandler");
			
			this.dataItem.text = this.text;
			
		}
	}
}