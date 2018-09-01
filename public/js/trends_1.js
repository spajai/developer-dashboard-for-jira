$(document).ready(function() {

//    var result = '';
    var file = '';

    $('#getChart').click(function(event) {
        file = ($('#fileId option:selected').text());
        if (file === ''){
            return false;
        }
        else{
            getTrends();
        }
    });

     //Get data from API
     function getTrends(){
         $.get("/api/v1/ticket/custom/trends?name=" + file, function(data, status){
             result = data;
             console.log(result);
             drawDayChart(result);
             drawMonthChart(result);
             drawWeekChart(result);
             drawYearChart(result);
             drawTsChart(result);
         });
     }
    
    Chart.defaults.global.defaultFontFamily = "Aerial";
    Chart.defaults.global.defaultFontSize = 10;
    Chart.defaults.global.defaultFontColor = "white";
});

function drawMonthChart(result) {
    var monthly = [];
    var labelsMonth = [];
    var canvasMonthly = document.getElementById("monthly").getContext('2d');
    canvasMonthly.height = 185;     //IMP : set this for all canvas to fixed the height .
    var strJSON = JSON.stringify(result);
    var obj = JSON.parse(strJSON);
	
	var months = [
        'January', 'February', 'March', 'April', 'May',
        'June', 'July', 'August', 'September',
        'October', 'November', 'December'
    ];
	
    for (var key in result["month"]) {
        monthly.push(result["month"][key].y);
        labelsMonth.push(months[key] || '')
    }
	
	var monthlyData = {
        label: 'Count',
        backgroundColor: 'orange',
        opacity: 0.25,
        data: monthly,
    };
	
	var barChart = new Chart(canvasMonthly, {
        type: 'bar',
        data: {
            labels: labelsMonth,
            datasets: [monthlyData]
        },
		options: {
			scales: {
				xAxes: [{
                    ticks: {
			            fontColor: "white",
                        autoSkip: false,
                        maxRotation: 90,
                        minRotation: 90
					}               
                }]
			}
		}
    });
}

function drawDayChart(result) {
    var day = [];
    var labelsDay = [];
    var canvasDay = document.getElementById("day").getContext('2d');
    canvasDay.height = 185;     //IMP : set this for all canvas to fixed the height .
    var strJSON = JSON.stringify(result);
    var obj = JSON.parse(strJSON);
	
    for (var key in result["day"]) {
        day.push(result["day"][key].y);
        labelsDay.push(result["day"][key].x);
    }
	
	var dayData = {
        label: 'Count',
        backgroundColor: 'orange',
        opacity: 0.25,
        data: day,
    };
	
	var lineChart = new Chart(canvasDay, {
        type: 'line',
        data: {
            labels: labelsDay,
            datasets: [dayData]
        },
		fill: "origin",
		options: {
			scales: {
				xAxes: [{
                    ticks: {
			            fontColor: "white",
                        autoSkip: false,
                        maxRotation: 90,
                        minRotation: 90
					}               
                }]
			}
		}
    });
}

function drawTsChart(result) {
    var Ts = [];
    var TsCount = [];
    var canvasTs = document.getElementById("time_stamp");
    canvasTs.height = 185;     //IMP : set this for all canvas to fixed the height .
    var strJSON = JSON.stringify(result);
    var obj = JSON.parse(strJSON);
	
	
    for (var key in result["time_stamp"]) {
        Ts.push(result["time_stamp"][key].x);
        TsCount.push(result["time_stamp"][key].y);
    }
	
	var TsData = {
        label: 'Count',
        //backgroundColor: 'orange',
		borderColor: 'orange',
	    fill: false,
        opacity: 0.25,
        data: TsCount,
    };
	
	var lineChart = new Chart(canvasTs, {
        type: 'line',
        data: {
            labels: Ts,
            datasets: [TsData],
			fill: false,
        },
		options: {
			scales: {
				xAxes: [{
                    type: 'time',
                    distribution: 'linear',
					display: true,
						scaleLabel: {
							display: true,
							labelString: 'Timestamp'
						},
                    ticks: {
			            fontColor: "white",
                        autoSkip: false,
                        maxRotation: 90,
                        minRotation: 90
					}               
                }],
				yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Count'
						}
					}]
			}
		}
    });
}

function drawYearChart(result) {
    var yearlyCount = [];
    var year = [];
    var canvasYear = document.getElementById("year");
    canvasYear.height = 185;     //IMP : set this for all canvas to fixed the height .
    var strJSON = JSON.stringify(result);
    var obj = JSON.parse(strJSON);
	
	
    for (var key in result["year"]) {
        year.push(result["year"][key].x);
        yearlyCount.push(result["year"][key].y);
    }
	
	var yearData = {
        label: 'Count',
        backgroundColor: 'orange',		
        opacity: 0.25,
        data: yearlyCount,
    };
	
	var barChart = new Chart(canvasYear, {
        type: 'bar',
        data: {
            labels: year,
            datasets: [yearData]
        },
		options: {
			scales: {
				xAxes: [{
                    ticks: {
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Year'
						},
			            fontColor: "white",
                        autoSkip: false,
                        maxRotation: 90,
                        minRotation: 90
					}               
                }],
				yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Count'
						}
				}]
			}
		}
    });
}

function drawWeekChart(result) {
    var week = [];
    var weeklyCount = [];
    var canvasWeek = document.getElementById("week").getContext('2d');
    canvasWeek.height = 185;     //IMP : set this for all canvas to fixed the height .
    var strJSON = JSON.stringify(result);
    var obj = JSON.parse(strJSON);

    for (var key in result["week"]) {
        week.push(result["week"][key].x);
        weeklyCount.push(result["week"][key].y);
    }

    var weekData = {
        label: 'Count',
        backgroundColor: 'orange',      
        opacity: 0.25,
        data: weeklyCount,
    };

    var barChart = new Chart(canvasWeek, {
        type: 'bar',
            data: {
                labels: week,
                datasets: [weekData]
        },
        options: {
            scales: {
                xAxes: [{
                   ticks: {
                      display: true,
                      scaleLabel: {
                          display: true,                                                                                                                                                labelString: 'Week'
                      },
                      fontColor: "white",
                      autoSkip: false,
                      maxRotation: 90,
                      minRotation: 90
                   }
                }],
                yAxes: [{
                    display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Count'
                        }
                }]
              }
        }
     });
}

