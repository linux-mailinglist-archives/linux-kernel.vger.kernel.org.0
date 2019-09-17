Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0741DB4FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 16:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfIQOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 10:06:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfIQOGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:06:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68568308212F;
        Tue, 17 Sep 2019 14:06:40 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 711A760852;
        Tue, 17 Sep 2019 14:06:39 +0000 (UTC)
Message-ID: <779eddcc937941e65659a11b1867c6623a2c8890.camel@redhat.com>
Subject: Re: [PATCH RT v3 3/5] sched: migrate_dis/enable: Use rt_invol_sleep
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Tue, 17 Sep 2019 09:06:34 -0500
In-Reply-To: <20190917075943.qsaakyent4dxjkq4@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
         <20190911165729.11178-4-swood@redhat.com>
         <20190917075943.qsaakyent4dxjkq4@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 17 Sep 2019 14:06:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-17 at 09:59 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-11 17:57:27 [+0100], Scott Wood wrote:
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 885a195dfbe0..32c6175b63b6 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -308,7 +308,9 @@ void pin_current_cpu(void)
> >  	preempt_lazy_enable();
> >  	preempt_enable();
> >  
> > +	rt_invol_sleep_inc();
> >  	__read_rt_lock(cpuhp_pin);
> > +	rt_invol_sleep_dec();
> >  
> >  	preempt_disable();
> >  	preempt_lazy_disable();
> 
> I understand the other one. But now looking at it, both end up in
> rt_spin_lock_slowlock_locked() which would be the proper place to do
> that annotation. Okay.

FWIW, if my lazy migrate patchset is accepted, then there will be no users
of __read_rt_lock() outside rwlock-rt.c and it'll be moot.

-Scott


