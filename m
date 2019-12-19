Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86962125D89
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 10:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLSJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 04:23:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44892 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfLSJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=24GBdvgPOniGO/u5Izbxbzv5IyyCWf616Is9oo5bboE=; b=IkiMFE+IcFYckiwO+I/fcf1MJ
        r6UTOjpgng6pF5rYTgTYW6LqO+2AuIP+72yCDVZn73fuJlkJXE+Z8hQzqr/12NibItH+SdwR/1WW1
        I4wcDCWItTYlUOM3tMIc1Jh64if4MsvSu/aHkGQYztIf+dXOo8BoWyBMtKZVlFO42eaDS4qXJ1sBG
        oymRrm1w76EZlnzrH5druTNPIWF5i6oCrYykaUKX9xruroRn1PDyXftHdj2y4rX0W0EtsOTAmxReL
        YPWDMtK4iEfJ1qyq6chSQe33ZCpwIPrnRGclYpObEkKYbd5qoTT8v3PFakpC9E/j1V1WedcUnbX6f
        aairSL9qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihs1h-0005cs-0B; Thu, 19 Dec 2019 09:23:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1EF64304D00;
        Thu, 19 Dec 2019 10:21:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 949ED2B291C41; Thu, 19 Dec 2019 10:23:19 +0100 (CET)
Date:   Thu, 19 Dec 2019 10:23:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Long Li <longli@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH 2/3] softirq: implement interrupt flood detection
Message-ID: <20191219092319.GX2844@hirez.programming.kicks-ass.net>
References: <20191218071942.22336-1-ming.lei@redhat.com>
 <20191218071942.22336-3-ming.lei@redhat.com>
 <20191218104941.GR2844@hirez.programming.kicks-ass.net>
 <20191219015948.GB6080@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219015948.GB6080@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 09:59:48AM +0800, Ming Lei wrote:
> > So pray tell, why did you not integrate this with IRQ_TIME_ACCOUNTING ?
> > That already takes a timestamp and does most of what you need.
> 
> Yeah, that was the 1st approach I thought of, but IRQ_TIME_ACCOUNTING
> may be disabled, and enabling it may cause observable effect on IO
> performance.

Is that an actual concern, are people disabling it?

> > > @@ -356,6 +512,7 @@ void irq_enter(void)
> > >  	}
> > >  
> > >  	__irq_enter();
> > > +	irq_interval_update();
> > >  }
> > 
> > Arggh.. you're going to make every single interrupt take at least 2
> > extra cache misses for this gunk?!?
> 
> Could you explain it a bit why two cache misses are involved?
> 
> I understand at most one miss is caused, which should only happen in
> irq_interval_update(), and what is the other one?

The rq clock thing IIRC.

