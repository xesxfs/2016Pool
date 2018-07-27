package com.AUI
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class Toast
   {
      
      public static var textFormat:TextFormat = new TextFormat("_sans",20,16777215,true,null,null,null,null,"center");
      
      public static var backgroundColor:int = 0;
      
      public static var backgroundAlpha:Number = 0.8;
      
      private static var _view:Sprite;
      
      private static var lastContent:String;
      
      private static var lastTween:TweenMax;
      
      private static var contentList:Array = [];
       
      
      public function Toast()
      {
         super();
      }
      
      public static function init(param1:Sprite) : void
      {
         _view = param1;
      }
      
      public static function show(param1:String, param2:Number = 2.4, param3:Boolean = false) : void
      {
         if(param1 == lastContent)
         {
            return;
         }
         lastContent = param1;
         if(param3 == true)
         {
            contentList.length = 0;
            if(lastTween)
            {
               lastTween.complete();
               lastTween = null;
            }
         }
         contentList.push(param1,param2);
         if(contentList.length)
         {
            _show(contentList[0],contentList[1]);
         }
      }
      
      private static function _show(param1:String, param2:int) : void
      {
         content = param1;
         second = param2;
         var box:Sprite = new Sprite();
         var paddingLR:int = 8;
         var paddingTB:int = 4;
         var round:Number = 10;
         var tf:TextField = new TextField();
         tf.mouseEnabled = false;
         tf.autoSize = "left";
         tf.defaultTextFormat = textFormat;
         tf.htmlText = content.replace(/\r\n/g,"\n");
         tf.x = paddingLR;
         tf.y = paddingTB;
         var barW:int = paddingLR + tf.width + paddingLR;
         var barH:int = paddingTB + tf.height + paddingTB;
         var bg:Sprite = new Sprite();
         bg.graphics.beginFill(backgroundColor,backgroundAlpha);
         bg.graphics.drawRoundRect(0,0,barW,barH,round,round);
         box.addChild(bg);
         box.addChild(tf);
         box.alpha = 0.2;
         box.scaleX = _view.scaleX;
         box.scaleY = _view.scaleY;
         box.x = int((_view.stage.stageWidth - box.width) / 2);
         box.y = int((_view.stage.stageHeight - box.height) / 2);
         _view.stage.addChild(box);
         TweenMax.to(box,0.3,{
            "y":box.y - 16,
            "alpha":1
         });
         lastTween = TweenMax.to(box,0.3,{
            "delay":second,
            "y":box.y - 32,
            "alpha":0,
            "onComplete":function():void
            {
               box.parent.removeChild(box);
               contentList.shift();
               contentList.shift();
               lastContent = null;
               if(contentList.length)
               {
                  _show(contentList[0],contentList[1]);
               }
            }
         });
      }
   }
}
