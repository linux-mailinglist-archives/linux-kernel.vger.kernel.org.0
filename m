Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14458A5371
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 11:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfIBJxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 05:53:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46816 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731381AbfIBJxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:53:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B1F6C28CBBD
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>, arnd@arndb.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 07/10] mfd: cros_ec: Use kzalloc and cros_ec_cmd_xfer_status helper
Date:   Mon,  2 Sep 2019 11:53:06 +0200
Message-Id: <20190902095309.18574-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902095309.18574-1-enric.balletbo@collabora.com>
References: <20190902095309.18574-1-enric.balletbo@collabora.com>
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
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mfd/cros_ec_dev.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 091d428f5531..148f39c79f41 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -30,18 +30,15 @@ static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 
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
@@ -90,8 +87,8 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	params = (struct ec_params_motion_sense *)msg->data;
 	params->cmd = MOTIONSENSE_CMD_DUMP;
 
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
-	if (ret < 0 || msg->result != EC_RES_SUCCESS) {
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret < 0) {
 		dev_warn(ec->dev, "cannot get EC sensor information: %d/%d\n",
 			 ret, msg->result);
 		goto error;
@@ -118,8 +115,8 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
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

