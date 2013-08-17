//from https://github.com/crispymtn/linear-partition/blob/master/linear_partition.coffee
var linear_parition = function(seq, k) {
	var n = seq.length;
	if (k <= 0) {
		return [];
	}
	if (k > n) {
		return _.map(seq, function(x){
			return [x];
		});
	}
	
	var table = new Array(k);
	for (var i = 0; i < k; i++) {
		table[i] = new Array(n);
	}
	
	var solution = new Array(k-1);
	for (var i = 0; i < k-1; i++) {
		table[i] = new Array(n-1);
	}
	
	for(var i=0; i < n; i++) {
		var temp = 0;
		if(i) {
			temp = table[i-1][0];
		}
		table[i][0] = seq[i] + temp;
	}
	
	for(var i=0; i < n; i++) {
		var temp = 0;
		if(i) {
			temp = table[i-1][0];
		}
		table[i][0] = seq[i] + temp;
	}
	
	for(var j=0; j < k; j++) {
		table[0][j] = seq[0] 
	}
	
	for(var i=1; i < n; i++) {
		for(var j=1; j < k; j++) {
			var m;
			var temp_m = new Array(i);
			for(var x = 0; x < i; x++) {
				temp_m[x] = [_.max([table[x][j-1], table[i][0]-table[x][0]]) , x];
			}
			m = _.min(temp_m);
			table[i][j] = m[0];
			solution[i-1][j-1] = m[1];
		}
	}
	
	n--;
	k -= 2;
	var ans = [];
	while (k >= 0) {
		for(var i = solution[n-1][k]+1; i < n+1; i++) {
			temp_ans[i] = seq[i];
		}
		ans = temp_ans.concat(ans);
		n = solution[n-1][k];
		k--;
	}
	
	var ret;
	for(var i = 0; i < n+1; i++) {
		ret = seq[i].concat(ans);
	}
	return ret;
};

window.onresize = function() {
    galleryify();
}

function resize_img($p, ideal_width, ideal_height) {
	$p.css({"width": ideal_width, "height": ideal_height});
}

function galleryify() {
	var $imgs = $("#gallery .picture img");
	var viewport_width = $("#content").width();
	var ideal_height = parseInt(($(window).height() - $(".navbar").height()) / 2);
	
	var summed_width = _.reduce($imgs, function (memo, img) {
		return $(img).width();
	}, 0);
	
	var rows = Math.round(summed_width / viewport_width);
	
	if (rows < 1) {
		//standard sizing
		_.each($imgs, function(img) {
			var $img = $(img);
			var ratio = $img.data("aspectRatio");
			resize_img($(img), (ideal_height * ratio), ideal_height);
		});
	} else {
		//distribute photos over rows using aspect ratio as weighting
		var weights = _.map($imgs, function(img) {
			var $img = $(img);
			return (100 * $img.data("aspectRatio"));
		});
		
		var partition = linear_partition(weights, rows);
		var index = 0;
		var row_buffer = [];
		_.each(partition, function(row) {
			row_buffer = [];
			_.each(row, function(im) {
				row_buffer.push($imgs[index++]);
			});
				var summed_ratios = _.reduce(row_buffer, function(img){
					return $img.data("aspectRatio");
				}, 0);
				_.each(row_buffer, function(photo) {
					var $img = $(photo);
					resize_photo($img, (viewport_width/summed_ratios)*$img.data("aspectRatio"), viewport_width/summed_ratios);
				});
		});
	}
}