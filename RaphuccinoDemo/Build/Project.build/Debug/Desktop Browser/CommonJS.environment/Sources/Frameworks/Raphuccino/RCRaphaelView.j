@STATIC;1.0;I;15;AppKit/CPView.jt;1131;

objj_executeFile("AppKit/CPView.j", NO);

{var the_class = objj_allocateClassPair(CPView, "RCRaphaelView"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("delegate"), new objj_ivar("_paper")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("delegate"), function $RCRaphaelView__delegate(self, _cmd)
{ with(self)
{
return delegate;
}
},["id"]),
new objj_method(sel_getUid("setDelegate:"), function $RCRaphaelView__setDelegate_(self, _cmd, newValue)
{ with(self)
{
delegate = newValue;
}
},["void","id"]), new objj_method(sel_getUid("initWithFrame:"), function $RCRaphaelView__initWithFrame_(self, _cmd, aFrame)
{ with(self)
{
    if (self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("RCRaphaelView").super_class }, "initWithFrame:", aFrame)) {
        var bounds = objj_msgSend(self, "bounds");

        _paper = Raphael(_DOMElement, bounds.width, bounds.height);

        var circle = _paper.circle(50, 40, 10);

        circle.attr("fill", "#f00");


        circle.attr("stroke", "#fff");

    }

    return self;
}
},["id","CGRect"])]);
}

