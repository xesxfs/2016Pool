package com.AUI
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class MessageBox extends Sprite
   {
      
      public static var textFormat:TextFormat = new TextFormat("_sans",20,16777215,true,null,null,null,null,"center");
      
      public static var backgroundColor:int = 0;
      
      public static var backgroundAlpha:Number = 0.6;
       
      
      public function MessageBox(param1:String)
      {
         super();
         var _loc6_:TextField = new TextField();
         _loc6_.mouseEnabled = false;
         _loc6_.autoSize = "left";
         _loc6_.defaultTextFormat = textFormat;
         _loc6_.htmlText = param1.replace("\r\n","\n");
         _loc6_.x = 8;
         _loc6_.y = 4;
         var _loc7_:int = 8 + _loc6_.width + 8;
         var _loc3_:int = 4 + _loc6_.height + 4;
         var _loc5_:Sprite = new Sprite();
         _loc5_.graphics.beginFill(backgroundColor,backgroundAlpha);
         _loc5_.graphics.drawRoundRect(0,0,_loc7_,_loc3_,10,10);
         this.addChild(_loc5_);
         this.addChild(_loc6_);
      }
   }
}
