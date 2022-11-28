#define TOOLTIP_CSS_SETUP \
"<style>\
.tooltip {\
  position: relative;\
  display: inline-block;\
  border-bottom: 2px dotted;\
}\
\
.tooltip .tooltiptext {\
  visibility: hidden;\
  background-color: black;\
  color: #fff;\
  text-align: center;\
  border-radius: 3px;\
  border: 1px solid grey;\
  padding: 10px 17px;\
  \
  position: absolute;\
  z-index: 1;\
}\
\
.tooltip:hover .tooltiptext {\
  visibility: visible;\
}\
</style>"
// IE11 does not support the max-content attribute, so 'width: max-content;' doesn't work.

#define TOOLTIP_WRAPPER(hover_me, width_px, tooltip_text) \
"<div class=\"tooltip\">[hover_me]<span class=\"tooltiptext\" style=\"width: [width_px]px\">[tooltip_text]</span></div>"
