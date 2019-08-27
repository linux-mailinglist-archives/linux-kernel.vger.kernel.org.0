Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1FA9E857
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfH0MuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 08:50:05 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:54139 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726170AbfH0MuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:50:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TacAofi_1566910188;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TacAofi_1566910188)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Aug 2019 20:49:54 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     alex.williamson@redhat.com, cohuck@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] vfio/type1: avoid redundant PageReserved checking
Date:   Tue, 27 Aug 2019 20:49:48 +0800
Message-Id: <3e892a6bdaa069a6e79c50208bd01cab8c9588ac.1566910119.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently, if the page is not a tail of compound page, it will be
checked twice for the same thing.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 drivers/vfio/vfio_iommu_type1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 054391f..cbe0d88 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -291,11 +291,10 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
 static bool is_invalid_reserved_pfn(unsigned long pfn)
 {
 	if (pfn_valid(pfn)) {
-		bool reserved;
 		struct page *tail = pfn_to_page(pfn);
 		struct page *head = compound_head(tail);
-		reserved = !!(PageReserved(head));
 		if (head != tail) {
+			bool reserved = !!(PageReserved(head));
 			/*
 			 * "head" is not a dangling pointer
 			 * (compound_head takes care of that)
@@ -310,7 +309,7 @@ static bool is_invalid_reserved_pfn(unsigned long pfn)
 			if (PageTail(tail))
 				return reserved;
 		}
-		return PageReserved(tail);
+		return !!(PageReserved(tail));
 	}
 
 	return true;
-- 
1.8.3.1

