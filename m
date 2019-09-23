Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E93BAC63
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 03:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391307AbfIWB2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 21:28:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390427AbfIWB2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 21:28:09 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5BDD59934B6DB95F0B3E;
        Mon, 23 Sep 2019 09:28:07 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 23 Sep 2019 09:27:59 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <sean@poorly.run>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <zhongjiang@huawei.com>
Subject: [PATCH v2] drm/vkms: Fix an undefined reference error in vkms_composer_worker
Date:   Mon, 23 Sep 2019 09:24:43 +0800
Message-ID: <1569201883-18779-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hit the following error when compile the kernel.

drivers/gpu/drm/vkms/vkms_composer.o: In function `vkms_composer_worker':
vkms_composer.c:(.text+0x5e4): undefined reference to `crc32_le'
make: *** [vmlinux] Error 1

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
2.7.4

