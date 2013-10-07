package data
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class CharFilesData 
	{
		
		private static var nome:String;
		private static var lvl:String;
		private static var race:String;
		private static var location:String;
		private static var sex:String;
		private static var currentExp:Number;
		private static var nextLevExp:Number;
		private static var filePath:String;
		
		private static var arrChar:Array;
		private static var arrCharacter:Array = new Array;
	
		
		public static function directoryToArray(directory:File):Array 
		{ 
			trace("start loaded")
			
			arrChar = directory.getDirectoryListing()
			//inFile = inFile.resolvePath("Salva.ess");  // name of file to read
			var _inBytes:ByteArray = new ByteArray(); 
			var inStream:FileStream = new FileStream();
			for(var i:Number = 0; i<arrChar.length-1;i++)
			{
				if(arrChar[i].extension == "ess")
				{
					_inBytes = new ByteArray()
					inStream.open(arrChar[i], FileMode.READ); 
					inStream.readBytes(_inBytes); 
					trace("done")
					inStream.close();
					arrCharacter.push(loaded2(_inBytes, arrChar[i]))
				}
			}
			
			return arrCharacter;
			
		} 
		private static function loaded2(inBytes:ByteArray, file:File):Object
		{
			try
			{
				var w:int;
				var h:int;
				var l:uint;
				var tmpArr:ByteArray = new ByteArray()
				var ni:int;
				inBytes.endian = Endian.LITTLE_ENDIAN
				inBytes.position = 0
				trace(inBytes.readUTFBytes(13))
				trace('1',inBytes.position)
				
				trace(inBytes.readInt())
				trace('2',inBytes.position)
				trace(inBytes.readInt())
				trace('3',inBytes.position)
				trace(inBytes.readInt())
				trace('4',inBytes.position)
				trace(ni = inBytes.readShort())
				trace('5',inBytes.position)
				nome = inBytes.readUTFBytes(ni)
				trace('6',inBytes.position)
				lvl = inBytes.readInt().toString();
				trace('7',inBytes.position);
				trace(ni = inBytes.readShort())
				trace('8',inBytes.position);
				location = inBytes.readUTFBytes(ni)
				trace('9',inBytes.position);
				trace(ni = inBytes.readShort())
				trace('10',inBytes.position);
				trace(inBytes.readUTFBytes(ni))
				trace('11',inBytes.position);
				trace(ni = inBytes.readShort())
				trace('12',inBytes.position);
				race = inBytes.readUTFBytes(ni)
				trace('13',inBytes.position);
				sex = inBytes.readShort().toString()
				trace('14',inBytes.position);
				currentExp = inBytes.readFloat()
				trace('15',inBytes.position);
				nextLevExp = inBytes.readFloat()
				trace('16',inBytes.position);
				trace(inBytes.readDouble())
				trace('17',inBytes.position);
				trace(w = inBytes.readInt())
				trace('18',inBytes.position);
				trace(h = inBytes.readInt())
				trace('19',inBytes.position);
				/* trace(inBytes.readInt())
				trace('20',inBytes.position);
				trace(inBytes.readByte())
				trace('21',inBytes.position); */
				l = 3*w*h
				
				var bitmapData:BitmapData;
				var bitmapBA:ByteArray = new ByteArray();
				var bitmap:Bitmap;
				//bitmapBA.endian = Endian.LITTLE_ENDIAN
				inBytes.readBytes(bitmapBA,0,l)
				
				trace('20',inBytes.position);
				trace(inBytes.readByte())
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
				var bit:Bitmap = new Bitmap(bitmapData)
				
			}
			catch(err:Error)
			{
			}
			var tmpObj:Object = new Object;
			tmpObj.nome = nome
			tmpObj.lvl = lvl
			tmpObj.location = location
			tmpObj.race = race
			tmpObj.sex = sex
			tmpObj.currentExp = currentExp
			tmpObj.nextLevExp = nextLevExp
			tmpObj.img = bit
			tmpObj.filePath = file.nativePath
			return tmpObj;
			
			
		}
	}
}