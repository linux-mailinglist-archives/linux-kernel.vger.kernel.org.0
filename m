Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55341661A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 16:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgBTP7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 10:59:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47622 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgBTP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:59:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C96B92951A0
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        pmalani@chromium.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Enrico Granata <egranata@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 8/8] platform/chrome: cros_ec_proto: Do not export cros_ec_cmd_xfer()
Date:   Thu, 20 Feb 2020 16:58:59 +0100
Message-Id: <20200220155859.906647-9-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220155859.906647-1-enric.balletbo@collabora.com>
References: <20200220155859.906647-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the remaining users of cros_ec_cmd_xfer() has been removed,
make this function private to the cros_ec_proto module.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_proto.c     | 5 ++---
 include/linux/platform_data/cros_ec_proto.h | 3 ---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 3e745e0fe092..11a2db7cd0f7 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -496,8 +496,8 @@ EXPORT_SYMBOL(cros_ec_query_all);
  *
  * Return: 0 on success or negative error code.
  */
-int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
-		     struct cros_ec_command *msg)
+static int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
+			    struct cros_ec_command *msg)
 {
 	int ret;
 
@@ -541,7 +541,6 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(cros_ec_cmd_xfer);
 
 /**
  * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index ba5914770191..1334fedc07cb 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -212,9 +212,6 @@ int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 int cros_ec_check_result(struct cros_ec_device *ec_dev,
 			 struct cros_ec_command *msg);
 
-int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
-		     struct cros_ec_command *msg);
-
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg);
 
-- 
2.25.0

