package
{
   import com.ALIB.DynamicEvent;
   import com.AUI.Alert;
   import com.AUI.AuiDefine;
   import com.AUI.Confirm;
   import com.AUI.Prompt;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Hud extends Sprite
   {
      
      public static const EN_ADD_COVER:String = "ADD_COVER";
      
      public static const EN_DEL_COVER:String = "DEL_COVER";
       
      
      public function Hud()
      {
         super();
      }
      
      public function addToCenter(param1:DisplayObject, param2:Boolean = true, param3:Boolean = false) : DisplayObject
      {
         view = param1;
         withCover = param2;
         clickCoverToClose = param3;
         var cover:Sprite = null;
         if(withCover == true)
         {
            cover = addCoverLayer();
            view.addEventListener("removedFromStage",function(param1:Event):void
            {
               if(cover.parent)
               {
                  cover.parent.removeChild(cover);
               }
               dispatchEvent(new Event("DEL_COVER"));
            });
            if(clickCoverToClose)
            {
               cover.addEventListener(AuiDefine.CLICK,function(param1:Event):void
               {
                  if(view.parent)
                  {
                     view.parent.removeChild(view);
                  }
               });
            }
         }
         view.x = int((game.w - view.width) / 2);
         view.y = int((game.h - view.height) / 2);
         addChild(view);
         return cover;
      }
      
      public function confirm(param1:String, param2:Function = null) : Confirm
      {
         var _loc3_:Confirm = new Confirm(param1,param2);
         addToCenter(_loc3_);
         return _loc3_;
      }
      
      public function alert(param1:String, param2:Function = null) : Alert
      {
         var _loc3_:Alert = new Alert(param1,param2);
         addToCenter(_loc3_);
         return _loc3_;
      }
      
      public function prompt(param1:String, param2:Function = null) : Prompt
      {
         var _loc3_:Prompt = new Prompt(param1,param2);
         addToCenter(_loc3_);
         return _loc3_;
      }
      
      public function addCoverLayer(param1:Number = 0.5) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         _loc3_.name = "cover";
         _loc3_.alpha = param1;
         _loc3_.graphics.beginFill(0);
         _loc3_.graphics.drawRect(0,0,game.w,game.h);
         addChild(_loc3_);
         dispatchEvent(new Event("ADD_COVER"));
         var _loc2_:DynamicEvent = new DynamicEvent("ADD_COVER");
         _loc2_.body = _loc3_;
         root.dispatchEvent(_loc2_);
         return _loc3_;
      }
   }
}
