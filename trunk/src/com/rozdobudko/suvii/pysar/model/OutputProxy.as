package com.rozdobudko.suvii.pysar.model
{
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryFindData;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;
	
	[Bindable("output")]
	
	public class OutputProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "OutputProxy";
		
		private var _cursor:IViewCursor;
		
		public function OutputProxy()
		{
			super(NAME, new ArrayCollection());
			
			/**
			 * Test
			 */
			this.addItem(new LogEntry(
										0,
										new LogEntryText("TESTE"), 
										new LogEntryText("test"), 
										new LogEntryText("Lorem")
										));
			this.addItem(new LogEntry(
										0,
										new LogEntryText("TEST"), 
										new LogEntryText("test"), 
										new LogEntryText("Lorem ipsum")
										));
//			this.addItem(new LogEntry(
//										0, 
//										new LogEntryText("Lorem ipsum dolorem sit amet"), 
//										new LogEntryText("test"), 
//										new LogEntryText("Lorem")
//										));
//			this.addItem(new LogEntry(
//										0, 
//										new LogEntryText("Як умру то поховайте, мене на долині."), 
//										new LogEntryText("test"), 
//										new LogEntryText("Lorem")
//										));
			
			this._cursor = this.entries.createCursor();
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
		}
		
		
		public function get cursor():IViewCursor
		{
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
	}
}