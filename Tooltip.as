package cocoon.ui {
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Quart;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Ashley Andrian
	 */
	public class Tooltip extends Sprite {
		private var tf:TextField;
		private var quad:Quad;
		private var hovered:Boolean;
		public var _parent:DisplayObject;
		private static var FADE_DURATION:Number = 0.4;
		private static var TRANSITION_DURATION:Number = 1;

		public function Tooltip(width:int, height:int, text:String) {
			super();
			
			quad = new Quad(width, height);
			tf = new TextField(width, height, text);
			hovered = false;
			
			addChild(quad);
			addChild(tf);
			
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void {
			
		}
	
		public function initialize(parent:DisplayObject):void {
			Starling.current.stage.addChild(this);
			this.alpha = 0;
			
			_parent = parent;
			stage.addEventListener(TouchEvent.TOUCH, parentHover);
		}
		
		private function parentHover(e:TouchEvent):void {
			var mouseX:int = e.getTouch(stage).globalX;
			var mouseY:int = e.getTouch(stage).globalY;
			
			if ((mouseX >= _parent.x) && (mouseX <= (_parent.x + _parent.width)) &&
			    (mouseY >= _parent.y) && (mouseY <= (_parent.y + _parent.height))) {
				if (!hovered) {
					TweenLite.killTweensOf(this, true);
					this.x = e.getTouch(stage).globalX;
					this.y = e.getTouch(stage).globalY + 50;
					hovered = true;
				}
				
				TweenMax.to(this, Tooltip.FADE_DURATION, { autoAlpha:1 } );
				TweenLite.to(this, Tooltip.TRANSITION_DURATION, { x:e.getTouch(stage).globalX, 
																  y:e.getTouch(stage).globalY, 
																  ease:Quart.easeOut } );
					
			} else {
				TweenMax.to(this, Tooltip.FADE_DURATION, { autoAlpha:0 } );
				hovered = false;
			}
		}
		
		public function get text():String {
			return tf.text
		}
		
		public function set text(val:String):void {
			tf.text = val;
		}
		
	}

}