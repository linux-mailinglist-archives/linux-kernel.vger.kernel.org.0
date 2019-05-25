Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF2B2A476
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfEYMve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 08:51:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44472 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbfEYMve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 08:51:34 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CC0974FDD342C8E267CA;
        Sat, 25 May 2019 20:51:30 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 20:51:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oded.gabbay@gmail.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdkfd: Make deallocate_hiq_sdma_mqd static
Date:   Sat, 25 May 2019 20:51:09 +0800
Message-ID: <20190525125109.20992-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:1846:6:
 warning: symbol 'deallocate_hiq_sdma_mqd' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ece35c7a77b5..89bb8edc04bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1843,7 +1843,8 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	return NULL;
 }
 
-void deallocate_hiq_sdma_mqd(struct kfd_dev *dev, struct kfd_mem_obj *mqd)
+static void deallocate_hiq_sdma_mqd(struct kfd_dev *dev,
+				    struct kfd_mem_obj *mqd)
 {
 	WARN(!mqd, "No hiq sdma mqd trunk to free");
 
-- 
2.17.1


