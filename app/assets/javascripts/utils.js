window.onresize = function() {
    galleryify();
}

//from https://github.com/crispymtn/linear-partition/blob/master/linear_partition.coffee
var linear_partition = function (seq, k) {
	var n = seq.length;
	if (k <= 0) {
		return [];
	}
	if (k > n) {
		return _.map(seq, function(x){
			return [x];
		});
	}
	
	var table = new Array(n);
	for (var i = 0; i < n; i++) {
		table[i] = new Array(k);
		for(var j = 0; j < k; j ++) {
			table[i][j] = 0;
		}
	}
	
	var solution = new Array(n-1);
	for (var i = 0; i < n-1; i++) {
		solution[i] = new Array(k-1);
		for(var j = 0; j < k-1; j ++) {
			solution[i][j] = 0;
		}		
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
			m = _.min(temp_m, function(o) {
				return o[0];
			});
			table[i][j] = m[0];
			solution[i-1][j-1] = m[1];
		}
	}
	
	n--;
	k -= 2;
	var ans = [];
	while (k >= 0) {
		temp_ans = new Array(n+1);
		for(var i = solution[n-1][k]+1; i < n+1; i++) {
			temp_ans[i] = seq[i];
		}
		ans = temp_ans.concat(ans);
		n = solution[n-1][k];
		k--;
	}

	var ret = [];
	for(var i = 0; i < n+1; i++) {
		ret.push(seq[i]);
	}
	return ret.concat(ans);
};

var resize_img = function($p, ideal_width, ideal_height) {
	$p.css({"width": ideal_width, "height": ideal_height});
}

var galleryify = function() {
	var $imgs = $("#gallery .picture img");
	var viewport_width = $("#content").width();
	//var ideal_height = parseInt(($(window).height() - $(".navbar").height()) / 2) - 10;
	//var ideal_height = (($(window).height() - $(".navbar").height()) / 2) - 500;
	var ideal_height = 120;
	
	var summed_width = _.reduce($imgs, function (memo, img) {
		return parseFloat($(img).attr("data-original-width")) + memo;
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
		var arr_partition = [];
		var new_p = [];
		var part_index = 0;
		for(var i =0; i < partition.length; i++) {
			if(partition[i] !== undefined || partition[i+1] !== undefined) {
				new_p.push(partition[i]);
			}
		}
		for(var i =0; i < new_p.length; i++) {
			if (new_p[i]) {
				if (arr_partition[part_index] === undefined) {
					arr_partition[part_index] = [];
				}
				arr_partition[part_index].push(new_p[i]);
			} else {
				part_index++;
			}
		}
		var index = 0;
		var row_buffer = [];
		_.each(arr_partition, function(row) {
			row_buffer = [];
			_.each(row, function(im) {
				row_buffer.push($imgs[index++]);
			});
				var summed_ratios = _.reduce(row_buffer, function(memo, img){
					return parseFloat($(img).attr("data-aspect-ratio")) + memo;
				}, 0);
				_.each(row_buffer, function(img) {
					var $img = $(img);
					resize_img($img, (viewport_width/summed_ratios)*parseFloat($img.attr("data-aspect-ratio")), viewport_width/summed_ratios);
				});
		});
	}
}