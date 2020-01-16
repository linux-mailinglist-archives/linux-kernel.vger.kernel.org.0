Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4515113DAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgAPMy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 07:54:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgAPMy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:54:59 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9BBD9299CC308E0F7886;
        Thu, 16 Jan 2020 20:54:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 20:54:47 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH -next] drm/nouveau: fix build error without CONFIG_IOMMU_API
Date:   Thu, 16 Jan 2020 20:50:10 +0800
Message-ID: <20200116125010.166572-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_IOMMU_API is n, build fails:

vers/gpu/drm/nouveau/nvkm/subdev/ltc/gp10b.c:37:9: error: implicit declaration of function dev_iommu_fwspec_get; did you mean iommu_fwspec_free? [-Werror=implicit-function-declaration]
  spec = dev_iommu_fwspec_get(device->dev);
         ^~~~~~~~~~~~~~~~~~~~
         iommu_fwspec_free
drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp10b.c:37:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  spec = dev_iommu_fwspec_get(device->dev);
       ^
drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp10b.c:39:17: error: struct iommu_fwspec has no member named ids
   u32 sid = spec->ids[0] & 0xffff;

Seletc IOMMU_API under config DRM_NOUVEAU to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/gpu/drm/nouveau/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 9c990266..ce03693 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -2,6 +2,7 @@
 config DRM_NOUVEAU
 	tristate "Nouveau (NVIDIA) cards"
 	depends on DRM && PCI && MMU
+	select IOMMU_API
 	select FW_LOADER
 	select DRM_KMS_HELPER
 	select DRM_TTM
-- 
2.7.4

