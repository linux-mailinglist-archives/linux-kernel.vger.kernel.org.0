Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82114E41D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 21:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgA3Ugt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 15:36:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36535 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgA3Ugt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:36:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so2090320pfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svzc273eNIwI5K8ESCCWdPw/f2JIAR9bYPfc0wTxaMM=;
        b=fDbUQKQTKBJMG01LuVENeNNOCCXJNkHqwK7iqJ0Ts36F6MzmIicptyqkxfq15xl4vb
         j45/Oe3+bPRFnuwDI2WEPrYFM36VqZC+xl384qfDVsfDHD1KIf2hMA2r4JB+WfaSB68m
         Bw8yoWnFyHcxa2OaLylgaS9hk/t/Hz2aMNyYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svzc273eNIwI5K8ESCCWdPw/f2JIAR9bYPfc0wTxaMM=;
        b=sHjjve6oNQv39Rfknjs+d1i4gaLNSTMxCadCF7ERmo0cJ8enbyVN57TXmgICZftXWx
         t8hb+MTl75bMBZs8EZVwDKSfMBSs04mf4OkvDogoplNimNGYTeC47qz6HQhJKyq2rGXZ
         USDfHVcy5q8x8qx2g2FpSW/QpvY74LlOx/ScwFOxw0qDhZS79tqSOMBe1A5UsrNeUm/l
         sk4qpzHnxpf1JaY1jBDI4F5D69QVHdLufmg3n2oel/hn0ZWaudxPA1QSWBSYyCKsiWvy
         kugIXnBZrKJZrlI3Tap5UEyXqe5uW6QPS+iT+KtePhEfMbO67C/cVvo+qzGV5xyKhrbR
         Djbw==
X-Gm-Message-State: APjAAAXxC+BTglxRIsXY+mrsbw2f3NBdEGuvCAYJ13LBuhWoETa/6/7/
        1iDTfv0/R132CLR5XUxyWSd6TbM3kqqwGQ==
X-Google-Smtp-Source: APXvYqxJClCFLnxaFZZk+sift7y7CU7H5nN8kYPpJ68tSTL4T0H+Om2h63Z4b0oIdlnv31R1dCeMLQ==
X-Received: by 2002:a63:5a23:: with SMTP id o35mr6491820pgb.4.1580416608457;
        Thu, 30 Jan 2020 12:36:48 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:36:48 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 17/17] platform/chrome: Drop cros_ec_cmd_xfer_status()
Date:   Thu, 30 Jan 2020 12:31:10 -0800
Message-Id: <20200130203106.201894-18-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove cros_ec_cmd_xfer_status() since all usages of that function
have been converted to cros_ec_send_cmd_msg().

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c     | 42 +++++----------------
 include/linux/platform_data/cros_ec_proto.h |  3 --
 2 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index efd1c0b6a830c8..8b97702ba97393 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -542,35 +542,6 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
 
-/**
- * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
- * @ec_dev: EC device.
- * @msg: Message to write.
- *
- * This function is identical to cros_ec_cmd_xfer, except it returns success
- * status only if both the command was transmitted successfully and the EC
- * replied with success status. It's not necessary to check msg->result when
- * using this function.
- *
- * Return: The number of bytes transferred on success or negative error code.
- */
-int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
-			    struct cros_ec_command *msg)
-{
-	int ret;
-
-	ret = cros_ec_cmd_xfer(ec_dev, msg);
-	if (ret < 0) {
-		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
-	} else if (msg->result != EC_RES_SUCCESS) {
-		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
-		return -EPROTO;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
-
 /**
  * cros_ec_send_cmd_msg() - Utility function to send commands to ChromeOS EC.
  * @ec: EC device struct.
@@ -581,10 +552,15 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
  * @indata: Data to be received from the EC.
  * @insize: Size of the &indata buffer.
  *
- * This function is a wrapper around &cros_ec_cmd_xfer_status, and performs
- * some of the common work involved with sending a command to the EC. This
- * includes allocating and filling up a &struct cros_ec_command message buffer,
- * and copying the received data to another buffer.
+ * This function is similar to cros_ec_cmd_xfer(), except it returns success
+ * status only if both the command was transmitted successfully and the EC
+ * replied with success status. It's not necessary to check msg->result when
+ * using this function.
+ *
+ * It also performs some of the common work involved with sending a command to
+ * the EC. This includes allocating and filling up a
+ * &struct cros_ec_command message buffer, and copying the received data to
+ * another buffer.
  *
  * Return: The number of bytes transferred on success or negative error code.
  */
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 166ce26bdd79eb..851bd9af582d94 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -198,9 +198,6 @@ int cros_ec_check_result(struct cros_ec_device *ec_dev,
 int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 		     struct cros_ec_command *msg);
 
-int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
-			    struct cros_ec_command *msg);
-
 int cros_ec_send_cmd_msg(struct cros_ec_device *ec_dev, unsigned int version,
 			 unsigned int command, void *outdata,
 			 unsigned int outsize, void *indata,
-- 
2.25.0.341.g760bfbb309-goog

