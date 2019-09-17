Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0045B4F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 15:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfIQNkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 09:40:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34924 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfIQNkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:40:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15so4448929qtq.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q2t22cvAHte1ch8tj9lxq14REfgJnpMH2IQOWoISxZk=;
        b=mf3ylWv/P6KKZLCmcDbvPDClWNE/yl8qC43ao/9coxSAnnpECS5gdQYATZ9ERdVNkB
         OL9mHdvCjmD9rGlwANsJBNE/jw2OzUoUb7qV/fKDihddwKuKM26xSdlNHtop8eImzCyl
         G6PepKApbQ49kcSkiWCsKs9i9wCgpwb5Wr6HmfmtdnTNL9l0Is7gR1vAnZOh6L7Zl6Vm
         21973yXAlXWUmsEscaUdyc116p1CaPqquPXgNHAwxjX4fKkgqAY+hhjJaK4A8Ehv2G+K
         HGfhabv1vu7ynxaRSu25/vJm7jRaTvhJmfJl490tK+iFsWZjIYVTO3oSgkmKqBrxdmrc
         FP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2t22cvAHte1ch8tj9lxq14REfgJnpMH2IQOWoISxZk=;
        b=HUl9xSGeShFhznonxgyPt163SHRcKoSF7db5Os1CYtCsikt82ScBgeswrsuT+q+DLk
         HsgIoPM3olvCNH3UrxqHqai0TDbkzlu/KuivMRhxIdSqO8YNw/NQ1az9/kzEPrIFm2TD
         //H1WXI9rsJZQ5kRhm0E25dBID8UgmcoUh62WZTBRxttxYNKAETkMFvWVQWzNlhudPTy
         mzyu169zsoXrSVQiEurArAQLUUi/OmuCLHVDtC1TONZIFoVKRN6/Am9e3WeUWn14wImM
         MKAkGuzoq5jt3EQC0VkOwA2AMt3md0Mxb2Vrm89OW6uG3QhrGMZrTMgasZXXLKWhkuxB
         vxkA==
X-Gm-Message-State: APjAAAV5Pl2XvXxwVrg2pJs/050P1kfLdBZNIlqoBGoPSYGA1NuM/7Dt
        J2kABQRirdrvG/mY/VTNb3EqkA==
X-Google-Smtp-Source: APXvYqxxE1JteTH87odhllssonVdekVi7hpPC+xb0XTDUBCG6B+wXwcAmYOqAGEvGpKicctPFHY+rg==
X-Received: by 2002:ac8:75cd:: with SMTP id z13mr3591864qtq.87.1568727603712;
        Tue, 17 Sep 2019 06:40:03 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 131sm1141820qkg.1.2019.09.17.06.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:40:03 -0700 (PDT)
Message-ID: <1568727601.5576.160.camel@lca.pw>
Subject: Re: [RFC PATCH] mm/slub: remove left-over debugging code
From:   Qian Cai <cai@lca.pw>
To:     David Rientjes <rientjes@google.com>,
        Pengfei Li <lpf.vector@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 17 Sep 2019 09:40:01 -0400
In-Reply-To: <alpine.DEB.2.21.1909161128480.105847@chino.kir.corp.google.com>
References: <1568650294-8579-1-git-send-email-cai@lca.pw>
         <alpine.DEB.2.21.1909161128480.105847@chino.kir.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-16 at 11:32 -0700, David Rientjes wrote:
> On Mon, 16 Sep 2019, Qian Cai wrote:
> 
> > SLUB_RESILIENCY_TEST and SLUB_DEBUG_CMPXCHG look like some left-over
> > debugging code during the internal development that probably nobody uses
> > it anymore. Remove them to make the world greener.
> 
> Adding Pengfei Li who has been working on a patchset for modified handling 
> of kmalloc cache initialization and touches the resiliency test.
> 
> I still find the resiliency test to be helpful/instructional for handling 
> unexpected conditions in these caches, so I'd suggest against removing it: 
> the only downside is that it's additional source code.  But it's helpful 
> source code for reference.
> 
> The cmpxchg failures could likely be more generalized beyond SLUB since 
> there will be other dependencies in the kernel than just this allocator.

OK, SLUB_RESILIENCY_TEST is fine to keep around and maybe be turned into a
Kconfig option to make it more visible.

Is it fine to remove SLUB_DEBUG_CMPXCHG? If somebody later want to generalize it
beyond SLUB, he/she can always find the old code somewhere anyway.

> 
> (I assume you didn't send a Signed-off-by line because this is an RFC.)
> 
> > ---
> >  mm/slub.c | 110 --------------------------------------------------------------
> >  1 file changed, 110 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 8834563cdb4b..f97155ba097d 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -150,12 +150,6 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
> >   * - Variable sizing of the per node arrays
> >   */
> >  
> > -/* Enable to test recovery from slab corruption on boot */
> > -#undef SLUB_RESILIENCY_TEST
> > -
> > -/* Enable to log cmpxchg failures */
> > -#undef SLUB_DEBUG_CMPXCHG
> > -
> >  /*
> >   * Mininum number of partial slabs. These will be left on the partial
> >   * lists even if they are empty. kmem_cache_shrink may reclaim them.
> > @@ -392,10 +386,6 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page
> >  	cpu_relax();
> >  	stat(s, CMPXCHG_DOUBLE_FAIL);
> >  
> > -#ifdef SLUB_DEBUG_CMPXCHG
> > -	pr_info("%s %s: cmpxchg double redo ", n, s->name);
> > -#endif
> > -
> >  	return false;
> >  }
> >  
> > @@ -433,10 +423,6 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
> >  	cpu_relax();
> >  	stat(s, CMPXCHG_DOUBLE_FAIL);
> >  
> > -#ifdef SLUB_DEBUG_CMPXCHG
> > -	pr_info("%s %s: cmpxchg double redo ", n, s->name);
> > -#endif
> > -
> >  	return false;
> >  }
> >  
> > @@ -2004,45 +1990,11 @@ static inline unsigned long next_tid(unsigned long tid)
> >  	return tid + TID_STEP;
> >  }
> >  
> > -static inline unsigned int tid_to_cpu(unsigned long tid)
> > -{
> > -	return tid % TID_STEP;
> > -}
> > -
> > -static inline unsigned long tid_to_event(unsigned long tid)
> > -{
> > -	return tid / TID_STEP;
> > -}
> > -
> >  static inline unsigned int init_tid(int cpu)
> >  {
> >  	return cpu;
> >  }
> >  
> > -static inline void note_cmpxchg_failure(const char *n,
> > -		const struct kmem_cache *s, unsigned long tid)
> > -{
> > -#ifdef SLUB_DEBUG_CMPXCHG
> > -	unsigned long actual_tid = __this_cpu_read(s->cpu_slab->tid);
> > -
> > -	pr_info("%s %s: cmpxchg redo ", n, s->name);
> > -
> > -#ifdef CONFIG_PREEMPT
> > -	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
> > -		pr_warn("due to cpu change %d -> %d\n",
> > -			tid_to_cpu(tid), tid_to_cpu(actual_tid));
> > -	else
> > -#endif
> > -	if (tid_to_event(tid) != tid_to_event(actual_tid))
> > -		pr_warn("due to cpu running other code. Event %ld->%ld\n",
> > -			tid_to_event(tid), tid_to_event(actual_tid));
> > -	else
> > -		pr_warn("for unknown reason: actual=%lx was=%lx target=%lx\n",
> > -			actual_tid, tid, next_tid(tid));
> > -#endif
> > -	stat(s, CMPXCHG_DOUBLE_CPU_FAIL);
> > -}
> > -
> >  static void init_kmem_cache_cpus(struct kmem_cache *s)
> >  {
> >  	int cpu;
> > @@ -2751,7 +2703,6 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
> >  				object, tid,
> >  				next_object, next_tid(tid)))) {
> >  
> > -			note_cmpxchg_failure("slab_alloc", s, tid);
> >  			goto redo;
> >  		}
> >  		prefetch_freepointer(s, next_object);
> > @@ -4694,66 +4645,6 @@ static int list_locations(struct kmem_cache *s, char *buf,
> >  }
> >  #endif	/* CONFIG_SLUB_DEBUG */
> >  
> > -#ifdef SLUB_RESILIENCY_TEST
> > -static void __init resiliency_test(void)
> > -{
> > -	u8 *p;
> > -	int type = KMALLOC_NORMAL;
> > -
> > -	BUILD_BUG_ON(KMALLOC_MIN_SIZE > 16 || KMALLOC_SHIFT_HIGH < 10);
> > -
> > -	pr_err("SLUB resiliency testing\n");
> > -	pr_err("-----------------------\n");
> > -	pr_err("A. Corruption after allocation\n");
> > -
> > -	p = kzalloc(16, GFP_KERNEL);
> > -	p[16] = 0x12;
> > -	pr_err("\n1. kmalloc-16: Clobber Redzone/next pointer 0x12->0x%p\n\n",
> > -	       p + 16);
> > -
> > -	validate_slab_cache(kmalloc_caches[type][4]);
> > -
> > -	/* Hmmm... The next two are dangerous */
> > -	p = kzalloc(32, GFP_KERNEL);
> > -	p[32 + sizeof(void *)] = 0x34;
> > -	pr_err("\n2. kmalloc-32: Clobber next pointer/next slab 0x34 -> -0x%p\n",
> > -	       p);
> > -	pr_err("If allocated object is overwritten then not detectable\n\n");
> > -
> > -	validate_slab_cache(kmalloc_caches[type][5]);
> > -	p = kzalloc(64, GFP_KERNEL);
> > -	p += 64 + (get_cycles() & 0xff) * sizeof(void *);
> > -	*p = 0x56;
> > -	pr_err("\n3. kmalloc-64: corrupting random byte 0x56->0x%p\n",
> > -	       p);
> > -	pr_err("If allocated object is overwritten then not detectable\n\n");
> > -	validate_slab_cache(kmalloc_caches[type][6]);
> > -
> > -	pr_err("\nB. Corruption after free\n");
> > -	p = kzalloc(128, GFP_KERNEL);
> > -	kfree(p);
> > -	*p = 0x78;
> > -	pr_err("1. kmalloc-128: Clobber first word 0x78->0x%p\n\n", p);
> > -	validate_slab_cache(kmalloc_caches[type][7]);
> > -
> > -	p = kzalloc(256, GFP_KERNEL);
> > -	kfree(p);
> > -	p[50] = 0x9a;
> > -	pr_err("\n2. kmalloc-256: Clobber 50th byte 0x9a->0x%p\n\n", p);
> > -	validate_slab_cache(kmalloc_caches[type][8]);
> > -
> > -	p = kzalloc(512, GFP_KERNEL);
> > -	kfree(p);
> > -	p[512] = 0xab;
> > -	pr_err("\n3. kmalloc-512: Clobber redzone 0xab->0x%p\n\n", p);
> > -	validate_slab_cache(kmalloc_caches[type][9]);
> > -}
> > -#else
> > -#ifdef CONFIG_SYSFS
> > -static void resiliency_test(void) {};
> > -#endif
> > -#endif	/* SLUB_RESILIENCY_TEST */
> > -
> >  #ifdef CONFIG_SYSFS
> >  enum slab_stat_type {
> >  	SL_ALL,			/* All slabs */
> > @@ -5875,7 +5766,6 @@ static int __init slab_sysfs_init(void)
> >  	}
> >  
> >  	mutex_unlock(&slab_mutex);
> > -	resiliency_test();
> >  	return 0;
> >  }
> >  
> > -- 
> > 1.8.3.1
> > 
> > 
