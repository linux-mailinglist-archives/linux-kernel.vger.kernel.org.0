Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1308912A065
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 12:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfLXLUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 06:20:33 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:38264 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfLXLUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:20:32 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ijiEj-0001Gs-CF; Tue, 24 Dec 2019 12:20:25 +0100
To:     Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Dec 2019 11:20:25 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        Zhang Yi <yi.zhang@redhat.com>
In-Reply-To: <20191224015926.GC13083@ming.t460p>
References: <a5f6a542-2dbc-62de-52e2-bd5413b5db51@huawei.com>
 <68058fd28c939b8e065524715494de95@www.loen.fr>
 <ac5b5a25-df2e-18e9-6b0f-60af8c7cec3b@huawei.com>
 <687cbcc4-89d9-63ea-a246-ce2abaae501a@huawei.com>
 <0fd543f8ffd90f90deb691aea1c275b4@www.loen.fr>
 <a5154365-59c5-429b-559e-94ad6dffcdb0@huawei.com>
 <20191220233138.GB12403@ming.t460p>
 <fffcd23dd8286615b6e2c99620836cb1@www.loen.fr>
 <d5774e2f-bb60-c27c-bf00-267b88400a12@huawei.com>
 <e815b5451ea86e99d42045f7067f455a@www.loen.fr>
 <20191224015926.GC13083@ming.t460p>
Message-ID: <7a961950624c414bb9d0c11c914d5c62@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: ming.lei@redhat.com, john.garry@huawei.com, tglx@linutronix.de, chenxiang66@hisilicon.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org, hare@suse.com, hch@lst.de, axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com, yi.zhang@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-24 01:59, Ming Lei wrote:
> On Mon, Dec 23, 2019 at 10:47:07AM +0000, Marc Zyngier wrote:
>> On 2019-12-23 10:26, John Garry wrote:
>> > > > > > I've also managed to trigger some of them now that I have
>> > > > > access to
>> > > > > > a decent box with nvme storage.
>> > > > >
>> > > > > I only have 2x NVMe SSDs when this occurs - I should not be
>> > > > > hitting this...
>> > > > >
>> > > > > Out of curiosity, have you tried
>> > > > > > with the SMMU disabled? I'm wondering whether we hit some
>> > > > > livelock
>> > > > > > condition on unmapping buffers...
>> > > > >
>> > > > > No, but I can give it a try. Doing that should lower the CPU
>> > > > > usage, though,
>> > > > > so maybe masks the issue - probably not.
>> > > >
>> > > > Lots of CPU lockup can is performance issue if there isn't
>> > > > obvious bug.
>> > > >
>> > > > I am wondering if you may explain it a bit why enabling SMMU 
>> may
>> > > > save
>> > > > CPU a it?
>> > > The other way around. mapping/unmapping IOVAs doesn't comes for
>> > > free.
>> > > I'm trying to find out whether the NVMe map/unmap patterns 
>> trigger
>> > > something unexpected in the SMMU driver, but that's a very long
>> > > shot.
>> >
>> > So I tested v5.5-rc3 with and without the SMMU enabled, and 
>> without
>> > the SMMU enabled I don't get the lockup.
>>
>> OK, so my hunch wasn't completely off... At least we have something
>> to look into.
>>
>> [...]
>>
>> > Obviously this is not conclusive, especially with such limited
>> > testing - 5 minute runs each. The CPU load goes up when disabling 
>> the
>> > SMMU, but that could be attributed to extra throughput (1183K ->
>> > 1539K) loading.
>> >
>> > I do notice that since we complete the NVMe request in irq 
>> context,
>> > we also do the DMA unmap, i.e. talk to the SMMU, in the same 
>> context,
>> > which is less than ideal.
>>
>> It depends on how much overhead invalidating the TLB adds to the
>> equation, but we should be able to do some tracing and find out.
>>
>> > I need to finish for the Christmas break today, so can't check 
>> this
>> > much further ATM.
>>
>> No worries. May I suggest creating a new thread in the new year, 
>> maybe
>> involving Robin and Will as well?
>
> Zhang Yi has observed the CPU lockup issue once when running heavy IO 
> on
> single nvme drive, and please CC him if you have new patch to try.

On which architecture? John was indicating that this also happen on 
x86.

> Then looks the DMA unmap cost is too big on aarch64 if SMMU is 
> involved.

So far, we don't have any data suggesting that this is actually the 
case.
Also, other workloads (such as networking) do not exhibit this 
behaviour,
while being least as unmap-heavy as NVMe is.

If the cross-architecture aspect is confirmed, this points more into
the direction of an interaction between the NVMe subsystem and the
DMA API more than an architecture-specific problem.

Given that we have so far very little data, I'd hold off any 
conclusion.

         M.
-- 
Jazz is not dead. It just smells funny...
