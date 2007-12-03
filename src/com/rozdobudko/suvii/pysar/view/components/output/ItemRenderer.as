package com.rozdobudko.suvii.pysar.view.components.output
{
	import com.rozdobudko.suvii.pysar.model.data.FindDataRange;
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.UIComponent;
	import flash.geom.Rectangle;
	import mx.events.ResizeEvent;
	import mx.controls.dataGridClasses.DataGridColumn;
	import flash.display.DisplayObject;

	public class ItemRenderer extends DataGridItemRenderer implements IListItemRenderer
	{
		private var container:UIComponent;
		private var bitmap:BitmapData;
		private var hightlights:Bitmap;
		
		public function ItemRenderer()
		{
			super();
			
			this.addEventListener(Event.ADDED, this.addedHandler);
			
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
			/**
			 * TODO: Refactory. Now created one unnecessary itemRenderer for each column, in this itemRenderer not runing method "setActualSize".
			 */
			 
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
			
			this.container.x = this.x;
			this.container.y = this.y;
			
			this.bitmap = new BitmapData(this.width,  this.height, true, 0x00000000);
			this.hightlights.bitmapData = this.bitmap;
			
			for(var i:uint; i<this.entry.findData.ranges.length; i++)
			{
				var range:FindDataRange = this.entry.findData.ranges[i];
				
				if(range.logText == logText)
				{
					var beginRect:Rectangle = this.getCharBoundaries(range.beginIndex);
					var endRect:Rectangle = this.getCharBoundaries(range.endIndex - 1);
					
					var rectangle:Rectangle = new Rectangle(beginRect.x, 
															beginRect.y, 
															endRect.x - beginRect.x + endRect.width, 
															beginRect.height);
					
					this.bitmap.fillRect(rectangle, this.entry.hightlightColor);
				}
			}
		}
		override public function validateNow():void
		{
			super.validateNow();
		}
		
		//-------------------------------------------//
		
		private function addedHandler(event:Event):void
		{
			var index:uint;
			
			for(var i:uint; i<this.parent.numChildren; i++)
			{
				if(this.parent.getChildAt(i) is ItemRenderer)
				{
					index = i;
					break;
				}
			}
			
			this.container = new UIComponent();
			this.hightlights = new Bitmap();
			this.container.addChild(this.hightlights);
			this.parent.addChildAt(this.container, i);
		}
	}
}