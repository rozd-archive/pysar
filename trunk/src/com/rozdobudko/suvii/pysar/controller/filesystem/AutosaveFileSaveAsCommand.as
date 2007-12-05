package com.rozdobudko.suvii.pysar.controller.filesystem
{
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.patterns.command.SimpleCommand;
	import org.puremvc.interfaces.INotification;
	import flash.filesystem.File;
	import flash.events.Event;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;

	public class AutosaveFileSaveAsCommand extends SimpleCommand implements ICommand
	{
		private var file:File = File.documentsDirectory;
		
		public function AutosaveFileSaveAsCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			trace("AutosaveFileSaveAsCommand");
			
			this.file.addEventListener(Event.SELECT, this.fileCompleteHandler);
			
			try
			{
				file.browseForSave("Save As");
			}
			catch(error:Error)
			{
				trace(error); // TODO: 
			}
		}
		
		private function fileCompleteHandler(event:Event):void
		{
			var stream:FileStream = new FileStream();
			stream.open(this.file, FileMode.WRITE);
			stream.writeUTFBytes("");
			stream.close();
		}
	}
}