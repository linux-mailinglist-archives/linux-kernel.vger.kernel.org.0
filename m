Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19118111ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 00:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfLCXEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 18:04:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43228 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfLCWv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:51:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so4508077oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 14:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQKFloBE3kmB2Ds1+BFIYLCl9sGC745Q8gW9p6gxpS8=;
        b=ZyXhg23zZbVM1HXJmU0YnEj7pGzpVTP0LjdaORmCC/z+Vs556N9r4E4Ums+6ExfOmn
         yuIXtVrP38nk7Ou1oGaRe0DIhaAh2OD1T+gegg1XRRdYUN7pprRk8bpq3QcfkyLeMcBG
         BldnfvppBcBAsjQA/iDxAg+8AadpfCmzg9kB2eje8z2Y8SgY78fgZJw7ddhgjqVOKt4W
         RZ9uf5bed1fQEh9DgTjee0agzBgyynd905JMx2tKIC4tM7yRkJ/jaGjrLPINPG/A73Ib
         eDMPPmLzZGPple6fmFgjtf7l+z8y8NdCbiIagMYU3pOQUnu0a2v7RPTzdANEKCMlnQCU
         OL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQKFloBE3kmB2Ds1+BFIYLCl9sGC745Q8gW9p6gxpS8=;
        b=rDhxl0TIu9y0Khp6CFtZyZjD5G14+ifHz2AdH4M4BaNjfVDwnY/hWdn4An66q7LAtJ
         tyxqLKypBqPQw2v5SnaQdVurw8J5fAmU32CqBxG+QoBDmb0r7fq0zYTlEm8I3ZNCq76L
         oXqCZcZM/6w34RpJHV402hg/lPOqOpsTIHrt+YyPqR3XhIPVbdnqXWgIZvLfC9XDlP9x
         j4PgHLtd+JRcybU3J0jVF5AyFN1XRdPxWpuzqCnhobd9FwWQeWQ4beR97ifbOJJNkUCj
         EPtXI2amiuL1APxoz968zS568kna8QoAiJ2iDymIe6Cxzc56cP7nlhIW12T7iIaZd8xN
         fr8g==
X-Gm-Message-State: APjAAAWz13dPv4/Z5918+sh+/l9R2zW6SyzNfcJkSIiuaZIvSHZcS8uC
        VAtVcqY6J1vtzbygydrd2xwiQSYXkB36YBQTHlhKgg==
X-Google-Smtp-Source: APXvYqygaOLyxv+jgF4qCBp1j1QUOYPbX7QxetsewfOVPpzqg+JELY4RcMDfTgGPhcjbfCA4vPk6d3RO012a+GJu8oc=
X-Received: by 2002:a9d:5d1a:: with SMTP id b26mr209203oti.139.1575413485445;
 Tue, 03 Dec 2019 14:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20191201150015.GC18573@shao2-debian> <CAGETcx9r0u=-WSnQ2ZS1KmZSVQqKwvpnhO-w41=jk8iF6BdALA@mail.gmail.com>
 <7e13b7f9-6c0f-0ab5-a6f9-5fb9b41257c9@gmail.com> <CAGETcx_PeYi-j+=0QOQR9c=_4n4becziS8WKKi77bXuNY1hufQ@mail.gmail.com>
 <CAL_JsqKBuCfCvFwbUQwTQxYAR1WL5r5Mnm_RBhHgH0b7_Bkg6w@mail.gmail.com>
In-Reply-To: <CAL_JsqKBuCfCvFwbUQwTQxYAR1WL5r5Mnm_RBhHgH0b7_Bkg6w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 3 Dec 2019 14:50:49 -0800
Message-ID: <CAGETcx9-TZfARQgc7N4=kp1WVvMuxpmw3n3-TmwYO1YNkQKmRw@mail.gmail.com>
Subject: Re: 5e6669387e ("of/platform: Pause/resume sync state during init
 .."): [ 3.192726] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:688 device_links_supplier_sync_state_resume
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LKP <lkp@lists.01.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 1:10 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Dec 3, 2019 at 2:05 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Dec 3, 2019 at 1:01 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > >
> > > On 12/2/19 3:19 PM, Saravana Kannan wrote:
> > > > On Sun, Dec 1, 2019 at 7:00 AM kernel test robot <lkp@intel.com> wrote:
> > > >>
> > > >> Greetings,
> > > >>
> > > >> 0day kernel testing robot got the below dmesg and the first bad commit is
> > > >>
> > > >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > >>
> > > >> commit 5e6669387e2287f25f09fd0abd279dae104cfa7e
> > > >> Author:     Saravana Kannan <saravanak@google.com>
> > > >> AuthorDate: Wed Sep 4 14:11:24 2019 -0700
> > > >> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >> CommitDate: Fri Oct 4 17:30:19 2019 +0200
> > > >>
> > > >>     of/platform: Pause/resume sync state during init and of_platform_populate()
> > > >>
> > > >>     When all the top level devices are populated from DT during kernel
> > > >>     init, the supplier devices could be added and probed before the
> > > >>     consumer devices are added and linked to the suppliers. To avoid the
> > > >>     sync_state() callback from being called prematurely, pause the
> > > >>     sync_state() callbacks before populating the devices and resume them
> > > >>     at late_initcall_sync().
> > > >>
> > > >>     Similarly, when children devices are populated from a module using
> > > >>     of_platform_populate(), there could be supplier-consumer dependencies
> > > >>     between the children devices that are populated. To avoid the same
> > > >>     problem with sync_state() being called prematurely, pause and resume
> > > >>     sync_state() callbacks across of_platform_populate().
> > > >>
> > > >>     Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > >>     Link: https://lore.kernel.org/r/20190904211126.47518-6-saravanak@google.com
> > > >>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >>
> > > >> fc5a251d0f  driver core: Add sync_state driver/bus callback
> > > >> 5e6669387e  of/platform: Pause/resume sync state during init and of_platform_populate()
> > > >> 81b6b96475  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux; tag 'dma-mapping-5.5' of git://git.infradead.org/users/hch/dma-mapping
> > > >> +-------------------------------------------------------------------------+------------+------------+------------+
> > > >> |                                                                         | fc5a251d0f | 5e6669387e | 81b6b96475 |
> > > >> +-------------------------------------------------------------------------+------------+------------+------------+
> > > >> | boot_successes                                                          | 30         | 0          | 0          |
> > > >> | boot_failures                                                           | 1          | 11         | 22         |
> > > >> | Oops:#[##]                                                              | 1          |            |            |
> > > >> | EIP:unmap_vmas                                                          | 1          |            |            |
> > > >> | PANIC:double_fault                                                      | 1          |            |            |
> > > >> | Kernel_panic-not_syncing:Fatal_exception                                | 1          |            |            |
> > > >> | WARNING:at_drivers/base/core.c:#device_links_supplier_sync_state_resume | 0          | 11         | 22         |
> > > >> | EIP:device_links_supplier_sync_state_resume                             | 0          | 11         | 22         |
> > > >> +-------------------------------------------------------------------------+------------+------------+------------+
> > > >>
> > > >> If you fix the issue, kindly add following tag
> > > >> Reported-by: kernel test robot <lkp@intel.com>
> > > >>
> > > >> [    3.186107] OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
> > > >> [    3.188595] platform testcase-data:testcase-device2: IRQ index 0 not found
> > > >> [    3.191047] ### dt-test ### end of unittest - 199 passed, 0 failed
> > > >> [    3.191932] ------------[ cut here ]------------
> > > >> [    3.192571] Unmatched sync_state pause/resume!
> > > >> [    3.192726] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:688 device_links_supplier_sync_state_resume+0x27/0xc0
> > > >> [    3.195084] Modules linked in:
> > > >> [    3.195494] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 5.4.0-rc1-00005-g5e6669387e228 #1
> > > >> [    3.196674] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > > >> [    3.197693] EIP: device_links_supplier_sync_state_resume+0x27/0xc0
> > > >> [    3.198680] Code: 00 00 00 3e 8d 74 26 00 57 56 31 d2 53 b8 a0 d0 d9 c1 e8 6c b6 38 00 a1 e4 d0 d9 c1 85 c0 75 13 68 84 ba c4 c1 e8 29 30 b1 ff <0f> 0b 58 eb 7f 8d 74 26 00 83 e8 01 85 c0 a3 e4 d0 d9 c1 75 6f 8b
> > > >> [    3.201560] EAX: 00000022 EBX: 00000000 ECX: 00000000 EDX: 00000000
> > > >> [    3.202466] ESI: 000001ab EDI: c02c7f80 EBP: c1e87d27 ESP: c02c7f20
> > > >> [    3.203301] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010282
> > > >> [    3.204258] CR0: 80050033 CR2: bfa1bf98 CR3: 01f28000 CR4: 00140690
> > > >> [    3.205022] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > > >> [    3.205919] DR6: fffe0ff0 DR7: 00000400
> > > >> [    3.206529] Call Trace:
> > > >> [    3.207011]  ? of_platform_sync_state_init+0x13/0x16
> > > >> [    3.207719]  ? do_one_initcall+0xda/0x260
> > > >> [    3.208247]  ? kernel_init_freeable+0x110/0x197
> > > >> [    3.208906]  ? rest_init+0x120/0x120
> > > >> [    3.209369]  ? kernel_init+0xa/0x100
> > > >> [    3.209775]  ? ret_from_fork+0x19/0x24
> > > >> [    3.210283] ---[ end trace 81d0f2d2ee65199b ]---
> > > >> [    3.210955] ALSA device list:
> > > >
> > > > Rob/Frank,
> > > >
> > > > This seems to be an issue with the unit test code not properly
> > > > cleaning up the state after it's done.
> > > >
> > > > Specifically, unittest_data_add() setting up of_root on systems where
> > > > there's no device tree (of_root == NULL). It doesn't clean up of_root
> > > > after the tests are done. This affects the of_have_populated_dt() API
> > > > that in turn affects calls to
> > > > device_links_supplier_sync_state_pause/resume(). I think unittests
> > > > shouldn't affect the of_have_populated_dt() API.
> > > There are at least a couple of reasons why the unittest devicetree data
> > > needs to remain after the point where devicetree unittests currently
> > > complete.  So cleaning up (removing the data) is not an option.
> > >
> > > I depend on the unittest devicetree entries still existing after the system
> > > boots and I can log into a shell for some validation of the final result of
> > > the devicetree data.
> >
> > IMHO unittests shouldn't have a residual impact on the system after
> > they are done. So, I'll agree to disagree on this one.
>
> They shouldn't be enabled in a production system either. Why would you
> want the extra boot time?

Should we ask the kernel test robot folks to not enable OF unittest
then? It broke my patch, but I wouldn't be surprised if it's silently
breaking other stuff too. I think we need to do option 4 below.

>
> > > There is also a desire for the devicetree unittests to be able to be loaded
> > > as a module.  That work is not yet scheduled, but I do not want to preclude
> > > the possibility.  If unittests are loaded from a module then they will
> > > need some devicetree data to exist that is created in early boot.  That
> > > data will be in the devicetree when of_platform_sync_state_init() is
> > > invoked.
> >
> > On a normal system, FDT is parsed and of_root is set (or not set) very
> > early on during setup_arch() before any of the initcall levels are
> > run. The return value of of_have_populated_dt() isn't expected to
> > change across initcall levels. But because of the way the unittest is
> > written (the of_root is changed at late_initcall() level) the return
> > value of of_have_populated_dt() changes across initcall levels. I
> > think that's a real problem with the unittest -- it's breaking API
> > semantics.
>
> I think what's really desired here is a 'Am I booting using DT' call.

I think the community has decided to use of_have_populated_dt() as
that call. So, we shouldn't break it.

>
> > of_have_populated_dt() is being used to check if DT is present in the
> > system and different things are done based on that. We can't have that
> > value change across initcall levels.
> >
> > Couple of thoughts:
> > 1. Don't run unit test if there is no live DT in the system?
>
> That's pretty much the only case I do run. I use UML to run the tests.

Ah, makes sense.

> > 2. If you don't want to do (1), then at least set up the unit test
> > data during setup_arch() instead of doing it at some initcall level?
>
> That further breaks making it a module. The plan is also to move to
> kunit which probably will preclude some hacky hook into setup_arch().
> Side effects may need to be fixed for kunit though.

Yup.

> > 3. Can you use overlays for the unit tests if they are loaded as a module?
>
> That was the idea, yes.
>
>
> 4. Make running the unittests a command line option instead of running
> if enabled. Still has side effects, but you have to explicitly run it.

Hmm... this is another good option. I think this should be done. Do we
have a consensus on this?

> A module would still be my preference. If only there was someone
> interested in making everything a module... ;)

:)

> > > > I was looking into writing a unittest patch to fix this, but I don't
> > > > know enough about the FDT parsing code to make sure I don't leak any
> > > > memory or free stuff that's in use. I'm not sure I can simply set
> > > > of_root = NULL if it was NULL before the unittest started. Let me know
> > > > how I should proceed or if you plan to write up a patch for this.
> > >
> > > Based on the above, "clean up" of the unittest data is not the solution.
> > >
> > > I haven't looked at the mechanism in device_links_supplier_sync_state_resume()
> > > that leads to the WARN yet.  But is does not seem reasonable for that code
> > > to be so sensitive to what valid data is in the devicetree that a WARN results.
> >
> > Sure, I could easily fix it to work around this. But this seems to be
> > a genuine problem with the unittest setup IMO.

I'll go ahead and do this (basically always doing it instead of
checking on of_have_populated_dt()) but I don't want us to forget this
unittest issue.

-Saravana
