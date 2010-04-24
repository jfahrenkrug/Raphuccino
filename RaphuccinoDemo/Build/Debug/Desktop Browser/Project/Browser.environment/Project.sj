@STATIC;1.0;p;15;AppController.jt;705;@STATIC;1.0;I;21;Foundation/CPObject.jI;23;Raphuccino/Raphuccino.jt;633;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("Raphuccino/Raphuccino.j", NO);
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("theWindow")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("applicationDidFinishLaunching:"), function $AppController__applicationDidFinishLaunching_(self, _cmd, aNotification)
{ with(self)
{
}
},["void","CPNotification"]), new objj_method(sel_getUid("awakeFromCib"), function $AppController__awakeFromCib(self, _cmd)
{ with(self)
{
}
},["void"])]);
}

p;6;main.jt;295;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;209;objj_executeFile("Foundation/Foundation.j", NO);
objj_executeFile("AppKit/AppKit.j", NO);
objj_executeFile("AppController.j", YES);
main= function(args, namedArgs)
{
    CPApplicationMain(args, namedArgs);
}

p;34;Frameworks/Raphuccino/Raphuccino.jt;142;@STATIC;1.0;i;14;raphael-min.jsi;15;RCRaphaelView.jt;86;

objj_executeFile("raphael-min.js", YES);
objj_executeFile("RCRaphaelView.j", YES);

p;37;Frameworks/Raphuccino/RCRaphaelView.jt;1170;@STATIC;1.0;I;15;AppKit/CPView.jt;1131;

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

e;