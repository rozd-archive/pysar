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
				case this.component.fatalStyleFormatter :
					
					this.proxy.fatalStyle.setStyle("color", this.component.fatalStyleFormatter.color.toString());
					this.component.fatalStyleFormatter.style = this.proxy.fatalStyle;
					
				break;
			}
		}
		
		private function styleFormatterChangeBoldHandler(event:LevelStyleFormatterEvent):void
		{
			trace("SettingsMediator :: styleFormatterChangeBoldHandler");
			
			switch(event.target)
			{
				case this.component.fatalStyleFormatter :
					
					this.proxy.fatalStyle.setStyle("fontWeight", this.component.fatalStyleFormatter.bold ? "bold" : "normal");
					this.component.fatalStyleFormatter.style = this.proxy.fatalStyle;
					
				break;
			}
		}
		
		private function styleFormatterChangeItalicHandler(event:LevelStyleFormatterEvent):void
		{
			trace("SettingsMediator :: styleFormatterChangeItalicHandler");
			
			switch(event.target)
			{
				case this.component.fatalStyleFormatter :
					
					this.proxy.fatalStyle.setStyle("fontStyle", this.component.fatalStyleFormatter.italic ? "italic" : "normal");
					this.component.fatalStyleFormatter.style = this.proxy.fatalStyle;
					
				break;
			}
		}
	}
}