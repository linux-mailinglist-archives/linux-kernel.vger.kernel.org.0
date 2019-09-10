Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7824AE650
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 11:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfIJJI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 05:08:57 -0400
Received: from foss.arm.com ([217.140.110.172]:59356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfIJJI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:08:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E559228;
        Tue, 10 Sep 2019 02:08:56 -0700 (PDT)
Received: from C02TF0J2HF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B684C3F67D;
        Tue, 10 Sep 2019 02:08:53 -0700 (PDT)
Date:   Tue, 10 Sep 2019 10:08:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jia He <justin.he@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190910090845.GD14442@C02TF0J2HF1T.local>
References: <20190906135747.211836-1-justin.he@arm.com>
 <20190909212712.GE29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909212712.GE29434@bombadil.infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 02:27:12PM -0700, Matthew Wilcox wrote:
> On Fri, Sep 06, 2019 at 09:57:47PM +0800, Jia He wrote:
> > +		if (!pte_young(vmf->orig_pte)) {
> > +			entry = pte_mkyoung(vmf->orig_pte);
> > +			if (ptep_set_access_flags(vmf->vma, vmf->address,
> > +				vmf->pte, entry, 0))
> > +				update_mmu_cache(vmf->vma, vmf->address,
> > +						vmf->pte);
> > +		}
> > +
> 
> Oh, btw, why call update_mmu_cache() here?  All you've done is changed
> the 'accessed' bit.  What is any architecture supposed to do in response
> to this?

For arm64 and x86 that's a no-op but an architecture with software TLBs
may preload them to avoid a subsequent fault on access after the pte was
made young.

-- 
Catalin
