import * as React from 'react';
import dayjs from 'dayjs';
import { DemoContainer, DemoItem } from '@mui/x-date-pickers/internals/demo';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { DateCalendar } from '@mui/x-date-pickers/DateCalendar';

export default function DateCalendarViews() {
    return (
        <LocalizationProvider dateAdapter={AdapterDayjs}>
            <DateCalendar
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
