Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B72316619D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 16:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgBTP7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 10:59:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47606 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgBTP7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:59:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 37C272951A9
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        pmalani@chromium.org
Subject: [PATCH 3/8] platform/chrome: cros_ec_vbc: Use cros_ec_cmd_xfer_status helper
Date:   Thu, 20 Feb 2020 16:58:54 +0100
Message-Id: <20200220155859.906647-4-enric.balletbo@collabora.com>
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

 drivers/platform/chrome/cros_ec_vbc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index 8edae465105c..46482d12cffe 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -40,7 +40,7 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
 	msg->outsize = para_sz;
 	msg->insize = resp_sz;
 
-	err = cros_ec_cmd_xfer(ecdev, msg);
+	err = cros_ec_cmd_xfer_status(ecdev, msg);
 	if (err < 0) {
 		dev_err(dev, "Error sending read request: %d\n", err);
 		kfree(msg);
@@ -83,7 +83,7 @@ static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
 	msg->outsize = para_sz;
 	msg->insize = 0;
 
-	err = cros_ec_cmd_xfer(ecdev, msg);
+	err = cros_ec_cmd_xfer_status(ecdev, msg);
 	if (err < 0) {
 		dev_err(dev, "Error sending write request: %d\n", err);
 		kfree(msg);
-- 
2.25.0

