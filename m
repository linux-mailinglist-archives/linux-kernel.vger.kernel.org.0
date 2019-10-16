Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 091CED94EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391053AbfJPPFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 11:05:54 -0400
Received: from foss.arm.com ([217.140.110.172]:42624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfJPPFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:05:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 454971570;
        Wed, 16 Oct 2019 08:05:53 -0700 (PDT)
Received: from bogus (unknown [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48FB13F68E;
        Wed, 16 Oct 2019 08:05:51 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:05:45 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wuyun.wu@huawei.com" <wuyun.wu@huawei.com>, hushiyuan@huawei.com,
        linfeilong@huawei.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V2] arm64: psci: Reduce waiting time of
 cpu_psci_cpu_kill()
Message-ID: <20191016150545.GA6750@bogus>
References: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
 <20191015162358.bt5rffidkv2j4xqb@willie-the-truck>
 <ab42357e-f4f9-9019-e8d9-7e9bfe106e9e@huawei.com>
 <20191016102545.GA11386@bogus>
 <13d82e24-90bd-0c17-ef7f-aa7fec272f59@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d82e24-90bd-0c17-ef7f-aa7fec272f59@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 07:29:59PM +0800, Yunfeng Ye wrote:
>
>
> On 2019/10/16 18:25, Sudeep Holla wrote:
> > On Wed, Oct 16, 2019 at 11:22:23AM +0800, Yunfeng Ye wrote:
> >>
> >>
> >> On 2019/10/16 0:23, Will Deacon wrote:
> >>> Hi,
> >>>
> >>> On Sat, Sep 21, 2019 at 07:21:17PM +0800, Yunfeng Ye wrote:
> >>>> If psci_ops.affinity_info() fails, it will sleep 10ms, which will not
> >>>> take so long in the right case. Use usleep_range() instead of msleep(),
> >>>> reduce the waiting time, and give a chance to busy wait before sleep.
> >>>
> >>> Can you elaborate on "the right case" please? It's not clear to me
> >>> exactly what problem you're solving here.
> >>>
> >> The situation is that when the power is off, we have a battery to save some
> >> information, but the battery power is limited, so we reduce the power consumption
> >> by turning off the cores, and need fastly to complete the core shutdown. However, the
> >> time of cpu_psci_cpu_kill() will take 10ms. We have tested the time that it does not
> >> need 10ms, and most case is about 50us-500us. if we reduce the time of cpu_psci_cpu_kill(),
> >> we can reduce 10% - 30% of the total time.
> >>
> >
> > Have you checked why PSCI AFFINITY_INFO not returning LEVEL_OFF quickly
> > then ? We wait for upto 5s in cpu_wait_death(worst case) before cpu_kill
> > is called from __cpu_die.
> >
> When cpu_wait_death() is done, it means that the cpu core's hardware prepare to
> die. I think not returning LEVEL_OFF quickly is that hardware need time to handle.
> I don't know how much time it need is reasonable, but I test that it need about
> 50us - 500us.
>

Fair enough.

> In addition I have not meat the worst case that cpu_wait_death() need upto
> 5s, and we only take normal case into account.
>

Good

>
> > Moreover I don't understand the argument here. The cpu being killed
> > will be OFF, as soon as it can and firmware controls that and this
> > change is not related to CPU_OFF. And this CPU calling cpu_kill can
> > sleep and 10ms is good to enter idle states if it's idle saving power,
> > so I fail to map the power saving you mention above.
> >
> We have hundreds of CPU cores that need to be shut down. For example,
> a CPU has 200 cores, and the thread to shut down the core is in CPU 0.
> and the thread need to shut down from core 1 to core 200. However, the
> implementation of the kernel can only shut down cpu cores one by one, so we
> need to wait for cpu_kill() to finish before shutting down the next
> CPU core. If it wait for 10ms each time in cpu_kill, it will takes up
> about 2 seconds in cpu_kill() total.
>

OK, thanks for the illustrative example. This make sense to me now. But
you comparing with battery powered devices confused me and I assumed
it as some hack to optimise mobile workload.

> >> So change msleep (10) to usleep_range() to reduce the waiting time. In addition,
> >> we don't want to be scheduled during the sleeping time, some threads may take a
> >> long time and don't give up the CPU, which affects the time of core shutdown,
> >> Therefore, we add a chance to busy-wait max 1ms.
> >>
> >
> > On the other hand, usleep_range reduces the timer interval and hence
> > increases the chance of the callee CPU not to enter deeper idle states.
> >
> > What am I missing here ? What's the use case or power off situation
> > you are talking about above ?
> >
> As mentioned above, we are not to save power through msleep to idle state,
> but to quickly turn off other CPU core's hardware to reduce power consumption.

You still don't provide your use-case in which this is required. I know
this will be useful for suspend-to-ram. Do you have any other use-case
that you need to power-off large number of CPUs like this ? Also you
mentioned battery powered, and I don't think any battery powered device
has 200 thread like in your example :)

You need to mention few things clearly in the commit log:
1. How the CPU hotplug operation is serialised in some use-case like
   suspend-to-ram
2. How that may impact systems with large number of CPUs
3. How your change helps to improve that

It may it easy for anyone to understand the motivation for this change.
The commit message you have doesn't give any clue on all the above and
hence we have lot of questions.

I will respond to the original patch separately.

--
Regards,
Sudeep
