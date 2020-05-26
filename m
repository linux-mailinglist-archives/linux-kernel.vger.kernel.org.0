Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A57919A3F5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 05:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbgDADZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 23:25:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36967 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgDADZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 23:25:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id z24so19288220qtu.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 20:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lFSYqvfFUF1ovFmHfTti7v5BOoCq3r1McUwFK2pG5RM=;
        b=qQ7NU+umHMNwA8WeCSpEzAz0Gu5MdxXUX6+CVuha9v7EDQa88dMLlniS/0F/FsHdDl
         y3yjMPhYDuajxnM6p54m0L+Qv6cvgEO76sYv69cGKusOR0qoihRASg8T531SA3XiX98o
         sJVR4alD6PsLT7ri8Aw6JodYLSvDr8Vqkf7EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lFSYqvfFUF1ovFmHfTti7v5BOoCq3r1McUwFK2pG5RM=;
        b=Ptq36ZCkXsP1omhcfWZFI2hrpS86OLDhz4efxmZuV7781fbHm9Fda7W3hDHEy4urq2
         PA3+IRNzXyq0YEvpr+Tu6Dd47x+X1BHKSmkOtUMbNW5Bns1iGw6toFwBiRN6xBVIPScD
         WnzPFA99LstQqZXI+Arp25yjd+a+xT1h/4amVt+lDAdfus9ufspS/3UJM39Fkewm2rS1
         zTmw949buNUthOnnmuVcW5VNPfauUCI5SyJe54ss2a8YucTgJ8L4X9a7BvC/Vk5jZHV6
         kKEZBwJr8THtRvsr5t8bmMRa/AVxgT+0OVn+DwSEFPL62+k/t90TVKMmpBXaUbYiWpPa
         SIuw==
X-Gm-Message-State: ANhLgQ0Z6FX1N4pAUtJTjT6noE1RHtB+FsNe+B+BjHwZr/wi+GCgl1Hf
        CmJdeTaaPP3sSOHJ6sM6tf7bpQ==
X-Google-Smtp-Source: ADFU+vtL2n03VIwQtnqW+IsY7DsD8p/H5OcQpXxMFlvAYLgwW2+c5WLD1AR6pXpDo7VO64CA/HRVzw==
X-Received: by 2002:ac8:4449:: with SMTP id m9mr8439493qtn.175.1585711556906;
        Tue, 31 Mar 2020 20:25:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i20sm605141qkl.135.2020.03.31.20.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 20:25:56 -0700 (PDT)
Date:   Tue, 31 Mar 2020 23:25:55 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org, willy@infradead.org,
        peterz@infradead.org, neilb@suse.com, vbabka@suse.cz,
        mgorman@suse.de, Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401032555.GA175966@google.com>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331160117.GA170994@google.com>
 <877dz0yxoa.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dz0yxoa.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 09:19:49AM +1100, NeilBrown wrote:
> On Tue, Mar 31 2020, Joel Fernandes wrote:
> 
> > On Tue, Mar 31, 2020 at 05:34:50PM +0200, Michal Hocko wrote:
> >> On Tue 31-03-20 10:58:06, Joel Fernandes wrote:
> >> [...]
> >> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> > > index 4be763355c9fb..965deefffdd58 100644
> >> > > --- a/kernel/rcu/tree.c
> >> > > +++ b/kernel/rcu/tree.c
> >> > > @@ -3149,7 +3149,7 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
> >> > >  
> >> > >  	if (!ptr)
> >> > >  		ptr = kmalloc(sizeof(unsigned long *) +
> >> > > -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
> >> > > +				sizeof(struct rcu_head), GFP_MEMALLOC);
> >> > 
> >> > Just to add, the main requirements here are:
> >> > 1. Allocation should be bounded in time.
> >> > 2. Allocation should try hard (possibly tapping into reserves)
> >> > 3. Sleeping is Ok but should not affect the time bound.
> >> 
> >> 
> >> __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
> >> memory reserves regarless of the sleeping status.
> >> 
> >> Using __GFP_MEMALLOC is quite dangerous because it can deplete _all_ the
> >> memory. What does prevent the above code path to do that?
> >
> > Can you suggest what prevents other users of GFP_MEMALLOC from doing that
> > also? That's the whole point of having a reserve, in normal usage no one will
> > use it, but some times you need to use it. Keep in mind this is not a common
> > case in this code here, this is triggered only if earlier allocation attempts
> > failed. Only *then* we try with GFP_MEMALLOC with promises to free additional
> > memory soon.
> 
> I think that "soon" is the key point.  Users of __GFP_MEMALLOC certainly
> must be working to free other memory, that other memory needs to be freed
> "soon".  In particular - sooner than all the reserve is exhausted.  This
> can require rate-limiting.  If one allocation can result in one page
> being freed, that is good and it is probably OK to have 1000 allocations
> resulting in 1000 pages being freed soon.  But 10 million allocation to
> gain 10 million pages is not such a good thing and shouldn't be needed.
> Once those first 1000 pages have been freed, you won't need
> __GFP_MEMALLOC allocations any more, and you must be prepare to wait for
> them.
> 
> So where does the rate-limiting happen in your proposal?  A GP can be
> multiple milliseconds, which is time for lots of memory to be allocated
> and for rcu-free queues to grow quite large.
> 
> You mention a possible fall-back of calling synchronize_rcu().  I think
> that needs to be a fallback that happens well before __GFP_MEMALLOC is
> exhausted.   You need to choose some maximum amount that you will
> allocate, then use synchronize_rcu() (or probably the _expedited
> version) after that.  The pool of reserves are certainly there for you
> to use, but not for you to exhaust.
> 
> If you have your own rate-limiting, then I think __GFP_MEMALLOC is
> probably OK, and also you *don't* want the memalloc to wait.  If memory
> cannot be allocated immediately, you need to use your own fallback.

Thanks a lot for explaining in detail, the RFC patch has served its purpose
well ;-)

On discussing with RCU comrades, we agreed to not use GFP_MEMALLOC. But
instead pre-allocate a cache (we do have a cache but it is not yet
pre-allocated, just allocated on demand).

About the rate limiting, we would fallback to synchronize_rcu() instead of
sleeping in case of trobule. However I would like to add a warning if we ever
hit the troublesome path mainly because that means we depleted the
pre-allocated cache and perhaps the user should switch to adding an rcu_head
in their structure to reduce latency. I'm adding that warning to my tree:

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4be763355c9fb..6172e6296dd7d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -110,6 +110,10 @@ module_param(rcu_fanout_exact, bool, 0444);
 static int rcu_fanout_leaf = RCU_FANOUT_LEAF;
 module_param(rcu_fanout_leaf, int, 0444);
 int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
+/* Silence the kvfree_rcu() complaint (warning) that it blocks */
+int rcu_kfree_nowarn;
+module_param(rcu_kfree_nowarn, int, 0444);
+
 /* Number of rcu_nodes at specified level. */
 int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
 int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
@@ -3266,6 +3270,12 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * state.
 	 */
 	if (!success) {
+		/*
+		 * Please embed an rcu_head and pass it along if you hit this
+		 * warning. Doing so would avoid long kfree_rcu() latencies.
+		 */
+		if (!rcu_kfree_nowarn)
+			WARN_ON_ONCE(1);
 		debug_rcu_head_unqueue(ptr);
 		synchronize_rcu();
 		kvfree(ptr);
