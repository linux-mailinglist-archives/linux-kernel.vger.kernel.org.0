Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4317D4253B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 14:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfFLMNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 08:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfFLMNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:13:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B20A208C2;
        Wed, 12 Jun 2019 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560341586;
        bh=u6+QfhTdC84UGP3uD6drBmy8AzLg6rTBFjv6qN+rV7U=;
        h=From:To:Cc:Subject:Date:From;
        b=1i+HmfwBwxsBg4QZGtn5RFlNgABFojDI0lKlCihgLE8lZJpTlwf1rlNA6edMAzAJG
         DP18t54RXiluJz4zwvlAMjG8LlISemQL3+KMPUnb1ID8lnxndmkNa5Z9wHq9esN1A3
         LI+x/N1GoPcREOyHMTYDnrfmGcq1laGyvBCIetZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] platform: x86: acer-wmi: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:12:51 +0200
Message-Id: <20190612121258.19535-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Also, because there is no need to save the file dentry, remove the
variable that was saving it and just recursively delete the whole
directory.

Cc: "Lee, Chun-Yi" <jlee@suse.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/acer-wmi.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 521b526cd467..f8f0e98b1f0b 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -259,7 +259,6 @@ struct acer_data {
 
 struct acer_debug {
 	struct dentry *root;
-	struct dentry *devices;
 	u32 wmid_devices;
 };
 
@@ -2148,29 +2147,15 @@ static struct platform_device *acer_platform_device;
 
 static void remove_debugfs(void)
 {
-	debugfs_remove(interface->debug.devices);
-	debugfs_remove(interface->debug.root);
+	debugfs_remove_recursive(interface->debug.root);
 }
 
-static int __init create_debugfs(void)
+static void __init create_debugfs(void)
 {
 	interface->debug.root = debugfs_create_dir("acer-wmi", NULL);
-	if (!interface->debug.root) {
-		pr_err("Failed to create debugfs directory");
-		return -ENOMEM;
-	}
 
-	interface->debug.devices = debugfs_create_u32("devices", S_IRUGO,
-					interface->debug.root,
-					&interface->debug.wmid_devices);
-	if (!interface->debug.devices)
-		goto error_debugfs;
-
-	return 0;
-
-error_debugfs:
-	remove_debugfs();
-	return -ENOMEM;
+	debugfs_create_u32("devices", S_IRUGO, interface->debug.root,
+			   &interface->debug.wmid_devices);
 }
 
 static int __init acer_wmi_init(void)
@@ -2300,9 +2285,7 @@ static int __init acer_wmi_init(void)
 
 	if (wmi_has_guid(WMID_GUID2)) {
 		interface->debug.wmid_devices = get_wmid_devices();
-		err = create_debugfs();
-		if (err)
-			goto error_create_debugfs;
+		create_debugfs();
 	}
 
 	/* Override any initial settings with values from the commandline */
@@ -2310,8 +2293,6 @@ static int __init acer_wmi_init(void)
 
 	return 0;
 
-error_create_debugfs:
-	platform_device_del(acer_platform_device);
 error_device_add:
 	platform_device_put(acer_platform_device);
 error_device_alloc:
-- 
2.22.0

