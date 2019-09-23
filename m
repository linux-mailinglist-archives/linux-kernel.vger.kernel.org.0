Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B5BBB9CB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389799AbfIWQlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 12:41:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbfIWQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:41:03 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iCROW-0001T3-67; Mon, 23 Sep 2019 18:41:00 +0200
Date:   Mon, 23 Sep 2019 18:41:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 1/5] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190923164059.5hvqttxvh7lxxzas@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-2-swood@redhat.com>
 <20190917074456.yj7t3wdwuhn3zcng@linutronix.de>
 <63b430ca2f067e61bef1c387fad782ab4a2c1ed3.camel@redhat.com>
 <20190917144252.v34ina4z2ydchoit@linutronix.de>
 <ad29574b34aca9ab61d310508f4f21a35cac406e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad29574b34aca9ab61d310508f4f21a35cac406e.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-17 11:12:48 [-0500], Scott Wood wrote:
> > rcu_read_lock() does:
> > >         __rcu_read_lock();
> > >         __acquire(RCU);
> > >         rcu_lock_acquire(&rcu_lock_map);
> > >         RCU_LOCKDEP_WARN(!rcu_is_watching(),
> > >                          "rcu_read_lock() used illegally while idle");
> > 
> > __acquire() is removed removed by cpp.
> > That RCU_LOCKDEP_WARN is doing the same thing as above and redundant.
> > Am I right to assume that you consider
> > 	rcu_lock_acquire(&rcu_bh_lock_map);
> > 
> > redundant because the only user of that is also checking for
> > rcu_lock_map?
> Yes.

I'm going to drop that hunk. It makes the patch smaller and result more
obvious. If the additional lock annotation (rcu_bh_lock_map) is too much
then we can still remove it later entirely (for RT) but for now I would
like to keep the changes simple and small.

> -Scott

Sebastian
