Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8312FC6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 16:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfECOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 10:06:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41670 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfECOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:06:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so6148232edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDG9A8vcxSWTc3lAhtot1/d3GbhCCecRqw2WbSyKudk=;
        b=feHZTD51V3Kr5/f8uHGsEm9lvHVjGVHfGjgwWhBBXg8KQhQyWaTT5ocm2pxvOmaA/U
         NHOymXRcp5B4BsHyh/B+1ypKS+hMZQKRMWS54BDSZVMwYYsObRy83TR+APQNE+A7fpTO
         V42S20HGilmypBW2HZg6GJD9e9LMG8JhGKKGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDG9A8vcxSWTc3lAhtot1/d3GbhCCecRqw2WbSyKudk=;
        b=BQUbnGzzjNcOsrxkV1XQt29LNDgHXoD3tngdIa3mTHDWqUX4roKHtOcOJdXVDVBt83
         4DZ92xjfHflBKpr7lKLa3GBPHDdr02lgfNOdgSKAUJUrUE3KfTXRQApELD/YU4xszeSF
         W1D7Zd+AIhnyJA8eIuG3ddvj3qHAhl5/nJjj8UapC53kjgRCLcpkpqxl6w5v0za2hhnh
         rQHU7Un6bQ5p4PeZLDOYCl7NwdwZgKBdFWrUF8XOKOMBFOCjDjby9tu6ZRsoSqNDjIUc
         dNbl+QI4rRe90PfDQAtHAUx22XlptXJmNqWwcD7a0yVuYKzcXxnUI2KdQeOB7bxT2h5W
         /iBw==
X-Gm-Message-State: APjAAAVwdLc5I2eFEv3ATqSE3qMhbrd7oGHn7F/3rUBKRURhZXbaHyzB
        AL3ul8cKbB0ToNF2HrNFUxv3HA==
X-Google-Smtp-Source: APXvYqxdUNO4AAjiICo5DT6ucVOjhvprFFm/2BtoKIfgOXzHwJyKhWHar6DRBfmM7Rt0E3BQHIA7OQ==
X-Received: by 2002:a50:b835:: with SMTP id j50mr8464031ede.63.1556892366022;
        Fri, 03 May 2019 07:06:06 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s53sm605472edb.20.2019.05.03.07.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 May 2019 07:06:05 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v6 2/3] iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
Date:   Fri,  3 May 2019 19:35:33 +0530
Message-Id: <1556892334-16270-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma_ranges list field of PCI host bridge structure has resource
entries in sorted order representing address ranges allowed for DMA
transfers.

Process the list and reserve IOVA addresses that are not present in its
resource entries (ie DMA memory holes) to prevent allocating IOVA
addresses that cannot be accessed by PCI devices.

Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77aabe6..954ae11 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -206,12 +206,13 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 	return 0;
 }
 
-static void iova_reserve_pci_windows(struct pci_dev *dev,
+static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 	struct resource_entry *window;
 	unsigned long lo, hi;
+	phys_addr_t start = 0, end;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM)
@@ -221,6 +222,31 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		hi = iova_pfn(iovad, window->res->end - window->offset);
 		reserve_iova(iovad, lo, hi);
 	}
+
+	/* Get reserved DMA windows from host bridge */
+	resource_list_for_each_entry(window, &bridge->dma_ranges) {
+		end = window->res->start - window->offset;
+resv_iova:
+		if (end > start) {
+			lo = iova_pfn(iovad, start);
+			hi = iova_pfn(iovad, end);
+			reserve_iova(iovad, lo, hi);
+		} else {
+			/* dma_ranges list should be sorted */
+			dev_err(&dev->dev, "Failed to reserve IOVA\n");
+			return -EINVAL;
+		}
+
+		start = window->res->end - window->offset + 1;
+		/* If window is last entry */
+		if (window->node.next == &bridge->dma_ranges &&
+		    end != ~(dma_addr_t)0) {
+			end = ~(dma_addr_t)0;
+			goto resv_iova;
+		}
+	}
+
+	return 0;
 }
 
 static int iova_reserve_iommu_regions(struct device *dev,
@@ -232,8 +258,11 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	LIST_HEAD(resv_regions);
 	int ret = 0;
 
-	if (dev_is_pci(dev))
-		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
+	if (dev_is_pci(dev)) {
+		ret = iova_reserve_pci_windows(to_pci_dev(dev), iovad);
+		if (ret)
+			return ret;
+	}
 
 	iommu_get_resv_regions(dev, &resv_regions);
 	list_for_each_entry(region, &resv_regions, list) {
-- 
2.7.4

