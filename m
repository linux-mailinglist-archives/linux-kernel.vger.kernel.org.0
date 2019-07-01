Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C814957
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEFMIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 08:08:04 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:17731 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFMID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:08:03 -0400
X-Greylist: delayed 35296 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 08:08:01 EDT
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x46C7rhM000674;
        Mon, 6 May 2019 21:07:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x46C7rhM000674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557144474;
        bh=h56McuLhI6nc4Saug3GmC8OGRtsjQtrIJHBkjGjXFuc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ccyfvfXd4Y+bvXMreZmZn5Kgd5ZubYBEJlL3ESlc0ytBY58/HW+sLtgtkkiGPzubA
         PBSolkZuynCHCse3pcSQUWLtoxfypo3X2G9lFL0YCa+9cOyOFFr8Z/y0jLE/91IM54
         qrYVnqKZlLfRjkQ7RjAJod9JcKLG9CKAt4SRV2+dbQ8nBcXVRJj1BUJEwFvv7M+jEd
         86aA0jy5lzpJPXEfuUwnWX2B63Pa7jShxOWBUYULKlPt0hNuIANmp8kbd41KBDivCO
         I0Y8YWNKjgySwCnHLAvNfs/WfKuKT4uNxyS6DhfqDyybH7CZGec7+51fPLo1sqywY8
         6n6qOuQyyD65A==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id l17so4544174uar.4;
        Mon, 06 May 2019 05:07:54 -0700 (PDT)
X-Gm-Message-State: APjAAAVnB2l+tbREyucbFnckMY4q3SQ3wC1UzuH2/09SMTEAWWNwawje
        sPRszoUmfpU26Lyi5gKEXkUGmMQ9hgCViKz3vwQ=
X-Google-Smtp-Source: APXvYqxBJq1DLxJZ7TPjTm97VhmF4y3b7Tz0dM50BTxVHb4OvPNDRJsTGoSV8f04wzgtuU22+FpWG3iDqv9gKTYemGY=
X-Received: by 2002:ab0:2bd8:: with SMTP id s24mr12566251uar.121.1557144472913;
 Mon, 06 May 2019 05:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190506094609.08e930f2@canb.auug.org.au> <CAK7LNASH4CuVBjfEJsT+aBx4aLrj9j2=aOD3B4f9+Tdcm=x2pg@mail.gmail.com>
 <20190506033151.GB2649@windriver.com>
In-Reply-To: <20190506033151.GB2649@windriver.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 6 May 2019 21:07:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=D96B_OgnRu-NK0-G+y8itvhe3qvwfYxZUCSqdC0gEA@mail.gmail.com>
Message-ID: <CAK7LNAS=D96B_OgnRu-NK0-G+y8itvhe3qvwfYxZUCSqdC0gEA@mail.gmail.com>
Subject: Re: Fwd: linux-next: build failure after merge of the kbuild tree
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,


On Mon, May 6, 2019 at 12:34 PM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> [Fwd: linux-next: build failure after merge of the kbuild tree] On 06/05/2019 (Mon 11:19) Masahiro Yamada wrote:
>
> > Hi Paul,
> >
> > In today's linux-next build testing,
> > more "make ... explicitly non-modular"
> > candidates showed up.
> >
>
> Hi Masahiro,
>
> I am not 100% clear on what you are asking me.  There are lots and lots
> of these in the kernel.... many fixed, and many remain unfortunately.
>
> > arch/arm/plat-omap/dma.c
> > drivers/clocksource/timer-ti-dm.c
> > drivers/mfd/omap-usb-host.c
> > drivers/mfd/omap-usb-tll.c
>
> None of these are "new".  I just checked, and I have had patches for all
> these for a long time, in my personal queue, found by my audits.


OK, I saw many patches from you
addressing this issue,
so I just thought you might be motivated to
fix them.

Anyway, I have a reason to fix them
because a patch in my tree is causing build errors.

So, I will do something for them
if you do not have a plan to send patches soon.

Thanks.



> > Would you send patches?
>
> It isn't that simple.  I wish it was.  Some subsystem maintainers are
> glad to take the patches, and some think they are a waste of time and
> reject them immediately.  Some I've sent just simply get "crickets".
>
> What that means is, that I need to look at each maintainer's
> requirements, and ensure the patch and commit log are matching
> expectatins - I will not just spam out hundreds of patches across all
> subsystems.  Anyone who has spent considerable time in linux development
> knows that is a recipe for failure.
>
> So I need to work across each subsystem - one at a time, with their
> individual maintainer requirements in mind, and if you look at git
> history, you will see that has been what I've tried to do when I had
> free time to work on fixing these across the whole linux tree.
>
> But fortunately, none of these represent a CVE/security issue, so I've
> never had a reason to try and pretend there was any reason for an
> immediate fix/merge - they just represent a better attention to detail
> in the code we merge and support that I'd like to see happen tree-wide.
>
> I appreciate that you are also interested in seeing all these fixed, and
> I also wish they could all be solved in one version, but unfortunately I
> don't think that is pragmatic.  So in the meantime, I will continue to
> chip away at things when we are early in the dev cycle and not starting
> the two week merge window, as we are just now.
>
> Thanks,
> Paul.
> --
>
> >
> > I think EXPORT_SYMBOL_GPL() in omap-usb-tll.c
> > are also unnecessary.
> >
> > Thanks.
> >
> >
> >
> > ---------- Forwarded message ---------
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, May 6, 2019 at 8:51 AM
> > Subject: linux-next: build failure after merge of the kbuild tree
> > To: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
> > Mailing List <linux-kernel@vger.kernel.org>, Alexey Gladkov
> > <gladkov.alexey@gmail.com>, Keshava Munegowda <keshava_mgowda@ti.com>,
> > Samuel Ortiz <sameo@linux.intel.com>
> >
> >
> > Hi Masahiro,
> >
> > After merging the kbuild tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> >
> > In file included from include/linux/module.h:18,
> >                  from drivers/mfd/omap-usb-tll.c:21:
> > drivers/mfd/omap-usb-tll.c:462:26: error: expected ',' or ';' before
> > 'USBHS_DRIVER_NAME'
> >  MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
> >                           ^~~~~~~~~~~~~~~~~
> > include/linux/moduleparam.h:26:47: note: in definition of macro '__MODULE_INFO'
> >    = __MODULE_INFO_PREFIX __stringify(tag) "=" info
> >                                                ^~~~
> > include/linux/module.h:164:30: note: in expansion of macro 'MODULE_INFO'
> >  #define MODULE_ALIAS(_alias) MODULE_INFO(alias, _alias)
> >                               ^~~~~~~~~~~
> > drivers/mfd/omap-usb-tll.c:462:1: note: in expansion of macro 'MODULE_ALIAS'
> >  MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
> >  ^~~~~~~~~~~~
> >
> > Caused by commit
> >
> >   6a26793a7891 ("moduleparam: Save information about built-in modules
> > in separate file")
> >
> > USBHS_DRIVER_NAME is not defined and this kbuild tree change has
> > exposed it. It has been this way since commit
> >
> >   16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")
> >
> > From v3.7-rc1 in 2012.
> >
> > I have applied the following patch for today.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 6 May 2019 09:39:14 +1000
> > Subject: [PATCH] mfd: omap: remove unused MODULE_ALIAS from omap-usb-tll.c
> >
> > USBHS_DRIVER_NAME has never been defined, so this cannot have ever
> > been used.
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/mfd/omap-usb-tll.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> > index 446713dbee27..1cc8937e8bec 100644
> > --- a/drivers/mfd/omap-usb-tll.c
> > +++ b/drivers/mfd/omap-usb-tll.c
> > @@ -459,7 +459,7 @@ EXPORT_SYMBOL_GPL(omap_tll_disable);
> >
> >  MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
> >  MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
> > -MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
> > +// MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers");
> >
> > --
> > 2.20.1
> >
> > --
> > Cheers,
> > Stephen Rothwell
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
>


-- 
Best Regards
Masahiro Yamada
