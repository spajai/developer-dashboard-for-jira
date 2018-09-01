var pieData = {"Jan":89,"Apr":66,"Mar":97,"May":43,"Jul":184,"year":707,"Feb":61,"Jun":167};

var day = [];
var monthly = [];
var priorityCount = [];
var projectType = [];
var statusType = [];
var yearlyCount = [];

var labelsDay = [];
var labelsMonth = [];
var priorityType = [];
var projectCount = [];
var statusCount = [];
var year = [];

$(document).ready(function() {
    //Get data from API
    $.get("/api/v1/ticket/trends", function(data, status){
        result = data;
        console.log(result);
        drawDayChart(result);
		drawMonthChart(result);
		drawPriorityChart(result);
		drawProjectChart(result);
		drawStatusChart(result);
		drawYearChart(result);
//        drawMonthPieChart(pieData);		
    });
    
    Chart.defaults.global.defaultFontFamily = "Aerial";
    Chart.defaults.global.defaultFontSize = 10;
    Chart.defaults.global.defaultFontColor = "white";
});

function drawMonthChart(result) {
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

function drawPriorityChart(result) {
    var canvasPriority = document.getElementById("priority");
    canvasPriority.height = 185;     //IMP : set this for all canvas to fixed the height .
    var strJSON = JSON.stringify(result);
    var obj = JSON.parse(strJSON);
	
	
    for (var key in result["priority"]) {
        priorityType.push(result["priority"][key].x);
        priorityCount.push(result["priority"][key].y);
    }
	
	var priorityData = {
        label: 'Count',
        //backgroundColor: 'orange',
		borderColor: 'orange',
	    fill: false,
        opacity: 0.25,
        data: priorityCount,
    };
	
	var lineChart = new Chart(canvasPriority, {
        type: 'line',
        data: {
            labels: priorityType,
            datasets: [priorityData],
			fill: false,
        },
		options: {
			scales: {
				xAxes: [{
					display: true,
						scaleLabel: {
							display: true,
							labelString: 'Priority'
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

function drawProjectChart(result) {
    var canvasProject = document.getElementById("project").getContext('2d');
    canvasProject.height = 185;     //IMP : set this for all canvas to fixed the height .
    var strJSON = JSON.stringify(result);
    var obj = JSON.parse(strJSON);
	
    for (var key in result["project"]) {
        projectType.push(result["project"][key].x);
        projectCount.push(result["project"][key].y);
    }
	
	var projectData = {
        label: 'Count',
        backgroundColor: 'orange',
        opacity: 0.25,
        data: projectCount,
    };
	
	var barChart = new Chart(canvasProject, {
        type: 'bar',
        data: {
            labels: projectType,
            datasets: [projectData]
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

function drawStatusChart(result) {
    var canvasStatus = document.getElementById("status");
    canvasStatus.height = 185;     //IMP : set this for all canvas to fixed the height .
    var strJSON = JSON.stringify(result);
    var obj = JSON.parse(strJSON);
	
    for (var key in result["status"]) {
        statusType.push(result["status"][key].x);
        statusCount.push(result["status"][key].y);
    }
	
	function getRandomColor() {
        var letters = '0123456789ABCDEF'.split('');
        var color = '#';
        for (var i = 0; i < 6; i++ ) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }
	
	var colors = [];
	for (var i=0; i < statusType.length; i++) {
		colors.push(getRandomColor());
    }
		
	var statusData = {
        label: 'Count',
        backgroundColor: colors,		
        opacity: 0.25,
        data: statusCount,
    };
	
	var doughnutChart = new Chart(canvasStatus, {
        type: 'doughnut',
        data: {
            labels: statusType,
            datasets: [statusData],
			backgroundColor: [
						'red',
						'orange',
						'yellow',
						'green',
						'blue',
			],
        },
		options: {
			animation: {
					animateScale: true,
					animateRotate: true
				},			
			},		
    });
}

function drawYearChart(result) {
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

function drawStatusChart(result) {
    var canvasStatus = document.getElementById("status");
    canvasStatus.height = 185;     //IMP : set this for all canvas to fixed the height .
    var strJSON = JSON.stringify(result);
    var obj = JSON.parse(strJSON);
	
    for (var key in result["status"]) {
        statusType.push(result["status"][key].x);
        statusCount.push(result["status"][key].y);
    }
	
	function getRandomColor() {
        var letters = '0123456789ABCDEF'.split('');
        var color = '#';
        for (var i = 0; i < 6; i++ ) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }
	
	var colors = [];
	for (var i=0; i < statusType.length; i++) {
		colors.push(getRandomColor());
    }
		
	var statusData = {
        label: 'Count',
        backgroundColor: colors,		
        opacity: 0.25,
        data: statusCount,
    };
	
	var doughnutChart = new Chart(canvasStatus, {
        type: 'doughnut',
        data: {
            labels: statusType,
            datasets: [statusData],
			backgroundColor: [
						'red',
						'orange',
						'yellow',
						'green',
						'blue',
			],
        },
		options: {
			animation: {
					animateScale: true,
					animateRotate: true
				},			
			},		
    });
}
