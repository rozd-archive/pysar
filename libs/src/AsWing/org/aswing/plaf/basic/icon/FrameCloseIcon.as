/*
 Copyright aswing.org, see the LICENCE.txt.
*/


package org.aswing.plaf.basic.icon
{
	
import org.aswing.*;
import org.aswing.graphics.*;
import org.aswing.geom.*;

/**
 * The icon for frame close.
 * @author iiley
 * @private
 */
public class FrameCloseIcon extends FrameIcon
{
	public function FrameCloseIcon(){
		super();
	}
	
	override public function updateIconImp(c:Component, g:Graphics2D, x:int, y:int):void
	{
		var w:Number = width/2;
		g.drawLine(
			new Pen(getColor(), w/3), 
			x+(width-w)/2, y+(width-w)/2,
			x+(width+w)/2, y+(width+w)/2);
		g.drawLine(
			new Pen(getColor(), w/3), 
			x+(width-w)/2, y+(width+w)/2,
			x+(width+w)/2, y+(width-w)/2);		
	}	
}
}