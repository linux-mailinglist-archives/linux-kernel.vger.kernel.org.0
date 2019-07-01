Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8792C5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 13:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfE1LvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 07:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfE1LvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:51:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FEE7C05E76E;
        Tue, 28 May 2019 11:50:58 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5CC15D9DC;
        Tue, 28 May 2019 11:50:50 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jean-philippe.brucker@arm.com
Subject: [PATCH v5 4/7] iommu/vt-d: Handle RMRR with PCI bridge device scopes
Date:   Tue, 28 May 2019 13:50:22 +0200
Message-Id: <20190528115025.17194-5-eric.auger@redhat.com>
In-Reply-To: <20190528115025.17194-1-eric.auger@redhat.com>
References: <20190528115025.17194-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 28 May 2019 11:51:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the vtd specification and especially the
Reserved Memory Region Reporting Structure chapter,
it is not obvious a device scope element cannot be a
PCI-PCI bridge, in which case all downstream ports are
likely to access the reserved memory region. Let's handle
this case in device_has_rmrr.

Fixes: ea2447f700ca ("intel-iommu: Prevent devices with RMRRs from being placed into SI Domain")

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- is_downstream_to_pci_bridge helper introduced in a separate patch
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 879f11c82b05..35508687f178 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2910,7 +2910,8 @@ static bool device_has_rmrr(struct device *dev)
 		 */
 		for_each_active_dev_scope(rmrr->devices,
 					  rmrr->devices_cnt, i, tmp)
-			if (tmp == dev) {
+			if (tmp == dev ||
+			    is_downstream_to_pci_bridge(dev, tmp)) {
 				rcu_read_unlock();
 				return true;
 			}
-- 
2.20.1

