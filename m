Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B79A16619F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 16:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgBTP71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 10:59:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47606 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgBTP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:59:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 122CC29519F
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        pmalani@chromium.org
Subject: [PATCH 7/8] platform/chrome: cros_ec: Use cros_ec_cmd_xfer_status helper
Date:   Thu, 20 Feb 2020 16:58:58 +0100
Message-Id: <20200220155859.906647-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220155859.906647-1-enric.balletbo@collabora.com>
References: <20200220155859.906647-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes use of cros_ec_cmd_xfer_status() instead of
cros_ec_cmd_xfer(). In this case the change is trivial and the only
reason to do it is because we want to make cros_ec_cmd_xfer() a private
function for the EC protocol and let people only use the
cros_ec_cmd_xfer_status() to return Linux standard error codes.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 6fc8f2c3ac51..e179411bdfbe 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -120,7 +120,7 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 
 	buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
 
-	ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
+	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
 
 	/* For now, report failure to transition to S0ix with a warning. */
 	if (ret >= 0 && ec_dev->host_sleep_v1 &&
-- 
2.25.0

