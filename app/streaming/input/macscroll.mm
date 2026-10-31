#include "macscroll.h"

#import <AppKit/AppKit.h>

// Local monitors run before the event is dispatched to SDL's view, so this is
// always up to date by the time SDL's wheel event for it is handled.
static bool s_LastEventWasPrecise;

void* MacScroll_StartMonitor()
{
    id monitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskScrollWheel
                                                       handler:^NSEvent*(NSEvent* event) {
        s_LastEventWasPrecise = event.hasPreciseScrollingDeltas;
        return event;
    }];

    return [monitor retain];
}

void MacScroll_StopMonitor(void* monitor)
{
    if (monitor != nullptr) {
        [NSEvent removeMonitor:(id)monitor];
        [(id)monitor release];
    }
}

bool MacScroll_LastEventWasPrecise()
{
    return s_LastEventWasPrecise;
}
