Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0384C3BAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbfFJR0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 13:26:23 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40090 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbfFJR0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:26:19 -0400
Received: by mail-vs1-f67.google.com with SMTP id a186so4019797vsd.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSkPLH9vDolbJlk5XvbY4CtX+5a/+fS/moYDl/wZCzc=;
        b=X3Tymq+lxR/tOVHDBtZz1webVwVCP2s2oH0yXtVQRx3F32sM/CMH9jfTJyOBuymJKm
         AbMh0J4rg6ag0Vr4a6szOR3XFKbXYEsuf2pDjpqlniCE88NG1+QgtA+I4bUYf20y6G5j
         qbmJ5YPzUYXwPkWRulV6e89Bz7Yi1Tac77kreGT6csAXiPEOiieFiFQIazrLMFSy6nkR
         os18qdAJHoUPec7y2vIYdi37NRolbTVYeS8VJKE9CK5NgF0+axbk/jMZYOoulIbJ90sY
         M840savZid7ZE8+ALK7/oDvvu4+jmXF3g66cBYskWNvrubs9qRXg+eJjoCiWfwQz2O5u
         SlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSkPLH9vDolbJlk5XvbY4CtX+5a/+fS/moYDl/wZCzc=;
        b=NjnfLAPjnUJjlzkDGFAATouXKapz7ryPFarhUw5OceiD4yWCEN5OSpesTpeTQ/R3wG
         EQb4QSJNRKSXhjKruiy12fhEeloaUhYeTfFo3HzlGvGS1JzUos0WEOndBS+hJH6Lhjgu
         dbDAIfHxOHPamqm2xshNrktcQxXXrO5QO8MUXO9uZzB+t17PwHRmCGpe7Grq89MLvok7
         wrj99XRgiIiLGT6wtkPl05JTDNcaK6fZYodp7SJ59/+TXVNhJ/57Le2ovM7BZ8FDwxcW
         j36qttUJDJEWjuzAk2ZsCLt7Iqao/e/0U9udiOyWHH7idxUTK4sg/kQXihyFI72x+1Jp
         /sPQ==
X-Gm-Message-State: APjAAAUR3ySU0BL1aiJJopxKC7LiapPBiSqM2N4T1Nd/g98BXr9xHeM1
        kravgCHKQZrWKPFiyaKfqNbfzA==
X-Google-Smtp-Source: APXvYqzCcBGzDjZnnnKYmBeaeDQFD2Zt4lSSiUrvfHl8DQYI4Et3/NEeN/1OKaheEtva1osez+Nw7w==
X-Received: by 2002:a67:8712:: with SMTP id j18mr28306727vsd.4.1560187578484;
        Mon, 10 Jun 2019 10:26:18 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d78sm4039758vke.41.2019.06.10.10.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 10:26:17 -0700 (PDT)
Message-ID: <1560187575.6132.70.camel@lca.pw>
Subject: Re: [PATCH -next] arm64/mm: fix a bogus GFP flag in pgd_alloc()
From:   Qian Cai <cai@lca.pw>
To:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     rppt@linux.ibm.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, linux-mm@kvack.org, vdavydov.dev@gmail.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 10 Jun 2019 13:26:15 -0400
In-Reply-To: <20190610114326.GF15979@fuggles.cambridge.arm.com>
References: <1559656836-24940-1-git-send-email-cai@lca.pw>
         <20190604142338.GC24467@lakrids.cambridge.arm.com>
         <20190610114326.GF15979@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-10 at 12:43 +0100, Will Deacon wrote:
> On Tue, Jun 04, 2019 at 03:23:38PM +0100, Mark Rutland wrote:
> > On Tue, Jun 04, 2019 at 10:00:36AM -0400, Qian Cai wrote:
> > > The commit "arm64: switch to generic version of pte allocation"
> > > introduced endless failures during boot like,
> > > 
> > > kobject_add_internal failed for pgd_cache(285:chronyd.service) (error:
> > > -2 parent: cgroup)
> > > 
> > > It turns out __GFP_ACCOUNT is passed to kernel page table allocations
> > > and then later memcg finds out those don't belong to any cgroup.
> > 
> > Mike, I understood from [1] that this wasn't expected to be a problem,
> > as the accounting should bypass kernel threads.
> > 
> > Was that assumption wrong, or is something different happening here?
> > 
> > > 
> > > backtrace:
> > >   kobject_add_internal
> > >   kobject_init_and_add
> > >   sysfs_slab_add+0x1a8
> > >   __kmem_cache_create
> > >   create_cache
> > >   memcg_create_kmem_cache
> > >   memcg_kmem_cache_create_func
> > >   process_one_work
> > >   worker_thread
> > >   kthread
> > > 
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > >  arch/arm64/mm/pgd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> > > index 769516cb6677..53c48f5c8765 100644
> > > --- a/arch/arm64/mm/pgd.c
> > > +++ b/arch/arm64/mm/pgd.c
> > > @@ -38,7 +38,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> > >  	if (PGD_SIZE == PAGE_SIZE)
> > >  		return (pgd_t *)__get_free_page(gfp);
> > >  	else
> > > -		return kmem_cache_alloc(pgd_cache, gfp);
> > > +		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_KERNEL);
> > 
> > This is used to allocate PGDs for both user and kernel pagetables (e.g.
> > for the efi runtime services), so while this may fix the regression, I'm
> > not sure it's the right fix.
> > 
> > Do we need a separate pgd_alloc_kernel()?
> 
> So can I take the above for -rc5, or is somebody else working on a different
> fix to implement pgd_alloc_kernel()?

The offensive commit "arm64: switch to generic version of pte allocation" is not
yet in the mainline, but only in the Andrew's tree and linux-next, and I doubt
Andrew will push this out any time sooner given it is broken.
