Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD7CA9009F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfHPLS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 07:18:58 -0400
Received: from foss.arm.com ([217.140.110.172]:55206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfHPLS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:18:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C706C360;
        Fri, 16 Aug 2019 04:18:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 09FE13F706;
        Fri, 16 Aug 2019 04:18:54 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [PATCH 1/2] drivers/dax/kmem: use default numa_mem_id if target_node is invalid
Date:   Fri, 16 Aug 2019 19:18:43 +0800
Message-Id: <20190816111844.87442-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816111844.87442-1-justin.he@arm.com>
References: <20190816111844.87442-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some platforms(e.g arm64 guest), the NFIT info might not be ready.
Then target_node might be -1. But if there is a default numa_mem_id(),
we can use it to avoid unnecessary fatal EINVL error.

devm_memremap_pages() also uses this logic if nid is invalid, we can
keep the same page with it.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/dax/kmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a02318c6d28a..ad62d551d94e 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -33,9 +33,9 @@ int dev_dax_kmem_probe(struct device *dev)
 	 */
 	numa_node = dev_dax->target_node;
 	if (numa_node < 0) {
-		dev_warn(dev, "rejecting DAX region %pR with invalid node: %d\n",
-			 res, numa_node);
-		return -EINVAL;
+		dev_warn(dev, "DAX %pR with invalid node, assume it as %d\n",
+				res, numa_node, numa_mem_id());
+		numa_node = numa_mem_id();
 	}
 
 	/* Hotplug starting at the beginning of the next block: */
-- 
2.17.1

