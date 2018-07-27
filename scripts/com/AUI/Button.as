package com.AUI
{
   import com.AUI.define.EDGE;
   import com.AUI.event.DataEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   
   public dynamic class Button extends MovieClip
   {
      
      public static const OVER:String = "over";
      
      public static const UP:String = "up";
      
      public static const DOWN:String = "down";
       
      
      public var _label:TextField;
      
      public var _labelFields:MovieClip;
      
      public var _BG:MovieClip;
      
      private var _focused:Boolean = false;
      
      private var _autoFitWidth:Boolean = false;
      
      private var _prefix:String = "";
      
      private var _state:String = "up";
      
      public var padding:EDGE;
      
      public function Button()
      {
         padding = new EDGE();
         super();
         if(_label != null)
         {
            var _loc1_:* = _label.x;
            padding.right = _loc1_;
            padding.left = _loc1_;
            _loc1_ = _label.y;
            padding.bottom = _loc1_;
            padding.top = _loc1_;
            _label.mouseEnabled = false;
         }
         if(_labelFields != null)
         {
            _labelFields.stop();
            _labelFields.mouseEnabled = false;
         }
         this.mouseChildren = false;
         this.buttonMode = true;
         this.stop();
         addEventListener("mouseDown",onMouse);
         addEventListener("mouseUp",onMouse);
         addEventListener("rollOver",onMouse);
         addEventListener("rollOut",onMouse);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         .super.enabled = param1;
         this.mouseEnabled = param1;
         this.filters = !!param1?null:[new ColorMatrixFilter([0.3,0.6,0,0,0,0.3,0.6,0,0,0,0.3,0.6,0,0,0,0,0,0,1,0])];
         if(param1 == false)
         {
            setState("up");
         }
      }
      
      public function get autoFitWidth() : Boolean
      {
         return _autoFitWidth;
      }
      
      public function set autoFitWidth(param1:Boolean) : void
      {
         _autoFitWidth = param1;
         _label.autoSize = !!_autoFitWidth?"left":"none";
      }
      
      public function get data() : String
      {
         if(_label == null)
         {
            return null;
         }
         return _label.text;
      }
      
      public function set data(param1:String) : void
      {
         if(_label == null)
         {
            return;
         }
         _label.text = param1;
         var _loc2_:DataEvent = new DataEvent("dataChange",true);
         dispatchEvent(_loc2_);
         updateView();
      }
      
      public function get dataHTML() : String
      {
         if(_label == null)
         {
            return null;
         }
         return _label.htmlText;
      }
      
      public function set dataHTML(param1:String) : void
      {
         if(_label == null)
         {
            return;
         }
         _label.htmlText = param1;
         var _loc2_:DataEvent = new DataEvent("dataChange",true);
         dispatchEvent(_loc2_);
         updateView();
      }
      
      public function set labelField(param1:String) : void
      {
         this._labelFields.gotoAndStop(param1);
      }
      
      public function get checked() : Boolean
      {
         return _prefix == "checked_";
      }
      
      public function set checked(param1:Boolean) : void
      {
         _prefix = !!param1?"checked_":"";
         updateView();
      }
      
      public function get focused() : Boolean
      {
         return _focused;
      }
      
      public function set focused(param1:Boolean) : void
      {
         _focused = param1;
         setState(!!_focused?"over":"up");
      }
      
      protected function onMouse(param1:MouseEvent) : void
      {
         if(super.enabled == false || _focused == true)
         {
            return;
         }
         if(param1.type == "mouseDown")
         {
            setState("down");
         }
         else if(param1.type == "rollOver")
         {
            setState("over");
         }
         else
         {
            setState("up");
         }
      }
      
      public function getState() : String
      {
         return _state;
      }
      
      public function setState(param1:String) : void
      {
         _state = param1;
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc1_:String = _prefix + _state;
         gotoAndStop(_loc1_);
         if(_autoFitWidth == true)
         {
            if(_BG != null)
            {
               _BG.width = getFitWidth();
               _label.x = int((_BG.width - _label.width) / 2);
            }
         }
      }
      
      override public function set width(param1:Number) : void
      {
         if(_autoFitWidth == true)
         {
            return;
         }
         .super.width = param1;
      }
      
      public function getFitWidth() : int
      {
         return padding.left + _label.width + padding.right;
      }
   }
}
