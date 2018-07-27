package com.adobe.images
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   
   public class PNGDecoder
   {
      
      private static const IHDR:int = 1229472850;
      
      private static const IDAT:int = 1229209940;
      
      private static const tEXt:int = 1950701684;
      
      private static const iTXt:int = 1767135348;
      
      private static const zTXt:int = 2052348020;
      
      private static const IEND:int = 1229278788;
      
      private static var infoWidth:uint;
      
      private static var infoHeight:uint;
      
      private static var infoBitDepth:int;
      
      private static var infoColourType:int;
      
      private static var infoCompressionMethod:int;
      
      private static var infoFilterMethod:int;
      
      private static var infoInterlaceMethod:int;
      
      private static var fileIn:ByteArray;
      
      private static var buffer:ByteArray;
      
      private static var scanline:int;
      
      private static var samples:int;
       
      
      public function PNGDecoder()
      {
         super();
      }
      
      public static function decodeImage(param1:ByteArray) : BitmapData
      {
         var _loc3_:Boolean = false;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         fileIn = param1;
         buffer = new ByteArray();
         samples = 4;
         fileIn.position = 0;
         if(fileIn.readUnsignedInt() != 2303741511)
         {
            return invalidPNG();
         }
         if(fileIn.readUnsignedInt() != 218765834)
         {
            return invalidPNG();
         }
         var _loc2_:Array = getChunks();
         var _loc4_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            fileIn.position = _loc2_[_loc6_].position;
            _loc3_ = true;
            if(_loc2_[_loc6_].type == 1229472850)
            {
               _loc4_++;
               if(_loc6_ == 0)
               {
                  _loc3_ = processIHDR(_loc2_[_loc6_].length);
               }
               else
               {
                  _loc3_ = false;
               }
            }
            if(_loc2_[_loc6_].type == 1229209940)
            {
               buffer.writeBytes(fileIn,fileIn.position,_loc2_[_loc6_].length);
            }
            if(!_loc3_ || _loc4_ > 1)
            {
               return invalidPNG();
            }
            _loc6_++;
         }
         var _loc5_:BitmapData = processIDAT();
         fileIn = null;
         buffer = null;
         return _loc5_;
      }
      
      public static function decodeInfo(param1:ByteArray) : XML
      {
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         fileIn = param1;
         fileIn.position = 0;
         if(fileIn.readUnsignedInt() != 2303741511)
         {
            fileIn = null;
            return null;
         }
         if(fileIn.readUnsignedInt() != 218765834)
         {
            fileIn = null;
            return null;
         }
         var _loc2_:Array = getChunks();
         var _loc3_:XML = <information />;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_].type == 1950701684)
            {
               _loc3_.appendChild(gettEXt(_loc2_[_loc4_].position,_loc2_[_loc4_].length));
            }
            if(_loc2_[_loc4_].type == 1767135348)
            {
               _loc3_.appendChild(getiTXt(_loc2_[_loc4_].position,_loc2_[_loc4_].length));
            }
            if(_loc2_[_loc4_].type == 2052348020)
            {
               _loc3_.appendChild(getzTXt(_loc2_[_loc4_].position,_loc2_[_loc4_].length));
            }
            _loc4_++;
         }
         fileIn = null;
         return _loc3_;
      }
      
      private static function gettEXt(param1:int, param2:int) : XML
      {
         var _loc4_:XML = <tEXt />;
         var _loc6_:String = "";
         var _loc3_:String = "";
         var _loc5_:int = -1;
         fileIn.position = param1;
         while(fileIn.position < param1 + param2)
         {
            _loc5_ = fileIn.readUnsignedByte();
            if(_loc5_ > 0)
            {
               _loc6_ = _loc6_ + String.fromCharCode(_loc5_);
               continue;
            }
            break;
         }
         _loc3_ = fileIn.readUTFBytes(param1 + param2 - fileIn.position);
         _loc4_.appendChild(<keyword>{_loc6_}</keyword>);
         _loc4_.appendChild(<text>{_loc3_}</text>);
         return _loc4_;
      }
      
      private static function getzTXt(param1:int, param2:int) : XML
      {
         var _loc6_:* = null;
         var _loc5_:XML = <zTXt />;
         var _loc8_:String = "";
         var _loc4_:String = "";
         var _loc7_:int = -1;
         fileIn.position = param1;
         while(fileIn.position < param1 + param2)
         {
            _loc7_ = fileIn.readUnsignedByte();
            if(_loc7_ > 0)
            {
               _loc8_ = _loc8_ + String.fromCharCode(_loc7_);
               continue;
            }
            break;
         }
         var _loc3_:int = fileIn.readUnsignedByte();
         if(_loc3_ == 0)
         {
            _loc6_ = new ByteArray();
            _loc6_.writeBytes(fileIn,fileIn.position,param1 + param2 - fileIn.position);
            _loc6_.uncompress();
            _loc4_ = _loc6_.readUTFBytes(_loc6_.length);
         }
         _loc5_.appendChild(<keyword>{_loc8_}</keyword>);
         _loc5_.appendChild(<text>{_loc4_}</text>);
         return _loc5_;
      }
      
      private static function getiTXt(param1:int, param2:int) : XML
      {
         var _loc6_:* = null;
         var _loc5_:XML = <iTXt />;
         var _loc9_:String = "";
         var _loc11_:String = "";
         var _loc10_:String = "";
         var _loc4_:String = "";
         var _loc8_:int = -1;
         fileIn.position = param1;
         while(fileIn.position < param1 + param2)
         {
            _loc8_ = fileIn.readUnsignedByte();
            if(_loc8_ > 0)
            {
               _loc9_ = _loc9_ + String.fromCharCode(_loc8_);
               continue;
            }
            break;
         }
         var _loc7_:* = fileIn.readUnsignedByte() == 1;
         var _loc3_:int = fileIn.readUnsignedByte();
         while(fileIn.position < param1 + param2)
         {
            _loc8_ = fileIn.readUnsignedByte();
            if(_loc8_ > 0)
            {
               _loc11_ = _loc11_ + String.fromCharCode(_loc8_);
               continue;
            }
            break;
         }
         while(fileIn.position < param1 + param2)
         {
            _loc8_ = fileIn.readUnsignedByte();
            if(_loc8_ > 0)
            {
               _loc10_ = _loc10_ + String.fromCharCode(_loc8_);
               continue;
            }
            break;
         }
         if(_loc7_)
         {
            if(_loc3_ == 0)
            {
               _loc6_ = new ByteArray();
               _loc6_.writeBytes(fileIn,fileIn.position,param1 + param2 - fileIn.position);
               _loc6_.uncompress();
               _loc4_ = _loc6_.readUTFBytes(_loc6_.length);
            }
         }
         else
         {
            _loc4_ = fileIn.readUTFBytes(param1 + param2 - fileIn.position);
         }
         _loc5_.appendChild(<keyword>{_loc9_}</keyword>);
         _loc5_.appendChild(<text>{_loc4_}</text>);
         _loc5_.appendChild(<languageTag>{_loc11_}</languageTag>);
         _loc5_.appendChild(<translatedKeyword>{_loc10_}</translatedKeyword>);
         return _loc5_;
      }
      
      private static function invalidPNG() : BitmapData
      {
         fileIn = null;
         buffer = null;
         return null;
      }
      
      private static function getChunks() : Array
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         do
         {
            _loc2_ = uint(fileIn.readUnsignedInt());
            _loc3_ = fileIn.readInt();
            _loc1_.push({
               "type":_loc3_,
               "position":fileIn.position,
               "length":_loc2_
            });
            fileIn.position = fileIn.position + (_loc2_ + 4);
         }
         while(_loc3_ != 1229278788 && fileIn.bytesAvailable > 0);
         
         return _loc1_;
      }
      
      private static function processIHDR(param1:int) : Boolean
      {
         if(param1 != 13)
         {
            return false;
         }
         infoWidth = fileIn.readUnsignedInt();
         infoHeight = fileIn.readUnsignedInt();
         infoBitDepth = fileIn.readUnsignedByte();
         infoColourType = fileIn.readUnsignedByte();
         infoCompressionMethod = fileIn.readUnsignedByte();
         infoFilterMethod = fileIn.readUnsignedByte();
         infoInterlaceMethod = fileIn.readUnsignedByte();
         if(infoWidth <= 0 || infoHeight <= 0)
         {
            return false;
         }
         switch(int(infoBitDepth) - 1)
         {
            case 0:
            case 1:
               switch(int(infoColourType))
               {
                  case 0:
                     if(infoBitDepth != 1 && infoBitDepth != 2 && infoBitDepth != 4 && infoBitDepth != 8 && infoBitDepth != 16)
                     {
                        return false;
                     }
                     break;
                  default:
                     return false;
                  case 2:
                     if(infoBitDepth != 8 && infoBitDepth != 16)
                     {
                        return false;
                     }
                     break;
                  case 3:
                  case 4:
                  default:
                  case 6:
                     if(infoBitDepth != 1 && infoBitDepth != 2 && infoBitDepth != 4 && infoBitDepth != 8)
                     {
                        return false;
                     }
                     break;
               }
               if(infoCompressionMethod != 0 || infoFilterMethod != 0)
               {
                  return false;
               }
               if(infoInterlaceMethod != 0 && infoInterlaceMethod != 1)
               {
                  return false;
               }
               return true;
            default:
            case 3:
            default:
            default:
            default:
            case 7:
            default:
            default:
            default:
            default:
            default:
            default:
            default:
            case 15:
               return false;
         }
      }
      
      private static function processIDAT() : BitmapData
      {
         var _loc2_:* = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:* = 0;
         var _loc1_:* = 0;
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc7_:BitmapData = new BitmapData(infoWidth,infoHeight);
         try
         {
            buffer.uncompress();
         }
         catch(err:*)
         {
            var _loc10_:* = null;
            return _loc10_;
         }
         scanline = 0;
         _loc2_ = uint(buffer.length);
         while(buffer.position < _loc2_)
         {
            _loc6_ = buffer.readUnsignedByte();
            if(_loc6_ == 0)
            {
               _loc8_ = 0;
               while(_loc8_ < infoWidth)
               {
                  _loc4_ = uint(noSample() << 16);
                  _loc1_ = uint(noSample() << 8);
                  _loc3_ = uint(noSample());
                  _loc5_ = uint(noSample() << 24);
                  _loc7_.setPixel32(_loc8_,scanline,_loc5_ + _loc4_ + _loc1_ + _loc3_);
                  _loc8_++;
               }
            }
            else if(_loc6_ == 1)
            {
               _loc8_ = 0;
               while(_loc8_ < infoWidth)
               {
                  _loc4_ = uint(subSample() << 16);
                  _loc1_ = uint(subSample() << 8);
                  _loc3_ = uint(subSample());
                  _loc5_ = uint(subSample() << 24);
                  _loc7_.setPixel32(_loc8_,scanline,_loc5_ + _loc4_ + _loc1_ + _loc3_);
                  _loc8_++;
               }
            }
            else if(_loc6_ == 2)
            {
               _loc8_ = 0;
               while(_loc8_ < infoWidth)
               {
                  _loc4_ = uint(upSample() << 16);
                  _loc1_ = uint(upSample() << 8);
                  _loc3_ = uint(upSample());
                  _loc5_ = uint(upSample() << 24);
                  _loc7_.setPixel32(_loc8_,scanline,_loc5_ + _loc4_ + _loc1_ + _loc3_);
                  _loc8_++;
               }
            }
            else if(_loc6_ == 3)
            {
               _loc8_ = 0;
               while(_loc8_ < infoWidth)
               {
                  _loc4_ = uint(averageSample() << 16);
                  _loc1_ = uint(averageSample() << 8);
                  _loc3_ = uint(averageSample());
                  _loc5_ = uint(averageSample() << 24);
                  _loc7_.setPixel32(_loc8_,scanline,_loc5_ + _loc4_ + _loc1_ + _loc3_);
                  _loc8_++;
               }
            }
            else if(_loc6_ == 4)
            {
               _loc8_ = 0;
               while(_loc8_ < infoWidth)
               {
                  _loc4_ = uint(paethSample() << 16);
                  _loc1_ = uint(paethSample() << 8);
                  _loc3_ = uint(paethSample());
                  _loc5_ = uint(paethSample() << 24);
                  _loc7_.setPixel32(_loc8_,scanline,_loc5_ + _loc4_ + _loc1_ + _loc3_);
                  _loc8_++;
               }
            }
            else
            {
               buffer.position = buffer.position + samples * infoWidth;
            }
            scanline = scanline + 1;
         }
         return _loc7_;
      }
      
      private static function noSample() : uint
      {
         var _loc1_:Number = buffer.position;
         buffer.position++;
         return buffer[_loc1_];
      }
      
      private static function subSample() : uint
      {
         var _loc1_:uint = buffer[buffer.position] + byteA();
         _loc1_ = _loc1_ & 255;
         var _loc2_:Number = buffer.position;
         buffer.position++;
         buffer[_loc2_] = _loc1_;
         return _loc1_;
      }
      
      private static function upSample() : uint
      {
         var _loc1_:uint = buffer[buffer.position] + byteB();
         _loc1_ = _loc1_ & 255;
         var _loc2_:Number = buffer.position;
         buffer.position++;
         buffer[_loc2_] = _loc1_;
         return _loc1_;
      }
      
      private static function averageSample() : uint
      {
         var _loc1_:uint = buffer[buffer.position] + Math.floor((byteA() + byteB()) / 2);
         _loc1_ = _loc1_ & 255;
         var _loc2_:Number = buffer.position;
         buffer.position++;
         buffer[_loc2_] = _loc1_;
         return _loc1_;
      }
      
      private static function paethSample() : uint
      {
         var _loc1_:uint = buffer[buffer.position] + paethPredictor();
         _loc1_ = _loc1_ & 255;
         var _loc2_:Number = buffer.position;
         buffer.position++;
         buffer[_loc2_] = _loc1_;
         return _loc1_;
      }
      
      private static function paethPredictor() : uint
      {
         var _loc8_:uint = byteA();
         var _loc2_:uint = byteB();
         var _loc4_:uint = byteC();
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         _loc7_ = _loc8_ + _loc2_ - _loc4_;
         _loc3_ = Math.abs(_loc7_ - _loc8_);
         _loc5_ = Math.abs(_loc7_ - _loc2_);
         _loc6_ = Math.abs(_loc7_ - _loc4_);
         if(_loc3_ <= _loc5_ && _loc3_ <= _loc6_)
         {
            _loc1_ = _loc8_;
         }
         else if(_loc5_ <= _loc6_)
         {
            _loc1_ = _loc2_;
         }
         else
         {
            _loc1_ = _loc4_;
         }
         return _loc1_;
      }
      
      private static function byteA() : uint
      {
         var _loc2_:int = scanline * (infoWidth * samples + 1);
         var _loc1_:int = buffer.position - samples;
         if(_loc1_ <= _loc2_)
         {
            return 0;
         }
         return buffer[_loc1_];
      }
      
      private static function byteB() : uint
      {
         var _loc1_:int = buffer.position - (infoWidth * samples + 1);
         if(_loc1_ < 0)
         {
            return 0;
         }
         return buffer[_loc1_];
      }
      
      private static function byteC() : uint
      {
         var _loc1_:int = buffer.position - (infoWidth * samples + 1);
         if(_loc1_ < 0)
         {
            return 0;
         }
         var _loc2_:int = (scanline - 1) * (infoWidth * samples + 1);
         _loc1_ = _loc1_ - samples;
         if(_loc1_ <= _loc2_)
         {
            return 0;
         }
         return buffer[_loc1_];
      }
   }
}
