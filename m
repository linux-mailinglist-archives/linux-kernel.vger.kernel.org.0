Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC112A541
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 01:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfLYAst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 19:48:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41039 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726225AbfLYAst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577234926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p2LMygbzX1GIK1jz4FStb57GDDXp2O5Zety4OXi+v+s=;
        b=FVH8KhY4U41UXJNWDCzqBRp530rawPONewoOH+hadie8TaxsRs+vYK9u4n1qT8s9xt1dQ5
        ABvdurHnJJUeTxxBMw6tvt1U25MsMMmn+BYmQEUpWu9TFnuOEIvdpvp+Qi7NUVEw7/yUrb
        fuKs/ifWWCk1ajslqo2VFftA9ZlESgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-EkYzMKfMPkeauNCrbD-hWA-1; Tue, 24 Dec 2019 19:48:41 -0500
X-MC-Unique: EkYzMKfMPkeauNCrbD-hWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB36D107ACC4;
        Wed, 25 Dec 2019 00:48:38 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B855B101F942;
        Wed, 25 Dec 2019 00:48:27 +0000 (UTC)
Date:   Wed, 25 Dec 2019 08:48:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, tglx@linutronix.de,
        "chenxiang (M)" <chenxiang66@hisilicon.com>, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, hare@suse.com, hch@lst.de,
        axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org,
        mingo@redhat.com, Zhang Yi <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
  for managed interrupt
Message-ID: <20191225004822.GA12280@ming.t460p>
References: <ac5b5a25-df2e-18e9-6b0f-60af8c7cec3b@huawei.com>
 <687cbcc4-89d9-63ea-a246-ce2abaae501a@huawei.com>
 <0fd543f8ffd90f90deb691aea1c275b4@www.loen.fr>
 <a5154365-59c5-429b-559e-94ad6dffcdb0@huawei.com>
 <20191220233138.GB12403@ming.t460p>
 <fffcd23dd8286615b6e2c99620836cb1@www.loen.fr>
 <d5774e2f-bb60-c27c-bf00-267b88400a12@huawei.com>
 <e815b5451ea86e99d42045f7067f455a@www.loen.fr>
 <20191224015926.GC13083@ming.t460p>
 <7a961950624c414bb9d0c11c914d5c62@www.loen.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a961950624c414bb9d0c11c914d5c62@www.loen.fr>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 11:20:25AM +0000, Marc Zyngier wrote:
> On 2019-12-24 01:59, Ming Lei wrote:
> > On Mon, Dec 23, 2019 at 10:47:07AM +0000, Marc Zyngier wrote:
> > > On 2019-12-23 10:26, John Garry wrote:
> > > > > > > > I've also managed to trigger some of them now that I have
> > > > > > > access to
> > > > > > > > a decent box with nvme storage.
> > > > > > >
> > > > > > > I only have 2x NVMe SSDs when this occurs - I should not be
> > > > > > > hitting this...
> > > > > > >
> > > > > > > Out of curiosity, have you tried
> > > > > > > > with the SMMU disabled? I'm wondering whether we hit some
> > > > > > > livelock
> > > > > > > > condition on unmapping buffers...
> > > > > > >
> > > > > > > No, but I can give it a try. Doing that should lower the CPU
> > > > > > > usage, though,
> > > > > > > so maybe masks the issue - probably not.
> > > > > >
> > > > > > Lots of CPU lockup can is performance issue if there isn't
> > > > > > obvious bug.
> > > > > >
> > > > > > I am wondering if you may explain it a bit why enabling SMMU
> > > may
> > > > > > save
> > > > > > CPU a it?
> > > > > The other way around. mapping/unmapping IOVAs doesn't comes for
> > > > > free.
> > > > > I'm trying to find out whether the NVMe map/unmap patterns
> > > trigger
> > > > > something unexpected in the SMMU driver, but that's a very long
> > > > > shot.
> > > >
> > > > So I tested v5.5-rc3 with and without the SMMU enabled, and
> > > without
> > > > the SMMU enabled I don't get the lockup.
> > > 
> > > OK, so my hunch wasn't completely off... At least we have something
> > > to look into.
> > > 
> > > [...]
> > > 
> > > > Obviously this is not conclusive, especially with such limited
> > > > testing - 5 minute runs each. The CPU load goes up when disabling
> > > the
> > > > SMMU, but that could be attributed to extra throughput (1183K ->
> > > > 1539K) loading.
> > > >
> > > > I do notice that since we complete the NVMe request in irq
> > > context,
> > > > we also do the DMA unmap, i.e. talk to the SMMU, in the same
> > > context,
> > > > which is less than ideal.
> > > 
> > > It depends on how much overhead invalidating the TLB adds to the
> > > equation, but we should be able to do some tracing and find out.
> > > 
> > > > I need to finish for the Christmas break today, so can't check
> > > this
> > > > much further ATM.
> > > 
> > > No worries. May I suggest creating a new thread in the new year,
> > > maybe
> > > involving Robin and Will as well?
> > 
> > Zhang Yi has observed the CPU lockup issue once when running heavy IO on
> > single nvme drive, and please CC him if you have new patch to try.
> 
> On which architecture? John was indicating that this also happen on x86.

ARM64.

To be honest, I never see such CPU lockup issue on x86 in case of running
heavy IO on single NVMe drive.

> 
> > Then looks the DMA unmap cost is too big on aarch64 if SMMU is involved.
> 
> So far, we don't have any data suggesting that this is actually the case.
> Also, other workloads (such as networking) do not exhibit this behaviour,
> while being least as unmap-heavy as NVMe is.

Maybe it is because networking workloads usually completes IO in softirq
context, instead of hard interrupt context.

> 
> If the cross-architecture aspect is confirmed, this points more into
> the direction of an interaction between the NVMe subsystem and the
> DMA API more than an architecture-specific problem.
> 
> Given that we have so far very little data, I'd hold off any conclusion.

We can start to collect latency data of dma unmapping vs nvme_irq()
on both x86 and arm64.

I will see if I can get a such box for collecting the latency data.


Thanks,
Ming

