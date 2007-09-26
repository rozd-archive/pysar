package modules
{
	import mx.containers.Panel;
	import mx.events.FlexEvent;
	import flash.events.MouseEvent;
	import common.Settings;
	import mx.controls.CheckBox;
	import flash.events.Event;
	import mx.events.ItemClickEvent;
	import mx.managers.PopUpManager;
	import ui.components.CustomizingGridPanel;
	
	/**
	 * Event flash.events.Event.CHANGE
	 * Dispatch when user click "OK" button.
	 */
	[Event(name="change", type="flash.events.Event")]

	/**
	 * Event flash.events.Event.CHANGE
	 * Dispatch when user click "Cancel" button.
	 */
	[Event(name="cancel", type="flash.events.Event")]

	public class SettingsModule extends SettingsModuleUI
	{
		public var levels:Array;
		
		private var levelsBoxGroup:Array;
		
		function SettingsModule(){
			super();
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			
			this.levelsBoxGroup = [];
		}
		
		//----------------Main methods--------------------
		public function init():void {
			trace("SettingsModule :: init");
			
			this.levels = new Array();
			
			this.debugButton.data = Settings.LEVEL_DEBUG;
			this.infoButton.data = Settings.LEVEL_INFO;
			this.warningButton.data = Settings.LEVEL_WARNING;
			this.errorButton.data = Settings.LEVEL_ERROR;
			this.fatalButton.data = Settings.LEVEL_FATAL;
			
			this.levelsRadioGroup.addEventListener(ItemClickEvent.ITEM_CLICK, this.levelsGroupClickHandler);
			
			this.debugBox.data = Settings.LEVEL_DEBUG;
			this.infoBox.data = Settings.LEVEL_INFO;
			this.warningBox.data = Settings.LEVEL_WARNING;
			this.errorBox.data = Settings.LEVEL_ERROR;
			this.fatalBox.data = Settings.LEVEL_FATAL;
			
			this.debugBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.infoBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.warningBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.errorBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.fatalBox.addEventListener(MouseEvent.CLICK, this.levelBoxClickHandler);
			this.levelsBoxGroup.push(this.debugBox, this.infoBox, this.warningBox, this.errorBox, this.fatalBox);
			
			this.okBut.addEventListener(MouseEvent.CLICK, this.okClickHandler);
			this.cancelBut.addEventListener(MouseEvent.CLICK, this.cancelClickHandler);
		}
		private function updateLevelsIcons():void {
			this.debugIconImage.alpha = 0.5;
			this.infoIconImage.alpha = 0.5;
			this.warningIconImage.alpha = 0.5;
			this.errorIconImage.alpha = 0.5;
			this.fatalIconImage.alpha = 0.5;
			
			for(var i:int; i<this.levels.length; i++){
				switch(this.levels[i]){
					case Settings.LEVEL_DEBUG :
						this.debugIconImage.alpha = 1;
					break;
					case Settings.LEVEL_INFO :
						this.infoIconImage.alpha = 1;
					break;
					case Settings.LEVEL_WARNING :
						this.warningIconImage.alpha = 1;
					break;
					case Settings.LEVEL_ERROR :
						this.errorIconImage.alpha = 1;
					break;
					case Settings.LEVEL_FATAL :
						this.fatalIconImage.alpha = 1;
					break;
				}
			}
		}
		override protected function showPopUp(type:String):void {
			switch(type){
				case "customizingFields" :
					var a:CustomizingGridPanel = CustomizingGridPanel(PopUpManager.createPopUp(this, CustomizingGridPanel));
					a.dataProvider = [
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"},
						{header:"Header", field:"Field"}
					];
				break;
			}
		}
		//----------------Main methods--------------------
		
		
		//----------------Handlers------------------------
		private function creationCompleteHandler(event:FlexEvent):void {
			trace("SettingsModule :: creationCompleteHandler");
			
			this.init();
		}
		//----------------Handlers------------------------
		
		
		//----------------User interaction----------------
		protected function okClickHandler(event:MouseEvent):void {
			//trace("SettingsModule :: okClickHandler");
			
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		protected function cancelClickHandler(event:MouseEvent):void {
			//trace("SettingsModule :: cancelClickHandler");
			
			this.dispatchEvent(new Event(Event.CANCEL));
		}
		protected function levelsGroupClickHandler(event:ItemClickEvent):void {
			for(var i:int=0; i<this.levelsBoxGroup.length; i++){
				this.levelsBoxGroup[i].selected = false;
			}
			
			this.levels = [];
			for(var j:int=0; j<=int(this.levelsRadioGroup.selection.data); j++){
				this.levels.push(j);
			}
			
			this.updateLevelsIcons();
		}
		protected function levelBoxClickHandler(event:MouseEvent):void {
			if(this.levelsRadioGroup.selection){
				this.levels = [];
				this.levelsRadioGroup.selection = null;
			}
			
			for(var i:int=0; i<this.levels.length; i++){
				if(this.levels[i] == CheckBox(event.target).data){
					if(!CheckBox(event.target).selected){
						this.levels.splice(i, 1);
					}
					this.updateLevelsIcons();
					return;
				}
			}
			
			this.levels.push(CheckBox(event.target).data);
			
			this.updateLevelsIcons();
		}
		//----------------User interaction----------------
	}
}