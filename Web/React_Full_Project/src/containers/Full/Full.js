import React, {Component} from 'react';
import {Switch, Route, Redirect} from 'react-router-dom';
import socketIOClient from "socket.io-client";

import {Container} from 'reactstrap';
import Header from '../../components/Header/';
import Sidebar from '../../components/Sidebar/';
import Breadcrumb from '../../components/Breadcrumb/';
import Aside from '../../components/Aside/';
import Footer from '../../components/Footer/';
import Dashboard from '../../views/Dashboard/';
import Charts from '../../views/Charts/';
import Widgets from '../../views/Widgets/';
import Customers from '../../views/Customers/'
import ActionableInsights from "../../views/ActionableInsights/";

// Components
import Buttons from '../../views/Components/Buttons/';
import Cards from '../../views/Components/Cards/';
import Forms from '../../views/Components/Forms/';
import Modals from '../../views/Components/Modals/';
import SocialButtons from '../../views/Components/SocialButtons/';
import Switches from '../../views/Components/Switches/';
import Tables from '../../views/Components/Tables/';
import Tabs from '../../views/Components/Tabs/';
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap';

// Icons
import FontAwesome from '../../views/Icons/FontAwesome/';
import SimpleLineIcons from '../../views/Icons/SimpleLineIcons/';
import {MuiThemeProvider} from "material-ui";

const serverNotificationPayment = "ServerNotifyForPayment";
const endpoint = "http://54.219.137.151:3333";

class Full extends Component {

  constructor() {
    super();
      this.togglePayment = this.togglePayment.bind(this);
        this.processPayment = this.processPayment.bind(this);
        this.state = {
            receivedResponse: false,
            notificationResponse: [],
            paymentProcessModal: false

        };
    }

    componentDidMount() {
        const socket = socketIOClient(endpoint);
        socket.on("ServerNotifyForPayment", data =>

            this.setState({
                notificationResponse: data,
                receivedResponse: true
            })
        );

        console.log(this.state.notificationResponse);
    }

    processPayment() {
        const socket = socketIOClient(endpoint);
        socket.emit("ServerConfirmPayment", this.state.notificationResponse[0].table_id);
        this.togglePayment();
    }

    togglePayment() {
        this.setState({
            paymentProcessModal: !this.state.paymentProcessModal
        });
    }

    render() {
    return (
      <div className="app">
        <Header />
        <div className="app-body">
          <Sidebar {...this.props}/>
          <main className="main">
            <Breadcrumb />
            <Container fluid>
                {this.state.receivedResponse &&
                    <Modal isOpen={this.state.paymentProcessModal} toggle={this.togglePayment} className={this.props.className}>
                        <ModalHeader toggle={this.togglePayment}>Ready to process payment for table {this.state.notificationResponse[0].table_id}</ModalHeader>
                        <ModalBody>
                            Table number {this.state.notificationResponse[0].table_id} is ready for its payment processing of ${this.state.notificationResponse[0].total_bill}
                        </ModalBody>
                        <ModalFooter>
                            <Button color="danger" onClick={this.togglePayment}>Cancel Payment</Button>
                            <Button color="primary" onClick={this.processPayment}>Process Payment!</Button>{' '}
                        </ModalFooter>
                    </Modal>
                }
                <MuiThemeProvider>
              <Switch>
                  <Route path="/insights" name="Actionable Insights" component={ActionableInsights}/>
                <Route path="/dashboard" name="Dashboard" component={Dashboard}/>
                <Route path="/customers" name="Customers" component={Customers}/>
                <Route path="/components/buttons" name="Buttons" component={Buttons}/>
                <Route path="/components/cards" name="Cards" component={Cards}/>
                <Route path="/components/forms" name="Forms" component={Forms}/>
                <Route path="/components/modals" name="Modals" component={Modals}/>
                <Route path="/components/social-buttons" name="Social Buttons" component={SocialButtons}/>
                <Route path="/components/switches" name="Switches" component={Switches}/>
                <Route path="/components/tables" name="Tables" component={Tables}/>
                <Route path="/components/tabs" name="Tabs" component={Tabs}/>
                <Route path="/icons/font-awesome" name="Font Awesome" component={FontAwesome}/>
                <Route path="/icons/simple-line-icons" name="Simple Line Icons" component={SimpleLineIcons}/>
                <Route path="/widgets" name="Widgets" component={Widgets}/>
                <Route path="/charts" name="Charts" component={Charts}/>
                <Redirect from="/" to="/dashboard"/>
              </Switch>
                </MuiThemeProvider>
            </Container>
          </main>
          <Aside />
        </div>
        <Footer />
      </div>
    );
  }
}

export default Full;
