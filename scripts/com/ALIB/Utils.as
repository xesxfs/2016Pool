package com.ALIB
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.external.ExternalInterface;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public class Utils
   {
      
      public static var origin:Point = new Point(0,0);
       
      
      public function Utils()
      {
         super();
      }
      
      public static function copyObject(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function cloneObject(param1:*, param2:ApplicationDomain) : *
      {
         var _loc4_:String = getQualifiedClassName(param1);
         var _loc3_:Object = param2.getDefinition(_loc4_);
         return new _loc3_();
      }
      
      public static function fillInto(param1:Object, param2:Object, param3:Boolean = false) : void
      {
         var _loc4_:* = undefined;
         if(param3)
         {
            param1 = copyObject(param1);
         }
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for(var _loc5_ in param1)
         {
            _loc4_ = param2[_loc5_];
            if(_loc4_ === undefined)
            {
               param2[_loc5_] = param1[_loc5_];
            }
         }
      }
      
      public static function pushInto(param1:Object, param2:Object, param3:Boolean = false) : void
      {
         if(param3)
         {
            param1 = copyObject(param1);
         }
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for(var _loc4_ in param1)
         {
            param2[_loc4_] = param1[_loc4_];
         }
      }
      
      public static function bitsToTimes(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 32)
         {
            if(param1 & 1 << _loc3_)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function getBitAt(param1:int, param2:int) : Boolean
      {
         return Boolean(param1 & 1 << param2);
      }
      
      public static function setBitAt(param1:int, param2:int, param3:Boolean) : int
      {
         var _loc4_:uint = 1 << param2;
         param1 = param1 & uint(~_loc4_);
         if(param3 == true)
         {
            param1 = param1 | _loc4_;
         }
         return param1;
      }
      
      public static function createText(param1:String, param2:TextFormat = null, param3:int = 0) : TextField
      {
         var _loc4_:TextField = new TextField();
         _loc4_.defaultTextFormat = param2 || new TextFormat(null,16,16777215);
         _loc4_.filters = [new GlowFilter(param3,1,2,2,4)];
         _loc4_.text = param1;
         _loc4_.width = _loc4_.textWidth + 6;
         _loc4_.height = _loc4_.textHeight + 6;
         return _loc4_;
      }
      
      public static function getRandString(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<String> = new Vector.<String>();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_.push(String.fromCharCode(65 + int(Math.random() * 26)));
            _loc3_++;
         }
         return _loc2_.join("");
      }
      
      public static function getRandIndex(param1:Array) : int
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = 0;
         var _loc4_:Number = Math.random();
         _loc5_ = 0;
         _loc3_ = param1.length;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = Number(_loc2_ + param1[_loc5_]);
            if(_loc4_ <= _loc2_)
            {
               return _loc5_;
            }
            _loc5_++;
         }
         return -1;
      }
      
      public static function codesToString(... rest) : String
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc4_ = 0;
         _loc3_ = rest.length;
         while(_loc4_ < _loc3_)
         {
            _loc2_.push(String.fromCharCode(rest[_loc4_]));
            _loc4_++;
         }
         return _loc2_.join("");
      }
      
      public static function convertToBitmap(param1:DisplayObject) : Bitmap
      {
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc2_.draw(param1);
         return new Bitmap(_loc2_);
      }
      
      public static function formatTime(param1:uint) : String
      {
         var _loc5_:* = undefined;
         var _loc7_:* = undefined;
         var _loc3_:* = undefined;
         var _loc6_:int = param1 / 3600;
         var _loc2_:int = param1 % 3600 / 60;
         var _loc4_:int = param1 % 60;
         if(_loc6_ < 10)
         {
            _loc5_ = "0" + _loc6_;
         }
         else
         {
            _loc5_ = _loc6_;
         }
         if(_loc2_ < 10)
         {
            _loc7_ = "0" + _loc2_;
         }
         else
         {
            _loc7_ = _loc2_;
         }
         if(_loc4_ < 10)
         {
            _loc3_ = "0" + _loc4_;
         }
         else
         {
            _loc3_ = _loc4_;
         }
         return _loc5_ + ":" + _loc7_ + ":" + _loc3_;
      }
      
      public static function getFlashPlayerVersion() : Number
      {
         var _loc3_:String = Capabilities.version;
         var _loc2_:Array = _loc3_.split(/[,\ ]/);
         var _loc1_:Number = parseFloat(_loc2_[1] + "." + _loc2_[2]);
         return _loc1_;
      }
      
      public static function isAllowScriptAllow() : Boolean
      {
         if(Security.sandboxType != "remote")
         {
            return true;
         }
         try
         {
            if(ExternalInterface.call("location.toString") == null)
            {
               return false;
            }
         }
         catch(e:Error)
         {
            var _loc3_:Boolean = false;
            return _loc3_;
         }
         return true;
      }
      
      public static function localToRoot(param1:DisplayObject, param2:Point) : Point
      {
         var _loc3_:Point = new Point();
         _loc3_ = _loc3_.subtract(param2);
         while(param1)
         {
            _loc3_.x = _loc3_.x + param1.x;
            _loc3_.y = _loc3_.y + param1.y;
            param1 = param1.parent;
            if(!(param1 == null || param1 == param1.root))
            {
               continue;
            }
            break;
         }
         return _loc3_;
      }
      
      public static function rootToLocal(param1:DisplayObject, param2:Point) : Point
      {
         var _loc3_:Point = new Point();
         _loc3_ = _loc3_.add(param2);
         while(param1)
         {
            _loc3_.x = _loc3_.x - param1.x;
            _loc3_.y = _loc3_.y - param1.y;
            param1 = param1.parent;
            if(!(param1 == null || param1 == param1.root))
            {
               continue;
            }
            break;
         }
         return _loc3_;
      }
      
      public static function isDebugPlayer() : Boolean
      {
         return Capabilities.isDebugger;
      }
   }
}
