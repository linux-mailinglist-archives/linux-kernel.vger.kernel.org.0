Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D375EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 08:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfGZGYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 02:24:40 -0400
Received: from verein.lst.de ([213.95.11.211]:41759 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfGZGYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:24:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 75E5C68BFE; Fri, 26 Jul 2019 08:24:37 +0200 (CEST)
Date:   Fri, 26 Jul 2019 08:24:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 6/7] mm/hmm: remove hugetlbfs check in
 hmm_vma_walk_pmd
Message-ID: <20190726062437.GC22881@lst.de>
References: <20190726005650.2566-1-rcampbell@nvidia.com> <20190726005650.2566-7-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726005650.2566-7-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 05:56:49PM -0700, Ralph Campbell wrote:
> walk_page_range() will only call hmm_vma_walk_hugetlb_entry() for
> hugetlbfs pages and doesn't call hmm_vma_walk_pmd() in this case.
> Therefore, it is safe to remove the check for vma->vm_flags & VM_HUGETLB
> in hmm_vma_walk_pmd().
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
