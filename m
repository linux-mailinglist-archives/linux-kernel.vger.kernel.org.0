Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B565183318
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 15:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgCLOa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 10:30:59 -0400
Received: from comms.puri.sm ([159.203.221.185]:44610 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbgCLOa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:30:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id A94B4DF78E;
        Thu, 12 Mar 2020 07:30:56 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QBVKPZ1-cdnn; Thu, 12 Mar 2020 07:30:55 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [RFC PATCH] usb: dwc3: enable runtime PM for drd role switch / extcon
Date:   Thu, 12 Mar 2020 15:30:38 +0100
Message-Id: <20200312143038.11719-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: runtime PM currently needs to be enabled ("auto") manually via sysfs as
its power/control is set to "on" by the driver.

When runtime PM enabled, dwc3 currently doesn't resume when a cable is connected.
It only suspends after a cable is disconnected.

When using an extcon driver (for a different chip on the board), dwc3 can
register a hook for that. (Still undocumented -> TODO?).

Make sure, dwc3 is resumed when "set_mode" is being called by drd.

this is only a question about what's missing to properly keep runtime
PM enabled for dwc3 and if my change makes any sense at all. It seems
to work fine for me...

I'm glad about any hints on how to keep runtime PM enabled (at least when
having an extcon hook set up).

thanks,
                                martin
---
 drivers/usb/dwc3/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1d85c42b9c67..201b712bd961 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -118,6 +118,9 @@ static void __dwc3_set_mode(struct work_struct *work)
 	unsigned long flags;
 	int ret;
 
+	pm_runtime_mark_last_busy(dwc->dev);
+	pm_runtime_put_sync_autosuspend(dwc->dev);
+
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
 
@@ -196,6 +199,8 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 {
 	unsigned long flags;
 
+	pm_runtime_get_sync(dwc->dev);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->desired_dr_role = mode;
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -1552,7 +1557,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err5;
 
 	dwc3_debugfs_init(dwc);
-	pm_runtime_put(dev);
+	pm_runtime_put_sync(dev);
 
 	return 0;
 
-- 
2.20.1

