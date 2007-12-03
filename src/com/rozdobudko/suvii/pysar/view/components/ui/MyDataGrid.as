package com.rozdobudko.suvii.pysar.view.components.ui
{
	import flash.events.Event;
	
	import mx.controls.DataGrid;

	public class MyDataGrid extends DataGrid
	{
		public function MyDataGrid()
		{
			super();
		}
		
		override protected function scrollHandler(event:Event):void
		{
			super.scrollHandler(event);
			//trace("MyDataGrid :: scrollHandler");
		}
		
		 override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		 {
		 	trace("MyDataGrid :: updateDisplayList");
		 	trace(this.verticalScrollPosition);
		 	trace("");
		 	var v:Number = this.verticalScrollPosition;
		 	
		 	super.updateDisplayList(unscaledWidth, unscaledHeight);
		 	trace(this.verticalScrollPosition);
		 	
		 	this.verticalScrollPosition = v;
		 }
	}
}