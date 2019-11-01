Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68CD8EC3FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 14:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfKANqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 09:46:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727296AbfKANqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 09:46:30 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AE60F80C6B319E22CD0B;
        Fri,  1 Nov 2019 21:46:26 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 21:46:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linux-graphics-maintainer@vmware.com>, <thellstrom@vmware.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/vmwgfx: remove set but not used variable 'srf'
Date:   Fri, 1 Nov 2019 21:46:11 +0800
Message-ID: <20191101134611.32456-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:339:22:
 warning: variable srf set but not used [-Wunused-but-set-variable]

'srf' is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 29d8794..de0530b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -336,7 +336,6 @@ static void vmw_hw_surface_destroy(struct vmw_resource *res)
 {
 
 	struct vmw_private *dev_priv = res->dev_priv;
-	struct vmw_surface *srf;
 	void *cmd;
 
 	if (res->func->destroy == vmw_gb_surface_destroy) {
@@ -360,7 +359,6 @@ static void vmw_hw_surface_destroy(struct vmw_resource *res)
 		 */
 
 		mutex_lock(&dev_priv->cmdbuf_mutex);
-		srf = vmw_res_to_srf(res);
 		dev_priv->used_memory_size -= res->backup_size;
 		mutex_unlock(&dev_priv->cmdbuf_mutex);
 	}
-- 
2.7.4


