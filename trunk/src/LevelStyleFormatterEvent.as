package com.rozdobudko.suvii.pysar.view.events
{
	import flash.events.Event;

	public class LevelStyleFormatterEvent extends Event
	{
		public static const CHANGE_FONT:String			= "changeFont";
		public static const CHANGE_COLOR:String			= "changeColor";
		public static const CHANGE_BOLD:String			= "changeBold";
		public static const CHANGE_ITALIC:String		= "changeItalic";
		public static const CLICK_FONT_BUTTON:String	= "clickFontButton";
		
		public function LevelStyleFormatterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}