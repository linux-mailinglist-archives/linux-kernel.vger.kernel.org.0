Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3F97E07B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbfHAQpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 12:45:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfHAQpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jx0ZGH2N64oexlrgF/Dx4A/IEojQrEGADSEMN0h47JA=; b=q04jVgzHX9OL9OEMNb9rTbxKBF
        rmVpiKo5Sos2Acr5+b2HW5GlwhdCjCgJMM8MVsj2k3ecFDB2mr9KHVDGxbajTJ4HdfzMgd5NpFOFM
        ZaNo8M9lCtSmIXX1dYUBCkdIyjD8K0z5WVQJ48qjcR1RD0Zh0bDinWZVHA0w0aicauKc0T6thtpUE
        h17QGgr2g73ENNZOmZUTFaOrJYZKNvr5xSD0NrgPInAXSY11UNQne0nR4sjomi7ym94Z3zAr7CtYf
        cZvzyj/d1VLaYSXFY/zgSGidltL9iVkf4Cnr0YYJoxNp/UBkaVMJRG16CG4FyaQ+Q/J++yWTZ8YFl
        LXdkpfvg==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htECn-0008F1-Ae; Thu, 01 Aug 2019 16:45:29 +0000
Date:   Thu, 1 Aug 2019 19:45:20 +0300
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping regression fixes for 5.3
Message-ID: <20190801164520.GA26214@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is the easy pull request for today, two related regression
fixes for changes from this merge window:


The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-3

for you to fetch changes up to f46cc0152501e46d1b3aa5e7eade61145070eab0:

  dma-contiguous: page-align the size in dma_free_contiguous() (2019-07-29 09:50:04 +0300)

----------------------------------------------------------------
dma-mapping regression fixes for 5.3

 - fix alignment issues introduced in the CMA allocation rework
   (Nicolin Chen)

----------------------------------------------------------------
Nicolin Chen (2):
      dma-contiguous: do not overwrite align in dma_alloc_contiguous()
      dma-contiguous: page-align the size in dma_free_contiguous()

 kernel/dma/contiguous.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
