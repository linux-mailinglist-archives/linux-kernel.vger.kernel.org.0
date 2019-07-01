Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1878A201A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 10:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfEPIsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 04:48:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfEPIsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:48:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14AB430820C9;
        Thu, 16 May 2019 08:48:18 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5A875C205;
        Thu, 16 May 2019 08:48:13 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, lorenzo.pieralisi@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v2 7/7] iommu/vt-d: Differentiate relaxable and non relaxable RMRRs
Date:   Thu, 16 May 2019 10:47:20 +0200
Message-Id: <20190516084720.10498-8-eric.auger@redhat.com>
In-Reply-To: <20190516084720.10498-1-eric.auger@redhat.com>
References: <20190516084720.10498-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 16 May 2019 08:48:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have a new IOMMU_RESV_DIRECT_RELAXABLE reserved memory
region type, let's report USB and GFX RMRRs as relaxable ones.

This allows to have a finer reporting at IOMMU API level of
reserved memory regions. This will be exploitable by VFIO to
define the usable IOVA range and detect potential conflicts
between the guest physical address space and host reserved
regions.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a36604f4900f..af1d65fdedfc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5493,7 +5493,9 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	for_each_rmrr_units(rmrr) {
 		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
 					  i, i_dev) {
+			struct pci_dev *pdev = to_pci_dev(device);
 			struct iommu_resv_region *resv;
+			enum iommu_resv_type type;
 			size_t length;
 
 			if (i_dev != device &&
@@ -5501,9 +5503,13 @@ static void intel_iommu_get_resv_regions(struct device *device,
 				continue;
 
 			length = rmrr->end_address - rmrr->base_address + 1;
+
+			type = (pdev &&
+				(IS_USB_DEVICE(pdev) || IS_GFX_DEVICE(pdev))) ?
+				IOMMU_RESV_DIRECT_RELAXABLE : IOMMU_RESV_DIRECT;
+
 			resv = iommu_alloc_resv_region(rmrr->base_address,
-						       length, prot,
-						       IOMMU_RESV_DIRECT,
+						       length, prot, type,
 						       GFP_ATOMIC);
 			if (!resv)
 				break;
-- 
2.20.1

