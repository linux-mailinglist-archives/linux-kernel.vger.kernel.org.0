Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E367C34C05
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfFDPUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 11:20:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43076 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfFDPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:20:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DDB41285374
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        dtor@chromium.org
Subject: [PATCH 08/10] mfd: cros_ec: Use kzalloc and cros_ec_cmd_xfer_status helper
Date:   Tue,  4 Jun 2019 17:20:17 +0200
Message-Id: <20190604152019.16100-9-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604152019.16100-1-enric.balletbo@collabora.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes use of cros_ec_cmd_xfer_status() instead of
cros_ec_cmd_xfer() so we can remove some redundant code. It also uses
kzalloc instead of kmalloc so we can remove more redundant code.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/mfd/cros_ec_dev.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 658622807b41..5663fda3739c 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -29,18 +29,15 @@ static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 
 	if (ec->features[0] == -1U && ec->features[1] == -1U) {
 		/* features bitmap not read yet */
-
-		msg = kmalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
+		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
 		if (!msg)
 			return -ENOMEM;
 
-		msg->version = 0;
 		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
 		msg->insize = sizeof(ec->features);
-		msg->outsize = 0;
 
-		ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
-		if (ret < 0 || msg->result != EC_RES_SUCCESS) {
+		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+		if (ret < 0) {
 			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
 				 ret, msg->result);
 			memset(ec->features, 0, sizeof(ec->features));
@@ -89,8 +86,8 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	params = (struct ec_params_motion_sense *)msg->data;
 	params->cmd = MOTIONSENSE_CMD_DUMP;
 
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
-	if (ret < 0 || msg->result != EC_RES_SUCCESS) {
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret < 0) {
 		dev_warn(ec->dev, "cannot get EC sensor information: %d/%d\n",
 			 ret, msg->result);
 		goto error;
@@ -117,8 +114,8 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	for (i = 0; i < sensor_num; i++) {
 		params->cmd = MOTIONSENSE_CMD_INFO;
 		params->info.sensor_num = i;
-		ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
-		if (ret < 0 || msg->result != EC_RES_SUCCESS) {
+		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+		if (ret < 0) {
 			dev_warn(ec->dev, "no info for EC sensor %d : %d/%d\n",
 				 i, ret, msg->result);
 			continue;
-- 
2.20.1

