Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCDA9F6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 01:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfH0XM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 19:12:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45358 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfH0XM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:12:29 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2kdD-0005dr-Ja; Wed, 28 Aug 2019 01:12:07 +0200
Date:   Wed, 28 Aug 2019 01:12:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
In-Reply-To: <20190827230451.GB5263@ming.t460p>
Message-ID: <alpine.DEB.2.21.1908280110380.1939@nanos.tec.linutronix.de>
References: <20190827085344.30799-1-ming.lei@redhat.com> <20190827085344.30799-2-ming.lei@redhat.com> <alpine.DEB.2.21.1908271633450.1939@nanos.tec.linutronix.de> <alpine.DEB.2.21.1908271817180.1939@nanos.tec.linutronix.de>
 <20190827230451.GB5263@ming.t460p>
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

On Wed, 28 Aug 2019, Ming Lei wrote:
> On Tue, Aug 27, 2019 at 06:19:00PM +0200, Thomas Gleixner wrote:
> > > We definitely are not going to have a 64bit multiplication and division on
> > > every interrupt. Asided of that this breaks 32bit builds all over the place.
> > 
> > That said, we already have infrastructure for something like this in the
> > core interrupt code which is optimized to be lightweight in the fast path.
> > 
> > kernel/irq/timings.c
> 
> irq/timings.c is much more complicated, especially it applies EWMA to
> compute each irq's average interval. However, we only need it for
> do_IRQ() to cover all interrupt & softirq handler.

That does not justify yet another ad hoc thingy.

> Also CONFIG_IRQ_TIMINGS is usually disabled on distributions.

That's not an argument at all.

Thanks,

	tglx
