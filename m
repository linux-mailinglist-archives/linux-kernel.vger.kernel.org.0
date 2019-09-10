Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3659FAF0B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437235AbfIJRuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 13:50:13 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:44977 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbfIJRuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1568137807; x=1599673807;
  h=from:to:subject:date:message-id:in-reply-to:references;
  bh=9g2f9965/AguN0jWvC9vxXzWh+98n2Npj805hP9BUAk=;
  b=cWfgCp+aGwkFEzm24T6/nJ5bbhw6vO48JdJOyAhmmt1TFybW+xwhYxix
   fdsNvpHqprbiqFkTLvppCjpQ3Dqmv1V0QM9CzRWqiLqv5q3Z1KjfPNKXM
   pRetXz7vi+hwnsxhw3j4ME2kyuWWrXorS+QhFTqkyoFRB4XCpAXfV8Lih
   g=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="701858170"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Sep 2019 17:49:46 +0000
Received: from uf8b156e456a5587c9af4.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 1E290A219D;
        Tue, 10 Sep 2019 17:49:43 +0000 (UTC)
Received: from uf8b156e456a5587c9af4.ant.amazon.com (localhost [127.0.0.1])
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x8AHnfdW023824;
        Tue, 10 Sep 2019 19:49:41 +0200
Received: (from sironi@localhost)
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Submit) id x8AHnfnG023822;
        Tue, 10 Sep 2019 19:49:41 +0200
From:   Filippo Sironi <sironi@amazon.de>
To:     sironi@amazon.de, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iommu/amd: Hold the domain lock when calling __map_single
Date:   Tue, 10 Sep 2019 19:49:22 +0200
Message-Id: <1568137765-20278-3-git-send-email-sironi@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568137765-20278-1-git-send-email-sironi@amazon.de>
References: <1568137765-20278-1-git-send-email-sironi@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__map_single makes several calls to __domain_flush_pages, which
traverses the device list that is protected by the domain lock.

Also, this is in line with the comment on top of __map_single, which
says that the domain lock should be held when calling.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 drivers/iommu/amd_iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f026a8c2b218..8e3664821b3c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2482,6 +2482,8 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
 	u64 dma_mask;
+	unsigned long flags;
+	dma_addr_t dma_addr;
 
 	domain = get_domain(dev);
 	if (PTR_ERR(domain) == -EINVAL)
@@ -2492,7 +2494,10 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	dma_mask = *dev->dma_mask;
 	dma_dom = to_dma_ops_domain(domain);
 
-	return __map_single(dev, dma_dom, paddr, size, dir, dma_mask);
+	spin_lock_irqsave(&domain->lock, flags);
+	dma_addr = __map_single(dev, dma_dom, paddr, size, dir, dma_mask);
+	spin_unlock_irqrestore(&domain->lock, flags);
+	return dma_addr;
 }
 
 /*
@@ -2663,6 +2668,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
 	struct page *page;
+	unsigned long flags;
 
 	domain = get_domain(dev);
 	if (PTR_ERR(domain) == -EINVAL) {
@@ -2692,8 +2698,10 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	if (!dma_mask)
 		dma_mask = *dev->dma_mask;
 
+	spin_lock_irqsave(&domain->lock, flags);
 	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
 				 size, DMA_BIDIRECTIONAL, dma_mask);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	if (*dma_addr == DMA_MAPPING_ERROR)
 		goto out_free;
-- 
2.7.4

