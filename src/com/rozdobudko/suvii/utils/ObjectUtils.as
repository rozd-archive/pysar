package com.rozdobudko.suvii.utils
{
	import flash.net.registerClassAlias;
	
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class ObjectUtils
	{
		public static function copy(source:Object):Object
		{
			var typeName:String = getQualifiedClassName(source);
			var packageName:String = typeName.split("::")[0];
			var type:Class = Class(getDefinitionByName(typeName))
			
			registerClassAlias(packageName, type);
			
			var copy:ByteArray = new ByteArray();
			copy.writeObject(source);
			copy.position = 0;
			
			return copy.readObject();
		}
	}
}