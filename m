Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C631B0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 09:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfEMHNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 03:13:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5471 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfEMHNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:13:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B79AF81F25;
        Mon, 13 May 2019 07:13:18 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02E6168434;
        Mon, 13 May 2019 07:13:15 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, lorenzo.pieralisi@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com
Subject: [PATCH 2/4] iommu/vt-d: Duplicate iommu_resv_region objects per device list
Date:   Mon, 13 May 2019 09:13:00 +0200
Message-Id: <20190513071302.30718-3-eric.auger@redhat.com>
In-Reply-To: <20190513071302.30718-1-eric.auger@redhat.com>
References: <20190513071302.30718-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 13 May 2019 07:13:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_iommu_get_resv_regions() aims to return the list of
reserved regions accessible by a given @device. However several
devices can access the same reserved memory region and when
building the list it is not safe to use a single iommu_resv_region
object, whose container is the RMRR. This iommu_resv_region must
be duplicated per device reserved region list.

Let's remove the struct iommu_resv_region from the RMRR unit
and allocate the iommu_resv_region directly in
intel_iommu_get_resv_regions().

Fixes: 0659b8dc45a6 ("iommu/vt-d: Implement reserved region get/put callbacks")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2075abdb174d..e2134b13c9ae 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -322,7 +322,6 @@ struct dmar_rmrr_unit {
 	u64	end_address;		/* reserved end address */
 	struct dmar_dev_scope *devices;	/* target devices */
 	int	devices_cnt;		/* target device count */
-	struct iommu_resv_region *resv; /* reserved region handle */
 };
 
 struct dmar_atsr_unit {
@@ -4206,7 +4205,6 @@ static inline void init_iommu_pm_ops(void) {}
 int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 {
 	struct acpi_dmar_reserved_memory *rmrr;
-	int prot = DMA_PTE_READ|DMA_PTE_WRITE;
 	struct dmar_rmrr_unit *rmrru;
 	size_t length;
 
@@ -4220,22 +4218,16 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 	rmrru->end_address = rmrr->end_address;
 
 	length = rmrr->end_address - rmrr->base_address + 1;
-	rmrru->resv = iommu_alloc_resv_region(rmrr->base_address, length, prot,
-					      IOMMU_RESV_DIRECT, GFP_KERNEL);
-	if (!rmrru->resv)
-		goto free_rmrru;
 
 	rmrru->devices = dmar_alloc_dev_scope((void *)(rmrr + 1),
 				((void *)rmrr) + rmrr->header.length,
 				&rmrru->devices_cnt);
 	if (rmrru->devices_cnt && rmrru->devices == NULL)
-		goto free_all;
+		goto free_rmrru;
 
 	list_add(&rmrru->list, &dmar_rmrr_units);
 
 	return 0;
-free_all:
-	kfree(rmrru->resv);
 free_rmrru:
 	kfree(rmrru);
 out:
@@ -4453,7 +4445,6 @@ static void intel_iommu_free_dmars(void)
 	list_for_each_entry_safe(rmrru, rmrr_n, &dmar_rmrr_units, list) {
 		list_del(&rmrru->list);
 		dmar_free_dev_scope(&rmrru->devices, &rmrru->devices_cnt);
-		kfree(rmrru->resv);
 		kfree(rmrru);
 	}
 
@@ -5271,6 +5262,7 @@ static void intel_iommu_remove_device(struct device *dev)
 static void intel_iommu_get_resv_regions(struct device *device,
 					 struct list_head *head)
 {
+	int prot = DMA_PTE_READ|DMA_PTE_WRITE;
 	struct iommu_resv_region *reg;
 	struct dmar_rmrr_unit *rmrr;
 	struct device *i_dev;
@@ -5280,10 +5272,21 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	for_each_rmrr_units(rmrr) {
 		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
 					  i, i_dev) {
+			struct iommu_resv_region *resv;
+			size_t length;
+
 			if (i_dev != device)
 				continue;
 
-			list_add_tail(&rmrr->resv->list, head);
+			length = rmrr->end_address - rmrr->base_address + 1;
+			resv = iommu_alloc_resv_region(rmrr->base_address,
+						       length, prot,
+						       IOMMU_RESV_DIRECT,
+						       GFP_ATOMIC);
+			if (!resv)
+				break;
+
+			list_add_tail(&resv->list, head);
 		}
 	}
 	rcu_read_unlock();
@@ -5301,10 +5304,8 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 {
 	struct iommu_resv_region *entry, *next;
 
-	list_for_each_entry_safe(entry, next, head, list) {
-		if (entry->type == IOMMU_RESV_MSI)
-			kfree(entry);
-	}
+	list_for_each_entry_safe(entry, next, head, list)
+		kfree(entry);
 }
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-- 
2.20.1

