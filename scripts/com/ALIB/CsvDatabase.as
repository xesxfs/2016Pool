package com.ALIB
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class CsvDatabase
   {
       
      
      private var _tfiles:Dictionary;
      
      public function CsvDatabase()
      {
         _tfiles = new Dictionary();
         super();
      }
      
      public static function stringToArray(param1:String) : Array
      {
         var _loc6_:* = null;
         var _loc9_:int = 0;
         var _loc7_:* = false;
         var _loc2_:* = 0;
         var _loc11_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc14_:* = null;
         var _loc13_:* = 0;
         var _loc10_:* = 0;
         var _loc12_:Array = [];
         var _loc8_:int = 0;
         var _loc4_:int = param1.length;
         while(true)
         {
            _loc6_ = param1.substring(_loc8_);
            _loc9_ = _loc6_.length;
            _loc2_ = 0;
            _loc11_ = 0;
            _loc3_ = [];
            loop1:
            while(_loc11_ < _loc9_)
            {
               _loc2_ = _loc11_;
               _loc14_ = _loc6_.charAt(_loc11_);
               if(_loc14_ == "\r" && _loc6_.charAt(_loc11_ + 1) == "\n")
               {
                  _loc11_ = _loc11_ + 2;
                  break;
               }
               if(_loc14_ == ",")
               {
                  _loc5_ = "";
                  _loc11_++;
                  _loc14_ = _loc6_.charAt(_loc11_);
                  if(_loc14_ == "," || _loc14_ == "\r" && _loc6_.charAt(_loc11_ + 1) == "\n")
                  {
                     _loc3_.push("");
                  }
               }
               else
               {
                  if(_loc14_ == "\"")
                  {
                     _loc11_++;
                     while(true)
                     {
                        _loc11_ = _loc6_.indexOf("\"",_loc11_);
                        if(_loc11_ == -1)
                        {
                           break;
                        }
                        if(_loc6_.charAt(_loc11_ + 1) == "\"")
                        {
                           _loc11_ = _loc11_ + 2;
                           continue;
                        }
                        _loc5_ = _loc6_.substring(_loc2_ + 1,uint(_loc11_));
                        _loc5_ = _loc5_.replace(/""/g,"\"");
                        _loc3_.push(_loc5_);
                        _loc11_++;
                        continue loop1;
                     }
                     throw new Error("Invalid colon end!");
                  }
                  _loc13_ = int(_loc6_.indexOf(",",_loc11_));
                  _loc10_ = int(_loc6_.indexOf("\r\n",_loc11_));
                  if(_loc13_ == -1)
                  {
                     _loc13_ = _loc9_;
                  }
                  if(_loc10_ == -1)
                  {
                     _loc10_ = _loc9_;
                  }
                  _loc7_ = _loc10_ < _loc13_;
                  _loc11_ = !!_loc7_?_loc10_:int(_loc13_);
                  _loc5_ = _loc6_.substring(_loc2_,uint(_loc11_));
                  _loc3_.push(_loc5_);
               }
            }
            _loc12_.push(_loc3_);
            _loc8_ = _loc8_ + _loc11_;
            if(_loc8_ < _loc4_)
            {
               continue;
            }
            break;
         }
         return _loc12_;
      }
      
      public static function arrayTotable(param1:Array) : Table#141
      {
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc13_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc4_:* = null;
         var _loc11_:* = null;
         var _loc12_:Array = param1.shift();
         var _loc2_:* = param1;
         var _loc14_:Vector.<Field> = new Vector.<Field>();
         _loc10_ = 0;
         _loc6_ = _loc12_.length;
         _loc12_.length;
         while(_loc10_ < _loc6_)
         {
            _loc11_ = String(_loc12_[_loc10_]).split(":");
            _loc13_ = new Field();
            _loc13_.name = _loc11_[0];
            _loc13_.type = _loc11_[1];
            _loc14_.push(_loc13_);
            _loc10_++;
         }
         _loc10_ = 0;
         _loc6_ = _loc2_.length;
         _loc2_.length;
         while(_loc10_ < _loc6_)
         {
            _loc9_ = _loc2_[_loc10_];
            _loc7_ = 0;
            _loc3_ = _loc9_.length;
            _loc9_.length;
            while(_loc7_ < _loc3_)
            {
               _loc4_ = _loc9_[_loc7_];
               _loc8_ = _loc14_[_loc7_].type;
               var _loc15_:* = _loc8_;
               if("int" !== _loc15_)
               {
                  if("0b" !== _loc15_)
                  {
                     if("0x" !== _loc15_)
                     {
                        if("string" !== _loc15_)
                        {
                           if("number" !== _loc15_)
                           {
                              if("object" !== _loc15_)
                              {
                                 if("array" !== _loc15_)
                                 {
                                    throw new Error("unknown filed type");
                                 }
                                 _loc9_[_loc7_] = objectToBytes(JSON.parse(!!_loc4_?"[" + _loc4_ + "]":"[]"));
                              }
                              else
                              {
                                 _loc9_[_loc7_] = objectToBytes(JSON.parse(!!_loc4_?"{" + _loc4_ + "}":"{}"));
                              }
                           }
                           else
                           {
                              _loc9_[_loc7_] = !!_loc4_?parseFloat(_loc4_):0;
                           }
                        }
                        else
                        {
                           _loc9_[_loc7_] = _loc4_;
                        }
                     }
                     else
                     {
                        _loc9_[_loc7_] = !!_loc4_?parseInt(_loc4_,16):0;
                     }
                  }
                  else
                  {
                     _loc9_[_loc7_] = !!_loc4_?parseInt(_loc4_,2):0;
                  }
               }
               else
               {
                  _loc9_[_loc7_] = !!_loc4_?parseInt(_loc4_):0;
               }
               _loc7_++;
            }
            _loc10_++;
         }
         var _loc5_:Table = new Table#141();
         _loc5_.head = _loc14_;
         _loc5_.body = _loc2_;
         return _loc5_;
      }
      
      public static function objectToBytes(param1:Object) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public static function bytesToObject(param1:ByteArray) : Object
      {
         var _loc2_:Object = param1.readObject();
         param1.position = 0;
         return _loc2_;
      }
      
      public function addCsvFile(param1:String, param2:String) : void
      {
         var _loc3_:TFile = new TFile();
         _loc3_.table = arrayTotable(stringToArray(param2));
         _tfiles[param1] = _loc3_;
      }
      
      public function getTable(param1:String) : Table#141
      {
         var _loc3_:TFile = _tfiles[param1];
         var _loc2_:int = getTimer();
         if(_loc2_ - _loc3_.ctime > 1000)
         {
            _loc3_.ctime = _loc2_;
         }
         return _loc3_.table;
      }
      
      public function getRowLength(param1:String) : int
      {
         return Table#141(getTable(param1)).body.length;
      }
      
      public function rowToObject(param1:Vector.<Field>, param2:Object) : Object
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc3_:* = null;
         var _loc4_:Object = {};
         _loc7_ = 0;
         _loc5_ = param1.length;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = param1[_loc7_].name;
            _loc3_ = param2[_loc7_];
            _loc4_[_loc6_] = _loc3_ is ByteArray?bytesToObject(_loc3_):_loc3_;
            _loc7_++;
         }
         return _loc4_;
      }
      
      public function rowsToArray(param1:Vector.<Field>, param2:Array) : Array
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc3_:* = undefined;
         var _loc5_:* = null;
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:Array = [];
         _loc7_ = 0;
         _loc4_ = param2.length;
         while(_loc7_ < _loc4_)
         {
            _loc9_ = param2[_loc7_];
            _loc8_ = null;
            _loc3_ = null;
            _loc5_ = {};
            _loc10_ = 0;
            _loc6_ = param1.length;
            while(_loc10_ < _loc6_)
            {
               _loc8_ = param1[_loc10_].name;
               _loc3_ = _loc9_[_loc10_];
               _loc5_[_loc8_] = _loc3_ is ByteArray?bytesToObject(_loc3_):_loc3_;
               _loc10_++;
            }
            _loc11_.push(_loc5_);
            _loc7_++;
         }
         return _loc11_;
      }
      
      public function selectRowA(param1:Array, param2:*, param3:int) : Object
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         _loc6_ = 0;
         _loc4_ = param1.length;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = param1[_loc6_];
            if(_loc5_[param3] == param2)
            {
               return _loc5_;
            }
            _loc6_++;
         }
         return null;
      }
      
      public function selectRowB(param1:Array, param2:*, param3:*, param4:int, param5:int) : Object
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         _loc8_ = 0;
         _loc6_ = param1.length;
         while(_loc8_ < _loc6_)
         {
            _loc7_ = param1[_loc8_];
            if(_loc7_[param5] == param2 && _loc7_[param4] == param3)
            {
               return _loc7_;
            }
            _loc8_++;
         }
         return null;
      }
      
      public function selectRowC(param1:Array, param2:int, param3:int) : Object
      {
         var _loc8_:* = 0;
         var _loc6_:* = null;
         var _loc4_:* = undefined;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         _loc7_ = 0;
         _loc5_ = param1.length;
         while(_loc7_ < _loc5_)
         {
            _loc8_ = _loc7_;
            _loc6_ = param1[_loc7_];
            _loc4_ = _loc6_[param3];
            if(param2 < 0)
            {
               if(_loc4_ >= param2)
               {
                  break;
               }
            }
            else if(_loc4_ > param2)
            {
               _loc8_--;
               break;
            }
            _loc7_++;
         }
         if(_loc8_ < 0)
         {
            _loc8_ = 0;
         }
         return param1[_loc8_];
      }
      
      public function selectRowD(param1:Array, param2:int, param3:int, param4:int, param5:int) : Object
      {
         var _loc11_:* = 0;
         var _loc9_:* = null;
         var _loc6_:* = undefined;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = -1;
         _loc10_ = 0;
         _loc7_ = param1.length;
         while(_loc10_ < _loc7_)
         {
            _loc9_ = param1[_loc10_];
            if(_loc9_[param5] == param2)
            {
               if(_loc8_ == -1)
               {
                  _loc8_ = _loc10_;
               }
               _loc11_ = _loc10_;
               _loc6_ = _loc9_[param4];
               if(param3 < 0)
               {
                  if(param3 * -1 >= _loc6_ * -1)
                  {
                     break;
                  }
               }
               else if(_loc6_ > param3)
               {
                  _loc11_--;
                  break;
               }
            }
            _loc10_++;
         }
         if(_loc8_ != -1)
         {
            if(_loc11_ < 0)
            {
               _loc11_ = _loc8_;
            }
            return param1[_loc11_];
         }
         return null;
      }
      
      public function selectRowsA(param1:Array, param2:*, param3:int) : Array
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc7_:Array = [];
         _loc6_ = 0;
         _loc4_ = param1.length;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = param1[_loc6_];
            if(_loc5_[param3] == param2)
            {
               _loc7_.push(_loc5_);
            }
            _loc6_++;
         }
         return _loc7_;
      }
      
      public function selectRowsB(param1:Array, param2:*, param3:*, param4:int, param5:int) : Array
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc9_:Array = [];
         _loc8_ = 0;
         _loc6_ = param1.length;
         while(_loc8_ < _loc6_)
         {
            _loc7_ = param1[_loc8_];
            if(_loc7_[param5] == param2 && _loc7_[param4] == param3)
            {
               _loc9_.push(_loc7_);
            }
            _loc8_++;
         }
         return _loc9_;
      }
      
      public function selectObjectA(param1:String, param2:*, param3:int = 0) : Object
      {
         var _loc4_:Table = getTable(param1);
         var _loc5_:Object = selectRowA(_loc4_.body,param2,param3);
         return _loc5_ && rowToObject(_loc4_.head,_loc5_);
      }
      
      public function selectObjectA2(param1:String, param2:int, param3:int = 0) : Object
      {
         var _loc4_:Table = getTable(param1);
         var _loc5_:Object = selectRowC(_loc4_.body,param2,param3);
         return _loc5_ && rowToObject(_loc4_.head,_loc5_);
      }
      
      public function selectObjectB(param1:String, param2:*, param3:*, param4:int = 1, param5:int = 0) : Object
      {
         var _loc6_:Table = getTable(param1);
         var _loc7_:Object = selectRowB(_loc6_.body,param2,param3,param4,param5);
         return _loc7_ && rowToObject(_loc6_.head,_loc7_);
      }
      
      public function selectObjectB2(param1:String, param2:int, param3:int, param4:int = 1, param5:int = 0) : Object
      {
         var _loc6_:Table = getTable(param1);
         var _loc7_:Object = selectRowD(_loc6_.body,param2,param3,param4,param5);
         return _loc7_ && rowToObject(_loc6_.head,_loc7_);
      }
      
      public function selectArrayA(param1:String, param2:int, param3:int = 0) : Array
      {
         var _loc4_:Table = getTable(param1);
         var _loc5_:Array = selectRowsA(_loc4_.body,param2,param3);
         return rowsToArray(_loc4_.head,_loc5_);
      }
      
      public function selectArrayB(param1:String, param2:int, param3:int, param4:int = 1, param5:int = 0) : Array
      {
         var _loc6_:Table = getTable(param1);
         var _loc7_:Array = selectRowsB(_loc6_.body,param2,param3,param4,param5);
         return rowsToArray(_loc6_.head,_loc7_);
      }
      
      public function selectAllArray(param1:String) : Array
      {
         var _loc2_:Table = getTable(param1);
         var _loc3_:Array = _loc2_.body;
         return rowsToArray(_loc2_.head,_loc3_);
      }
      
      public function selectValueA(param1:String, param2:*, param3:int = 1, param4:int = 0) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:Table = getTable(param1);
         var _loc7_:Object = selectRowA(_loc6_.body,param2,param4);
         if(_loc7_)
         {
            _loc5_ = _loc7_[param3];
            _loc5_ = _loc5_ is ByteArray?bytesToObject(_loc5_):_loc5_;
            return _loc5_;
         }
         return null;
      }
      
      public function selectValueA2(param1:String, param2:*, param3:String, param4:int = 0) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:* = 0;
         var _loc9_:* = undefined;
         var _loc11_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Table = getTable(param1);
         var _loc10_:Object = selectRowA(_loc8_.body,param2,param4);
         if(_loc10_)
         {
            _loc9_ = _loc8_.head;
            _loc11_ = 0;
            _loc7_ = _loc9_.length;
            while(_loc11_ < _loc7_)
            {
               if(_loc9_[_loc11_].name == param3)
               {
                  _loc6_ = _loc11_;
                  break;
               }
               _loc11_++;
            }
            _loc5_ = _loc10_[_loc6_];
            _loc5_ = _loc5_ is ByteArray?bytesToObject(_loc5_):_loc5_;
            return _loc5_;
         }
         return null;
      }
      
      public function selectValueB(param1:String, param2:*, param3:*, param4:int = 2, param5:int = 1, param6:int = 0) : *
      {
         var _loc7_:* = undefined;
         var _loc8_:Table = getTable(param1);
         var _loc9_:Object = selectRowB(_loc8_.body,param2,param3,param5,param6);
         if(_loc9_)
         {
            _loc7_ = _loc9_[param4];
            _loc7_ = _loc7_ is ByteArray?bytesToObject(_loc7_):_loc7_;
            return _loc7_;
         }
         return null;
      }
      
      public function selectValueD(param1:String, param2:int, param3:int, param4:int = 2, param5:int = 1, param6:int = 0) : *
      {
         var _loc7_:* = undefined;
         var _loc8_:Table = getTable(param1);
         var _loc9_:Object = selectRowD(_loc8_.body,param2,param3,param5,param6);
         if(_loc9_)
         {
            _loc7_ = _loc9_[param4];
            _loc7_ = _loc7_ is ByteArray?bytesToObject(_loc7_):_loc7_;
            return _loc7_;
         }
         return null;
      }
   }
}

class Field
{
    
   
   public var type:String;
   
   public var name:String;
   
   function Field()
   {
      super();
   }
}

class Table#141
{
    
   
   public var head:Vector.<Field>;
   
   public var body:Array;
   
   function Table#141()
   {
      super();
   }
}

class TFile
{
    
   
   public var table:Table#141;
   
   public var ccode:int;
   
   public var ctime:int;
   
   function TFile()
   {
      super();
   }
}
