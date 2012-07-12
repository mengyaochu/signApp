$(document).ready(function() {

  var date = new Date();
  var d = date.getDate();
  var m = date.getMonth();
  var y = date.getFullYear();
  
  $('#calendar').fullCalendar({
    editable: true,        
    header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'agendaWeek',
        height: 500,
        slotMinutes: 15,
        minTime: 7,
        maxTime: 22,
        firstHour: 8,
        
        loading: function(bool){
            if (bool) 
                $('#loading').show();
            else 
                $('#loading').hide();
        },

        selectable: true,
        selectHelper: true,
        editable:true,
        // a future calendar might have many sources.        
        eventSources: [{
            url: '/calendar/',
            color: 'red',
            textColor: 'black',
            ignoreTimezone: false
        }],
        
        timeFormat: 'H:mm { - H:mm } ',
        dragOpacity: "0.5",
        
        select: function(start, end, allDay) {
            window.location.replace("/calendar/new"+"?starts_at="+start+"&ends_at="+end);
        },

        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        eventResize: function(event, dayDelta, minuteDelta, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
            window.location.replace("/calendar/"+event.id);
        },
  });
});

function updateEvent(the_event) {
  $.ajax({
    type: 'put',
    url: "calendar/" + the_event.id,
    headers: {
      'X-Transaction': 'put',
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    data: 
    { 
      event: { title: the_event.title,
               starts_at: "" + the_event.start,
               ends_at: "" + the_event.end,
               description: the_event.description
         }
    },
    complete:  function (reponse) { }
  });
};

function addEvent(the_event) {
  $.ajax({
    type: 'post',
    url: "calendar/events",
    headers: {
      'X-Transaction': 'POST',
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    data: 
    { 
      event: { title: the_event.title,
               starts_at: "" + the_event.start,
               ends_at: "" + the_event.end,
               description: the_event.description
         }
    },
    complete: function (reponse) { }
  });

};