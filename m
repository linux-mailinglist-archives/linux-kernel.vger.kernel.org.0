Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 356A0172AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 23:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgB0WUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 17:20:11 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:32996 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbgB0WUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:20:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id C9BB02A160;
        Thu, 27 Feb 2020 17:20:07 -0500 (EST)
Date:   Fri, 28 Feb 2020 09:19:29 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Greg Ungerer <gerg@linux-m68k.org>
cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
In-Reply-To: <1a16c680-2bbe-eb24-6ea3-4b50d0c3e377@linux-m68k.org>
Message-ID: <alpine.LNX.2.22.394.2002280902070.8@nippy.intranet>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com> <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com> <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org> <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
 <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org> <alpine.LNX.2.22.394.2002261637400.8@nippy.intranet> <a682c89d-baf2-3d3c-647f-a07b2a146c9f@linux-m68k.org> <alpine.LNX.2.22.394.2002270908380.8@nippy.intranet>
 <1a16c680-2bbe-eb24-6ea3-4b50d0c3e377@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020, Greg Ungerer wrote:

> On 27/2/20 8:31 am, Finn Thain wrote:
> 
> >>>
> >>> BTW, one of the benefits of "%s: request_irq failed" is that a 
> >>> compilation unit with multiple request_irq calls permits the 
> >>> compiler to coalesce all duplicated format strings. Whereas, that's 
> >>> not possible with "foo: request_irq failed" and "bar: request_irq 
> >>> failed".
> >>
> >> Given the wide variety of message text used with failed request_irq() 
> >> calls it would be shear luck that this matched anything else. A quick 
> >> grep shows that "%s: request_irq() failed\n" has no other exact 
> >> matches in the current kernel source.
> > 
> > You are overlooking the patches in this series that produce multiple 
> > identical format strings.
> 
> No I didn't :-)  None of these will end up compiled in at the same time. 
> The various ColdFire SoC parts have a single timer hardware module - and 
> only the required one will be compiled in, not all of them.
> 

I was referring to e.g. [PATCH v2 08/18] MIPS: Replace setup_irq() by 
request_irq(), in which you can find this:

@@ -116,8 +110,16 @@ static void __init ar7_irq_init(int base)
                                                 handle_level_irq);
        }
 
-       setup_irq(2, &ar7_cascade_action);
-       setup_irq(ar7_irq_base, &ar7_cascade_action);
+       if (request_irq(2, no_action, IRQF_NO_THREAD, "AR7 cascade interrupt",
+                       NULL)) {
+               pr_err("%s: request_irq() failed\n",
+                      "AR7 cascade interrupt");
+       }
+       if (request_irq(ar7_irq_base, no_action, IRQF_NO_THREAD,
+                       "AR7 cascade interrupt", NULL)) {
+               pr_err("%s: request_irq() failed\n",
+                      "AR7 cascade interrupt");
+       }
        set_c0_status(IE_IRQ0);
 }
 
BTW, I think that deduplication of string constants can happen during LTO, 
so the benefit of consistency need not be confined to a compilation unit. 
I don't think this is relevant to kernel builds.
