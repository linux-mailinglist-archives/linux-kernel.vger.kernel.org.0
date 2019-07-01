Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3F56FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 19:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfFZRvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 13:51:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfFZRvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/vs8Egy5g6Si0QhAWTdGb3iiX4UWuX/9RaMs8MRYrk0=; b=ObuCZMnJZL8XNKfEkGcnHvqPQ
        0snBZEHMJeZIlgKormOrFx9XKNZKn33QySiOBBapISItR0gi6ysSoc9ZVrAvT5JH0ueHZqZMyuA+y
        izLVmercQAhaMcp4j3x985xKi65IjQaHbwJJMqkkU7xHeSx/4nYn3SbcYtle1VLXXJCgG+2cKeyhv
        YSqVHhTYdnvfShOwnTEnhzxv9QE0MO/ANXi1ljUb8edvZeH4nyR99EXN+gpeUJcDAg/hhxRxKWQhg
        tGB7O37l3u0XPhaTtCwYKe1W3Z2e3ktVUq+DPh5eltEiqNFJ1ofEPqZPq1qHKtMXUva310T8yKBvq
        edAHdacLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgC4x-0004yn-Oh; Wed, 26 Jun 2019 17:51:31 +0000
Date:   Wed, 26 Jun 2019 10:51:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        iommu@lists.linux-foundation.org
Subject: Re: DMA-API attr - DMA_ATTR_NO_KERNEL_MAPPING
Message-ID: <20190626175131.GA17250@infradead.org>
References: <CACDBo564RoWpi8y2pOxoddnn0s3f3sA-fmNxpiXuxebV5TFBJA@mail.gmail.com>
 <CACDBo55GfomD4yAJ1qaOvdm8EQaD-28=etsRHb39goh+5VAeqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACDBo55GfomD4yAJ1qaOvdm8EQaD-28=etsRHb39goh+5VAeqw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:12:45PM +0530, Pankaj Suryawanshi wrote:
> [CC: linux kernel and Vlastimil Babka]

The right list is the list for the DMA mapping subsystem, which is
iommu@lists.linux-foundation.org.  I've also added that.

> > I am writing driver in which I used DMA_ATTR_NO_KERNEL_MAPPING attribute
> > for cma allocation using dma_alloc_attr(), as per kernel docs
> > https://www.kernel.org/doc/Documentation/DMA-attributes.txt  buffers
> > allocated with this attribute can be only passed to user space by calling
> > dma_mmap_attrs().
> >
> > how can I mapped in kernel space (after dma_alloc_attr with
> > DMA_ATTR_NO_KERNEL_MAPPING ) ?

You can't.  And that is the whole point of that API.
