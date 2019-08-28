Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9F5A04B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 16:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfH1OVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 10:21:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfH1OVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5miFGnPe5RpYDj/Z2zM+wDYPkBcELi5PHsN67JsLU40=; b=C5yshFhd1Yq+LUhUehHTilZS9
        fohwe25pSav/nTwz0sWetQQmwfprwB6OJiI3jJBHDWa24moS92VxURWQTl/IXHhW6stQLhuYQEVll
        MGZQ/OzubmdslO+P9OPuKM80uT8E5vybX0h8FYEr/ZKyWiiSA1oKZVm5Z3iUjdl2nVQQIPJHnaXtw
        A/OWQMr4tCIN68mb5fGaoJXabRa2Dbnx5DXilcVXgRDQJ61va5rtytMG08fBKRL5jQG9rwxF549LZ
        NftVRvTAyJUNWn31zbMcBAFvW59/hEqEmowPpeDS0U8cWpCxV7iZ9p7au8X9D0BzJ+dxLZTBVdVTW
        pqjEHc3ew==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2yox-0005Z0-Bu; Wed, 28 Aug 2019 14:21:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     jgg@mellanox.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch
Subject: [PATCH] mm: remove the __mmu_notifier_invalidate_range_start/end exports
Date:   Wed, 28 Aug 2019 16:21:09 +0200
Message-Id: <20190828142109.29012-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bo modular code uses these, which makes a lot of sense given the
wrappers around them are only called by core mm code.

Also remove the recently added __mmu_notifier_invalidate_range_start_map
export for which the same applies.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/mmu_notifier.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 690f1ea639d5..240f4e14d42e 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -25,7 +25,6 @@ DEFINE_STATIC_SRCU(srcu);
 struct lockdep_map __mmu_notifier_invalidate_range_start_map = {
 	.name = "mmu_notifier_invalidate_range_start"
 };
-EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range_start_map);
 #endif
 
 /*
@@ -184,7 +183,6 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range_start);
 
 void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range,
 					 bool only_end)
@@ -218,7 +216,6 @@ void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range,
 	srcu_read_unlock(&srcu, id);
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 }
-EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range_end);
 
 void __mmu_notifier_invalidate_range(struct mm_struct *mm,
 				  unsigned long start, unsigned long end)
-- 
2.20.1

