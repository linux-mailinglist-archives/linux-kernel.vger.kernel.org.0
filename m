Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7E11150F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 14:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLFNWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 08:22:23 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:43580 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLFNWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:22:22 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id adNL2100i5USYZQ06dNLw0; Fri, 06 Dec 2019 14:22:21 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1idDYq-0006Bo-Rm; Fri, 06 Dec 2019 14:22:20 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1idDYq-0007X1-QC; Fri, 06 Dec 2019 14:22:20 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] driver core: Print device when resources present in really_probe()
Date:   Fri,  6 Dec 2019 14:22:19 +0100
Message-Id: <20191206132219.28908-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device already has devres items attached before probing, a warning
backtrace is printed.  However, this backtrace does not reveal the
offending device, leaving the user uninformed.  Furthermore, using
WARN_ON() causes systems with panic-on-warn to reboot.

Fix this by replacing the WARN_ON() by a dev_crit() message.
Abort probing the device, to prevent doing more damage to the device's
resources.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Use dev_crit() instead of dev_WARN_ON(),
  - Abort probing, as this is a critical situation.
---
 drivers/base/dd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d811e60610d33ae9..b25bcab2a26bd2ad 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -516,7 +516,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
-	WARN_ON(!list_empty(&dev->devres_head));
+	if (!list_empty(&dev->devres_head)) {
+		dev_crit(dev, "Resources present before probing\n");
+		return -EBUSY;
+	}
 
 re_probe:
 	dev->driver = drv;
-- 
2.17.1

