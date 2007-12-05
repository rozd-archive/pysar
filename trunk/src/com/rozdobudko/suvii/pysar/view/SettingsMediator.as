package com.rozdobudko.suvii.pysar.view
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.Settings;
	import com.rozdobudko.suvii.pysar.model.SettingsProxy;
	import com.rozdobudko.suvii.pysar.view.components.SettingsPanel;
	import com.rozdobudko.suvii.pysar.view.events.LevelStyleFormatterEvent;
	
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import mx.controls.RadioButtonGroup;
	import mx.events.ItemClickEvent;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.patterns.mediator.Mediator;
	import org.puremvc.patterns.observer.Notification;
	import mx.styles.CSSStyleDeclaration;
	
	import com.rozdobudko.suvii.utils.ObjectUtils;
	import flash.filesystem.File;
	import flash.events.Event;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;

	public class SettingsMediator extends Mediator implements IMediator
	{
		// ---------------- STATIC FIELDS ---------------- //

		public static const NAME:String = "SettingsMediator";

		// ---------------- PRIVATE FIELDS --------------- //

		private var levelsBoxGroup:Array;

		private var levelsRadioGroup:RadioButtonGroup;
		
		private var icons:Array;
		
		private var levels:Array;
		
		/**
		 * @private
		 * Collection of styles from <code>SettingsProxy</code>, all elements is CSSStyleDeclaration type.
		 * As a key using instance of <code>LevelStyleFormatterEvent</code>.
		 */
		private var stylesMap:Dictionary;
		
		// ----------------- CONSTRUCTOR ----------------- //
		
		public function SettingsMediator(viewComponent:Object=null)
		{
			super(viewComponent);
				
				// main
				
			this.component.cancelBut.addEventListener(MouseEvent.CLICK, this.cancelClickHandler);
			this.component.okBut.addEventListener(MouseEvent.CLICK, this.okClickHandler);
			
				// levels 
				
			this.levelsRadioGroup = this.component.levelsRadioGroup;
								  
			this.levelsRadioGroup.addEventListener(ItemClickEvent.ITEM_CLICK, this.levelGroupClickHandler);
			
			this.levelsBoxGroup = [
									this.component.debugBox, 
									this.component.infoBox, 
									this.component.warningBox, 
									this.component.errorBox, 
									this.component.fatalBox
								  ];
			
			this.component.debugBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.component.infoBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.component.warningBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.component.errorBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.component.fatalBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			
			this.icons = [];
			this.icons[Settings.LEVEL_DEBUG] =		this.component.debugIconImage;
			this.icons[Settings.LEVEL_INFO] =		this.component.infoIconImage;
			this.icons[Settings.LEVEL_WARNING] =	this.component.warningIconImage;
			this.icons[Settings.LEVEL_ERROR] =		this.component.errorIconImage;
			this.icons[Settings.LEVEL_FATAL] =		this.component.fatalIconImage;
			
				// autosave
			
			this.component.openAutosaveFileBut.addEventListener(MouseEvent.CLICK, this.openAutosaveFileHandler);
			
			this.init();
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		private function get component():SettingsPanel
		{
			return this.getViewComponent() as SettingsPanel;
		}
		
		private function get proxy():SettingsProxy
		{
			return this.facade.retrieveProxy(SettingsProxy.NAME) as SettingsProxy;
		}
		
		// -------------------- FIEDS -------------------- //
		
		
		
		// --------------- PRIVATE METHODS --------------- //
		
		private function init():void
		{
			this.levels = this.proxy.levels ? this.proxy.levels.concat() : [];
			
			this.component.debugStyleFormatter.style =		this.cloneStyle(this.proxy.debugStyle);
			this.component.infoStyleFormatter.style =		this.cloneStyle(this.proxy.infoStyle);
			this.component.warningStyleFormatter.style =	this.cloneStyle(this.proxy.warningStyle);
			this.component.errorStyleFormatter.style =		this.cloneStyle(this.proxy.errorStyle);
			this.component.fatalStyleFormatter.style =		this.cloneStyle(this.proxy.fatalStyle);
			
			this.updateLevelsIcons();
		}
		
		private function save():void
		{
			this.proxy.levels = this.levels.concat();
			
			this.copyStyle(this.component.debugStyleFormatter.style, this.proxy.debugStyle);
			this.copyStyle(this.component.infoStyleFormatter.style, this.proxy.infoStyle);
			this.copyStyle(this.component.warningStyleFormatter.style, this.proxy.warningStyle);
			this.copyStyle(this.component.errorStyleFormatter.style, this.proxy.errorStyle);
			this.copyStyle(this.component.fatalStyleFormatter.style, this.proxy.fatalStyle);
			
			this.proxy.save();
		}
		
		private function updateLevelsIcons():void
		{
			for(var i:uint; i<this.levels.length; i++)
			{
				this.icons[i].alpha = this.levels[i] ? 1 : 0.3;
				
				if(this.proxy.selectedLevelsByButtons)
				{
					if(this.levelsRadioGroup.selectedValue == null)
					{
						this.levelsRadioGroup.selectedValue = this.levels[i] ? i : this.levelsRadioGroup.selectedValue;
					}
					this.levelsBoxGroup[i].selected = false;
				}
				else if(this.proxy.selectedLevelsByBoxes)
				{
					this.levelsRadioGroup.selection = null;
					
					this.levelsBoxGroup[i].selected = this.levels[i];
				}
			}
		}
		
		/**
		 * @private
		 * Copy of the all styles from one style object to other.
		 * @param host The source object.
		 * @param site The object that get the styles.
		 */
		private function copyStyle(host:CSSStyleDeclaration, site:CSSStyleDeclaration):void
		{
			site.setStyle("color", host.getStyle("color")); 
			site.setStyle("fontFamily", host.getStyle("fontFamily")); 
			site.setStyle("fontStyle", host.getStyle("fontStyle")); 
			site.setStyle("fontWeight", host.getStyle("fontWeight")); 
			site.setStyle("paddingLeft", host.getStyle("paddingLeft")); 
			site.setStyle("paddingRight", host.getStyle("paddingRight"));
		}
		
		/**
		 * @private
		 * Clone of the CSSStyleDeclaration style object.
		 * @param The clonable object.
		 */
		private function cloneStyle(style:CSSStyleDeclaration):CSSStyleDeclaration
		{
			var clone:CSSStyleDeclaration = new CSSStyleDeclaration();
			
			this.copyStyle(style, clone);
			
			return clone;
		}
		
		// ------------------- HANDLERS ------------------- //
		
		
		
		// --------------- USER INTERACTION --------------- //
		
		private function cancelClickHandler(event:MouseEvent):void
		{
			this.facade.notifyObservers(new Notification(PysarFacade.SETTINGS_CLOSE));
		}
		
		
		private function okClickHandler(event:MouseEvent):void
		{
			this.save();
			
			this.facade.notifyObservers(new Notification(PysarFacade.SETTINGS_CHANGE));
		}
		
		
		private function levelGroupClickHandler(event:ItemClickEvent):void
		{
			this.levels = [];
			
			this.proxy.selectedLevelsByButtons = true;
			
			for(var j:uint; j<this.levelsRadioGroup.numRadioButtons; j++)
			{
				this.levels[j] = j >= this.levelsRadioGroup.selection.data;
			}
			
			this.updateLevelsIcons();
		}
		
		
		private function levelBoxClickHandler(event:MouseEvent):void
		{
			this.levels = [];
			
			this.proxy.selectedLevelsByBoxes = true;
			
			for(var i:uint; i<this.levelsBoxGroup.length; i++)
			{
				this.levels[this.levelsBoxGroup[i].data] = this.levelsBoxGroup[i].selected;
			}
			
			this.updateLevelsIcons();
		}
		
		
		private function openAutosaveFileHandler(event:MouseEvent):void
		{
			this.sendNotification(PysarFacade.FS_AUTOSAVE_FILE_SAVE_AS);
			
//			var file:File = File.documentsDirectory;
//			file.browseForSave("Save As");
//			file.addEventListener(Event.SELECT, this.autosaveSaveHandler);
//			file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.autosaveSecurityErrorHandler);
//			file.addEventListener(IOErrorEvent.IO_ERROR, this.autosaveIOErrorHandler);

//			var docsDir:File = File.documentsDirectory;
//			try
//			{
//			    docsDir.browseForSave("Save As");
//			    docsDir.addEventListener(Event.SELECT, this.saveData);
//			}
//			catch (error:Error)
//			{
//			    trace("Failed:", error.message)
//			}
////			
//			function saveData(event:Event):void 
//		{
//		    var newFile:File = event.target as File;
//		    var str:String = "Hello.";
//		    if (!newFile.exists)
//		    {
//		        var stream:FileStream = new FileStream();
//		        stream.open(newFile, FileMode.WRITE);
//		        stream.writeUTFBytes(str);
//		        stream.close();
//		    }
//		}
		}
		
		private function saveData(event:Event):void 
		{
		    var newFile:File = event.target as File;
		    var str:String = "Hello.";
		    if (!newFile.exists)
		    {
		        var stream:FileStream = new FileStream();
		        stream.open(newFile, FileMode.WRITE);
		        stream.writeUTFBytes(str);
		        stream.close();
		    }
		}
		
		public function autosaveSaveHandler(event:Event):void
		{
			trace("autosaveSaveHandler");
			
			var file:File = event.target as File;
			
			if(!file.exists)
			{
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.WRITE);
				stream.writeUTFBytes("");
				stream.close();
			}
		}
		
		private function autosaveSecurityErrorHandler(event:SecurityErrorEvent):void
		{
			trace(event);
		}
		private function autosaveIOErrorHandler(event:IOErrorEvent):void
		{
			trace(event);
		}
	}
}