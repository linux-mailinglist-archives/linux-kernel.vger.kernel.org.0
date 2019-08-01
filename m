Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28757E084
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfHAQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 12:47:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAQrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jRDKLsjk8HUCz3+oK1y5lg3vRrF1WHpghzvIdr5Ml58=; b=kcblAkhG6mt3yoCMfrfug7uY2G
        v4QSh/1jdBTXFzZDTEaT8TMTNlorj84dGMHjHAUGg1+W99MsFL2rQLIufjOytL7JnIP1Zj9eXYer8
        SLSJH6PsRtzGEte27601VXpUk9F4ZELCl8fEUZKQoUTWN2Bh4xBvLggFZYD4I8yM2bRarnvXrUH/M
        CeGR+MgjY1VlygGooho0/aLmDRMEJr41ItyqCbq7tMrTmd5UOkE7NwCGi1lYRIDaz0LCufUqBzc9m
        O8ceJWszS1Ym1xjhtaGVbceHblO6Kh/T5W8iIC9aRfGxP50iznhSiypav1GVv8Q6wRV27LQC1Sbe4
        n6EFcfnw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htEER-00007z-TL; Thu, 01 Aug 2019 16:47:12 +0000
Date:   Thu, 1 Aug 2019 19:47:02 +0300
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm highmem block I/O regression fix for 5.3
Message-ID: <20190801164702.GA26365@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And here is another somewhat unusual pull request, mostly because it
touches almost entirely arch/arm, but to fix a block regression.

I would have preferred to feed this through the arm tree, but after
the original thread in reply to the bug report I haven't heard anything
back from Russell.


The following changes since commit 06532750010e06dd4b6d69983773677df7fc5291:

  dma-mapping: use dma_get_mask in dma_addressing_limited (2019-07-23 17:43:58 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/arm-swiotlb-5.3

for you to fetch changes up to ad3c7b18c5b362be5dbd0f2c0bcf1fd5fd659315:

  arm: use swiotlb for bounce buffering on LPAE configs (2019-07-24 17:29:01 +0200)

----------------------------------------------------------------
add swiotlb support to arm

This fixes a cascade of regressions that originally started with
the addition of the ia64 port, but only got fatal once we removed
most uses of block layer bounce buffering in Linux 4.18.

The reason is that while the original i386/PAE code that was the first
architecture that supported > 4GB of memory without an iommu decided to
leave bounce buffering to the subsystems, which in those days just mean
block and networking as no one else consumer arbitrary userspace memory.

Later with ia64, x86_64 and other ports we assumed that either an iommu
or something that fakes it up ("software IOTLB" in beautiful Intel
speak) is present and that subsystems can rely on that for dealing with
addressing limitations in devices.   Except that the ARM LPAE scheme
that added larger physical address to 32-bit ARM did not follow that
scheme and thus only worked by chance and only for block and networking
I/O directly to highmem.

Long story, short fix - add swiotlb support to arm when build for LPAE
platforms, which actuallys turns out to be pretty trivial with the
modern dma-direct / swiotlb code to fix the Linux 4.18-ish regression.

----------------------------------------------------------------
Christoph Hellwig (2):
      dma-mapping: check pfn validity in dma_common_{mmap,get_sgtable}
      arm: use swiotlb for bounce buffering on LPAE configs

 arch/arm/include/asm/dma-mapping.h |  4 ++-
 arch/arm/mm/Kconfig                |  5 ++++
 arch/arm/mm/dma-mapping.c          | 61 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/init.c                 |  5 ++++
 kernel/dma/mapping.c               | 13 ++++++--
 5 files changed, 85 insertions(+), 3 deletions(-)
