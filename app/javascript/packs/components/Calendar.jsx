import * as React from 'react';
import dayjs from 'dayjs';
import { PickersDay } from '@mui/x-date-pickers/PickersDay';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { DateCalendar } from '@mui/x-date-pickers/DateCalendar';

export default function DateCalendarViews({ availabilities }) {
    console.log(availabilities);
    const shouldDisableDate = (day) => {
        const formattedDay = dayjs(day).format('YYYY-MM-DD');
        return availabilities[formattedDay]?.length == 0 ? true : false;
    };

    return (
        <LocalizationProvider dateAdapter={AdapterDayjs}>
            <DateCalendar
                shouldDisableDate={shouldDisableDate}
                day={<PickersDay sx={{ background: 'red' }} />}
                disablePast={true}
                showDaysOutsideCurrentMonth={true}
                minDate={dayjs().startOf('month')}
                maxDate={dayjs().add(2, 'month')}
                style={{
                    margin: '0',
                }}
                defaultValue={dayjs()}
                views={['day']}
            />
        </LocalizationProvider>
    );
}
