Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615464DCC9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 23:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfFTViw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 17:38:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfFTViv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:38:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFEC530872C3;
        Thu, 20 Jun 2019 21:38:50 +0000 (UTC)
Received: from ovpn-117-83.phx2.redhat.com (ovpn-117-83.phx2.redhat.com [10.3.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A155D60FFE;
        Thu, 20 Jun 2019 21:38:47 +0000 (UTC)
Message-ID: <8bcc818b1b08850e109d1cde529ab98c4ed788df.camel@redhat.com>
Subject: Re: [PATCH RT 1/4] rcu: Acquire RCU lock when disabling BHs
From:   Scott Wood <swood@redhat.com>
To:     paulmck@linux.ibm.com
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 Jun 2019 16:38:47 -0500
In-Reply-To: <20190620212035.GY26519@linux.ibm.com>
References: <20190619011908.25026-1-swood@redhat.com>
         <20190619011908.25026-2-swood@redhat.com>
         <20190620205352.GV26519@linux.ibm.com>
         <1b6dfc95bba69aa53e4e84eebf6af60f0b9ed95c.camel@redhat.com>
         <20190620212035.GY26519@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 20 Jun 2019 21:38:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-20 at 14:20 -0700, Paul E. McKenney wrote:
> On Thu, Jun 20, 2019 at 04:06:02PM -0500, Scott Wood wrote:
> > On Thu, 2019-06-20 at 13:53 -0700, Paul E. McKenney wrote:
> > > And I have to ask...
> > > 
> > > What did you do to test this change to kernel/softirq.c?  My past
> > > attempts
> > > to do this sort of thing have always run afoul of open-coded BH
> > > transitions.
> > 
> > Mostly rcutorture and loads such as kernel builds, on a debug
> > kernel.  By
> > "open-coded BH transition" do you mean directly manipulating the preempt
> > count?  That would already be broken on RT.
> 
> OK, then maybe you guys have already done the needed cleanup work.  Cool!

Do you remember what code was doing such things?  Grepping for the obvious
things doesn't turn up anything outside the softirq code, even in the
earlier non-RT kernels I checked.

> But don't the additions of rcu_read_lock() and rcu_read_unlock() want
> to be protected by "!IS_ENABLED(CONFIG_PREEMPT_RT_FULL)" or similar?

This is already a separate PREEMPT_RT_FULL-specific implementation.

-Scott


