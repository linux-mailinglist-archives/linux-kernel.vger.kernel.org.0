Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA10A9C0C9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 00:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfHXWh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 18:37:58 -0400
Received: from verein.lst.de ([213.95.11.211]:37660 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfHXWh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 18:37:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5FED368B02; Sun, 25 Aug 2019 00:37:54 +0200 (CEST)
Date:   Sun, 25 Aug 2019 00:37:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] mm/hmm: hmm_range_fault() NULL pointer bug
Message-ID: <20190824223754.GA21891@lst.de>
References: <20190823221753.2514-1-rcampbell@nvidia.com> <20190823221753.2514-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823221753.2514-2-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:17:52PM -0700, Ralph Campbell wrote:
> Although hmm_range_fault() calls find_vma() to make sure that a vma exists
> before calling walk_page_range(), hmm_vma_walk_hole() can still be called
> with walk->vma == NULL if the start and end address are not contained
> within the vma range.

Should we convert to walk_vma_range instead?  Or keep walk_page_range
but drop searching the vma ourselves?

Except for that the patch looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
