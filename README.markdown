#PSScrollingTickerViewExample

This is a basic example project to show the use of `PSScrollingTickerView`

The aim is to provide a simple clean API for implementing a scrolling ticker.

Features
- Simple construction
- Fairly configurable (needs work) - can configure: text, font, textColor, speed of scroll, delay before scrolling
- Can start scrolling using `- (void)scroll;`
- When a user taps on the scrollview it will scroll again

PSScrollingTickerView is a first stab and needs work.

Limitations
- Uses blocks so needs >= iOS 4
- Cannot change the text once added to view hierarchy 