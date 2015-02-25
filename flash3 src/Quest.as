package  {
	public class Quest{
		private var name:String;
		private var players:int;
		private var lines:Array;
		private var id:int;
		
		public function Quest(name:String, players:int, id:int){
			this.name = name;
			this.id = id;
			this.players = players;
			this.lines = new Array();
		}
		
		public function getId() : int{
			return id;
		}
		
		public function addChild(child:Line) : void{
			lines[child.getId()] = child;
		}
		
		public function removeChild(child:Line) : void{
			lines[child.getId()] = null;
		}
		public function removeChild(child:int) : void{
			lines[child] = null;
		}
		public function getChild(child:int) : Line{
			return lines[child];
		}
		
		public function compileHtml() : String{
			var s:String = "<b>" + name + "</b>";
			var l:Line = new Line();
			for each(var b in lines){
				s += "<br>" + b.formatData(false);
			}
			//for(var b:Line in lines){
				//s += "<br>" + b.formatData(false);
			//}
			return s;
		}
		
	}
}
