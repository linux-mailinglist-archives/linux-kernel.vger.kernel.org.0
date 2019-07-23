Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8AF171CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbfGWQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 12:30:52 -0400
Received: from verein.lst.de ([213.95.11.211]:43190 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfGWQav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:30:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9C53F68B02; Tue, 23 Jul 2019 18:30:48 +0200 (CEST)
Date:   Tue, 23 Jul 2019 18:30:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] nouveau: unlock mmap_sem on all errors from
 nouveau_range_fault
Message-ID: <20190723163048.GD1655@lst.de>
References: <20190722094426.18563-1-hch@lst.de> <20190722094426.18563-5-hch@lst.de> <20190723151824.GL15331@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723151824.GL15331@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:18:28PM +0000, Jason Gunthorpe wrote:
> Hum..
> 
> The caller does this:
> 
> again:
> 		ret = nouveau_range_fault(&svmm->mirror, &range);
> 		if (ret == 0) {
> 			mutex_lock(&svmm->mutex);
> 			if (!nouveau_range_done(&range)) {
> 				mutex_unlock(&svmm->mutex);
> 				goto again;
> 
> And we can't call nouveau_range_fault() -> hmm_range_fault() without
> holding the mmap_sem, so we can't allow nouveau_range_fault to unlock
> it.

Goto again can only happen if nouveau_range_fault was successful,
in which case we did not drop mmap_sem.

Also:

>  	ret = hmm_range_fault(range, true);
>  	if (ret <= 0) {
>  		if (ret == 0)
>  			ret = -EBUSY;
> -		up_read(&range->vma->vm_mm->mmap_sem);
>  		hmm_range_unregister(range);

This would hold mmap_sem over hmm_range_unregister, which can lead
to deadlock if we call exit_mmap and then acquire mmap_sem again.
