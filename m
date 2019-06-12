Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E19142038
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 11:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436683AbfFLJDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 05:03:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37032 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbfFLJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KW6pIO4BW4A8NeSYhtYsxDO73dMYune9Npy8bVLERxc=; b=qNxuFUcW0ZQz2Y/FnKYi/jyGT
        PwGnV1Uup63HRxijOvNiF1QjNrbJne2nId4R5WNXCUDmnWEWrlT6l40vgIJU2t5vbaaK+g+7GS49R
        /DMOjgHqucWyYByVbDcFvfvDQaGpfR56oBxnB2IUurjJ7hB2Y37Cx2+RhmXzEWxlb/DhZlOuH3XIF
        Adf3UXp4hKRkEsforUJGAvv0oMvD0fE5NSJYj8PCc8eCxwGKo4nhFUoFenCrr7bQp0eHTm+1Xs52V
        EY1RssJdTe/ZkE5eI4ZwZXQd/B/iPmQfmTn4jxmBZ66NB+rLYG+bSIz8/MW2qMYJn6cKZkrzrLnjD
        Uqnl92lHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haz9p-0004Xd-Hq; Wed, 12 Jun 2019 09:03:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DDC320564E00; Wed, 12 Jun 2019 11:02:57 +0200 (CEST)
Date:   Wed, 12 Jun 2019 11:02:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, clemens@ladisch.de,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, x86@kernel.org
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
Message-ID: <20190612090257.GF3436@hirez.programming.kicks-ass.net>
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:09:20PM +0200, Thomas Gleixner wrote:
> Jason,
> 
> On Fri, 7 Jun 2019, Jason A. Donenfeld wrote:
> 
> Adding a few more people on cc and keeping full context.
> 
> > Hey Thomas,
> > 
> > After some discussions here prior about the different clocks
> > available, WireGuard uses ktime_get_boot_fast_ns() pretty extensively.
> > The requirement is for a quasi-accurate monotonic counter that takes
> > into account sleep time, and this seems to fit the bill pretty well.

How quasi? Do the comments in kernel/sched/clock.c look like something
you could use?

As already mentioned in the other tasks, anything ktime will be
horrifically crap when it ends up using the HPET, the code in
kernel/sched/clock.c is a best effort to keep using TSC even when it is
deemed unusable for timekeeping.
