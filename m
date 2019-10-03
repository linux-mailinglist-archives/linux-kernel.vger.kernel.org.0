Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5207C9A45
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfJCIze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 04:55:34 -0400
Received: from foss.arm.com ([217.140.110.172]:38742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbfJCIzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:55:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E756128;
        Thu,  3 Oct 2019 01:55:32 -0700 (PDT)
Received: from arrakis.emea.arm.com (unknown [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E50A63F739;
        Thu,  3 Oct 2019 01:55:30 -0700 (PDT)
Date:   Thu, 3 Oct 2019 09:55:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ryohei Suzuki <ryh.szk.cmnty@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peng Fan <peng.fan@nxp.com>, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] mm: export cma alloc and release
Message-ID: <20191003085528.GB21629@arrakis.emea.arm.com>
References: <20191002212257.196849-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002212257.196849-1-salyzyn@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 02:22:48PM -0700, Mark Salyzyn wrote:
> Some drivers can not be turned into a module without cma_alloc and
> cma_release exported.  Examples include ion, and we also found some
> out of tree infiniband and camera drivers.
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: kernel-team@android.com
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/cma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 7fe0b8356775..65d830eea3b1 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -500,6 +500,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  	pr_debug("%s(): returned %p\n", __func__, page);
>  	return page;
>  }
> +EXPORT_SYMBOL_GPL(cma_alloc);
>  
>  /**
>   * cma_release() - release allocated pages
> @@ -533,6 +534,7 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
>  
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(cma_release);

Aren't drivers supposed to use the DMA API for such allocations rather
than invoking cma_*() directly?

-- 
Catalin
