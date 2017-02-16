## Unfinished + Bugs
- [x] [Large images seem to scale wrong, far above where it should be](https://my.mixtape.moe/mejbyh.png)
([potentially fixed needs more testing](https://b.catgirlsare.sexy/7x8r.png))
- [ ] [Color buffer doesnt restore to previous state ~50% of the time](https://b.catgirlsare.sexy/xEMn.png)
(Tag ending order is not preserved)
- [ ] Finish settings tab on chatbox
- [x] /me duplicates

## Matrixing crap
- [x] Matrix translation tags move it to the top of the screen
- [ ] [Rotation is relative to start of markup](https://b.catgirlsare.sexy/xxN0.png)

## Improvements
- Multiple matrices
- Add link parsing back to chatbox
- Save last 5 lines of text and upon re-opening (eg rejoin) print them in grey
- Avatar tag
- Custom font tag
- Add ```<code>``` tag (and re-implement lua command syntax parsing as a chat feature not an addon)
- Add ```<anime>``` tag

### Notes
```
[11:15 AM] Q2F2: @Ghosty Potentially tracked down the issue with the Y autism
[11:16 AM] Q2F2: seems to arise from hights being calculated before being adjusted
[11:16 AM] Q2F2: this can be demonstrated with an image that changes size
[11:16 AM] Q2F2: every time a message is sent, causing height recalc
[11:16 AM] Q2F2: the image size is 'taken' as the current size of the image
[11:16 AM] Q2F2: even though it changes
[11:16 AM] Q2F2: ill demonstrate
[11:17 AM] Q2F2: https://my.mixtape.moe/owebwl.mp4
```
