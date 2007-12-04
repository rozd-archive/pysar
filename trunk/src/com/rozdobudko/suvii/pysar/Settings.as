package com.rozdobudko.suvii.pysar
{
	import flash.text.TextFormat;
	
	public class Settings
	{
		public static const CONNECTION_NAME:String = "_ASLogger_Default";
		
		/**
		 * String id of debug level.
		 */
		public static const DEBUG:String = "debug";
		
		/**
		 * String id of info level.
		 */
		public static const INFO:String = "info";
		
		/**
		 * String id of warning level.
		 */
		public static const WARNING:String = "warning";
		
		/**
		 * String id of error level.
		 */
		public static const ERROR:String = "error";
		
		/**
		 * String id of fatal level.
		 */
		public static const FATAL:String = "fatal";
		
		
		
		public static const LEVEL_DEBUG:Number = 0;
		public static const LEVEL_INFO:Number = 1;
		public static const LEVEL_WARNING:Number = 2;
		public static const LEVEL_ERROR:Number = 3;
		public static const LEVEL_FATAL:Number = 4;
		
		public static const FIND_HIGHTLIGHT_COLOR:Number = 0xFFFFFF00;
		
		public static const PREFERENCES_FILE_NAME:String = "preferences.xml";
	}
}