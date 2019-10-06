Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410BACCF31
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 09:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfJFHo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 03:44:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbfJFHo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 03:44:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C1C11CD79D031C936330;
        Sun,  6 Oct 2019 15:44:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Sun, 6 Oct 2019 15:44:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <le.ma@amd.com>,
        <Yong.Zhao@amd.com>, <Trigger.Huang@amd.com>, <tao.zhou1@amd.com>,
        <Hawking.Zhang@amd.com>, <Felix.Kuehling@amd.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/amdgpu: remove duplicated include from mmhub_v1_0.c
Date:   Sun, 6 Oct 2019 07:44:04 +0000
Message-ID: <20191006074404.48416-1-yuehaibing@huawei.com>
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

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 4c7e8c64a94e..6965e1e6fa9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -31,7 +31,6 @@
 #include "vega10_enum.h"
 
 #include "soc15_common.h"
-#include "amdgpu_ras.h"
 
 #define mmDAGB0_CNTL_MISC2_RV 0x008f
 #define mmDAGB0_CNTL_MISC2_RV_BASE_IDX 0





