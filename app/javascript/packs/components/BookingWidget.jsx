import React, { useState, useEffect } from 'react';
import Calendar from './Calendar';
import dayjs from 'dayjs';

const BASE_URL = 'http://localhost:3000/api';
const CALENDAR_AVAILABILITY_URL = `${BASE_URL}/studios`;
const STUDIOS_BY_TYPE_URL = `${BASE_URL}/studios`;

const BOOKING_TYPES = [{ value: 'two_hour_rehearsal', name: 'Rehearsal' }];
const BookingWidget = () => {
    const [availabilities, setAvailabilities] = useState(null);
    const [bookingType, setBookingType] = useState(BOOKING_TYPES[0].value);
    const [availableStudios, setAvailableStudios] = useState(null);
    const [currentDay, setCurrentDay] = useState(dayjs());
    const [availableToday, setAvailableToday] = useState(null);

    const handleDateChange = (newDate) => {
        setCurrentDay(newDate);
        setAvailableToday(availabilities[newDate.format('YYYY-MM-DD')]);
        console.log(newDate.format('YYYY-MM-DD'), availabilities);
    };

    const fetchStudiosByType = async (type) => {
        return fetch(`${STUDIOS_BY_TYPE_URL}/${type}`)
            .then((response) => response.json())
            .then((result) => {
                setAvailableStudios(result);
                return result;
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    };
    const fetchCalendar = (studioId, booking_type) => {
        fetch(
            `${CALENDAR_AVAILABILITY_URL}/${studioId}/availabilities?booking_type=${booking_type}`
        )
            .then((response) => response.json())
            .then((result) => {
                setAvailabilities(result);
                setAvailableToday(result[currentDay]);
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    };
    useEffect(() => {
        fetchStudiosByType(bookingType).then((studios) => {
            fetchCalendar(studios[0].id, bookingType);
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
                    <label htmlFor='booking-type'>Select a booking type</label>
                    <select id='booking-type' name='booking-type'>
                        {BOOKING_TYPES.map((bt) => (
                            <option key={bt.value} value={bt.value}>
                                {bt.name}
                            </option>
                        ))}
                    </select>
                    <label htmlFor='studio-select'>Pick a studio</label>
                    <select
                        id='studio-select'
                        name='studio-select'
                        onChange={(e) => {
                            fetchCalendar(e.target.value, bookingType);
                        }}
                    >
                        {availableStudios &&
                            availableStudios.map((studio) => (
                                <option key={studio.id} value={studio.id}>
                                    {studio.name}
                                </option>
                            ))}
                    </select>
                </div>
                <div className='middle-pane'>
                    {availabilities && (
                        <Calendar
                            availabilities={availabilities}
                            defaultDay={currentDay}
                            setCurrentDay={handleDateChange}
                        />
                    )}
                </div>
                <div className='right-pane'>
                    {currentDay.format('YYYY-MM-DD')}

                    {availableToday &&
                        availableToday.map((time) => (
                            <button type='button' className='select-time-btn'>
                                {dayjs(time).format('HH:mm')}
                            </button>
                        ))}
                </div>
            </div>
        </div>
    );
};
export default BookingWidget;