package com.rozdobudko.suvii.pysar.model
{
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryFindData;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;
	import mx.utils.UIDUtil;
	import com.rozdobudko.suvii.pysar.PysarFacade;
	
	[Bindable("output")]
	
	public class OutputProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "OutputProxy";
		
		private var _cursor:IViewCursor;
		
		public function OutputProxy()
		{
			super(NAME, new ArrayCollection());
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getProxyName():String
		{
			return NAME;
		}
		
		// -------------------- FIEDS -------------------- //
		
		public function get entries():ArrayCollection
		{
			return this.getData() as ArrayCollection;
		}
		
		public function set entries(data:ArrayCollection):void
		{
			this.setData(data);
			
			this.sendNotification(PysarFacade.OUTPUT_UPDATE);
		}
		
		
		public function get cursor():IViewCursor
		{
			if(!this._cursor)
			{
				this._cursor = this.entries.createCursor();
			}
			
			return this._cursor;
		}
		
		// ------------------- METHODS ------------------- //
		
		public function addItem(item:LogEntry):void
		{
			item.findData = new LogEntryFindData(item);
			this.entries.addItem(item);
		}
		
		public function getItemAt(index:int):LogEntry
		{
			return this.entries.getItemAt(index) as LogEntry;
		}
		
		public function resetCursor():void
		{
			this._cursor = this.entries.createCursor();
		}
	}
}