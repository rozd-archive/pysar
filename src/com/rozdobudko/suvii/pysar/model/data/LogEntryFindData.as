package com.rozdobudko.suvii.pysar.model.data
{
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	
	public class LogEntryFindData
	{
		private var _ranges:Array;
		
		private var _owner:LogEntry;
		private var _beginIndex:int;
		private var _endIndex:int;
		
		private var _textes:ArrayCollection;
		private var _cursor:IViewCursor;
		
		public function LogEntryFindData(owner:LogEntry)
		{
			super();
			
			this._textes = new ArrayCollection();
			
			this.owner = owner;
			
			if(!owner)
			{
				throw new Error("0001");
			}
			
			this._textes.addItem(this.owner.message);
			this._textes.addItem(this.owner.className);
			this._textes.addItem(this.owner.connectionName);
			
			this._cursor = this._textes.createCursor();
		}
		
		
		// -------------------- FIEDS -------------------- //
		
		public function get owner():LogEntry
		{
			return this._owner;
		}
		
		
		public function set owner(value:LogEntry):void
		{
			this._owner = value;
		}
		
		
		public function get cursor():IViewCursor
		{
			return this._cursor;
		}
		
		/**
		 * List of the LogEntryFindDataRange instances.
		 */
		public function get ranges():Array
		{
			return this._ranges;
		}
		
		
		public function set ranges(value:Array):void
		{
			this._ranges = value;
		}
		
		
		public function get beginIndex():int
		{
			return this._beginIndex;
		}
		
		
		public function set beginIndex(value:int):void
		{
			this._beginIndex = value;
		}


		public function get endIndex():int
		{
			return this._endIndex;
		}
		
		
		public function set endIndex(value:int):void
		{
			this._endIndex = value;
		}
		
		// ------------------- METHODS ------------------- //
	}
}