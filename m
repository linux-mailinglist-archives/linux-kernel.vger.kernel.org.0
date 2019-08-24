Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6209C0CC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 00:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfHXWjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 18:39:11 -0400
Received: from verein.lst.de ([213.95.11.211]:37672 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbfHXWjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 18:39:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB04B68B02; Sun, 25 Aug 2019 00:39:07 +0200 (CEST)
Date:   Sun, 25 Aug 2019 00:39:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/hmm: hmm_range_fault() infinite loop
Message-ID: <20190824223907.GB21891@lst.de>
References: <20190823221753.2514-1-rcampbell@nvidia.com> <20190823221753.2514-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823221753.2514-3-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:17:53PM -0700, Ralph Campbell wrote:
> Normally, callers to handle_mm_fault() are supposed to check the
> vma->vm_flags first. hmm_range_fault() checks for VM_READ but doesn't
> check for VM_WRITE if the caller requests a page to be faulted in
> with write permission (via the hmm_range.pfns[] value).
> If the vma is write protected, this can result in an infinite loop:
>   hmm_range_fault()
>     walk_page_range()
>       ...
>       hmm_vma_walk_hole()
>         hmm_vma_walk_hole_()
>           hmm_vma_do_fault()
>             handle_mm_fault(FAULT_FLAG_WRITE)
>             /* returns VM_FAULT_WRITE */
>           /* returns -EBUSY */
>         /* returns -EBUSY */
>       /* returns -EBUSY */
>     /* loops on -EBUSY and range->valid */
> Prevent this by checking for vma->vm_flags & VM_WRITE before calling
> handle_mm_fault().
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
