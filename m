Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E9321594
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 10:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfEQIqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 04:46:20 -0400
Received: from smtpbg202.qq.com ([184.105.206.29]:60676 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbfEQIqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:46:20 -0400
X-QQ-mid: bizesmtp16t1558082773tm07v0xa
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 17 May 2019 16:46:07 +0800 (CST)
X-QQ-SSF: 01400000000000H0HH32B00A0000000
X-QQ-FEAT: CFH4W+6pIGx1dJE2Hd1A+5u95gxttT7bEag7TWWOa4cDVjC/xNT1V6RQJB1Xo
        jnBLKAmsznvjtywdbljTIWWgZmPmQU4po06R+W9mXx7x+DbYOf6O3hCkEbry3Evs0QMf8rg
        A1nbpNwlShiHZD+YA4fXz/DA8KB2UE9irk2ERQFcIRskVUblI2yMBGnTi8kYP/YUH0/OcUu
        LUaJkGfnND0zIbLx0BofW4fgOSH5oX5iSiYEYWWT2jbnziGMZIqiKepA2GChIp2I8VyeGZS
        zQnty7doCaOryy67wc484PZ8Q6yI4eFsw6KGsX+xd9M2MiNhayiOWSIxg7glKXHC4iYA==
X-QQ-GoodBg: 2
From:   xiaolinkui <xiaolinkui@kylinos.cn>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        xinhui.pan@amd.com, evan.quan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn
Subject: [PATCH] gpu: drm: use struct_size() in kmalloc()
Date:   Fri, 17 May 2019 16:46:00 +0800
Message-Id: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() helper to keep code simple.

Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 22bd21e..4717a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1375,8 +1375,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	if (con)
 		return 0;
 
-	con = kmalloc(sizeof(struct amdgpu_ras) +
-			sizeof(struct ras_manager) * AMDGPU_RAS_BLOCK_COUNT,
+	con = kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT),
 			GFP_KERNEL|__GFP_ZERO);
 	if (!con)
 		return -ENOMEM;
-- 
2.7.4



