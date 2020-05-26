Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13744198C17
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 08:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgCaGJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 02:09:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbgCaGJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 02:09:32 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B858550253D4B86CF4E7;
        Tue, 31 Mar 2020 14:09:29 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 31 Mar 2020
 14:09:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <yuehaibing@huawei.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] vdpasim: Return status in vdpasim_get_status
Date:   Tue, 31 Mar 2020 14:08:58 +0800
Message-ID: <20200331060858.32520-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200331033501.31272-1-yuehaibing@huawei.com>
References: <20200331033501.31272-1-yuehaibing@huawei.com>
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
v2: Fix patch title typo
---
 drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c b/drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c
index 6e8a0cf2fdeb..72863d01a12a 100644
--- a/drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c
@@ -488,7 +488,7 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
 	status = vdpasim->status;
 	spin_unlock(&vdpasim->lock);
 
-	return vdpasim->status;
+	return status;
 }
 
 static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
-- 
2.17.1


