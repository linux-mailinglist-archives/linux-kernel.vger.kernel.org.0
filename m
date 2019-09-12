Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A5B0A47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 10:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfILI0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 04:26:17 -0400
Received: from verein.lst.de ([213.95.11.211]:45327 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfILI0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:26:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 573D1227A81; Thu, 12 Sep 2019 10:26:13 +0200 (CEST)
Date:   Thu, 12 Sep 2019 10:26:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] mm/hmm: make full use of walk_page_range()
Message-ID: <20190912082613.GA14368@lst.de>
References: <20190911222829.28874-1-rcampbell@nvidia.com> <20190911222829.28874-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911222829.28874-2-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int hmm_pfns_fill(unsigned long addr,
> +			 unsigned long end,
> +			 struct hmm_range *range,
> +			 enum hmm_pfn_value_e value)

Nit: can we use the space a little more efficient, e.g.:

static int hmm_pfns_fill(unsigned long addr, unsigned long end,
		struct hmm_range *range, enum hmm_pfn_value_e value)

> +static int hmm_vma_walk_test(unsigned long start,
> +			     unsigned long end,
> +			     struct mm_walk *walk)

Same here.

> +	if (!(vma->vm_flags & VM_READ)) {
> +		(void) hmm_pfns_fill(start, end, range, HMM_PFN_NONE);

There should be no need for the void cast here.
