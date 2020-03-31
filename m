Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A41198A97
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 05:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgCaDlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 23:41:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727358AbgCaDlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:41:11 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C76FF6A302195BD1C05E;
        Tue, 31 Mar 2020 11:41:08 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Tue, 31 Mar 2020
 11:41:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <yuehaibing@huawei.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] vdpasim: Rerun status in vdpasim_get_status
Date:   Tue, 31 Mar 2020 11:35:01 +0800
Message-ID: <20200331033501.31272-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
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


