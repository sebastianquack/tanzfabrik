import React, { useState } from 'react';
import Calendar from './Calendar';

const BookingWidget = () => {
    return (
        <div
            style={{
                width: '100%',
            }}
        >
            <h2 class='headline'>Studio Booking</h2>
            <div
                style={{
                    borderWidth: '1px',
                    borderStyle: 'solid',
                    margin: '2rem 0 2rem 0',
                    width: '100%',
                }}
            >
                <Calendar />
            </div>
        </div>
    );
};
export default BookingWidget;
