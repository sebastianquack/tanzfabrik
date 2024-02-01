import React from 'react';
import { createRoot } from 'react-dom/client';

import BookingWidget from './components/BookingWidget';

document.addEventListener('DOMContentLoaded', () => {
    const domNode = document.getElementById('studio-booking-widget-root');
    const root = createRoot(domNode);
    root.render(<BookingWidget />);
});
