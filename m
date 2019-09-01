Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3670AA48CC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 12:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfIAKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 06:49:45 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:49681 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728523AbfIAKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 06:49:45 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1i4NQQ-0001RB-Iw; Sun, 01 Sep 2019 12:49:38 +0200
Date:   Sun, 1 Sep 2019 11:49:36 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        yamada.masahiro@socionext.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] genirq: move debugfs option to kernel hacking
Message-ID: <20190901114936.5e2f3490@why>
In-Reply-To: <20190901101032.7pysfrpincyrci35@mail.google.com>
References: <20190901035539.2957-1-changbin.du@gmail.com>
        <alpine.DEB.2.21.1909010814360.3955@nanos.tec.linutronix.de>
        <20190901101032.7pysfrpincyrci35@mail.google.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: changbin.du@gmail.com, tglx@linutronix.de, akpm@linux-foundation.org, yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Sep 2019 18:10:33 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> On Sun, Sep 01, 2019 at 08:23:02AM +0200, Thomas Gleixner wrote:
> > On Sun, 1 Sep 2019, Changbin Du wrote:
> >   
> > > Just like the other generic debug options, move the irq one to
> > > 'Kernel hacking' menu.  
> > 
> > Why?
> > 
> > Kernel hacking is a inscrutable mess where you can waste a lot of time to
> > find what you are looking for.
> >  
> yes, the 'kernel hacking' menu has many items now and are not well structured.
> Let me see if it can be improved.
> 
> > If I want to debug interrupts then having the option right there where all
> > other interrupt related configuration is makes tons of sense.
> > 
> > I would be less opposed to this when the kernel hacking menu would be
> > halfways well structured, but you just chose another random place for that
> > option which is worse than what we have now.
> >   
> We already have an irq debug option CONFIG_DEBUG_SHIRQ here. Maybe we can group
> them into a submenu.

DEBUG_SHIRQ is extremely different from GENERIC_IRQ_DEBUGFS. The former
is a test option, verifying that endpoint drivers have a correct
behaviour. The latter is a dump of the kernel internals, which is
mostly for people dealing with the internals of the IRQ subsystem.

Preserving this distinction between the users of the IRQ API on one
side and the debugging of the IRQ subsystem on the other is important.
Moving these two things close together could make it even more confusing
for the users (who usually do not need to mess with the IRQ subsystem's
internals...).

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
