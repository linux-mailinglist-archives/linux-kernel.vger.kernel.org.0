Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81936148B48
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbgAXPcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 10:32:50 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:38112 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387599AbgAXPct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:32:49 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jan 2020 10:32:49 EST
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id CF222118E4; Fri, 24 Jan 2020 15:25:40 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH 2/2] usb: hub: use non-removable-ports DT property
Date:   Fri, 24 Jan 2020 15:25:04 +0000
Message-Id: <20200124152504.23411-2-mans@mansr.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124152504.23411-1-mans@mansr.com>
References: <20200124152504.23411-1-mans@mansr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark any ports listed in the non-removable-ports DT property as
hardwired. This is useful for boards with built-in USB devices
that cannot be (or have not been) marked as fixed in hardware.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/usb/core/hub.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4ac74b354801..97f8f15fb632 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1366,6 +1366,9 @@ static int hub_configure(struct usb_hub *hub,
 	unsigned unit_load;
 	unsigned full_load;
 	unsigned maxchild;
+	struct property *prop;
+	const __be32 *cur;
+	u32 val;
 
 	hub->buffer = kmalloc(sizeof(*hub->buffer), GFP_KERNEL);
 	if (!hub->buffer) {
@@ -1667,6 +1670,19 @@ static int hub_configure(struct usb_hub *hub,
 		}
 	}
 
+	of_property_for_each_u32(hub_dev->of_node, "non-removable-ports",
+				 prop, cur, val) {
+		if (val < 1 || val > hdev->maxchild) {
+			dev_warn(hub_dev,
+				 "bad port number %u in non-removable-ports\n",
+				 val);
+			continue;
+		}
+
+		hub->ports[val - 1]->connect_type =
+			USB_PORT_CONNECT_TYPE_HARD_WIRED;
+	}
+
 	usb_hub_adjust_deviceremovable(hdev, hub->descriptor);
 
 	hub_activate(hub, HUB_INIT);
-- 
2.25.0

