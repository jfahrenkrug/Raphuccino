@STATIC;1.0;I;21;Foundation/CPObject.jI;23;Raphuccino/Raphuccino.jt;633;objj_executeFile("Foundation/CPObject.j", NO);
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

