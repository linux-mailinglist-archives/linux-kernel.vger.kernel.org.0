Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64F1BAC61
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 03:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391035AbfIWBYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 21:24:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390427AbfIWBYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 21:24:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 506207C9861F3A22CD27;
        Mon, 23 Sep 2019 09:24:30 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 23 Sep 2019 09:24:22 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <sean@poorly.run>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <zhongjiang@huawei.com>
Subject: [PATCH] drm/vkms: Fix an undefined reference error in vkms_composer_worker
Date:   Mon, 23 Sep 2019 09:21:11 +0800
Message-ID: <1569201671-18489-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

I hit the following error when compile the kernel.

drivers/gpu/drm/vkms/vkms_composer.o: In function `vkms_composer_worker':
vkms_composer.c:(.text+0x5e4): undefined reference to `crc32_le'
make: *** [vmlinux] Error 1

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e67c194..285d649 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -257,6 +257,7 @@ config DRM_VKMS
 	tristate "Virtual KMS (EXPERIMENTAL)"
 	depends on DRM
 	select DRM_KMS_HELPER
+	select CRC32
 	default n
 	help
 	  Virtual Kernel Mode-Setting (VKMS) is used for testing or for
-- 
1.7.12.4

