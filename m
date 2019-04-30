Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E39F724
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 13:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfD3Lz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 07:55:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfD3Lzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1FRlbeq74rKv2BVig4MgSeofWTqiuNAZ7kl/vVWV7YQ=; b=uifRx/IHUn5YjaDIjS3gB7PtR
        6o1P8LCjJUH8ZoSAFUqjkLns23nKJBnAr5zwqjWk0AQSpkCxHTdLgR6KA0mmac340IsQdi34n29Kk
        WtTfSus8BLgzK/SiP5D7xzx+ma0Zmie4XDJGtjf2eBlKlYUtq0/HpSuSEP/hv3YkTeOZrV1WNX19w
        KT1nl5Wk8Qa2Z2vNndUE/9mBMwFfyJRB+j0BoLqHV7jnYQDkOv0n5GjA49JcWrVtk9wv103/TDedy
        I8KfwOdEO/GY139tcBYwMGyO8ZtPALn8U3f0SbZsZuNH/9MWbEcXrQoDEE3JrXxFjv0X91OB3WTox
        f0y0zDjEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLRMX-0000eR-K8; Tue, 30 Apr 2019 11:55:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6A6F2139B636; Tue, 30 Apr 2019 13:55:51 +0200 (CEST)
Date:   Tue, 30 Apr 2019 13:55:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com
Subject: Re: Question about sched_setaffinity()
Message-ID: <20190430115551.GT2623@hirez.programming.kicks-ass.net>
References: <20190427180246.GA15502@linux.ibm.com>
 <20190430100318.GP2623@hirez.programming.kicks-ass.net>
 <20190430105129.GA3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430105129.GA3923@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 03:51:30AM -0700, Paul E. McKenney wrote:
> > Then I'm not entirely sure how we can return 0 and not run on the
> > expected CPU. If we look at __set_cpus_allowed_ptr(), the only paths out
> > to 0 are:
> > 
> >  - if the mask didn't change
> >  - if we already run inside the new mask
> >  - if we migrated ourself with the stop-task
> >  - if we're not in fact running
> > 
> > That last case should never trigger in your circumstances, since @p ==
> > current and current is obviously running. But for completeness, the
> > wakeup of @p would do the task placement in that case.
> 
> Are there some diagnostics I could add that would help track this down,
> be it my bug or yours?

Maybe limited function trace combined with the scheduling tracepoints
would give clue.

Trouble is, I forever forget how to set that up properly :/ Maybe
something along these lines:

$ trace-cmd record -p function_graph -g sched_setaffinity -g migration_cpu_stop -e
sched_migirate_task -e sched_switch -e sched_wakeup

Also useful would be:

echo 1 > /proc/sys/kernel/traceoff_on_warning

which ensures the trace stops the moment we find fail.
