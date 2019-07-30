Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF0B07A336
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 10:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfG3Iix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 04:38:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43670 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbfG3Iix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:38:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id r22so2080456pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=xAWml8zHr+RR4WtcfJXF5qLyW4vcoY8hdC2IB6AOcOc=;
        b=fBVA+CF5JEE+effJV4K3mQ0bjdRf0WrTxicmyOKsFjrrZqG78elCDi+wOBnBnXbWx4
         ym1k2k4QFEQUs+2gBa3CJ8E3EZlJB6wKi6b2qJAHGQoVrmG3TXgEof609/nKFxHb+7dJ
         eMDWK3XSTFbb8nqVxKtVIsKD6qfgbXSrkfehk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xAWml8zHr+RR4WtcfJXF5qLyW4vcoY8hdC2IB6AOcOc=;
        b=C1gVHHCWCN0d36HgA+8aGPPbWP2yHMGhulwH4nkP7GjwdS1IMndqycg/6y78NcJHsp
         YsSg3fE8JR8bqqFV6zIvcT7oKm2XyVoKTGBlgjH3KHZgCo5NFg8U7DmaVIhQY0sIjRTU
         Q18Q5fIMJ+83TOhRzwRbZ2+HWrKsZGVpIphgm5BXZmzteBAIbVHP3pOgkNkZVOOusNOi
         6k5ZW9Akj0JMlrkzhZFj1V0ov+qhyH/pxRFaL02MgOmTnaBhNBGG6suxOpFTbywWnHod
         K/wTZLhWyHJpRFdtHFb9i+7qzdwD5Z9M7409S3TeQe2GEfIxfEm0U8A4Re69k8hvrSC3
         KGQQ==
X-Gm-Message-State: APjAAAXs072cdaHWiiULGLA5a3oi1sATDpOF0ueecmBVA2Fa3MK1QqSz
        zHYK0Hckt1oOs6+K2a+1Cct67+pw
X-Google-Smtp-Source: APXvYqwSLszFoXT/40dnLzTLf7YGDHfpuGGatDiw5WyLEl3Fheu3QtT1c4tQCU0jbRE9fZcIOn3FmQ==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr117904140pja.104.1564475932272;
        Tue, 30 Jul 2019 01:38:52 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id q126sm70680998pfq.123.2019.07.30.01.38.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 01:38:51 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Subject: Re: [PATCH v2 1/3] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <20190729154426.GA51922@lakrids.cambridge.arm.com>
References: <20190729142108.23343-1-dja@axtens.net> <20190729142108.23343-2-dja@axtens.net> <20190729154426.GA51922@lakrids.cambridge.arm.com>
Date:   Tue, 30 Jul 2019 18:38:47 +1000
Message-ID: <877e7zhq7c.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for your email - I'm very new to mm stuff and the feedback is
very helpful.

>> +#ifndef CONFIG_KASAN_VMALLOC
>>  int kasan_module_alloc(void *addr, size_t size)
>>  {
>>  	void *ret;
>> @@ -603,6 +604,7 @@ void kasan_free_shadow(const struct vm_struct *vm)
>>  	if (vm->flags & VM_KASAN)
>>  		vfree(kasan_mem_to_shadow(vm->addr));
>>  }
>> +#endif
>
> IIUC we can drop MODULE_ALIGN back to PAGE_SIZE in this case, too.

Yes, done.

>>  core_initcall(kasan_memhotplug_init);
>>  #endif
>> +
>> +#ifdef CONFIG_KASAN_VMALLOC
>> +void kasan_cover_vmalloc(unsigned long requested_size, struct vm_struct *area)
>
> Nit: I think it would be more consistent to call this
> kasan_populate_vmalloc().
>

Absolutely. I didn't love the name but just didn't 'click' that populate
would be a better verb.

>> +{
>> +	unsigned long shadow_alloc_start, shadow_alloc_end;
>> +	unsigned long addr;
>> +	unsigned long backing;
>> +	pgd_t *pgdp;
>> +	p4d_t *p4dp;
>> +	pud_t *pudp;
>> +	pmd_t *pmdp;
>> +	pte_t *ptep;
>> +	pte_t backing_pte;
>
> Nit: I think it would be preferable to use 'page' rather than 'backing',
> and 'pte' rather than 'backing_pte', since there's no otehr namespace to
> collide with here. Otherwise, using 'shadow' rather than 'backing' would
> be consistent with the existing kasan code.

Not a problem, done.

>> +	addr = shadow_alloc_start;
>> +	do {
>> +		pgdp = pgd_offset_k(addr);
>> +		p4dp = p4d_alloc(&init_mm, pgdp, addr);
>> +		pudp = pud_alloc(&init_mm, p4dp, addr);
>> +		pmdp = pmd_alloc(&init_mm, pudp, addr);
>> +		ptep = pte_alloc_kernel(pmdp, addr);
>> +
>> +		/*
>> +		 * we can validly get here if pte is not none: it means we
>> +		 * allocated this page earlier to use part of it for another
>> +		 * allocation
>> +		 */
>> +		if (pte_none(*ptep)) {
>> +			backing = __get_free_page(GFP_KERNEL);
>> +			backing_pte = pfn_pte(PFN_DOWN(__pa(backing)),
>> +					      PAGE_KERNEL);
>> +			set_pte_at(&init_mm, addr, ptep, backing_pte);
>> +		}
>
> Does anything prevent two threads from racing to allocate the same
> shadow page?
>
> AFAICT it's possible for two threads to get down to the ptep, then both
> see pte_none(*ptep)), then both try to allocate the same page.
>
> I suspect we have to take init_mm::page_table_lock when plumbing this
> in, similarly to __pte_alloc().

Good catch. I think you're right, I'll add the lock.

>> +	} while (addr += PAGE_SIZE, addr != shadow_alloc_end);
>> +
>> +	kasan_unpoison_shadow(area->addr, requested_size);
>> +	requested_size = round_up(requested_size, KASAN_SHADOW_SCALE_SIZE);
>> +	kasan_poison_shadow(area->addr + requested_size,
>> +			    area->size - requested_size,
>> +			    KASAN_VMALLOC_INVALID);
>
> IIUC, this could leave the final portion of an allocated page
> unpoisoned.
>
> I think it might make more sense to poison each page when it's
> allocated, then plumb it into the page tables, then unpoison the object.
>
> That way, we can rely on any shadow allocated by another thread having
> been initialized to KASAN_VMALLOC_INVALID, and only need mutual
> exclusion when allocating the shadow, rather than when poisoning
> objects.

Yes, that makes sense, will do.

Thanks again,
Daniel

