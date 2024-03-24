import React from 'react';
import { createRoot } from 'react-dom/client';

import BookingWidget from './components/BookingWidget';

document.addEventListener('DOMContentLoaded', () => {
    const userId = getCookie('user_id');

    console.log({ userId });

    const domNode = document.getElementById('studio-booking-widget-root');
    const root = createRoot(domNode);
    root.render(<BookingWidget />);
});

function getCookie(name) {
    const cookies = document.cookie.split(';');
    for (let cookie of cookies) {
        const [cookieName, cookieValue] = cookie.trim().split('=');
        if (cookieName === name) {
            return decodeURIComponent(cookieValue);
        }
    }
    return null;
}
