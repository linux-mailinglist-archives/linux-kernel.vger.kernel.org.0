Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D549F962
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 06:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfH1E2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 00:28:12 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42572 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfH1E2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 00:28:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Taf2mB9_1566966484;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Taf2mB9_1566966484)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Aug 2019 12:28:09 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     alex.williamson@redhat.com, cohuck@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] vfio/type1: avoid redundant PageReserved checking
Date:   Wed, 28 Aug 2019 12:28:04 +0800
Message-Id: <3517844d6371794cff59b13bf9c2baf1dcbe571c.1566966365.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20190827124041.4f986005@x1.home>
References: <20190827124041.4f986005@x1.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently, if the page is not a tail of compound page, it will be
checked twice for the same thing.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 drivers/vfio/vfio_iommu_type1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 054391f..d0f7346 100644
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
+			bool reserved = PageReserved(head);
 			/*
 			 * "head" is not a dangling pointer
 			 * (compound_head takes care of that)
-- 
1.8.3.1

