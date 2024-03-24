import React, { useState, useEffect } from 'react';
import classNames from 'classnames';
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
    const [selectedStudio, setSelectedStudio] = useState(null);
    const [currentDay, setCurrentDay] = useState(dayjs());
    const [availableToday, setAvailableToday] = useState(null);
    const [selectedTimes, setSelectedTimes] = useState({});

    const handleDateChange = (newDate) => {
        setCurrentDay(newDate);
        setAvailableToday(availabilities[newDate.format('YYYY-MM-DD')]);
    };

    const handleTimeSelection = (time) => {
        if (selectedTimes[time.id]) {
            delete selectedTimes[time.id];
            setSelectedTimes({ ...selectedTimes });
        } else {
            const data = { ...selectedTimes, [time.id]: time };
            setSelectedTimes(data);
        }
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

    const handleChangeStudio = (studioId, bookingType) => {
        const selectedStudio = availableStudios.find((s) => s.id == studioId);
        console.log({ selectedStudio });
        setSelectedStudio(selectedStudio);
        fetchCalendar(studioId, bookingType);
    };
    useEffect(() => {
        fetchStudiosByType(bookingType).then((studios) => {
            setSelectedStudio(studios[0]);
            fetchCalendar(studios[0].id, bookingType);
        });
    }, []);
    return (
        <>
            <div className='widget-container'>
                <div className='widget-content'>
                    <div className='left-pane'>
                        <p className='title'>
                            <strong>Studio Booking</strong>
                        </p>
                        <Selection
                            availableStudios={availableStudios}
                            bookingType={bookingType}
                            handleChangeStudio={handleChangeStudio}
                        />
                        {selectedStudio && (
                            <>
                                <img
                                    src={selectedStudio.image.url}
                                    alt={selectedStudio.image.url}
                                />
                                <p className='studio-title'>
                                    {selectedStudio.name} <br />
                                    {selectedStudio.address}
                                </p>
                                <div
                                    className='trix-content'
                                    dangerouslySetInnerHTML={{
                                        __html: selectedStudio.description,
                                    }}
                                />
                            </>
                        )}
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
                        <p>{currentDay.format('DD-MM-YYYY')}</p>
                        {availableToday &&
                            availableToday.map((time) => {
                                return (
                                    <TimeSlotBtn
                                        key={time.id}
                                        time={time}
                                        handleClick={handleTimeSelection}
                                        selected={selectedTimes[time.id]}
                                    />
                                );
                            })}
                    </div>
                </div>
                <div className='widget-footer'>
                    <SelectedTimes
                        times={selectedTimes}
                        handleClick={handleTimeSelection}
                    />
                </div>
            </div>
        </>
    );
};

const Selection = ({ availableStudios, bookingType, handleChangeStudio }) => {
    return (
        <div className='studio-selection-container'>
            <label htmlFor='booking-type'>
                <p className='rich_content_2'>Pick a booking type</p>
            </label>
            <select
                id='booking-type'
                name='booking-type'
                className='select-field'
            >
                {BOOKING_TYPES.map((bt) => (
                    <option key={bt.value} value={bt.value}>
                        {bt.name}
                    </option>
                ))}
            </select>
            <label htmlFor='studio-select'>
                <p className='rich_content_2'>Pick a studio</p>
            </label>
            <select
                id='studio-select'
                name='studio-select'
                className='select-field'
                onChange={(e) => {
                    handleChangeStudio(e.target.value, bookingType);
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
    );
};

const SelectedTimes = ({ times, handleClick }) => {
    const entries = Object.entries(times);
    if (entries.length == 0) return <></>;
    return (
        <>
            <h4 className='special-text'>Selected Times</h4>
            <div className='selection-container'>
                {entries.map(([id, time]) => {
                    return (
                        <button
                            type='button'
                            className='select-time-btn selected'
                            key={`x-${id}-x`}
                            onClick={() => handleClick(time)}
                        >
                            {dayjs(time.start).format('HH:mm')} -{' '}
                            {dayjs(time.end).format('HH:mm')}
                        </button>
                    );
                })}
            </div>
        </>
    );
};

const TimeSlotBtn = ({ time, handleClick, selected }) => {
    return (
        <button
            onClick={(e) => handleClick(time)}
            type='button'
            className={classNames('select-time-btn', selected && 'selected')}
            key={time.id}
        >
            {dayjs(time.start).format('HH:mm')} -{' '}
            {dayjs(time.end).format('HH:mm')}
        </button>
    );
};
export default BookingWidget;
