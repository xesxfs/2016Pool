package fla
{
   import com.ALIB.DynamicEvent;
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.Window;
   import com.greensock.TweenMax;
   import fla.play.CreateMain;
   import fla.play.FreeMain;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class Home extends Window
   {
       
      
      public var _freeMode:Button;
      
      public var _challengeMode:Button;
      
      public var _market:Button;
      
      public var _create:Button;
      
      public var _alarm:Button;
      
      public var _lang:SelectLanguage;
      
      public var _name:MovieClip;
      
      public var _setting:Button;
      
      public var _bg:Sprite;
      
      public var _appVer:TextField;
      
      public var _test:Button;
      
      public function Home()
      {
         super();
         _alarm.visible = false;
         _name.mouseEnabled = false;
         _name.mouseChildren = false;
         _lang.init(onChangeLang);
         _appVer.text = game.shell.appVer.toString();
         updateLabels();
         this.addEventListener(AuiDefine.CLICK,onClick);
         _setting.addEventListener(AuiDefine.CLICK,onClickSetting);
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         e = param1;
         super.onAddedToStage(e);
         var de:DynamicEvent = new DynamicEvent("CHANGE_BG");
         de.body = _bg;
         root.dispatchEvent(de);
         if(_G.player.getStep() <= 0)
         {
            _G.shineObject(this._challengeMode);
            _G.player.setStep(1);
         }
         var ae:DynamicEvent = new DynamicEvent("GET_VAL");
         ae.body = "alarm";
         root.dispatchEvent(ae);
         var alarm:Array = ae.body as Array;
         if(alarm)
         {
            if(alarm[0] > _G.player.getAlarmVer())
            {
               _alarm.visible = true;
               TweenMax.to(_alarm,0.4,{
                  "alpha":0.2,
                  "yoyo":true,
                  "repeat":7
               });
            }
            _alarm.addEventListener(AuiDefine.CLICK,function(param1:Event):void
            {
               TweenMax.killTweensOf(_alarm);
               _G.player.setAlarmVer(alarm[0]);
               var _loc2_:* = alarm[1];
               if(1 !== _loc2_)
               {
                  if(2 === _loc2_)
                  {
                     game.hud.addToCenter(new Recommend(alarm[2]));
                  }
               }
               else
               {
                  game.hud.alert(alarm[2]);
               }
            });
         }
      }
      
      private function onClick(param1:Event) : void
      {
         var _loc2_:Object = param1.target as DisplayObject;
         var _loc3_:* = _loc2_;
         if(_challengeMode !== _loc3_)
         {
            if(_freeMode !== _loc3_)
            {
               if(_create !== _loc3_)
               {
                  if(_market === _loc3_)
                  {
                     game.self.setContentView(new Market());
                  }
               }
               else
               {
                  game.self.setContentView(new CreateMain(0));
               }
            }
            else
            {
               game.self.setContentView(new FreeMain());
            }
         }
         else
         {
            game.self.setContentView(new ChallEntry());
         }
      }
      
      private function onClickSetting(param1:Event) : void
      {
         game.hud.addToCenter(new Profile());
      }
      
      private function onChangeLang(param1:String) : void
      {
         Language.field = param1;
         _G.player.setLangField(param1);
         updateLabels();
      }
      
      private function updateLabels() : void
      {
         _challengeMode.labelField = Language.field;
         _freeMode.labelField = Language.field;
         _market.labelField = Language.field;
         _create.labelField = Language.field;
         _name.gotoAndStop(Language.field);
      }
   }
}
