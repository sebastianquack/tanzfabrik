import React from 'react';
import ReactDOM from 'react-dom';

import BookingWidget from './components/BookingWidget';

document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
        <BookingWidget />,
        document.getElementById('studio-booking-widget-container')
    );
});
