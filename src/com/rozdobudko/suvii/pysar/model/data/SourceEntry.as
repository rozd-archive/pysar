package com.rozdobudko.suvii.pysar.model.data
{
	public class SourceEntry
	{
		// ---------------- STATIC FIELDS ---------------- //



		// --------------- PRIVATE FIELDS ---------------- //
		
		private var _name:String;

		private var _enabled:Boolean;
		
		// ----------------- CONSTRUCTOR ----------------- //
		
		public function SourceEntry(name:String, enabled:Boolean=true)
		{
			this.name = name;
			this.enabled = enabled;
		}
		
		// -------------------- FIEDS -------------------- //
		
		public function get name():String
		{
			return this._name;
		}
		
		public function set name(value:String):void
		{
			this._name = value;
		}
		
		public function get enabled():Boolean
		{
			return this._enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			this._enabled = value;
		}
	}
}