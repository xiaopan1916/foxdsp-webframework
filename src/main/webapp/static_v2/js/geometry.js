function Point(x, y) {
	this.set(x,y);
}
Point.prototype = {
	set: function(x,y){
		this.setX(x);
		this.setY(y);
	},
	setX: function(x){
		this.x = x;
	},
	setY: function(y){
		this.y = y;
	}
};
function Rectangle(x1,y1,x2,y2){
	this.p1 = new Point(Math.min(x1,x2),Math.max(y1,y2));
	this.p2 = new Point(Math.max(x1,x2),Math.min(y1,y2));
}
Rectangle.prototype = {
	/*
		判断两个矩形相交
		TODO:不知道咋写
	*/
	cross: function(r){
		var s = this;
		return Math.abs((s.p1.x+s.p2.x)/2-(r.p1.x+r.p2.x)/2)<=(Math.abs(s.p1.x-s.p2.x)+Math.abs(r.p1.x-r.p2.x))/2 &&
			Math.abs((s.p1.y+s.p2.y)/2-(r.p1.y+r.p2.y)/2)<=(Math.abs(s.p1.y-s.p2.y)+Math.abs(r.p1.y-r.p2.y))/2;
	}
};