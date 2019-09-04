Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC974A7A07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 06:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfIDEhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 00:37:45 -0400
Received: from foss.arm.com ([217.140.110.172]:47466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfIDEhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:37:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 676E1337;
        Tue,  3 Sep 2019 21:37:44 -0700 (PDT)
Received: from [10.162.41.129] (p8cg001049571a15.blr.arm.com [10.162.41.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16C833F718;
        Tue,  3 Sep 2019 21:37:39 -0700 (PDT)
Subject: Re: [PATCH] mm: fix double page fault on arm64 if PTE_AF is cleared
To:     Jia He <justin.he@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190904005831.153934-1-justin.he@arm.com>
 <fd22d787-3240-fe42-3ca3-9e8a98f86fce@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <961889b3-ef08-2ee9-e3a1-6aba003f47c1@arm.com>
Date:   Wed, 4 Sep 2019 10:07:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fd22d787-3240-fe42-3ca3-9e8a98f86fce@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/2019 08:49 AM, Anshuman Khandual wrote:
>  		/*
>  		 * This really shouldn't fail, because the page is there
>  		 * in the page tables. But it might just be unreadable,
>  		 * in which case we just give up and fill the result with
> -		 * zeroes.
> +		 * zeroes. If PTE_AF is cleared on arm64, it might
> +		 * cause double page fault here. so makes pte young here
>  		 */
> +		if (!pte_young(vmf->orig_pte)) {
> +			entry = pte_mkyoung(vmf->orig_pte);
> +			if (ptep_set_access_flags(vmf->vma, vmf->address,
> +				vmf->pte, entry, vmf->flags & FAULT_FLAG_WRITE))
> +				update_mmu_cache(vmf->vma, vmf->address,
> +						vmf->pte);
> +		}

This looks correct where it updates the pte entry with PTE_AF which
will prevent a subsequent page fault. But I think what we really need
here is to make sure 'uaddr' is mapped correctly at vma->pte. Probably
a generic function arch_map_pte() when defined for arm64 should check
CPU version and ensure continuance of PTE_AF if required. The comment
above also need to be updated saying not only the page should be there
in the page table, it needs to mapped appropriately as well.
