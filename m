Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352C696208
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfHTOJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:09:57 -0400
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:49221 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729155AbfHTOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:09:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2429C100E86C6;
        Tue, 20 Aug 2019 14:09:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,3,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2540:2551:2553:2559:2565:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4361:5007:7514:7903:8828:9010:9025:9040:9388:10010:10049:10400:10848:11232:11473:11657:11658:11914:12043:12050:12297:12663:12679:12740:12895:13161:13229:13439:13894:14094:14096:14106:14180:14181:14659:14721:21060:21067:21080:21451:21627:21740:21781:21944:30046:30054:30060:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:1:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: juice52_1c3ac93d74b63
X-Filterd-Recvd-Size: 3840
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 20 Aug 2019 14:09:53 +0000 (UTC)
Message-ID: <b7190f9c3fedb5d4055cfd2802eb025140ce56d4.camel@perches.com>
Subject: Re: Status of Subsystems
From:   Joe Perches <joe@perches.com>
To:     Sebastian Duda <sebastian.duda@fau.de>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 20 Aug 2019 07:09:52 -0700
In-Reply-To: <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
References: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
         <20190820131422.2navbg22etf7krxn@pali>
         <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 15:56 +0200, Sebastian Duda wrote:
> On 20.08.19 15:14, Pali Rohár wrote:
> > On Tuesday 20 August 2019 15:05:51 Sebastian Duda wrote:
> > > Hello Pali,
> > > 
> > > in my master thesis, I'm using the association of subsystems to
> > > maintainers/reviewers and its status given in the MAINTAINERS file.
> > > During the research I noticed that there are several subsystems without a
> > > status in the maintainers file. One of them is the subsystem `ALPS PS/2
> > > TOUCHPAD DRIVER` where you're mentioned as reviewer.
> > > 
> > > Is it intended not to mention a status for your subsystems?
> > > What is the current status of these systems?
> > > 
> > > Kind regards
> > > Sebastian Duda
> > 
> > Hi Sebastian! ALPS PS/2 is a driver for ALPS touchpad. They can be
> > found on more laptops. And ALPS PS/2 itself is not separate subsystem.
> > It is just driver which is part of kernel input subsystem with mailing
> > list linux-input@vger.kernel.org.
> > 
> Hi Pali,
> 
> so the status of the files is inherited from the subsystem `INPUT 
> MULTITOUCH (MT) PROTOCOL`?

Not really, no.

It's inherited from

MAINTAINERS-INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN) DRIVERS
MAINTAINERS-M:  Dmitry Torokhov <dmitry.torokhov@gmail.com>
MAINTAINERS-L:  linux-input@vger.kernel.org
MAINTAINERS-Q:  http://patchwork.kernel.org/project/linux-input/list/
MAINTAINERS-T:  git git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
MAINTAINERS-S:  Maintained
MAINTAINERS:F:  drivers/input/
MAINTAINERS-F:  include/linux/input.h
MAINTAINERS-F:  include/uapi/linux/input.h
MAINTAINERS-F:  include/uapi/linux/input-event-codes.h
MAINTAINERS-F:  include/linux/input/
MAINTAINERS-F:  Documentation/devicetree/bindings/input/
MAINTAINERS-F:  Documentation/devicetree/bindings/serio/
MAINTAINERS-F:  Documentation/input/

You could see this via

$ ./scripts/get_maintainer.pl -f --sections drivers/input/mouse/alps.c
ALPS PS/2 TOUCHPAD DRIVER
R:	Pali Rohár <pali.rohar@gmail.com>
F:	drivers/input/mouse/alps.*

INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN) DRIVERS
M:	Dmitry Torokhov <dmitry.torokhov@gmail.com>
L:	linux-input@vger.kernel.org
Q:	http://patchwork.kernel.org/project/linux-input/list/
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
S:	Maintained
F:	drivers/input/
F:	include/linux/input.h
F:	include/uapi/linux/input.h
F:	include/uapi/linux/input-event-codes.h
F:	include/linux/input/
F:	Documentation/devicetree/bindings/input/
F:	Documentation/devicetree/bindings/serio/
F:	Documentation/input/

THE REST
M:	Linus Torvalds <torvalds@linux-foundation.org>
L:	linux-kernel@vger.kernel.org
Q:	http://patchwork.kernel.org/project/LKML/list/
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
S:	Buried alive in reporters
F:	*
F:	*/


