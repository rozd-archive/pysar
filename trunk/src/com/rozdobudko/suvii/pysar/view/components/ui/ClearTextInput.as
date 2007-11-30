package com.rozdobudko.suvii.pysar.view.components.ui
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.controls.TextInput;
	import mx.events.FlexEvent;

	/**
	 * @class ClearTextInput
	 * @brief A TextInput with button to clear the text.
	 * @author Jove
	 * @version 1.1
	 */
	public class ClearTextInput extends TextInput
	{
		
		[Embed(source="../../../../../../../assets/clear-text-input/WindowCloseButton.gif")]
		private static const WINDOW_CLOSE_BUTTON_1:Class;
		
		[Embed(source="../../../../../../../assets/clear-text-input/WindowCloseButton2.gif")]
		private static const WINDOW_CLOSE_BUTTON_2:Class;
				
		private var clearButton:Button;
		
		public var defultText:String = "Please Input Text..."
		public var defultTextColor:String = "#FF0000"
		
		public function ClearTextInput()
		{
			super();
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, this.addButton);
			this.addEventListener("textChanged", this.textChangedHandler);
			this.addEventListener(FocusEvent.FOCUS_IN, this.focusInHandler);
			this.addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHandler);
		}
		
		private function addButton(event:FlexEvent):void
		{
			if(clearButton == null)
			{
				clearButton = new Button();
				clearButton.width = 10;
				clearButton.height = 10;
				clearButton.y = (this.height - 10) / 2;
				clearButton.x = this.width - 10 - (this.height - 10) / 2;
				clearButton.focusEnabled=false;
				clearButton.buttonMode = true;
				clearButton.useHandCursor = true;
				clearButton.mouseChildren = false;
				clearButton.setStyle("upSkin", WINDOW_CLOSE_BUTTON_1);
				clearButton.setStyle("overSkin", WINDOW_CLOSE_BUTTON_2);
				clearButton.setStyle("downSkin", WINDOW_CLOSE_BUTTON_2);
				clearButton.addEventListener(MouseEvent.CLICK, clearClickHandler);
				clearButton.visible = false;
				
				this.addChild(clearButton);
				
				if(text == "")
				{
					setDefaultText();
				}
			}
		}
		
		private function clearClickHandler(event:MouseEvent):void
		{
			this.text = "";
			clearButton.visible = false;
			
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		override protected function focusInHandler(event:FocusEvent):void
		{
			super.focusInHandler(event);
			
			if(text == "")
			{
				this.text = "";
				this.textField.text = "";
				this.textField.textColor = this.getStyle("color");
				clearButton.visible = false;
			}
		}
		
		override protected function focusOutHandler(event:FocusEvent):void
		{
			super.focusOutHandler(event);
			
			if(text == "")
			{
				setDefaultText();
			}
		}
		
		private function setDefaultText():void
		{
			this.text = "";
			this.textField.text = defultText;
			this.textField.textColor = convertColor(defultTextColor);
			
			clearButton.visible = false;
		}
				
		private function textChangedHandler(event:Event):void
		{
			if(text != "")
			{
				clearButton.visible = true;
				this.textField.textColor = this.getStyle("color");
			}
			else
			{
				if(this.focusManager.getFocus() is ClearTextInput && ClearTextInput(this.focusManager.getFocus()) == this)
				{
					clearButton.visible = false;
					this.textField.textColor = this.getStyle("color");
				}
				else
				{
					this.callLater(setDefaultText);
				}
			}
		}
		
		private function convertColor(color:String):Number
		{
			if(color.length > 1 && color.substring(0,1) == "#")
			{
				return Number("0x" + color.substring(1));
			}
			else
			{
				return Number(color);
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(clearButton != null)
			{
				clearButton.x = this.width - 10 - (this.height - 10) / 2;
				clearButton.y = (this.height - 10) / 2;
			}
		}
	}
}