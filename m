Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4946123C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGFQsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 12:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfGFQsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 12:48:30 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25EE120836;
        Sat,  6 Jul 2019 16:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562431709;
        bh=BZUv1pShBEQqlv2ihdlkRWLFlmzEqNY4ATRYHhmQCgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjGAb5A7LfqHN0C34VG4F0RQjxkgPj2OULTwmXwxKTBEKNf6AG6QMFxNMeKFwLVbJ
         Yr9GmGX8yWPrw7/1K8f5GUhegX4zOeZoyv/A3xRWpdp0tFQpOUlQzVqVDO5rgQ+Kg+
         5TBu0W2GkMyxhWyxB2mPCWa6xUcj1ZKag33US9hA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] mfd: aat2870: no need to check return value of debugfs_create functions
Date:   Sat,  6 Jul 2019 18:47:22 +0200
Message-Id: <20190706164722.18766-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190706164722.18766-1-gregkh@linuxfoundation.org>
References: <20190706164722.18766-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/aat2870-core.c  | 13 ++-----------
 include/linux/mfd/aat2870.h |  1 -
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index 9d3d90d386c2..51f4c10d2f36 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -334,18 +334,9 @@ static const struct file_operations aat2870_reg_fops = {
 static void aat2870_init_debugfs(struct aat2870_data *aat2870)
 {
 	aat2870->dentry_root = debugfs_create_dir("aat2870", NULL);
-	if (!aat2870->dentry_root) {
-		dev_warn(aat2870->dev,
-			 "Failed to create debugfs root directory\n");
-		return;
-	}
 
-	aat2870->dentry_reg = debugfs_create_file("regs", 0644,
-						  aat2870->dentry_root,
-						  aat2870, &aat2870_reg_fops);
-	if (!aat2870->dentry_reg)
-		dev_warn(aat2870->dev,
-			 "Failed to create debugfs register file\n");
+	debugfs_create_file("regs", 0644, aat2870->dentry_root, aat2870,
+			    &aat2870_reg_fops);
 }
 
 #else
diff --git a/include/linux/mfd/aat2870.h b/include/linux/mfd/aat2870.h
index f7316c29bdec..d9542246bd44 100644
--- a/include/linux/mfd/aat2870.h
+++ b/include/linux/mfd/aat2870.h
@@ -149,7 +149,6 @@ struct aat2870_data {
 
 	/* for debugfs */
 	struct dentry *dentry_root;
-	struct dentry *dentry_reg;
 };
 
 struct aat2870_subdev_info {
-- 
2.22.0

