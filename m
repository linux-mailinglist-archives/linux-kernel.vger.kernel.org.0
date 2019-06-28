Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464825A603
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 22:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfF1Uqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 16:46:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47588 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1Uqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zJTVkv2dO5Re8XVS1UPG6dVVDjFW3G/p2+JFz74aRSk=; b=xdhy6CKwhbe9L0+7lT1Wu8y0Q
        N2ZXVhhcTngwSdtlU7u6s5LVsQxP6/RTKSToOI28bLUFbiaIDQ0llEDdCpp6L7hmMqgAFyj2E6VWy
        5hlFthyxPyzzlxCdqt3qp9bsuhfYYilfQzKhcj973j7yn0+QCSyBvAGDSUUwWxGsEkcINizlSF7a6
        Gle/fg0JcJFFLX0PybvB2d9kzY0Hkly3cHGHaAhrXYlVWy20tWypcc6v77R6rSI8veB+XafYCUXJq
        aqCWnHmkABzlQWju1l6ATHt05TaiLDqsA4c9JOESf2O2A3sPNGCwhP8hv9RCthdKZPm5IZoWQjEe0
        BglbS48qQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgxl5-0003T6-Nd; Fri, 28 Jun 2019 20:46:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAFAC2021621E; Fri, 28 Jun 2019 22:46:08 +0200 (CEST)
Date:   Fri, 28 Jun 2019 22:46:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, dvyukov@google.com, namhyung@kernel.org,
        xiexiuqi@huawei.com,
        syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com
Subject: Re: [PATCH] perf: Fix race between close() and fork()
Message-ID: <20190628204608.GG3402@hirez.programming.kicks-ass.net>
References: <278ac311-d8f3-2832-5fa1-522471c8c31c@huawei.com>
 <20190228140109.64238-1-alexander.shishkin@linux.intel.com>
 <20190308155429.GB10860@lakrids.cambridge.arm.com>
 <20190624121902.GE3436@hirez.programming.kicks-ass.net>
 <20190625084904.GY3463@hirez.programming.kicks-ass.net>
 <20190625104320.GZ3463@hirez.programming.kicks-ass.net>
 <20190628165003.GA5143@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628165003.GA5143@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 05:50:03PM +0100, Mark Rutland wrote:
> > +		/*
> > +		 * Wake any perf_event_free_task() waiting for this event to be
> > +		 * freed.
> > +		 */
> > +		smp_mb(); /* pairs with wait_var_event() */
> > +		wake_up_var(var);
> 
> Huh, so wake_up_var() doesn't imply a RELEASE?
> 
> As an aside, doesn't that mean all callers of wake_up_var() have to do
> likewise to ensure it isn't re-ordered with whatever prior stuff they're
> trying to notify waiters about? Several do an smp_store_release() then a
> wake_up_var(), but IIUC the wake_up_var() could get pulled before that
> release...

Yah,...

  https://lkml.kernel.org/r/20190624165012.GH3436@hirez.programming.kicks-ass.net

I needs to get back to that.
