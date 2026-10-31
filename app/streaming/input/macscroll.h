#pragma once

// Watches macOS scroll events to tell trackpad scrolling apart from a mouse
// wheel, which SDL doesn't report. Must be used from the main thread.
void* MacScroll_StartMonitor();
void MacScroll_StopMonitor(void* monitor);

// True if the most recent scroll event had precise deltas, which is the case
// for trackpads (and the Magic Mouse) but not for notched mouse wheels.
bool MacScroll_LastEventWasPrecise();
