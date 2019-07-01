Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9737A273F3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 03:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfEWBZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 21:25:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37598 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWBZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:25:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id o7so4860691qtp.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 18:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=njdxTCx9sHvhXBO8qYKeyjDfTv940qYZZaxw6PV/Gjw=;
        b=A31akJabwD8jMvChoq1F+vzlkyFJQns+BUWI5y0dyb4297Y7+4TZXwIL4TkDMZALfk
         pelhH2UrRwgU8c8URxGEBM/Ssa807LfSfVxhMs1F2nVxyJIHt+jxjrH+6iMFyg+ExzvR
         kYeAGyDLcyFf+jj2ZNQnqsxfGGapaYfyE2Bv6O3dBnNZNGnLpU+Q6lHW68yKSyPsmyfq
         XmD4VsQqfgEgK3f16MLpU74f2RS/yBxlKKivRNXZHsrnCw+PQkVUfa98C/X/bhygkFKu
         e/eyIYKNA7Rfnw3JG9pdogOLyaaxeiowstkABr2tdpfRbA+MweHxdOL3t7Fbl/do/8Av
         DD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=njdxTCx9sHvhXBO8qYKeyjDfTv940qYZZaxw6PV/Gjw=;
        b=tiifiWVzz3SzDzwstwwBf5VxKZF/i31l/iQrLSNvbShuaBV53WscB/7+m5IgOrAo/e
         GGXjTzwf2Je/t2DmIosT1waG8wgdj+y46Hue+6/4bxDPBcTGBIkr8LVB/OlD6iPQieTj
         i7eIe9NI84d6meNeYLbV3VfCEWbG1B1Om8QGlarbi7r6ARc+8Mj2weo2Jdbj7zhOWrRQ
         MNvjQ8A2gZdXuTPwaZTXSJDUHoEWpJsEewnoDDeyqs2dP9EwyvLEUwjWlduNGVtlGXZf
         6FW+0h2D4WeRcXTneG0c4eWi/G2i3iNn47UD5vg4lbcIuDG0iY5cMOlC/GqPL0VmO7Fe
         nf5g==
X-Gm-Message-State: APjAAAXT8kYw4TtxOIR+0gNE/cR6uQd0yYch3eL/fS9JWhmvwceHNWn1
        qxpP36pJUPPOYvprE5/u7o53nQ==
X-Google-Smtp-Source: APXvYqxzRJZnFxB3o/XVhavs5ooWPlIn4ae89mU6L1KTlFuGrn+5W96SJdziwkgg1ieGMsYD9R2/nw==
X-Received: by 2002:aed:3fc3:: with SMTP id w3mr31505876qth.168.1558574705305;
        Wed, 22 May 2019 18:25:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id f21sm11229434qkl.72.2019.05.22.18.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 18:25:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTcTg-0002i5-9H; Wed, 22 May 2019 22:25:04 -0300
Date:   Wed, 22 May 2019 22:25:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/5] mm/hmm: Fix mm stale reference use in hmm_free()
Message-ID: <20190523012504.GG15389@ziepe.ca>
References: <20190506233514.12795-1-rcampbell@nvidia.com>
 <20190522233628.GA16137@ziepe.ca>
 <2938d2da-424d-786e-5486-1e4fa9f58425@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2938d2da-424d-786e-5486-1e4fa9f58425@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 05:54:17PM -0700, Ralph Campbell wrote:
> 
> On 5/22/19 4:36 PM, Jason Gunthorpe wrote:
> > On Mon, May 06, 2019 at 04:35:14PM -0700, rcampbell@nvidia.com wrote:
> > > From: Ralph Campbell <rcampbell@nvidia.com>
> > > 
> > > The last reference to struct hmm may be released long after the mm_struct
> > > is destroyed because the struct hmm_mirror memory may be part of a
> > > device driver open file private data pointer. The file descriptor close
> > > is usually after the mm_struct is destroyed in do_exit(). This is a good
> > > reason for making struct hmm a kref_t object [1] since its lifetime spans
> > > the life time of mm_struct and struct hmm_mirror.
> > 
> > > The fix is to not use hmm->mm in hmm_free() and to clear mm->hmm and
> > > hmm->mm pointers in hmm_destroy() when the mm_struct is
> > > destroyed.
> > 
> > I think the right way to fix this is to have the struct hmm hold a
> > mmgrab() on the mm so its memory cannot go away until all of the hmm
> > users release the struct hmm, hmm_ranges/etc
> > 
> > Then we can properly use mmget_not_zero() instead of the racy/abnormal
> > 'if (hmm->xmm == NULL || hmm->dead)' pattern (see the other
> > thread). Actually looking at this, all these tests look very
> > questionable. If we hold the mmget() for the duration of the range
> > object, as Jerome suggested, then they all get deleted.
> > 
> > That just leaves mmu_notifier_unregister_no_relase() as the remaining
> > user of hmm->mm (everyone else is trying to do range->mm) - and it
> > looks like it currently tries to call
> > mmu_notifier_unregister_no_release on a NULL hmm->mm and crashes :(
> > 
> > Holding the mmgrab fixes this as we can safely call
> > mmu_notifier_unregister_no_relase() post exit_mmap on a grab'd mm.
> > 
> > Also we can delete the hmm_mm_destroy() intrustion into fork.c as it
> > can't be called when the mmgrab is active.
> > 
> > This is the basic pattern we used in ODP when working with mmu
> > notifiers, I don't know why hmm would need to be different.
> > 
> > > index 2aa75dbed04a..4e42c282d334 100644
> > > +++ b/mm/hmm.c
> > > @@ -43,8 +43,10 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
> > >   {
> > >   	struct hmm *hmm = READ_ONCE(mm->hmm);
> > > -	if (hmm && kref_get_unless_zero(&hmm->kref))
> > > +	if (hmm && !hmm->dead) {
> > > +		kref_get(&hmm->kref);
> > >   		return hmm;
> > > +	}
> > 
> > hmm->dead and mm->hmm are not being read under lock, so this went from
> > something almost thread safe to something racy :(
> > 
> > > @@ -53,25 +55,28 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
> > >    * hmm_get_or_create - register HMM against an mm (HMM internal)
> > >    *
> > >    * @mm: mm struct to attach to
> > > - * Returns: returns an HMM object, either by referencing the existing
> > > - *          (per-process) object, or by creating a new one.
> > > + * Return: an HMM object reference, either by referencing the existing
> > > + *         (per-process) object, or by creating a new one.
> > >    *
> > > - * This is not intended to be used directly by device drivers. If mm already
> > > - * has an HMM struct then it get a reference on it and returns it. Otherwise
> > > - * it allocates an HMM struct, initializes it, associate it with the mm and
> > > - * returns it.
> > > + * If the mm already has an HMM struct then return a new reference to it.
> > > + * Otherwise, allocate an HMM struct, initialize it, associate it with the mm,
> > > + * and return a new reference to it. If the return value is not NULL,
> > > + * the caller is responsible for calling hmm_put().
> > >    */
> > >   static struct hmm *hmm_get_or_create(struct mm_struct *mm)
> > >   {
> > > -	struct hmm *hmm = mm_get_hmm(mm);
> > > -	bool cleanup = false;
> > > +	struct hmm *hmm = mm->hmm;
> > > -	if (hmm)
> > > -		return hmm;
> > > +	if (hmm) {
> > > +		if (hmm->dead)
> > > +			goto error;
> > 
> > Create shouldn't fail just because it is racing with something doing
> > destroy
> > 
> > The flow should be something like:
> > 
> > spin_lock(&mm->page_table_lock); // or write side mmap_sem if you prefer
> > if (mm->hmm)
> >     if (kref_get_unless_zero(mm->hmm))
> >          return mm->hmm;
> >     mm->hmm = NULL
> > 
> > 
> > > +		goto out;
> > > +	}
> > >   	hmm = kmalloc(sizeof(*hmm), GFP_KERNEL);
> > >   	if (!hmm)
> > > -		return NULL;
> > > +		goto error;
> > > +
> > >   	init_waitqueue_head(&hmm->wq);
> > >   	INIT_LIST_HEAD(&hmm->mirrors);
> > >   	init_rwsem(&hmm->mirrors_sem);
> > > @@ -83,47 +88,32 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
> > >   	hmm->dead = false;
> > >   	hmm->mm = mm;
> > > -	spin_lock(&mm->page_table_lock);
> > > -	if (!mm->hmm)
> > > -		mm->hmm = hmm;
> > > -	else
> > > -		cleanup = true;
> > > -	spin_unlock(&mm->page_table_lock);
> > 
> > BTW, Jerome this needs fixing too, it shouldn't fail the function just
> > because it lost the race.
> > 
> > More like
> > 
> > spin_lock(&mm->page_table_lock);
> > if (mm->hmm)
> >     if (kref_get_unless_zero(mm->hmm)) {
> >          kfree(hmm);
> >          return mm->hmm;
> >     }
> > mm->hmm = hmm
> > 
> > > -	if (cleanup)
> > > -		goto error;
> > > -
> > >   	/*
> > > -	 * We should only get here if hold the mmap_sem in write mode ie on
> > > -	 * registration of first mirror through hmm_mirror_register()
> > > +	 * The mmap_sem should be held for write so no additional locking
> > 
> > Please let us have proper lockdep assertions for this kind of stuff.
> > 
> > > +	 * is needed. Note that struct_mm holds a reference to hmm.
> > > +	 * It is cleared in hmm_release().
> > >   	 */
> > > +	mm->hmm = hmm;
> > 
> > Actually using the write side the mmap_sem seems sort of same if it is
> > assured the write side is always held for this call..
> > 
> > 
> > Hmm, there is a race with hmm_destroy touching mm->hmm that does
> > hold the write lock.
> > 
> > > +
> > >   	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
> > >   	if (__mmu_notifier_register(&hmm->mmu_notifier, mm))
> > >   		goto error_mm;
> > 
> > And the error unwind here is problematic as it should do
> > kref_put. Actually after my patch to use container_of this
> > mmu_notifier_register should go before the mm->hmm = hmm to avoid
> > having to do the sketchy error unwind at all.
> > 
> > > +out:
> > > +	/* Return a separate hmm reference for the caller. */
> > > +	kref_get(&hmm->kref);
> > >   	return hmm;
> > >   error_mm:
> > > -	spin_lock(&mm->page_table_lock);
> > > -	if (mm->hmm == hmm)
> > > -		mm->hmm = NULL;
> > > -	spin_unlock(&mm->page_table_lock);
> > > -error:
> > > +	mm->hmm = NULL;
> > >   	kfree(hmm);
> > > +error:
> > >   	return NULL;
> > >   }
> > >   static void hmm_free(struct kref *kref)
> > >   {
> > >   	struct hmm *hmm = container_of(kref, struct hmm, kref);
> > > -	struct mm_struct *mm = hmm->mm;
> > > -
> > > -	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
> > 
> > Where did the unregister go?
> > 
> > > -
> > > -	spin_lock(&mm->page_table_lock);
> > > -	if (mm->hmm == hmm)
> > > -		mm->hmm = NULL;
> > > -	spin_unlock(&mm->page_table_lock);
> > 
> > Well, we still need to NULL mm->hmm if the hmm was put before the mm
> > is destroyed.
> > 
> > >   	kfree(hmm);
> > >   }
> > > @@ -135,25 +125,18 @@ static inline void hmm_put(struct hmm *hmm)
> > >   void hmm_mm_destroy(struct mm_struct *mm)
> > >   {
> > > -	struct hmm *hmm;
> > > +	struct hmm *hmm = mm->hmm;
> > > -	spin_lock(&mm->page_table_lock);
> > > -	hmm = mm_get_hmm(mm);
> > > -	mm->hmm = NULL;
> > >   	if (hmm) {
> > > +		mm->hmm = NULL;
> > 
> > At this point The kref on mm is 0, so any other thread reading mm->hmm
> > has a use-after-free bug. Not much point in doing this assignment , it
> > is just confusing.
> > 
> > >   		hmm->mm = NULL;
> > > -		hmm->dead = true;
> > > -		spin_unlock(&mm->page_table_lock);
> > >   		hmm_put(hmm);
> > > -		return;
> > >   	}
> > > -
> > > -	spin_unlock(&mm->page_table_lock);
> > >   }
> > >   static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> > >   {
> > > -	struct hmm *hmm = mm_get_hmm(mm);
> > > +	struct hmm *hmm = mm->hmm;
> > 
> > container_of is much safer/better
> > 
> > > @@ -931,20 +909,14 @@ int hmm_range_register(struct hmm_range *range,
> > >   		return -EINVAL;
> > >   	if (start >= end)
> > >   		return -EINVAL;
> > > +	hmm = mm_get_hmm(mm);
> > > +	if (!hmm)
> > > +		return -EFAULT;
> > >   	range->page_shift = page_shift;
> > >   	range->start = start;
> > >   	range->end = end;
> > > -
> > > -	range->hmm = mm_get_hmm(mm);
> > > -	if (!range->hmm)
> > > -		return -EFAULT;
> > > -
> > > -	/* Check if hmm_mm_destroy() was call. */
> > > -	if (range->hmm->mm == NULL || range->hmm->dead) {
> > 
> > This comment looks bogus too, we can't race with hmm_mm_destroy as the
> > caller MUST have a mmgrab or mmget on the mm already to call this API
> > - ie can't be destroyed.
> > 
> > As discussed in the other thread this should probably be
> > mmget_not_zero.
> > 
> > Jason
> 
> I think you missed the main points which are:

Well, I covered a lot of points in the above, I only suggested the
reverse refcount in the initial block. All the other notes basically
still apply no matter which way the refcount goes.
 
> 1) mm->hmm holds a reference to struct hmm so hmm isn't going away until
>    __mmdrop() is called. hmm->mm is not a reference to mm,
>   just a "backward" pointer.

But this wasn't done completely. If the hmm is created once and lives
until exit_mmap then there is no need for any of the refcounting,
hmm->dead, etc.

The refcounting is all moved to the mm via mmgrab/mmget and all the
places that were doing refcount/dead, etc need to switch to those mm
APIs instead.

In many senses this would be simpler, as we don't have the weird mess
of a hmm coming and going concurrently on the same mm, but I think the
patch needs to do a complete change over (delete the kref, delete
dead, delete the 'null mm/hmm' idea, and document what mmget/grab
every caller must be holding) before we can see what it would look
like.

This design would also solve the srcu race I pointed out.

>   Trying to make struct hmm hold a *reference* to mm seems wrong to me.

Well, this is a fairly standard direction, the caller of
hmm_mirror_register()/hmm_mirror_unregister() should reasonably expect
that hmm or the mm will not going away during the registered period.

What this patch is trying to do is to say that the caller must hold a
mmgrab for the duration of registration, for the sole benefit of
HMM. This seems like it is breaking the encapsulation of the API.

Arugably I would like to remove the mmgrab detail from the ODP code
and just establish a hmm_mirror as enough to guarentee the mm, hmm,
etc is valid memory until the ODP is cleaned up. 

> 2) mm->hmm is only set with mm->mmap_sem held for write.
>    mm->hmm is only cleared when __mmdrop() is called.
>    hmm->mm is only cleared when __mmdrop() is called so it is long after the
> call to hmm_release().

Then we don't need any refcounting on struct hmm, all the refcounting
falls to mmgrab/mmget instead..

> 3) The mmu notifier unregister happens only as part of exit_mmap().

> The hmm->dead and hmm->mm == NULL checks are more for sanity
> checking

It is all a use-after free - and it is just confusing what the
lifetime is supposed to be, should all be deleted.

In this approach all the tests for !mm->hmm should either lockdep
assert that the mm_sem write side is held or use mmgrab_not_zero &&
VM_BUG_ON instead (having previously established somehow that the hmm
was created already).

The test !hmm->mm should never exist. If the hmm object is valid
memory then the mm object *MUST* also be valid memory.

> since hmm_mirror_register() shouldn't be called without holding mmap_sem.
> A VM_WARN or other check makes sense like you said.

Stuff like this really should be documented as a lockdep assertion..

Jason
