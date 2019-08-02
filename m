Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5917E776
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 03:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfHBBYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 21:24:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726974AbfHBBYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:24:38 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 09B61C6E263045241A3D;
        Fri,  2 Aug 2019 09:24:37 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 2 Aug 2019 09:24:25 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Clark" <robdclark@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Eric Biggers" <ebiggers@google.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sean Paul <seanpaul@chromium.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/vgem: Fix wrong pointer passed to PTR_ERR()
Date:   Fri, 2 Aug 2019 01:29:20 +0000
Message-ID: <20190802012920.60344-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_ERR should access the value just tested by IS_ERR, otherwise
the wrong error code will be returned.

Fixes: 7e9e5ead55be ("drm/vgem: fix cache synchronization on arm/arm64")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index b98689fb0d5d..ef52546f48c4 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -304,10 +304,10 @@ static struct page **pin_and_sync(struct drm_vgem_gem_object *bo)
 	if (IS_ERR(sgt)) {
 		dev_err(dev->dev,
 			"failed to allocate sgt: %ld\n",
-			PTR_ERR(bo->table));
+			PTR_ERR(sgt));
 		drm_gem_put_pages(&bo->base, pages, false, false);
 		mutex_unlock(&bo->pages_lock);
-		return ERR_CAST(bo->table);
+		return ERR_CAST(sgt);
 	}
 
 	/*



