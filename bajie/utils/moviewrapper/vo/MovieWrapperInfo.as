package bajie.utils.moviewrapper.vo
{
	public class MovieWrapperInfo
	{
		public var mcWidth:int;
		public var mcHeight:int;
		public var totalFrames:int;
		public var columns:int;
		public var lines:int;
		
		public function MovieWrapperInfo(column:int, width:int, height:int, totalFrame:int)
		{
			columns = column;
			lines = Math.ceil((totalFrame/ columns));
			mcWidth = width;
			mcHeight = height;
			totalFrames = totalFrame;
		}
	}
}