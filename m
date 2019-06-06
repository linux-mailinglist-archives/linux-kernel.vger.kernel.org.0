Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2955B370E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 11:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfFFJxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 05:53:08 -0400
Received: from ns.iliad.fr ([212.27.33.1]:45472 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfFFJxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:53:08 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 2758320D88;
        Thu,  6 Jun 2019 11:53:06 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id D0DB520AC3;
        Thu,  6 Jun 2019 11:53:05 +0200 (CEST)
To:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Race between MMIO writes and level IRQs
Message-ID: <459c9bd7-becd-e704-cc13-213770f17018@free.fr>
Date:   Thu, 6 Jun 2019 11:53:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jun  6 11:53:06 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

There's something about interrupts I have never quite understood,
which I'd like to clear up once and for all. What I'm about to write
will probably sound trivial to anyone's who's already figured it out,
but I need to walk through it.

Consider a device, living on some peripheral bus, with an interrupt
line flowing from the device into some kind of interrupt controller.

I.e. there are two "communication channels"
1) the peripheral bus, and 2) the "out-of-band" interrupt line.

At some point, the device requires the CPU to do $SOMETHING. It sends
a signal over the interrupt line (either a pulse for edge interrupts,
or keeping the line high for level interrupts). After some time, the
CPU will "take the interrupt", mask all(?) interrupts, and jump to the
proper interrupt service routine (ISR).

The CPU does whatever it's supposed to do, and then needs to inform
the device that "yes, the work is done, stop pestering me". Typically,
this is done by writing some value to one of the device's registers.

AFAICT, this is the part where things can go wrong:

The CPU issues the magic MMIO write, which will take some time to reach
the device over the peripheral bus. Meanwhile, the device maintains the
IRQ signal (assuming a level interrupt). Once the CPU leaves the ISR, the
framework will unmask IRQs. If the write has not yet reached the device,
the CPU will be needlessly interrupted again.

Basically, there's a race between the MMIO write and the IRQ unmasking.
We'd like to be able to guarantee that the MMIO write is complete before
unmasking interrupts, right?

Some people use memory barriers, but my understanding is that this is
not sufficient. The memory barrier may guarantee that the MMIO write
has left the CPU "domain", but not that it has reached the device.

Am I mistaken?

So it looks like the only surefire way to guarantee that the MMIO write
has reached the device is to read the value back from the device?

Tangential: is this one of the issues solved by MSI?
https://en.wikipedia.org/wiki/Message_Signaled_Interrupts#Advantages

Regards.

