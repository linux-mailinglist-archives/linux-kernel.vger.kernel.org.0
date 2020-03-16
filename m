Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9704D1872CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 19:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbgCPSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 14:55:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45615 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbgCPSz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:55:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id e18so19945473ljn.12;
        Mon, 16 Mar 2020 11:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2VuFMwbSu/LOip+pf/0EM/ytgjmPQBGyBHk/pyoOkUA=;
        b=IifTKMxZknDHUK/wXsvyDcVUO8YIi2r71zftzFwWNNYT2cu8VZ/d9cOgEkjdyTlQWc
         6o7+S8DsgTWWxkx/ZdQ7XliNJgaBeeyAm2y8QKR8oidVPZsd/lMe0rvEwqrq/g/wpNPR
         MS1FYrns0qFXlBwiWgaV5ZwiswYHnPolGRWa3x3Qp3l/NiyUI5GuKsgR8SHgjyLeCkx0
         bQGLwD+89HtxO+9EYnfUtHBc4f4PIzxp2f/8ZZH1iTv4ZYwzbr4zoY5rLZeI88KaFE80
         ciQ3bLjJ2M3/WA2UTG2hnI9MwF630A3yv2YGw5HRseiAhZOCv3IUb6COSi1hQwjuaUCR
         ia/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2VuFMwbSu/LOip+pf/0EM/ytgjmPQBGyBHk/pyoOkUA=;
        b=DL+GtIH2jsVQvEfaqyCGNu8WbHYLDEg/xAOxqizz0rbyfJgDqxAQXMtnlsv8WAYDkZ
         4/UNUolUTF9TVbqFp/OEqGixiHs9o3HJIVghHgfWl3bnwSOU/4IZuDFUWwur2CIch7jL
         3H2D6QfSnP2i9ZECyYUAo+tfDKzK9L6bHPLvsyKclPmGaDGueUcF/Yj9tdyGkhLF/UDs
         ek4X5+zp2a1/SH0DmpXfceXMqsO4N9ZoQ3EIkr8mQcRyHUB359PsbJH2CdIFA+enZ/Mv
         fwBGMSEYhgwO6yl1kX/x8aK0yA0Y7lORtPGPUY8uBCf1B8tVxCTuD2FqqQGeuxjjEQhi
         YiQg==
X-Gm-Message-State: ANhLgQ0HDY3h5dT6iF6n2mtq5Cst5iBS3UWNzrOg/OQOi78dpUEzgYy9
        o5TbOYsn/eLJSQ3Tprv5OEU=
X-Google-Smtp-Source: ADFU+vtxsaKYbIwfkrxB8obYCaCNAhJ/raX2AWSS3ZHkuh1FwL8E3jiBT0ZDGu6QXp8+4QTyAcupEQ==
X-Received: by 2002:a2e:a0cd:: with SMTP id f13mr429032ljm.198.1584384926427;
        Mon, 16 Mar 2020 11:55:26 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id q4sm621656lfp.18.2020.03.16.11.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 11:55:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 16 Mar 2020 19:55:19 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 2/6] rcu: introduce kvfree_rcu() interface
Message-ID: <20200316185519.GA10577@pc636>
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-3-urezki@gmail.com>
 <20200316154539.GE190951@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316154539.GE190951@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 11:45:39AM -0400, Joel Fernandes wrote:
> On Sun, Mar 15, 2020 at 07:18:36PM +0100, Uladzislau Rezki (Sony) wrote:
> > kvfree_rcu() can deal with an allocated memory that is obtained
> > via kvmalloc(). It can return two types of allocated memory or
> > "pointers", one can belong to regular SLAB allocator and another
> > one can be vmalloc one. It depends on requested size and memory
> > pressure.
> > 
> > Based on that, two streams are split, thus if a pointer belongs
> > to vmalloc allocator it is queued to the list, otherwise SLAB
> > one is queued into "bulk array" for further processing.
> > 
> > The main reason of such splitting is:
> >     a) to distinguish kmalloc()/vmalloc() ptrs;
> >     b) there is no vmalloc_bulk() interface.
> > 
> > As of now we have list_lru.c user that needs such interface,
> > also there will be new comers. Apart of that it is preparation
> > to have a head-less variant later.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/linux/rcupdate.h |  9 +++++++++
> >  kernel/rcu/tiny.c        |  3 ++-
> >  kernel/rcu/tree.c        | 17 ++++++++++++-----
> >  3 files changed, 23 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 2be97a83f266..bb270221dbdc 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -845,6 +845,15 @@ do {									\
> >  		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
> >  } while (0)
> >  
> > +/**
> > + * kvfree_rcu() - kvfree an object after a grace period.
> > + * @ptr:	pointer to kvfree
> > + * @rhf:	the name of the struct rcu_head within the type of @ptr.
> > + *
> > + * Same as kfree_rcu(), just simple alias.
> > + */
> > +#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
> > +
> >  /*
> >   * Place this after a lock-acquisition primitive to guarantee that
> >   * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
> > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > index dd572ce7c747..4b99f7b88bee 100644
> > --- a/kernel/rcu/tiny.c
> > +++ b/kernel/rcu/tiny.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/cpu.h>
> >  #include <linux/prefetch.h>
> >  #include <linux/slab.h>
> > +#include <linux/mm.h>
> >  
> >  #include "rcu.h"
> >  
> > @@ -86,7 +87,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
> >  	rcu_lock_acquire(&rcu_callback_map);
> >  	if (__is_kfree_rcu_offset(offset)) {
> >  		trace_rcu_invoke_kfree_callback("", head, offset);
> > -		kfree((void *)head - offset);
> > +		kvfree((void *)head - offset);
> >  		rcu_lock_release(&rcu_callback_map);
> >  		return true;
> >  	}
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 2f4c91a3713a..1c0a73616872 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2899,9 +2899,9 @@ static void kfree_rcu_work(struct work_struct *work)
> >  	}
> >  
> >  	/*
> > -	 * Emergency case only. It can happen under low memory
> > -	 * condition when an allocation gets failed, so the "bulk"
> > -	 * path can not be temporary maintained.
> > +	 * vmalloc() pointers end up here also emergency case. It can
> 
> Suggest rephrase for clarity:
> 
> nit: We can end up here either with 1) vmalloc() pointers or 2) low on memory
> and could not allocate a bulk array.
> 
Let's go with your suggestion. I see that you took patches to your tree.
Could you please update it on your own? Otherwise i can send out V2, so
please let me know.

Thanks for the comments!

--
Vlad Rezki
