import React, {Component} from 'react';
import {Badge, Row, Col, Card, CardHeader, CardFooter, CardBody, Label, Input, Table, Pagination, PaginationItem, PaginationLink} from 'reactstrap';
import {getServerTableOrderData} from "../../utilities/backend-api";
import socketIOClient from "socket.io-client";


const serverNotifyNewOrder = "ServerNotifyNewOrder";
const endpoint = "http://54.219.137.151:3333";
class Customers extends Component {

    constructor() {
        super();
        this.state = ({
            tableOrderData: [],
        })
    }

    getTableOrderData() {
        // getServerTableOrderData().then((tables) => {
        //     this.setState({
        //         tableOrderData: tables
        //     })
        // })
    };

    componentDidMount() {
        const socket = socketIOClient(endpoint);
        socket.on(serverNotifyNewOrder, data => this.setState({
            tableOrderData: data
        }));
        console.log(this.state.tableOrderData);
    }

    render() {

        return (
            <div className="animated fadeIn">
                <Row>
                    {this.state.tableOrderData !== null && this.state.tableOrderData.map((order, index) => (
                        <div key={index}>
                            <Col xs="12" sm="6" md="4">
                                <Card>
                                    <CardHeader>
                                        <i className="fa fa-align-justify" /> Table Number : {order.tableId}
                                    </CardHeader>
                                    <CardBody>
                                        <Table responsive>
                                            <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Food Item</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            {order.map((foodItem, index) => (
                                                <div key={index}>
                                                    <tr>
                                                        <td>{index}</td>
                                                        <td>{foodItem.name}</td>
                                                    </tr>
                                                </div>
                                            ))}
                                            </tbody>
                                        </Table>
                                    </CardBody>
                                </Card>
                            </Col>
                        </div>
                    ))}
                    <Col xs="12" sm="6" md="4">
                        <Card>
                            <CardHeader>
                                <i className="fa fa-align-justify" /> Table Number :
                            </CardHeader>
                            <CardBody>
                                <Table responsive>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Food Item</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Brined Pineapple Lamb</td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Fried Ginger & Honey Lamb</td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>Stir-Fried Raspberry & Peanut Clams</td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>Sautéed Garlic & Rosemary Kebabs</td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td>Avocado Surprise</td>
                                    </tr>
                                    </tbody>
                                </Table>
                            </CardBody>
                        </Card>
                    </Col>
                    {/*<Col xs="12" sm="6" md="4">*/}
                        {/*<Card>*/}
                            {/*<CardHeader>*/}
                                {/*Table Number:*/}
                            {/*</CardHeader>*/}
                            {/*<CardBody>*/}
                                {/*Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut*/}
                                {/*laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation*/}
                                {/*ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.*/}
                            {/*</CardBody>*/}
                        {/*</Card>*/}
                    {/*</Col>*/}
                    {/*<Col xs="12" sm="6" md="4">*/}
                        {/*<Card>*/}
                            {/*<CardBody>*/}
                                {/*Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut*/}
                                {/*laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation*/}
                                {/*ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.*/}
                            {/*</CardBody>*/}
                            {/*<CardFooter>Card footer</CardFooter>*/}
                        {/*</Card>*/}
                    {/*</Col>*/}
                    {/*<Col xs="12" sm="6" md="4">*/}
                        {/*<Card>*/}
                            {/*<CardHeader>*/}
                                {/*<i className="fa fa-check float-right"></i>Card with icon*/}
                            {/*</CardHeader>*/}
                            {/*<CardBody>*/}
                                {/*Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut*/}
                                {/*laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation*/}
                                {/*ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.*/}
                            {/*</CardBody>*/}
                        {/*</Card>*/}
                    {/*</Col>*/}
                    {/*<Col xs="12" sm="6" md="4">*/}
                        {/*<Card>*/}
                            {/*<CardHeader>*/}
                                {/*Card with switch*/}
                                {/*<Label className="switch switch-sm switch-text switch-info float-right mb-0">*/}
                                    {/*<Input type="checkbox" className="switch-input"/>*/}
                                    {/*<span className="switch-label" data-on="On" data-off="Off"></span>*/}
                                    {/*<span className="switch-handle"></span>*/}
                                {/*</Label>*/}
                            {/*</CardHeader>*/}
                            {/*<CardBody>*/}
                                {/*Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut*/}
                                {/*laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation*/}
                                {/*ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.*/}
                            {/*</CardBody>*/}
                        {/*</Card>*/}
                    {/*</Col>*/}
                    {/*<Col xs="12" sm="6" md="4">*/}
                        {/*<Card>*/}
                            {/*<CardHeader>*/}
                                {/*Card with label*/}
                                {/*<Badge color="success" className="float-right">Success</Badge>*/}
                            {/*</CardHeader>*/}
                            {/*<CardBody>*/}
                                {/*Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut*/}
                                {/*laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation*/}
                                {/*ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.*/}
                            {/*</CardBody>*/}
                        {/*</Card>*/}
                    {/*</Col>*/}
                    {/*<Col xs="12" sm="6" md="4">*/}
                        {/*<Card>*/}
                            {/*<CardHeader>*/}
                                {/*Card with label*/}
                                {/*<Badge pill color="danger" className="float-right">42</Badge>*/}
                            {/*</CardHeader>*/}
                            {/*<CardBody>*/}
                                {/*Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut*/}
                                {/*laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation*/}
                                {/*ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.*/}
                            {/*</CardBody>*/}
                        {/*</Card>*/}
                    {/*</Col>*/}
                </Row>
            </div>
        )
    }
}

export default Customers;