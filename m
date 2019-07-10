Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E080629F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404759AbfGHT5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:57:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfGHT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xm+6ZVNdxMkUHmStif1/+KnHVgQpdfL0ddXk9glkGmk=; b=DFWUKgf+5gf9Djl7P5hCdIY/Q
        s8mYkpHgFRngVPafI2T5xkyqdbEH7JjITgUjvoWFhZf1shCbK+NEkqMV41GrRXrwvAyfAlD3k3A8m
        gLK6txJNix3aeR+ehwPTTgWD5zmWlpN2DBG0cc8+ZAjYVPP2jue0gMNrf5qS2ix6bOV53knAuyppP
        xHNL7F217OT75WxqSX4fYzfkXxfCLL9GMtvCnJ+XgXkqWui03prTYW5UfrgVcV3M7ER1VMbGL5+SY
        ajg7ZJxX8NPA+ZK0ph+ELAZMmjVVunl9jFWKPxY1nNiIjxqWmxQQ04QPxM0536aFupm6DR3EMYw8g
        ObGNbJTZA==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkZla-0001nU-Jg; Mon, 08 Jul 2019 19:57:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     rdunlap@infradead.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: mark dma_alloc_need_uncached as __always_inline
Date:   Mon,  8 Jul 2019 12:57:33 -0700
Message-Id: <20190708195733.26501-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the __always_inline at least i386 configs that have
CONFIG_OPTIMIZE_INLINING set seem fail to inline
dma_alloc_need_uncached, leading to a linker error because of
undefined symbols.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-noncoherent.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 53ee36ecdf37..3813211a9aad 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -23,7 +23,7 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 /*
  * Check if an allocation needs to be marked uncached to be coherent.
  */
-static inline bool dma_alloc_need_uncached(struct device *dev,
+static __always_inline bool dma_alloc_need_uncached(struct device *dev,
 		unsigned long attrs)
 {
 	if (dev_is_dma_coherent(dev))
-- 
2.20.1

