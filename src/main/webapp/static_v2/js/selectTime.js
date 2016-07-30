function hexadecimal(str){
    var d = str.split("");
    if(d.length!=168){
        return '0';
    }
    var h='';
    for(var i=0; i< d.length; i=i+4){
        var t = '';
        for(var j=0; j< 4; j++){
            t += d[i+j];
        }
        h += parseInt(t,2).toString(16);
    }
    return h;
}
function binary(str){
    var d = str.split("");
    if(d.length!=42){
        return '';
    }
    var b = '';
    for(var i=0;i<d.length;i++){
        var bb = parseInt(d[i],16).toString(2);
        var bbl = bb.length;
        var z = '';
        if(bbl<4){
            for(var j=0;j<4-bbl;j++){
                z+='0';
            }
        }
        b=b+z + bb;
    }
    return b;
}


function analyticTime(timeStr){
    var times = timeStr.split('');
    var week = ['星期一','星期二','星期三','星期四','星期五','星期六','星期日'];
    var show=[];
    for(var i=0;i<7;i=i+1){
        var oneWeekShow = '';
        var oneWeekTime = '';
        var toAdd = false;
        for(var j=0;j<24;j++){
            var h = times[j+i*24];
            if(h=='1'){
                if(toAdd){
                    if(j==23){
                        oneWeekTime +=('~'+j+':59'+'</em>');
                    }else{
                        continue;
                    }
                }else{
                    toAdd = true;
                    oneWeekTime +=('<em class="period-details">'+j+':00');
                    if(j==23){
                        oneWeekTime +=('~'+j+':59'+'</em>');
                    }
                }
            }else{
                if(toAdd){
                    toAdd = false;
                    oneWeekTime +=('~'+(j-1)+':59'+'</em>');
                }else{
                    continue;
                }
            }
        }
        if(oneWeekTime!=''){
            oneWeekShow = '<span class="week">'+week[i] +'</span>' + '<span class="period-list">' +oneWeekTime +'</span>';
            show.push(oneWeekShow);
        }
    }
    return show;
}

var showSelectTime = function (str) {
    if( str.indexOf("1") != -1 ){
        $(".J_dayPartingWrapText").show();
        //$(".J_dayPartingWrapText i", parent.document).text(len);
        var showTs = analyticTime(str);
        var show='';
        for(var i=0;i<showTs.length;i++){
            show+= '<span class="week-oneday">'+showTs[i]+'</span>';
        }
        $('#dayPartingShow').html(show);
    }else{
        $(".J_dayPartingWrapText").hide();
        $(".J_dayPartingCtrl[data-value='0']").addClass("checked");
        $(".J_dayPartingCtrl[data-value='1']").removeClass("checked");
    }
}