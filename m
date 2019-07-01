Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550DF328F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 08:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfFCGyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 02:54:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfFCGyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:54:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33A6F30593D8;
        Mon,  3 Jun 2019 06:54:10 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31C4E1001E67;
        Mon,  3 Jun 2019 06:54:03 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jean-philippe.brucker@arm.com
Subject: [PATCH v6 5/7] iommu/vt-d: Handle PCI bridge RMRR device scopes in intel_iommu_get_resv_regions
Date:   Mon,  3 Jun 2019 08:53:34 +0200
Message-Id: <20190603065336.10524-6-eric.auger@redhat.com>
In-Reply-To: <20190603065336.10524-1-eric.auger@redhat.com>
References: <20190603065336.10524-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 03 Jun 2019 06:54:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case the RMRR device scope is a PCI-PCI bridge, let's check
the device belongs to the PCI sub-hierarchy.

Fixes: 0659b8dc45a6 ("iommu/vt-d: Implement reserved region get/put callbacks")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

---

v5 -> v6:
- Added Lu's R-b
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 346103ce16d3..eed7ac206777 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5496,7 +5496,8 @@ static void intel_iommu_get_resv_regions(struct device *device,
 			struct iommu_resv_region *resv;
 			size_t length;
 
-			if (i_dev != device)
+			if (i_dev != device &&
+			    !is_downstream_to_pci_bridge(device, i_dev))
 				continue;
 
 			length = rmrr->end_address - rmrr->base_address + 1;
-- 
2.20.1

