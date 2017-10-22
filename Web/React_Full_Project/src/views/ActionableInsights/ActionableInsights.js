import React, {Component} from 'react';
import {Bar, Doughnut, Line, Pie, Polar, Radar} from 'react-chartjs-2';
import {CardColumns, Card, CardHeader, CardBody, Col, Row, CardTitle, Progress, CardFooter} from 'reactstrap';
import Widget01 from "../Widgets/Widget01";
import classNames from 'classnames';
import {Dialog, FlatButton, RaisedButton, TextField} from "material-ui";


class ActionableInsights extends Component {

    constructor() {
        super();
        this.handleClose = this.handleClose.bind(this);
        this.sendPromotionalEmail = this.sendPromotionalEmail.bind(this);
        this.sendTargetedEmail = this.sendTargetedEmail.bind(this);
        this.state = {
            showSendPromotionalEmailDialog: false,
            showSendTargettedEmailDialog: false,
            showResupplyEmailDialog: false
        };
    }

    sendTargetedEmail() {
        this.setState({
            showSendTargettedEmailDialog: true
        })
    }
    sendPromotionalEmail() {
        this.setState({
            showSendPromotionalEmailDialog: true
        })
    };

    sendResupplyEmail() {
        this.setState({
            showResupplyEmailDialog: true
        })
    };

    handleClose() {
        this.setState({
            showSendPromotionalEmailDialog: false,
            showSendTargettedEmailDialog: false,
            showResupplyEmailDialog: false
        });
    }

    render() {

        const actions = [
            <FlatButton
                label="Cancel"
                primary={true}
                onClick={this.handleClose}
            />,
            <FlatButton
                label="Send"
                secondary={true}
                keyboardFocused={true}
                onClick={this.handleClose}
            />,
        ];

        return (
            <div className="animated fadeIn">
                <h3>Marketing Insights</h3>
                <hr />
                <Row>
                    <Col xs="12" sm="8" lg="6">
                        <Card>
                            <CardBody>
                                <CardTitle className="mb-0">Your most well-received dish (for the past month) : </CardTitle>
                                <br/>
                                <div className="h5 m-0">Fish Fillet</div>
                                <div>80.1% of the customers who ate this gave it a thumbs-up.</div>
                                <Progress className={classNames("progress-xs my-1", "")} color="success" value="80"/>
                            </CardBody>
                            <CardFooter>
                                <CardTitle className="mb-0">Recommendation:</CardTitle>
                                You can consider having a 20% promotion for this dish and sending a promotional email to your existing customers.
                                <br/><br/>
                                Would you like to send an email to your customers now?<br/><br/>
                                <RaisedButton label="Send email" primary={true} onClick={() => this.sendPromotionalEmail()}>
                                </RaisedButton>
                                <Dialog
                                    title="Confirm the email content"
                                    actions={actions}
                                    modal={false}
                                    open={this.state.showSendPromotionalEmailDialog}
                                    onRequestClose={this.handleClose}
                                >
                                    <TextField
                                        floatingLabelText="Subject"
                                        value="Exclusive 20% Discount for our Most Well-Received Dish"
                                        fullWidth={true}
                                    />
                                    <TextField
                                        floatingLabelText="Content"
                                        multiLine={true}
                                        value={'We have a limited promotion only for you.' + '\n' +
                                        'Come visit us and receive a 20% off on our Fish Fillet, a dish that has been recommended by many.' + '\n' +
                                        'The promotion only lasts for a week, so hurry down and come visit our store at 715 Stewart Dr, SunnyVale, CA 91130.\n' +
                                        'NOTE: Please show this email to qualify for this offer.'}
                                        fullWidth={true}
                                    />
                                </Dialog>
                            </CardFooter>
                        </Card>
                    </Col>
                    <Col xs="12" sm="8" lg="6">
                        <Card>
                            <CardBody>
                                <CardTitle className="mb-0">Your worst performing dish is (for the past month) : </CardTitle>
                                <br/>
                                <div className="h5 m-0">Cabbage Casserole</div>
                                <div>92.3% of the customers who ate this gave it a thumbs-down.</div>
                                <Progress className={classNames("progress-xs my-1", "")} color="danger" value="80"/>
                            </CardBody>
                            <CardFooter>
                                <CardTitle className="mb-0">Recommendation:</CardTitle>
                                You can consider removing this dish entirely from your menu to reduce any potential food wastage.<br/> OR you can consider changing the recipe for it.
                            </CardFooter>
                        </Card>
                    </Col>
                </Row>
                <Row>
                    <Col xs="12" sm="8" lg="6">
                        <Card>
                            <CardBody>
                                <CardTitle className="mb-0">Your long time customer just left a bad review for you </CardTitle>
                            </CardBody>
                            <CardFooter>
                                <CardTitle className="mb-0">Recommendation:</CardTitle>
                                You can consider sending him/her a 20% discount on everything through a promotional email to entice him/her to come back and visit.
                                <br/><br/>
                                Would you like to send an email to him/her now?<br/><br/>
                                <RaisedButton label="Send email" primary={true} onClick={() => this.sendTargetedEmail()}>
                                </RaisedButton>
                                <Dialog
                                    title="Confirm the email content"
                                    actions={actions}
                                    modal={false}
                                    open={this.state.showSendTargettedEmailDialog}
                                    onRequestClose={this.handleClose}
                                >
                                    <TextField
                                        floatingLabelText="Subject"
                                        value="Exclusive 20% discount on all items"
                                        fullWidth={true}
                                    />
                                    <TextField
                                        floatingLabelText="Content"
                                        multiLine={true}
                                        value={'We have a limited promotion just for you.' + '\n' +
                                        'Come visit us and receive a 20% off for everything on the menu!' + '\n' +
                                        'The promotion only lasts for a week, so hurry down and come visit our store at 715 Stewart Dr, SunnyVale, CA 91130.\n' +
                                        'NOTE: Please show this email to qualify for this offer.'}
                                        fullWidth={true}
                                    />
                                </Dialog>
                            </CardFooter>
                        </Card>
                    </Col>
                </Row>
                <br/><br/>
                <h3>Logistics Insights</h3>
                <hr />
                <Row>
                    <Col xs="12" sm="8" lg="6">
                        <Card>
                            <CardBody>
                                <CardTitle className="mb-0">You're running low on certain ingredients</CardTitle>
                                <br/>
                                <div className="h5 m-0">Fish Fillet</div>
                                <div>Based on the high popularity of your Roast Beef Sandwich, Fish Fillet and Fried Ginger & Honey Lamb, you may be running super
                                    low on Beef Neck, Dory Fish Fillet and Lamb Shoulder.</div>
                                <Progress className={classNames("progress-xs my-1", "")} color="danger" value="30"/>
                            </CardBody>
                            <CardFooter>
                                <CardTitle className="mb-0">Recommendation:</CardTitle>
                                You can consider sending an email to your supplier to order these ingredients in advance, before they run out.
                                <br/><br/>
                                Would you like to send an email to your supplier now?<br/><br/>
                                <RaisedButton label="Send email" primary={true} onClick={() => this.sendResupplyEmail()}>
                                </RaisedButton>
                                <Dialog
                                    title="Confirm the email content"
                                    actions={actions}
                                    modal={false}
                                    open={this.state.showResupplyEmailDialog}
                                    onRequestClose={this.handleClose}
                                >
                                    <TextField
                                        floatingLabelText="Subject"
                                        value="Order details"
                                        fullWidth={true}
                                    />
                                    <TextField
                                        floatingLabelText="Content"
                                        multiLine={true}
                                        value={'I would like to order the following items:' + '\n' +
                                        'Beef Neck\nFish Fillet\nLamb Shoulder' + '\n\n' +
                                        'Please send me the items by the following week.'}
                                        fullWidth={true}
                                    />
                                </Dialog>
                            </CardFooter>
                        </Card>
                    </Col>
                </Row>

            </div>
        )
    }
}

export default ActionableInsights;
