import React, { Component } from 'react';
import {Bar, Line} from 'react-chartjs-2';
import {
  Badge,
  Row,
  Col,
  Progress,
  Dropdown,
  DropdownToggle,
  DropdownMenu,
  DropdownItem,
  Card,
  CardHeader,
  CardBody,
  CardFooter,
  CardTitle,
  Button,
  ButtonToolbar,
  ButtonGroup,
  ButtonDropdown,
  Label,
  Input,
  Table
} from 'reactstrap';

const brandPrimary = '#20a8d8';
const brandSuccess = '#4dbd74';
const brandInfo = '#63c2de';
const brandWarning = '#f8cb00';
const brandDanger = '#f86c6b';


// Main Chart

// convert Hex to RGBA
function convertHex(hex, opacity) {
  hex = hex.replace('#', '');
  var r = parseInt(hex.substring(0, 2), 16);
  var g = parseInt(hex.substring(2, 4), 16);
  var b = parseInt(hex.substring(4, 6), 16);

  var result = 'rgba(' + r + ',' + g + ',' + b + ',' + opacity / 100 + ')';
  return result;
}

//Random Numbers
function random(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

function randomDec(min, max) {
    return +(Math.random() * (max - min) + min).toFixed(2);
}


let numHours= 16;
let dayData = [];
for(let i = 0; i < numHours; i++) {
    dayData.push(random(5, 30));
}

let numDays = 27;
let monthData = [];
for (let i = 0; i <= numDays; i++) {
    monthData.push(random(30, 150));
}

let yearData = [];
let numMonths = 10 * 4;
for(let i = 0; i < numMonths; i++) {
    yearData.push(random(2500, 5000));
}

const mainDayChart = {
    labels: ['08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00',
            '20:00', '21:00', '22:00', '23:00'],
    datasets: [
        {
            label: 'Volume of People (per Hour)',
            backgroundColor: convertHex(brandSuccess, 10),
            borderColor: brandSuccess,
            pointHoverBackgroundColor: '#fff',
            borderWidth: 2,
            data: dayData
        }
    ]
};

const mainMonthChart = {
  labels: ['M', 'T', 'W', 'T', 'F', 'S', 'S', 'M', 'T', 'W', 'T', 'F', 'S', 'S', 'M', 'T', 'W', 'T', 'F', 'S', 'S', 'M', 'T', 'W', 'T', 'F', 'S', 'S'],
  datasets: [
      {
          label: 'Volume of People (per Day)',
          backgroundColor: convertHex(brandSuccess, 10),
          borderColor: brandSuccess,
          pointHoverBackgroundColor: '#fff',
          borderWidth: 2,
          data: monthData
      }
  ]
};

const mainYearChart = {
    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
    datasets: [
        {
            label: "Volume of People (per Month)",
            backgroundColor: convertHex(brandSuccess, 10),
            borderColor: brandSuccess,
            pointHoverBackgroundColor: '#fff',
            borderWidth: 2,
            data: yearData
        }
    ]
};

const mainChartDayOpts = {
    maintainAspectRatio: false,
    legend: {
        display: false
    },
    scales: {
        xAxes: [{
            gridLines: {
                drawOnChartArea: false,
            }
        }],
        yAxes: [{
            ticks: {
                beginAtZero: true,
                maxTicksLimit: 5,
                stepSize: 2,
                max: 40
            }
        }]
    },
    elements: {
        point: {
            radius: 0,
            hitRadius: 10,
            hoverRadius: 4,
            hoverBorderWidth: 3,
        }
    }
};

const mainChartMonthOpts = {
  maintainAspectRatio: false,
  legend: {
    display: false
  },
  scales: {
    xAxes: [{
      gridLines: {
        drawOnChartArea: false,
      }
    }],
    yAxes: [{
      ticks: {
        beginAtZero: true,
        maxTicksLimit: 5,
        stepSize: Math.ceil(250 / 10),
        max: 150
      }
    }]
  },
  elements: {
    point: {
      radius: 0,
      hitRadius: 10,
      hoverRadius: 4,
      hoverBorderWidth: 3,
    }
  }
};

const mainChartYearOpts = {
    maintainAspectRatio: false,
    legend: {
        display: false
    },
    scales: {
        xAxes: [{
            gridLines: {
                drawOnChartArea: false,
            }
        }],
        yAxes: [{
            ticks: {
                beginAtZero: true,
                maxTicksLimit: 5,
                stepSize: Math.ceil(5000 / 10),
                max: 5000
            }
        }]
    },
    elements: {
        point: {
            radius: 0,
            hitRadius: 10,
            hoverRadius: 4,
            hoverBorderWidth: 3,
        }
    }
};

let serviceRatingData = [];
let numPoints = 6 * 4;
for(let i = 0; i <= numPoints; i++) {
    serviceRatingData.push(randomDec(0, 5));
}

const serviceRatingChart = {
    labels: ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
    datasets: [
        {
            label: "Service Rating",
            backgroundColor: convertHex(brandPrimary, 10),
            borderColor: brandPrimary,
            pointHoverBackgroundColor: '#fff',
            borderWidth: 2,
            data: serviceRatingData
        }
    ]
};
const serviceRatingOpts = {
    maintainAspectRatio: false,
    legend: {
        display: false
    },
    scales: {
        xAxes: [{
            gridLines: {
                drawOnChartArea: false,
            }
        }],
        yAxes: [{
            ticks: {
                beginAtZero: true,
                maxTicksLimit: 5,
                stepSize: 0.5,
                max: 5
            }
        }]
    },
    elements: {
        point: {
            radius: 0,
            hitRadius: 10,
            hoverRadius: 4,
            hoverBorderWidth: 3,
        }
    }
};

let overallPerfData = [];
let perfDataPoints = 6 * 4;
for(let i = 0; i <= perfDataPoints; i++) {
    overallPerfData.push(randomDec(0, 5));
}

const overallPerfChart = {
    labels: ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
    datasets: [
        {
            label: "Service Rating",
            backgroundColor: convertHex(brandPrimary, 10),
            borderColor: brandPrimary,
            pointHoverBackgroundColor: '#fff',
            borderWidth: 2,
            data: overallPerfData
        }
    ]
};
const overallPerfOpts = {
    maintainAspectRatio: false,
    legend: {
        display: false
    },
    scales: {
        xAxes: [{
            gridLines: {
                drawOnChartArea: false,
            }
        }],
        yAxes: [{
            ticks: {
                beginAtZero: true,
                maxTicksLimit: 5,
                stepSize: 0.5,
                max: 5
            }
        }]
    },
    elements: {
        point: {
            radius: 0,
            hitRadius: 10,
            hoverRadius: 4,
            hoverBorderWidth: 3,
        }
    }
};

class Dashboard extends Component {
    constructor(props) {
        super(props);

        this.changeChartViewToYear = this.changeChartViewToYear.bind(this);
        this.changeChartViewToMonth = this.changeChartViewToMonth.bind(this);
        this.changeChartViewToDay = this.changeChartViewToDay.bind(this);
        this.setTotalVists = this.setTotalVists.bind(this);
        this.state = {
            monthBtnClass: 'btn btn-outline-secondary active',
            yearBtnClass: 'btn btn-outline-secondary',
            dayBtnClass: 'btn btn-outline-secondary',
            monthChartOpen: true,
            dayChartOpen: false,
            yearChartOpen: false,
            totalVisits: 0,
            dropdownOpen: false,
            dataRange: 'For the month October 2017'
        }
    }

    componentDidMount() {
        // this.setState({
        //     chartOptions: mainChartMonthOpts,
        //     chartOpen: mainMonthChart
        // });
        this.setTotalVists(numDays, monthData);
    }



    setTotalVists(numPoints, data) {
        let totalVists = 0;
        for(let i = 0; i < numPoints; i++) {
            totalVists += data[i];
        }
        this.setState({
            totalVisits: totalVists
        });
    }

    changeChartViewToYear() {
        this.setState({
            yearChartOpen: true,
            dayChartOpen: false,
            monthChartOpen: false,
            dataRange: 'For the year 2017',
            monthBtnClass: 'btn btn-outline-secondary',
            yearBtnClass: 'btn btn-outline-secondary active',
            dayBtnClass: 'btn btn-outline-secondary'
        });
        this.setTotalVists(numMonths, yearData);
    }

    changeChartViewToMonth() {
        this.setState({
            yearChartOpen: false,
            dayChartOpen: false,
            monthChartOpen: true,
            dataRange: 'For the month October 2017',
            dayBtnClass: 'btn btn-outline-secondary',
            yearBtnClass: 'btn btn-outline-secondary',
            monthBtnClass: 'btn btn-outline-secondary active'
        });
        this.setTotalVists(numDays, monthData);

    }

    changeChartViewToDay() {
        this.setState({
            yearChartOpen: false,
            dayChartOpen: true,
            monthChartOpen: false,
            dataRange: 'For the day 21 October 2017',
            dayBtnClass: 'btn btn-outline-secondary active',
            yearBtnClass: 'btn btn-outline-secondary',
            monthBtnClass: 'btn btn-outline-secondary'
        });
        this.setTotalVists(numHours, dayData);
    }

    render() {

    return (
      <div className="animated fadeIn">
        <Row>
          <Col>
            <Card>
              <CardBody>
                <Row>
                  <Col sm="5">
                    <CardTitle className="mb-0">Volume of Customers</CardTitle>
                    <div className="small text-muted">{this.state.dataRange}</div>
                  </Col>
                  <Col sm="7" className="d-none d-sm-inline-block">
                    <Button color="primary" className="float-right"><i className="icon-cloud-download"></i></Button>
                    <ButtonToolbar className="float-right" aria-label="Toolbar with button groups">
                      <ButtonGroup className="mr-3" data-toggle="buttons" aria-label="First group">
                          <Button htmlFor="dayChart" id="dayChartBtn" className={this.state.dayBtnClass} onClick={this.changeChartViewToDay}>
                              Day
                          </Button>
                        <Button htmlFor="monthChart" id="monthChartBtn" className={this.state.monthBtnClass} onClick={this.changeChartViewToMonth}>
                          Month
                        </Button>
                        <Button htmlFor="yearChart" id="yearChartBtn" className={this.state.yearBtnClass} onClick={this.changeChartViewToYear} >
                          Year
                        </Button>
                      </ButtonGroup>
                    </ButtonToolbar>
                  </Col>
                </Row>

                <div className="chart-wrapper" style={{height: 300 + 'px', marginTop: 40 + 'px'}}>
                    {this.state.dayChartOpen &&
                    <Line data={mainDayChart} options={mainChartDayOpts} height={300}/>
                    }
                    {this.state.monthChartOpen &&
                    <Line data={mainMonthChart} options={mainChartMonthOpts} height={300}/>
                    }
                    {this.state.yearChartOpen &&
                    <Line data={mainYearChart} options={mainChartYearOpts} height={300}/>
                    }
                </div>
              </CardBody>
              <CardFooter>
                <ul>
                  <li>
                    <div className="text-muted">Total Visits : {this.state.totalVisits} </div>
                    <strong></strong>
                  </li>
                </ul>
              </CardFooter>
            </Card>
          </Col>
        </Row>

          <Row>

              <Col>
                  <Card>
                      <CardBody>
                      <Row>
                              <Col sm="12">
                                  <CardTitle className="mb-0">Service Rating (out of 5)</CardTitle>
                                  <div className="small text-muted">For the past 6 months</div>
                              </Col>
                          </Row>
                          <div className="chart-wrapper" style={{height: 300 + 'px', marginTop: 40 + 'px'}}>
                              <Line data={serviceRatingChart} options={serviceRatingOpts} height={300} showLing={false}/>
                          </div>
                      </CardBody>
                  </Card>
              </Col>
              <Col>
                  <Card>
                      <CardBody>
                          <Row>
                              <Col sm="12">
                                  <CardTitle className="mb-0">Overall Performance Rating (out of 5)</CardTitle>
                                  <div className="small text-muted">For the past 6 months</div>
                              </Col>
                          </Row>
                          <div className="chart-wrapper" style={{height: 300 + 'px', marginTop: 40 + 'px'}}>
                              <Line data={overallPerfChart} options={overallPerfOpts} height={300} showLing={false}/>
                          </div>
                      </CardBody>
                  </Card>
              </Col>
          </Row>
        <Row>
            <Col>
                <Card>
                    <CardHeader>
                        Top 5 Most Popular Main of the Month
                    </CardHeader>
                    <CardBody>
                        <Table responsive>
                            <thead>
                            <tr>
                                <th>Ranking</th>
                                <th>Food Name</th>
                                <th>No. of Orders</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>1</td>
                                <td>Roast Beef Sandwich</td>
                                <td>838 &nbsp;<Badge color="success">Most Popular!</Badge> </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Fish Fillet</td>
                                <td>733</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Fried Ginger & Honey Lamb</td>
                                <td>712</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Herb Encrusted Seabass</td>
                                <td>655</td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>Ribeye Steak</td>
                                <td>648</td>
                            </tr>
                            </tbody>
                        </Table>
                    </CardBody>
                </Card>
            </Col>
            <Col>
                <Card>
                    <CardHeader>
                        Top 5 Most Liked Main of the Month
                    </CardHeader>
                    <CardBody>
                        <Table responsive>
                            <thead>
                            <tr>
                                <th>Ranking</th>
                                <th>Food Name</th>
                                <th>No. of Thumbs-Up</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>1</td>
                                <td>Roast Beef Sandwich</td>
                                <td>543 &nbsp;<Badge color="success">Most Liked!</Badge> </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Fried Ginger & Honey Lamb</td>
                                <td>443</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Sautéed Garlic & Rosemary Kebabs</td>
                                <td>442</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Fish Fillet</td>
                                <td>421</td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>Ribeye Steak</td>
                                <td>410</td>
                            </tr>
                            </tbody>
                        </Table>
                    </CardBody>
                </Card>
            </Col>
        </Row>
      </div>
    )
  }
}

export default Dashboard;
