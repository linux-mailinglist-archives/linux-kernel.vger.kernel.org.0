Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E8E5A967
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 09:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfF2HPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 03:15:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38346 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfF2HPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 03:15:24 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hh7Zu-0001Xt-L3; Sat, 29 Jun 2019 09:15:18 +0200
Date:   Sat, 29 Jun 2019 09:15:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        "tipbuild@zytor.com" <tipbuild@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, "lkp@01.org" <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [LKP] [x86/hotplug] e1056a25da:
 WARNING:at_arch/x86/kernel/apic/apic.c:#setup_local_APIC
In-Reply-To: <alpine.DEB.2.21.1906280929010.32342@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906290912390.1802@nanos.tec.linutronix.de>
References: <20190620021856.GP7221@shao2-debian> <alpine.DEB.2.21.1906212108150.5503@nanos.tec.linutronix.de> <58ea508f-dc2e-8537-fe96-49cca0a7c799@intel.com> <alpine.DEB.2.21.1906250821220.32342@nanos.tec.linutronix.de> <f5c36f89-61bf-a82e-3d3b-79720b2da2ef@intel.com>
 <alpine.DEB.2.21.1906251330330.32342@nanos.tec.linutronix.de> <20190628063231.GA7766@shbuild999.sh.intel.com> <alpine.DEB.2.21.1906280929010.32342@nanos.tec.linutronix.de>
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

Feng,

On Fri, 28 Jun 2019, Thomas Gleixner wrote:
> On Fri, 28 Jun 2019, Feng Tang wrote:
> > On Tue, Jun 25, 2019 at 07:32:03PM +0800, Thomas Gleixner wrote:
> > > the head of that branch is:
> > > 
> > >       4f3f6d6a7f8e ("x86/apic/x2apic: Add conditional IPI shorthands support")
> > > 
> > > This is WIP and force pushed. There are no incremental changes. Could you
> > > please check again?
> > 
> > Since you can't reproduce it yet, we've added some debug hook to get more
> > info, like dmesg below:
> > 
> > [  288.866069] IRR[7]: 0x1000
> > [  289.890274] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/apic/apic.c:1502 setup_local_APIC+0x2d1/0x4f0
> 
> > [  290.182418] queued = 0x1000 acked = 0
> > [  290.189159] IRR[7]: 0x1000
> > 
> > Which shows the IRR[7] was set 0x1000, IIUC, it means vector
> > 0xec, which is for LAPIC timer, and ISRs are all 0 before and
> > after the loop.
> 
> Ahhhh. That makes a lot of sense now.
> 
> That interrupt is in the IRR, but not in the ISR. So the acknowledge
> attempts are useless because the ack only clears an pending ISR and the IRR
> is not propagated because in the state in which this happens the entry is
> masked.
> 
> That function just 'works' by chance not by design. I'll stare into it and
> fix it up for real.
> 
> Thank you very much for that information. Your debug was spot on!

I rewrote that function so it actually handles that case correctly along
with some other things which were broken and force pushed the WIP.x86/ipi
branch.

Can you please run exactly that test again against that new version and
verify that this is fixed now?

Thanks,

	tglx
