Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8003A17D6EB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 23:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCHW4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 18:56:30 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:40520 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726352AbgCHW43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 18:56:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9795F101D66B3;
        Sun,  8 Mar 2020 22:56:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2540:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6119:6691:7264:7514:7903:10004:10400:10848:11232:11658:11914:12043:12295:12297:12683:12740:12760:12895:13069:13184:13229:13311:13357:13439:14096:14097:14180:14181:14659:14721:21080:21433:21627:21740:21819:21939:30046:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: art56_1b3ccfb8be443
X-Filterd-Recvd-Size: 3075
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Mar 2020 22:56:27 +0000 (UTC)
Message-ID: <5129f7dbd8506cc9fd5a8f76dc993d789566af6c.camel@perches.com>
Subject: Re: [PATCH RFC] MAINTAINERS: include GOOGLE FIRMWARE entry
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <groeck@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 08 Mar 2020 15:54:47 -0700
In-Reply-To: <CABXOdTcrxoBCz24Ap=YJYZnr+oLAmaR10xZ9ar2mYbE1=RAoug@mail.gmail.com>
References: <20200308195116.12836-1-lukas.bulwahn@gmail.com>
         <CABXOdTcrxoBCz24Ap=YJYZnr+oLAmaR10xZ9ar2mYbE1=RAoug@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-08 at 15:32 -0700, Guenter Roeck wrote:
> On Sun, Mar 8, 2020 at 12:51 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > All files in drivers/firmware/google/ are identified as part of THE REST
> > according to MAINTAINERS, but they are really maintained by others.
[]
> > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > @@ -7111,6 +7111,14 @@ S:       Supported
> >  F:     Documentation/networking/device_drivers/google/gve.rst
> >  F:     drivers/net/ethernet/google
> > 
> > +GOOGLE FIRMWARE
> > +M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > +M:     Stephen Boyd <swboyd@chromium.org>
> > +R:     Guenter Roeck <groeck@chromium.org>
> > +R:     Julius Werner <jwerner@chromium.org>
> > +S:     Maintained
> > +F:     drivers/firmware/google/
> > +
> 
> FWIW, I would not mind stepping up as maintainer if needed, but I
> think we should strongly discourage this kind of auto-assignment of
> maintainers and/or reviewers.

Auto assignment should definitely _not_ be done.

This is an RFC proposal though.

Sometimes it's better to not produce an RFC as
a patch, but maybe just show a proposed section
and ask if is appropriate may be a better style
going forward.

Maybe just emailing Greg, Stephen, Guenter and
Julius (cc'ing LKML) asking something like the
below would be better:

----------------------------------------------------

Hey all.

Files in drivers/firmware/google/ do not seem to
have a listed MAINTAINER.

Would a section entry in MAINTAINERS like this be
appropriate?

GOOGLE FIRMWARE
M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
M:     Stephen Boyd <swboyd@chromium.org>
R:     Guenter Roeck <groeck@chromium.org>
R:     Julius Werner <jwerner@chromium.org>
S:     Maintained
F:     drivers/firmware/google/

Is there a git tree somewhere that should be added?
What would be the
status of this proposed section?
Does someone really look after it at
all?


