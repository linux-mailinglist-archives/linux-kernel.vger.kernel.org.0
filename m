Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6B7FB179
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 14:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKMNhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 08:37:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfKMNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rXc6QoCjcK1fWhu8XRtkOP3UczvVAyRhRkKSV31pqqU=; b=bFor07CLRIOg9YoQ7IHm/cB8W
        hIdGbFb1njbAVrpUQdjFjesLOX1WnXAFGw2pmnHSNTm81yc3bNalr5a013MlgrHy2k8zz5sgrxxRI
        3NOx1YPtfD+HhiWw/ijEAP4y4eC5bJYgtFWuSO1drKdGcBrSfoxS2rFJs3Q+klQQs8sxntRYznHQC
        zIfN/V3b0xC7OhOFui/EgHwb+bX3f13IP38BMZyt+CCdA6r1tvBX/kGHXthO0XGnTEjH/t8VyKwW1
        mfgvknItIypIHg0YD3UH+lPMm9B0tQAvyPIwoUPJ8WzpLPnVBkY9zdsmG1pabm/PNYEHSr9eQ9k5m
        yk33iGgkQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUspw-0008Mt-Me; Wed, 13 Nov 2019 13:37:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: generic DMA bypass flag
Date:   Wed, 13 Nov 2019 14:37:29 +0100
Message-Id: <20191113133731.20870-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've recently beeing chatting with Lu about using dma-iommu and
per-device DMA ops in the intel IOMMU driver, and one missing feature
in dma-iommu is a bypass mode where the direct mapping is used even
when an iommu is attached to improve performance.  The powerpc
code already has a similar mode, so I'd like to move it to the core
DMA mapping code.  As part of that I noticed that the current
powerpc code has a little bug in that it used the wrong check in the
dma_sync_* routines to see if the direct mapping code is used.

These two patches just add the generic code and move powerpc over,
the intel IOMMU bits will require a separate discussion.

The x86 AMD Gart code also has a bypass mode, but it is a lot
strange, so I'm not going to touch it for now.
