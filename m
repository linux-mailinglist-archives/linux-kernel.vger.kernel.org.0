Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC08319B5AB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgDASh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 14:37:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45354 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDASh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:37:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id t17so506713ljc.12;
        Wed, 01 Apr 2020 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ChPzfp50uye5s6cR7YNBoT+4A3H45gyCxHFKR4xyF5U=;
        b=o2gAp7G0cvfDzGxgy/htRMh9ZzYSROVUylzIe3v/N+3cD7IBbUIgDK/qxkgF0bnmdd
         vwSxvZhSBUhArsXCBF4q+XqES0z4+kLFyv093glrug2o3YGYLH6Jt4kJNlqO4u2evUcx
         vNvCArRJZSzhfFXba0n2Voebj9j6QV90zCxJCf+CuDc6ph6ItVyk5yAeI/2Kugyf5CPD
         rA5qbTY/rOE0EkJvPapbOeNUs5C6MNtfJ785sPatfQ2BqVNSQV8Tz5Re3decS4MTAuYO
         +wpOS0saPhG6KjRAcwADkpy9GnSHJvMXMSYpEsUwsm02oynEjqqMSYsApUV1Qm8xi+qS
         JgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ChPzfp50uye5s6cR7YNBoT+4A3H45gyCxHFKR4xyF5U=;
        b=HVqC63BLp5ossSNsRFqIYWf14LRrvYiUrN8/FK73pmNv5lRtpr/yFQVkWJEDvq/c+b
         Lsw9JpbQv0EcFpBhbsTtKCb6RRpD6QHjCwIsW5wvvdK4rhFuBfUtoXPnh8mlCnJS2AnQ
         UHlupcVxInu1sJQjY0a3Tx+E2zV6SAMio+yukitluPw+4vVGBpCBGhhiV3OApapzy0y+
         g3cKLPu1Xw2yMFPfRMPwOERjEwNFXO9/FkJgjMiPZ77it/Q/IO/oqRVm4GVVxrYCvzye
         HwGDpxQREDmyyrJgEoZkilnVePAugc9FD7Kgu8/xxnmgpsrIouLnpxg3yyO0OZLZx9hY
         JWvw==
X-Gm-Message-State: AGi0PuZyCVnmM+NdnCLd7RrlU/WkR149z2hIzN6ZHoQVTX6nXEN6i4yR
        XQjE4uYVyNak5lAmbQA0us8=
X-Google-Smtp-Source: APiQypLqTbhyf8vdAzNpwruAWk6zd3Y+34qmO6h8QfNZiY6Fi0yJXRSz1JblP+I+pRCUW52i7ItVOQ==
X-Received: by 2002:a2e:4942:: with SMTP id b2mr10128427ljd.135.1585766274540;
        Wed, 01 Apr 2020 11:37:54 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id d21sm1711255ljc.49.2020.04.01.11.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 11:37:53 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Apr 2020 20:37:45 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401183745.GA5960@pc636>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331140433.GA26498@pc636>
 <20200331150911.GC236678@google.com>
 <20200331160119.GA27614@pc636>
 <20200331183000.GD236678@google.com>
 <20200401122550.GA32593@pc636>
 <20200401134745.GV19865@paulmck-ThinkPad-P72>
 <20200401181601.GA4042@pc636>
 <20200401182615.GE19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401182615.GE19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 11:26:15AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 01, 2020 at 08:16:01PM +0200, Uladzislau Rezki wrote:
> > > > > 
> > > > > Right. Per discussion with Paul, we discussed that it is better if we
> > > > > pre-allocate N number of array blocks per-CPU and use it for the cache.
> > > > > Default for N being 1 and tunable with a boot parameter. I agree with this.
> > > > > 
> > > > As discussed before, we can make use of memory pool API for such
> > > > purpose. But i am not sure if it should be one pool per CPU or
> > > > one pool per NR_CPUS, that would contain NR_CPUS * N pre-allocated
> > > > blocks.
> > > 
> > > There are advantages and disadvantages either way.  The advantage of the
> > > per-CPU pool is that you don't have to worry about something like lock
> > > contention causing even more pain during an OOM event.  One potential
> > > problem wtih the per-CPU pool can happen when callbacks are offloaded,
> > > in which case the CPUs needing the memory might never be getting it,
> > > because in the offloaded case (RCU_NOCB_CPU=y) the CPU posting callbacks
> > > might never be invoking them.
> > > 
> > > But from what I know now, systems built with CONFIG_RCU_NOCB_CPU=y
> > > either don't have heavy callback loads (HPC systems) or are carefully
> > > configured (real-time systems).  Plus large systems would probably end
> > > up needing something pretty close to a slab allocator to keep from dying
> > > from lock contention, and it is hard to justify that level of complexity
> > > at this point.
> > > 
> > > Or is there some way to mark a specific slab allocator instance as being
> > > able to keep some amount of memory no matter what the OOM conditions are?
> > > If not, the current per-CPU pre-allocated cache is a better choice in the
> > > near term.
> > > 
> > As for mempool API:
> > 
> > mempool_alloc() just tries to make regular allocation taking into
> > account passed gfp_t bitmask. If it fails due to memory pressure,
> > it uses reserved preallocated pool that consists of number of
> > desirable elements(preallocated when a pool is created).
> > 
> > mempoll_free() returns an element to to pool, if it detects that
> > current reserved elements are lower then minimum allowed elements,
> > it will add an element to reserved pool, i.e. refill it. Otherwise
> > just call kfree() or whatever we define as "element-freeing function."
> 
> Unless I am missing something, mempool_alloc() acquires a per-mempool
> lock on each invocation under OOM conditions.  For our purposes, this
> is essentially a global lock.  This will not be at all acceptable on a
> large system.
> 
It uses pool->lock to access to reserved objects, so if we have one memory
pool per one CPU then it would be serialized.

--
Vlad Rezki
