Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB73998FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbfHVJsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 05:48:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732310AbfHVJsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:48:51 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0jhn-000790-5b; Thu, 22 Aug 2019 11:48:31 +0200
Date:   Thu, 22 Aug 2019 11:48:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Keith Busch <keith.busch@gmail.com>
cc:     Ming Lei <ming.lei@redhat.com>, Long Li <longli@microsoft.com>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        chenxiang <chenxiang66@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
Subject: Re: [PATCH 0/3] fix interrupt swamp in NVMe
In-Reply-To: <CAOSXXT7LVjBqVW14y-pZyUCat3PBPd_nVd_uDahBdhyW+eHmcg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908221143060.1983@nanos.tec.linutronix.de>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com> <CACVXFVPCiTU0mtXKS0fyMccPXN6hAdZNHv6y-f8-tz=FE=BV=g@mail.gmail.com> <fd7d6101-37f4-2d34-f2f7-cfeade610278@huawei.com> <CY4PR21MB0741D1CD295AD572548E61D1CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20190821094406.GA28391@ming.t460p> <CY4PR21MB07410E84C8C7C1D64BD7BF41CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com> <20190822013356.GC28635@ming.t460p> <CAOSXXT7LVjBqVW14y-pZyUCat3PBPd_nVd_uDahBdhyW+eHmcg@mail.gmail.com>
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

On Wed, 21 Aug 2019, Keith Busch wrote:
> On Wed, Aug 21, 2019 at 7:34 PM Ming Lei <ming.lei@redhat.com> wrote:
> > On Wed, Aug 21, 2019 at 04:27:00PM +0000, Long Li wrote:
> > > Here is the command to benchmark it:
> > >
> > > fio --bs=4k --ioengine=libaio --iodepth=128 --filename=/dev/nvme0n1:/dev/nvme1n1:/dev/nvme2n1:/dev/nvme3n1:/dev/nvme4n1:/dev/nvme5n1:/dev/nvme6n1:/dev/nvme7n1:/dev/nvme8n1:/dev/nvme9n1 --direct=1 --runtime=120 --numjobs=80 --rw=randread --name=test --group_reporting --gtod_reduce=1
> > >
> >
> > I can reproduce the issue on one machine(96 cores) with 4 NVMes(32 queues), so
> > each queue is served on 3 CPUs.
> >
> > IOPS drops > 20% when 'use_threaded_interrupts' is enabled. From fio log, CPU
> > context switch is increased a lot.
> 
> Interestingly use_threaded_interrupts shows a marginal improvement on
> my machine with the same fio profile. It was only 5 NVMes, but they've
> one queue per-cpu on 112 cores.

Which is not surprising because the thread and the hard interrupt are on
the same CPU and there is just that little overhead of the context switch.

The thing is that this really depends on how the scheduler decides to place
the interrupt thread.

If you have a queue for several CPUs, then depending on the load situation
allowing a multi-cpu affinity for the thread can cause lots of task
migration.

But restricting the irq thread to the CPU on which the interrupt is affine
can also starve that CPU. There is no universal rule for that.

Tracing should tell.

Thanks,

	tglx



