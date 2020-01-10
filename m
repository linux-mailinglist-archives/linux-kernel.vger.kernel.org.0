Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEB71364C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 02:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgAJB3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 20:29:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730567AbgAJB3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:29:42 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5D29D34CFD4DE76F7EB0;
        Fri, 10 Jan 2020 09:29:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 10 Jan 2020 09:29:34 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/mgag200: Fix typo in parameter description
Date:   Fri, 10 Jan 2020 01:25:23 +0000
Message-ID: <20200110012523.33053-1-weiyongjun1@huawei.com>
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

Fix typo in parameter description.

Fixes: 3cacb2086e41 ("drm/mgag200: Add module parameter to pin all buffers at offset 0")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/mgag200/mgag200_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 7a5bad2f57d7..2236f8ef20a4 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -28,7 +28,7 @@ MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, mgag200_modeset, int, 0400);
 
 int mgag200_hw_bug_no_startadd = -1;
-MODULE_PARM_DESC(modeset, "HW does not interpret scanout-buffer start address correctly");
+MODULE_PARM_DESC(hw_bug_no_startadd, "HW does not interpret scanout-buffer start address correctly");
 module_param_named(hw_bug_no_startadd, mgag200_hw_bug_no_startadd, int, 0400);
 
 static struct drm_driver driver;



