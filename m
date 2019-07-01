Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA81A4F5E3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 15:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfFVN1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 09:27:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57814 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFVN1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 09:27:54 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1heg3T-0006S2-TU; Sat, 22 Jun 2019 15:27:44 +0200
Date:   Sat, 22 Jun 2019 15:27:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Octavio Alvarez <octallk1@alvarezp.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>
Subject: Re: PROBLEM: Marvell 88E8040 (sky2) fails after hibernation
In-Reply-To: <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org>
Message-ID: <alpine.DEB.2.21.1906221523340.5503@nanos.tec.linutronix.de>
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org> <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org> <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de> <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Octavio,

On Wed, 19 Jun 2019, Octavio Alvarez wrote:
> On 6/13/19 3:45 PM, Thomas Gleixner wrote:
> > Can you please provide the content of /proc/interrupts with the driver
> > loaded and working after boot (don't hibernate) for the following kernels:
> > 
> 
> $ cat linux-master-after-boot.txt
>            CPU0       CPU1       CPU2       CPU3

>  27:          1          0          0          0   PCI-MSI 3145728-edge eth0

> >    Linus upstream + revert
> 
> $ cat linux-master-reverted-after-boot.txt
>            CPU0       CPU1       CPU2       CPU3

>  27:          1          0          0          0   PCI-MSI 3145728-edge eth0
 
> Meanwhile, here it is for 4.9, which is the latest Debian-provided kernel and
> worked:
> 
> $ cat linux-4.9-after-boot.txt
>            CPU0       CPU1       CPU2       CPU3

>  24:          1          0          0          0   PCI-MSI 3145728-edge eth0
 
> I will keep trying 4.14, unless you say otherwise.

It would be interesting though I don't expect too much data.

So all of the above use PCI/MSI. That's at least a data point. I need to
stare into that driver again to figure out why this might make a
difference, but right now I'm lost.

Thanks,

	tglx


