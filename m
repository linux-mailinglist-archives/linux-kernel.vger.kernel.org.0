Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82FAEA17F3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 13:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfH2LSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 07:18:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45744 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfH2LSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:18:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id x19so3590064eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 04:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjixq+s7ZD6fFiV9g8QRBxU/OWNAVY/P4LPyIACEzEM=;
        b=djC2H5JFeHWERoQFSNo6K1Buv/HAY/zdTZ/Vy9BLHhv70G1BP5aEHIemdlQWFvLK0t
         3RSHU3+QDvVjBRH6rmndTQFisShBSy2rXVQU/0CyVBy93HiUWngryqj8oTbKIdj6Vnpz
         sNXUippKE5z0M2ZtM+fW6KuMBLAdoZNiZD6qsjd/JWY1vRPgY0j28/rH0E6Idert9w7d
         sS2fZojsKu+F+CaN8iGeU4WiMl20abUTFNRMZ2XUCm9qApaELu6NPAdSB6YiqFtgC0ZA
         1lVSgZoDWeqEdOzemcXFc9s7dX1wZPrqyNfi+GQQTYnagocsIo/CfeeTtfPlcX3yRrKD
         +5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjixq+s7ZD6fFiV9g8QRBxU/OWNAVY/P4LPyIACEzEM=;
        b=Vuq75kP2DSamKpTm97zkOPcNTopnwoOU5AVkxHKvDQMGPd9iTOKaQnUWtSh+sBmjXp
         1NnQG/PGvrTguibPF44OLb1YJrpFmNx2wVtcA0py73CM11RxyzKKLCAcNSXvt/Y5dBJC
         AqlF0hU8vi7sy+u0Nm5K8AI1Yz3x2YO08yrAA/p52NVtKDsKFUhW14JJ6GNT7eZXFfuF
         AP7A6LrklhgrQ5gl9V1j+8ewPLpXwLpj/HReVzcNfor0TPQLjZwsASuX4QxnBrRHfW2C
         3EgAmtEVa5ZeCH/uFkq7LUDjeLKbaKhcfXkDKyZxgqVmlJiwCuVxgzy26xOq1xr66vzN
         PuJw==
X-Gm-Message-State: APjAAAVOxMPC5zDGCDUBHiw5VIyWIC3OYJ2mLcaS5adEh+mX/u+vz0Fn
        mKfBF5ItJlaW3rM4f9y3bKM=
X-Google-Smtp-Source: APXvYqwZIsELufro/apZKANBvYbuav5XunBjAgaDShMq6vd+vYkJ2aickX4Wp+WCq2PXzJ9kM5tq1A==
X-Received: by 2002:a50:9401:: with SMTP id p1mr8952979eda.189.1567077483603;
        Thu, 29 Aug 2019 04:18:03 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id y9sm388439eds.49.2019.08.29.04.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:18:02 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] iommu: virt: Use iommu_put_resv_regions_simple()
Date:   Thu, 29 Aug 2019 13:17:52 +0200
Message-Id: <20190829111752.17513-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829111752.17513-1-thierry.reding@gmail.com>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use the new standard function instead of open-coding it.

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/virtio-iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3ea9d7682999..bc3c7ab7f996 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -838,14 +838,6 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static void viommu_put_resv_regions(struct device *dev, struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 static struct iommu_ops viommu_ops;
 static struct virtio_driver virtio_iommu_drv;
 
@@ -915,7 +907,7 @@ static int viommu_add_device(struct device *dev)
 err_unlink_dev:
 	iommu_device_unlink(&viommu->iommu, dev);
 err_free_dev:
-	viommu_put_resv_regions(dev, &vdev->resv_regions);
+	iommu_put_resv_regions_simple(dev, &vdev->resv_regions);
 	kfree(vdev);
 
 	return ret;
@@ -933,7 +925,7 @@ static void viommu_remove_device(struct device *dev)
 
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&vdev->viommu->iommu, dev);
-	viommu_put_resv_regions(dev, &vdev->resv_regions);
+	iommu_put_resv_regions_simple(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
 
@@ -962,7 +954,7 @@ static struct iommu_ops viommu_ops = {
 	.remove_device		= viommu_remove_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.put_resv_regions	= viommu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.of_xlate		= viommu_of_xlate,
 };
 
-- 
2.22.0

