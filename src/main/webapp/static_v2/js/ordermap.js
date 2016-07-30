
    var libMapfun = {
        /**
         *
         * @param p
         * {
                    option: option,
                    data: data,
                    legendName: "positionname",
                    startDate: "",
                    endDate: "",
                    dateName: "balancedate",
                    seriesName: "pvsum"
                }
         */
        initEchartsDateLine: function (p) {
            var dateArr = dateutils.getDateArr(p.startDate, p.endDate);
            var map = [];

            for (var i = 0; i < p.data.length; i++) {
                var obj = p.data[i], seriesObj = map[obj[p.legendName]];
                if (seriesObj === undefined) {
                    //初始化一个全是0完整的数列，用于补全数据中没有的日期
                    seriesObj = [];
                    for (var j = 0; j < dateArr.length; j++) {
                        seriesObj.push(0);
                    }
                    map[obj[p.legendName]] = seriesObj;
                }
                seriesObj[dateArr.indexOf(obj[p.dateName])] = obj[p.seriesName];
            }

            p.option.xAxis[0].data = dateArr;
            p.option.legend.data = [];
            p.option.series = [];
            for (var key in map) {
                p.option.legend.data.push(key);
                p.option.series.push({"name": key, "type": "line", "data": map[key]});
            }
        }
    };


    var dateutils = {
        DAY: 86400000,
        getDateArr: function (startDate, endDate) {
            if (endDate.getTime() < startDate.getTime()) {
                return [];
            } else {
                var arr = [];
                for (var i = 0; startDate.getTime() < endDate.getTime(); i++) {
                    arr.push(dateutils.formatYYYYMMDD(startDate));
                    startDate.setTime(startDate.getTime() + dateutils.DAY);
                }
                if ((startDate.getTime() - endDate.getTime()) < dateutils.DAY) {
                    //差值小于1天，说明还要增加最后一天
                    arr.push(dateutils.formatYYYYMMDD(endDate));
                }
                return arr;
            }
        },
        getDateByDay: function (date, dayNum) {
            //var newDate = new Date();
            //newDate.setTime(date.getTime() + dayNum * dateutils.DAY);
            //return newDate;
            return new Date(date.getTime() + dayNum * dateutils.DAY);
        },
        formatYYYYMMDD: function (date) {
            return date.toISOString().slice(0, 10);
        }
    }


    function Map() {
        /** 存放键的数组(遍历用到) */
        this.keys = new Array();
        /** 存放数据 */
        this.data = new Object();

        /**
         * 放入一个键值对
         * @param {String} key
         * @param {Object} value
         */
        this.put = function (key, value) {
            if (this.data[key] == null) {
                this.keys.push(key);
            }
            this.data[key] = value;
        };

        /**
         * 获取某键对应的值
         * @param {String} key
         * @return {Object} value
         */
        this.get = function (key) {
            return this.data[key];
        };

        /**
         * 删除一个键值对
         * @param {String} key
         */
        this.remove = function (key) {
            this.keys.remove(key);
            this.data[key] = null;
        };

        /**
         * 遍历Map,执行处理函数
         *
         * @param {Function} 回调函数 function(key,value,index){..}
         */
        this.each = function (fn) {
            if (typeof fn != 'function') {
                return;
            }
            var len = this.keys.length;
            for (var i = 0; i < len; i++) {
                var k = this.keys[i];
                fn(k, this.data[k], i);
            }
        };

        /**
         * 获取键值数组(类似Java的entrySet())
         * @return 键值对象{key,value}的数组
         */
        this.entrys = function () {
            var len = this.keys.length;
            var entrys = new Array(len);
            for (var i = 0; i < len; i++) {
                entrys[i] = {
                    key: this.keys[i],
                    value: this.data[i]
                };
            }
            return entrys;
        };

        /**
         * 判断Map是否为空
         */
        this.isEmpty = function () {
            return this.keys.length == 0;
        };

        /**
         * 获取键值对数量
         */
        this.size = function () {
            return this.keys.length;
        };

        /**
         * 重写toString
         */
        this.toString = function () {
            var s = "{";
            for (var i = 0; i < this.keys.length; i++, s += ',') {
                var k = this.keys[i];
                s += k + "=" + this.data[k];
            }
            s += "}";
            return s;
        };
    }
