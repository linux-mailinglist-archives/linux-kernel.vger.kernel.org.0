Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6D5102C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 00:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfD3Wv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 18:51:26 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45899 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727569AbfD3Wtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:49:53 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 May 2019 01:49:47 +0300
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x3UMncnY009688;
        Wed, 1 May 2019 01:49:45 +0300
From:   Parav Pandit <parav@mellanox.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com
Cc:     cjia@nvidia.com, parav@mellanox.com
Subject: [PATCHv2 04/10] vfio/mdev: Avoid masking error code to EBUSY
Date:   Tue, 30 Apr 2019 17:49:31 -0500
Message-Id: <20190430224937.57156-5-parav@mellanox.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190430224937.57156-1-parav@mellanox.com>
References: <20190430224937.57156-1-parav@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of masking return error to -EBUSY, return actual error
returned by the driver.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/vfio/mdev/mdev_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 00ca61392de9..836d31985f14 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -141,7 +141,7 @@ static int mdev_device_remove_ops(struct mdev_device *mdev, bool force_remove)
 	 */
 	ret = parent->ops->remove(mdev);
 	if (ret && !force_remove)
-		return -EBUSY;
+		return ret;
 
 	sysfs_remove_groups(&mdev->dev.kobj, parent->ops->mdev_attr_groups);
 	return 0;
-- 
2.19.2

