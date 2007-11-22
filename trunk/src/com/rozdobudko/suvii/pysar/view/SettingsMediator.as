package com.rozdobudko.suvii.pysar.view
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.Settings;
	import com.rozdobudko.suvii.pysar.model.SettingsProxy;
	import com.rozdobudko.suvii.pysar.view.components.SettingsPanel;
	import com.rozdobudko.suvii.pysar.view.events.LevelStyleFormatterEvent;
	
	import flash.events.MouseEvent;
	
	import mx.controls.RadioButtonGroup;
	import mx.events.ColorPickerEvent;
	import mx.events.ItemClickEvent;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.patterns.mediator.Mediator;
	import org.puremvc.patterns.observer.Notification;

	public class SettingsMediator extends Mediator implements IMediator
	{
		// ---------------- STATIC FIELDS ---------------- //

		public static const NAME:String = "SettingsMediator";

		// ---------------- PRIVATE FIELDS --------------- //

		private var levelsBoxGroup:Array;

		private var levelsRadioGroup:RadioButtonGroup;
		
		private var icons:Array;
		
		private var levels:Array;
		
		// ----------------- CONSTRUCTOR ----------------- //
		
		public function SettingsMediator(viewComponent:Object=null)
		{
			super(viewComponent);
			
			this.component.container.creationPolicy
			
			this.component.cancelBut.addEventListener(MouseEvent.CLICK, this.cancelClickHandler);
			this.component.okBut.addEventListener(MouseEvent.CLICK, this.okClickHandler);
			
			this.component.levelsRadioGroup.addEventListener(ItemClickEvent.ITEM_CLICK, this.levelGroupClickHandler);
			
			this.component.debugBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.component.infoBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.component.warningBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.component.errorBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.component.fatalBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			
			this.component.debugStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_FONT, this.styleFormatterChangeFontHandler);
			this.component.debugStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_COLOR, this.styleFormatterChangeColorHandler);
			this.component.debugStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_BOLD, this.styleFormatterChangeBoldHandler);
			this.component.debugStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_ITALIC, this.styleFormatterChangeItalicHandler);
			
			this.component.infoStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_FONT, this.styleFormatterChangeFontHandler);
			this.component.infoStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_COLOR, this.styleFormatterChangeColorHandler);
			this.component.infoStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_BOLD, this.styleFormatterChangeBoldHandler);
			this.component.infoStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_ITALIC, this.styleFormatterChangeItalicHandler);
			
			this.component.warningStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_FONT, this.styleFormatterChangeFontHandler);
			this.component.warningStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_COLOR, this.styleFormatterChangeColorHandler);
			this.component.warningStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_BOLD, this.styleFormatterChangeBoldHandler);
			this.component.warningStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_ITALIC, this.styleFormatterChangeItalicHandler);
			
			this.component.errorStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_FONT, this.styleFormatterChangeFontHandler);
			this.component.errorStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_COLOR, this.styleFormatterChangeColorHandler);
			this.component.errorStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_BOLD, this.styleFormatterChangeBoldHandler);
			this.component.errorStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_ITALIC, this.styleFormatterChangeItalicHandler);
			
			this.component.fatalStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_FONT, this.styleFormatterChangeFontHandler);
			this.component.fatalStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_COLOR, this.styleFormatterChangeColorHandler);
			this.component.fatalStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_BOLD, this.styleFormatterChangeBoldHandler);
			this.component.fatalStyleFormatter.addEventListener(LevelStyleFormatterEvent.CHANGE_ITALIC, this.styleFormatterChangeItalicHandler);
			
			this.levelsBoxGroup = [
									this.component.debugBox, 
									this.component.infoBox, 
									this.component.warningBox, 
									this.component.errorBox, 
									this.component.fatalBox
								  ];
								  
			this.levelsRadioGroup = this.component.levelsRadioGroup;
			
			this.icons = [];
			this.icons[Settings.LEVEL_DEBUG] = this.component.debugIconImage;
			this.icons[Settings.LEVEL_INFO] = this.component.infoIconImage;
			this.icons[Settings.LEVEL_WARNING] = this.component.warningIconImage;
			this.icons[Settings.LEVEL_ERROR] = this.component.errorIconImage;
			this.icons[Settings.LEVEL_FATAL] = this.component.fatalIconImage;
			
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
			this.levels = this.proxy.levels || [];
			
			this.updateLevelsIcons();
		}
		
		private function save():void
		{
			this.proxy.levels = this.levels;
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
		
		// ------------------- HANDLERS ------------------- //
		
		
		
		// --------------- USER INTERACTION --------------- //
		
		private function cancelClickHandler(event:MouseEvent):void
		{
			this.facade.notifyObservers(new Notification(PysarFacade.SETTINGS_CLOSE));
		}
		
		
		private function okClickHandler(event:MouseEvent):void
		{
			this.save();
			
			this.facade.notifyObservers(new Notification(PysarFacade.SETTINGS_CLOSE));
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
	
	
		private function styleFormatterChangeFontHandler(event:LevelStyleFormatterEvent):void
		{
			trace("SettingsMediator :: styleFormatterChangeFontHandler");
		}
		
		
		private function styleFormatterChangeColorHandler(event:LevelStyleFormatterEvent):void
		{
			trace("SettingsMediator :: styleFormatterChangeColorHandler");
			
			switch(event.target)
			{
				case this.component.debugStyleFormatter :
					this.proxy.debugStyle.setStyle("color", event.target.color.toString());
					event.target.style = this.proxy.debugStyle;
				break;
				case this.component.infoStyleFormatter :
					this.proxy.infoStyle.setStyle("color", event.target.color.toString());
					event.target.style = this.proxy.infoStyle;
				break;
				case this.component.warningStyleFormatter :
					this.proxy.warningStyle.setStyle("color", event.target.color.toString());
					event.target.style = this.proxy.warningStyle;
				break;
				case this.component.errorStyleFormatter :
					this.proxy.errorStyle.setStyle("color", event.target.color.toString());
					event.target.style = this.proxy.errorStyle;
				break;
				case this.component.fatalStyleFormatter :
					this.proxy.fatalStyle.setStyle("color", event.target.color.toString());
					event.target.style = this.proxy.fatalStyle;
				break;
			}
		}
		
		
		private function styleFormatterChangeBoldHandler(event:LevelStyleFormatterEvent):void
		{
			trace("SettingsMediator :: styleFormatterChangeBoldHandler");
			
			switch(event.target)
			{
				case this.component.debugStyleFormatter :
					this.proxy.debugStyle.setStyle("fontWeight", event.target.bold ? "bold" : "normal");
					event.target.style = this.proxy.debugStyle;
				break;
				case this.component.infoStyleFormatter :
					this.proxy.infoStyle.setStyle("fontWeight", event.target.bold ? "bold" : "normal");
					event.target.style = this.proxy.infoStyle;
				break;
				case this.component.warningStyleFormatter :
					this.proxy.warningStyle.setStyle("fontWeight", event.target.bold ? "bold" : "normal");
					event.target.style = this.proxy.warningStyle;
				break;
				case this.component.errorStyleFormatter :
					this.proxy.errorStyle.setStyle("fontWeight", event.target.bold ? "bold" : "normal");
					event.target.style = this.proxy.errorStyle;
				break;
				case this.component.fatalStyleFormatter :
					this.proxy.fatalStyle.setStyle("fontWeight", event.target.bold ? "bold" : "normal");
					event.target.style = this.proxy.fatalStyle;
				break;
			}
		}
		
		
		private function styleFormatterChangeItalicHandler(event:LevelStyleFormatterEvent):void
		{
			trace("SettingsMediator :: styleFormatterChangeItalicHandler");
			
			switch(event.target)
			{
				case this.component.debugStyleFormatter :
					this.proxy.debugStyle.setStyle("fontStyle", event.target.italic ? "italic" : "normal");
					event.target.style = this.proxy.debugStyle;
				break;
				case this.component.infoStyleFormatter :
					this.proxy.infoStyle.setStyle("fontStyle", event.target.italic ? "italic" : "normal");
					event.target.style = this.proxy.infoStyle;
				break;
				case this.component.warningStyleFormatter :
					this.proxy.warningStyle.setStyle("fontStyle", event.target.italic ? "italic" : "normal");
					event.target.style = this.proxy.warningStyle;
				break;
				case this.component.errorStyleFormatter :
					this.proxy.errorStyle.setStyle("fontStyle", event.target.italic ? "italic" : "normal");
					event.target.style = this.proxy.errorStyle;
				break;
				case this.component.fatalStyleFormatter :
					this.proxy.fatalStyle.setStyle("fontStyle", event.target.italic ? "italic" : "normal");
					event.target.style = this.proxy.fatalStyle;
				break;
			}
		}
	}
}