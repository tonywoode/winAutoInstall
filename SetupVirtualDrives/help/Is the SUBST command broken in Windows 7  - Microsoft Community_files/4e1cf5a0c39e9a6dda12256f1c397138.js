Bootstrapper.bindDependencyDOMParsed(function(){var Bootstrapper=window["Bootstrapper"];var ensightenOptions=Bootstrapper.ensightenOptions;try{$("#AnswersStarsWrapper").attr({"ms.cmpnm":"top contributors","ms.cmptyp":"linklist"});Bootstrapper.ajaxListener.create(function(){var n=$(".starcontainer.starshown");if(n.length>0)return n},function(n){$(n).each(function(){$(this).attr({"ms.index":$(this).index()+1})})});Bootstrapper.ajaxListener.create(function(){var n=$("#AnswersStars A.staruser[href*\x3dprofile], #AnswersStars A.starusername[href*\x3dprofile]");
if(n.length>0)return n},function(n){var ti;if($(n).hasClass("starusername"))ti=Bootstrapper.TAG.getLinkBITitle(n);else ti=$(this).attr("title");$(n).attr({"ms.cmpgrp":"body","ms.cmpnm":"top_contributors","ms.cmptyp":"linklist","ms.title":ti,"ms.interactiontype":"1"})})}catch(e){Bootstrapper.reportException(e)}},658021,[658018],284879,[284875]);
Bootstrapper.bindDependencyDOMParsed(function(){var Bootstrapper=window["Bootstrapper"];var ensightenOptions=Bootstrapper.ensightenOptions;try{(function(){Bootstrapper.ajaxListener.create(function(){try{var ts=$("#ThreadSummary");if(ts.length>0)return ts}catch(err){}},function(ts){$(".qMeta ul li",this).each(function(){var idx=$(this).index();$(this).attr({"ms.cmpnm":"answers_prod_topic","ms.cmptyp":"linklist","ms.interactiontype":"1","ms.index":idx});$("a",this).each(function(){$(this).attr({"ms.title":$.trim($(this).text().toLowerCase())})})});
$("#questioncontainer .message .messageControls li,#allReplies .messageControls li").each(function(){var idx=$(this).index();$(this).attr({"ms.index":idx})});$("#questioncontainer .message .messageControls li button,#allReplies .messageControls li").each(function(){if(navigator.appVersion.indexOf("MSIE")!=-1)Bootstrapper.unobtrusiveAddEvent(this,"onclick",function(){var ndx=$(this).parent().attr("ms.index");MscomCustomEvent("ms.cmpgrp\x3dbody","ms.cmpnm\x3dthreadaction","ms.cmptyp\x3dlink","ms.interactiontype\x3d1",
"ms.title\x3d"+$.trim($(this).text().toLowerCase()),"ms.index\x3d"+ndx)});else Bootstrapper.unobtrusiveAddEvent(this,"onmousedown",function(){var ndx=$(this).parent().attr("ms.index");MscomCustomEvent("ms.cmpgrp\x3dbody","ms.cmpnm\x3dthreadaction","ms.cmptyp\x3dlink","ms.interactiontype\x3d1","ms.title\x3d"+$.trim($(this).text().toLowerCase()),"ms.index\x3d"+ndx)})})});Bootstrapper.ajaxListener.create(function(){try{var rc=$("#RelatedThreads");if(rc.length>0)return rc}catch(err){}},function(rc){$(this).attr({"ms.cmpnm":"answers_related",
"ms.cmptyp":"linklist","ms.interactiontype":"1"});$("li.moreHelpLink",this).each(function(){$(this).attr({"ms.index":$(this).index()})});$("a",this).each(function(){var t=$.trim($(this).text().toLowerCase());if(t.length>140)t=t.substr(0,140)+"...";$(this).attr({"ms.title":t})})});$("#SocialIcons").attr({"ms.interactiontype":"1","ms.cmpnm":"social_media"});Bootstrapper.ajaxListener.create(function(){try{var qu=$("#questioncontainer");if(qu.length>0)return qu}catch(err){}},function(qu){$("a.messageUserImage",
this).each(function(){var puid=$(this).attr("href").split("/").pop();var t=$.trim($(this).attr("title").toLowerCase());$(this).attr({"ms.cmpnm":"answer_user","ms.cmptyp":"link","ms.interactiontype":"1","ms.title":t,"ms.agtid":puid})})});Bootstrapper.ajaxListener.create(function(){try{var pi=$("#allReplies");if(pi.length>0)return pi}catch(err){}},function(pi){$("a.messageUserImage",this).each(function(){var puid=$(this).attr("href").split("/").pop();var t=$.trim($(this).attr("title").toLowerCase());
$(this).attr({"ms.cmpnm":"answers_user","ms.cmptyp":"link","ms.interactiontype":"1","ms.title":t,"ms.agtid":puid})});$("button.ratingYBtn",this).click(function(){MscomCustomEvent("ms.cmpgrp\x3dbody","ms.cmpnm\x3danswers_helpful","ms.cmptyp\x3dlink","ms.interactiontype\x3d1","ms.title\x3dme too")})});Bootstrapper.ajaxListener.create(function(){try{var n=$(".message-user-image");if(n.length>0)return n}catch(err){}},function(n){$(n).each(function(){var ti=$.trim($(this).attr("title").toLowerCase());
var url=$(this).attr("href");var id=/profile\/.{36}/.exec(url);if(id!==null){id=id.toString();id=id.split("/");var puid=id[1];$(this).attr({"ms.cmpnm":"answers_user","ms.cmptyp":"link","ms.interactiontype":"1","ms.agtid":puid,"ms.title":ti})}else $(this).attr({"ms.cmpnm":"answers_user","ms.cmptyp":"link","ms.interactiontype":"1","ms.title":ti})})});Bootstrapper.ajaxListener.create(function(){try{var n=$("a.userNameShowWhiteSpace");if(n.length>0)return n}catch(err){}},function(n){$(n).each(function(){var ti=
$.trim($(this).attr("title").toLowerCase());var url=$(this).attr("href");var id=/profile\/.{36}/.exec(url);if(id!==null){id=id.toString();id=id.split("/");var puid=id[1];$(this).attr({"ms.cmpnm":"answers_user","ms.cmptyp":"link","ms.interactiontype":"1","ms.agtid":puid,"ms.title":ti})}else $(this).attr({"ms.cmpnm":"answers_user","ms.cmptyp":"link","ms.interactiontype":"1","ms.title":ti})})})})()}catch(e){Bootstrapper.reportException(e)}},658027,[658018],284873,[284875]);