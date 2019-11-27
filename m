Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1636310B182
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfK0OkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 09:40:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0OkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=howc56bxTEyWXedb5RcS/cev28tOk9Lz2mtefx1HF+w=; b=uo3NQC8M7tVPEIZTbh3f/yeg/a
        1ohDdK9fsu6Jx5pkykl7Y4CnpzvLq3y67GfVai1JbgdtrZLrza/17IYN6R3L4/ZiW7b6ZIFuRNXdC
        xv7zTtRjjsiWfc8jTu4jsHsBTzzNCNiJd+E4CnWGba5IMlaywtDJ31GO4u8HrHfZ+NdXkK18ZsreS
        PHSZBGMHPP9VCXlqT/7BwYSOI17nsYTvtOnGeVE+63tsJOZWOj8PyVVVnVqHpz788SpA0I9MfBs1f
        0DAo7dknCRYaNVrBvA+EryacOtNeB2t9ZJcYoKD6RLG5aMdzwDxhHpaycRrUvVKEiH6TgV+i9nNxs
        z2QnEoWQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZyUF-0006rV-2E; Wed, 27 Nov 2019 14:40:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dma-mapping: force unencryped devices are always addressing limited
Date:   Wed, 27 Nov 2019 15:40:06 +0100
Message-Id: <20191127144006.25998-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127144006.25998-1-hch@lst.de>
References: <20191127144006.25998-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices that are forced to DMA through unencrypted bounce buffers
need to be treated as if they are addressing limited.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 1dbe6d725962..f6c35b53d996 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -416,6 +416,8 @@ EXPORT_SYMBOL_GPL(dma_get_merge_boundary);
  */
 bool dma_addressing_limited(struct device *dev)
 {
+	if (force_dma_unencrypted(dev))
+		return true;
 	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
 			    dma_get_required_mask(dev);
 }
-- 
2.20.1

