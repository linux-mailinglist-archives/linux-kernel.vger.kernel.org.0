Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601A716619C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 16:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgBTP7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 10:59:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47592 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgBTP7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:59:20 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5748829519F
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        pmalani@chromium.org
Subject: [PATCH 1/8] platform/chrome: cros_ec_proto: Report command not supported
Date:   Thu, 20 Feb 2020 16:58:52 +0100
Message-Id: <20200220155859.906647-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220155859.906647-1-enric.balletbo@collabora.com>
References: <20200220155859.906647-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In practice most drivers that use the EC protocol what really care is if
the result was successful or not, hence, we introduced a
cros_ec_cmd_xfer_status() function that converts EC errors to standard
Linux error codes. On some few cases, though, we are interested on know
if the command is supported or not, and in such cases, just ignore the
error. To achieve this, return a -ENOTSUPP error when the command is not
supported.

This will allow us to finish the conversion of all users to use the
cros_ec_cmd_xfer_status() function instead of cros_ec_cmd_xfer() and
make the latest private to the protocol driver, so users of the protocol
are not confused in which function they should use.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_proto.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 3cfa643f1d07..3e745e0fe092 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -553,7 +553,10 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
  * replied with success status. It's not necessary to check msg->result when
  * using this function.
  *
- * Return: The number of bytes transferred on success or negative error code.
+ * Return:
+ * >=0 - The number of bytes transferred
+ * -ENOTSUPP - Operation not supported
+ * -EPROTO - Protocol error
  */
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg)
@@ -563,6 +566,10 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret < 0) {
 		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
+	} else if (msg->result == EC_RES_INVALID_VERSION) {
+		dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
+			msg->result);
+		return -ENOTSUPP;
 	} else if (msg->result != EC_RES_SUCCESS) {
 		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
 		return -EPROTO;
-- 
2.25.0

