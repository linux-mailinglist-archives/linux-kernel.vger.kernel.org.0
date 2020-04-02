Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D53119BA7B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 04:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgDBCtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 22:49:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732667AbgDBCtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:49:50 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D362E931DED58BC8DBED;
        Thu,  2 Apr 2020 10:49:48 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 10:49:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <yuehaibing@huawei.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 -next] vdpasim: Return status in vdpasim_get_status
Date:   Thu, 2 Apr 2020 10:49:16 +0800
Message-ID: <20200402024916.35192-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200331060858.32520-1-yuehaibing@huawei.com>
References: <20200331060858.32520-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdpasim->status should acquired under spin lock.

Fixes: 870448c31775 ("vdpasim: vDPA device simulator")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v3: rework based on commit a4be40cbcedb ("vdpa: move to drivers/vdpa")
v2: Fix patch title typo
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6e8a0cf2fdeb..72863d01a12a 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -488,7 +488,7 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
 	status = vdpasim->status;
 	spin_unlock(&vdpasim->lock);
 
-	return vdpasim->status;
+	return status;
 }
 
 static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
-- 
2.17.1


