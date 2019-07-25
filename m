Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7EF75116
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfGYO2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 10:28:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbfGYO2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:28:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EF37DF7F374C1751FBF9;
        Thu, 25 Jul 2019 22:27:59 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Jul 2019
 22:27:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <eric@anholt.net>, <wahrenst@gmx.net>,
        <gregkh@linuxfoundation.org>, <inf.braun@fau.de>,
        <nishkadg.linux@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: vc04_services: fix used-but-set-variable warning
Date:   Thu, 25 Jul 2019 22:27:16 +0800
Message-ID: <20190725142716.49276-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use variables 'local_entity_uc' and 'local_uc',
mute gcc used-but-set-variable warning:

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function vchiq_release_internal:
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:16: warning:
 variable local_entity_uc set but not used [-Wunused-but-set-variable]
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:6: warning:
 variable local_uc set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index cc4383d..04e6427 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2861,15 +2861,13 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
 		} else {
 			vchiq_log_info(vchiq_susp_log_level,
 				"%s %s count %d, state count %d - suspending",
-				__func__, entity, *entity_uc,
-				arm_state->videocore_use_count);
+				__func__, entity, local_entity_uc, local_uc);
 			vchiq_arm_vcsuspend(state);
 		}
 	} else
 		vchiq_log_trace(vchiq_susp_log_level,
 			"%s %s count %d, state count %d",
-			__func__, entity, *entity_uc,
-			arm_state->videocore_use_count);
+			__func__, entity, local_entity_uc, local_uc);
 
 unlock:
 	write_unlock_bh(&arm_state->susp_res_lock);
-- 
2.7.4


