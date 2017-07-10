package bajie.interfaces.decode
{
	import flash.utils.ByteArray;

	public interface IDecode
	{
		function decode(data:ByteArray, type:int):ByteArray;
	}
}