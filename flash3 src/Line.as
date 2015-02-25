package{
	public class Line {
		private var dat:String;
		private var children:Array;
		private var id:int;
		
		public function Line(data:String, id:int){
			this.dat = data;
			this.children = new Array();
			this.id = id;
		}
		
		public function getId() : int{
			return id;
		}
		
		public function addChild(child:Line) : void{
			children[child.getId()] = child;
		}
		
		public function removeChild(child:Line) : void{
			children[child.getId()] = null;
		}
		public function removeChild(child:int) : void{
			children[child] = null;
		}
		public function getChild(child:int) : Line{
			return children[child];
		}
		
		public function formatData(child:Boolean) : String{
			var s:String;
			if(child){
				s = "<i>      =" + dat + "</i>";
			}else{
				s = "<i>    + " + dat + "</i>";
			}
			for each(var l in children){
				s += "<br>" + l.formatData(true);
			}
			return s;
		}
		
	}
}
