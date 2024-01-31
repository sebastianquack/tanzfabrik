import React, { useState, useEffect } from 'react';
import Calendar from './Calendar';

const URL =
    'http://localhost:3000/api/studios/980190963/availabilities?booking_type=two_hour_rehearsal';
const BookingWidget = () => {
    const [data, setData] = useState(null);

    useEffect(() => {
        fetch(URL)
            .then((response) => response.json())
            .then((result) => {
                setData(result);
                console.log(result);
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    }, []);
    return (
        <div
            style={{
                width: '100%',
            }}
        >
            <h2 className='headline'>Studio Booking</h2>
            <div className='widget-content'>
                <div className='left-pane'>
                    <label for='booking-type'>Select a booking type</label>
                    <select id='booking-type' name='booking-type'>
                        <option value='rehearsal'>Rehearsal</option>
                        <option value='workshop'>Workshop</option>
                        <option value='production'>Product</option>
                    </select>
                    <label for='studio-select'>Pick a studio</label>
                    <select id='studio-select' name='studio-select'>
                        <option value='s1'>Studio 1</option>
                        <option value='s2'>Studio 3</option>
                        <option value='s3'>Studio 4</option>
                    </select>
                </div>
                <div className='middle-pane'>
                    {data && <Calendar availabilities={data} />}
                </div>
                <div className='right-pane'></div>
            </div>
        </div>
    );
};
export default BookingWidget;
