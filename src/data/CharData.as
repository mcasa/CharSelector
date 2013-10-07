package data
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class CharData extends Object
	{
		
		public var nome:String;
		public var lvl:Number;
		public var race:String;
		public var location:String;
		public var sex:Number;
		public var currentExp:Number;
		public var nextLevExp:Number;
		public var bit:Bitmap;
		public var fileName:String;
		
		//private  var filePathSKSE:String;
		
	/*	private  var arrChar:Array;
		private  var arrCharacterESS:Array = new Array;
		private  var arrCharacterSKSE:Array = new Array;*/
		
		public function CharData(file:File):void
		{
			load(file)
			
		}
		
		public function getProperty(prop:String):*
		{
			
			return this['prop']
			
		}
		
		private  function load(file:File):void
		{
			try
			{
				var inBytes:ByteArray = new ByteArray(); 
				var inStream:FileStream = new FileStream();
				var w:int;
				var h:int;
				var l:uint;
				var tmpArr:ByteArray = new ByteArray()
				var ni:int;
				inBytes = new ByteArray()
				inStream.open(file, FileMode.READ); 
				inStream.readBytes(inBytes); 
				trace("done")
				inStream.close();
				inBytes.endian = Endian.LITTLE_ENDIAN
				inBytes.position = 0
				trace('Constant', inBytes.readUTFBytes(13))
				trace(inBytes.position)
				trace('headerSize',inBytes.readInt())
				trace(inBytes.position)
				trace('version',inBytes.readInt())
				trace(inBytes.position)
				trace('saveNumber',inBytes.readInt())
				trace(inBytes.position)
				trace('playerName size', ni = inBytes.readShort())
				trace(inBytes.position)
				trace('playerName',nome = inBytes.readUTFBytes(ni))
				trace(inBytes.position)
				trace('playerLevel', lvl = inBytes.readInt());
				trace(inBytes.position);
				trace('playerLocationSize', ni = inBytes.readShort())
				trace(inBytes.position);
				trace('playerLocation', location = inBytes.readUTFBytes(ni));
				trace(inBytes.position);
				trace('gameDateSize',ni = inBytes.readShort())
				trace(inBytes.position);
				trace('gameDate', inBytes.readUTFBytes(ni))
				trace(inBytes.position);
				trace('playerRaceSize',ni = inBytes.readShort())
				trace(inBytes.position);
				trace('playerRace',race = inBytes.readUTFBytes(ni))
				trace(inBytes.position);
				trace('playerSexs',sex = inBytes.readShort())
				trace(inBytes.position);
				trace("currentExp", currentExp = inBytes.readFloat())
				trace(inBytes.position);
				trace('nextLevelExp',nextLevExp = inBytes.readFloat())
				trace(inBytes.position);
				trace('fileTime',inBytes.readDouble())
				trace(inBytes.position);
				trace('shotWidth',w = inBytes.readInt())
				trace(inBytes.position);
				trace('shotheight',h = inBytes.readInt())
				trace(inBytes.position);
				l = 3*w*h
				
				var bitmapData:BitmapData;
				var bitmapBA:ByteArray = new ByteArray();
				var bitmap:Bitmap;
				//bitmapBA.endian = Endian.LITTLE_ENDIAN
				inBytes.readBytes(bitmapBA,0,l)
				trace('screenShotData done')
				trace(inBytes.position);
				trace('formVersion',inBytes.readByte())
				trace('21',inBytes.position);
				bitmapData = new BitmapData(w, h);
				bitmapBA.position = 0
				bitmapBA.endian = Endian.LITTLE_ENDIAN
				
				for(var i:Number =0; i<h; i++)
				{
					for(var j:Number =0; j<w; j++)
					{
						var alphaValue = 0
						var redValue = bitmapBA.readByte();
						var greenValue = bitmapBA.readByte();
						var blueValue = bitmapBA.readByte();
						var color:uint = alphaValue << 32 | redValue << 16 | greenValue << 8 | blueValue;
						bitmapData.setPixel(j,i,color);
						//bitmapData.setPixel32(j,i, color);
					}
				}
				
				bitmapData.lock()
				bit = new Bitmap(bitmapData)
				
			}
			catch(err:Error)
			{
				trace("Errore nel caricamento del file " + file.nativePath)
			}
			fileName = removeExtension(file.nativePath)
			
			/*var tmpObj:Object = new Object;
			tmpObj.nome = nome
			tmpObj.lvl = lvl
			tmpObj.location = location
			tmpObj.race = race
			tmpObj.sex = sex
			tmpObj.currentExp = currentExp
			tmpObj.nextLevExp = nextLevExp
			tmpObj.img = bit
			tmpObj.filePath = file.nativePath*/

			
			
		}
		
		private  function removeExtension(fileName:String):String
		{
			var i:Number = fileName.indexOf(".")
				return fileName.substring(0,i)
			
		}
	}
}