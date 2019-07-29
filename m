Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B02879C46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 00:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbfG2WLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 18:11:30 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35005 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388139AbfG2WL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:11:26 -0400
Received: by mail-pf1-f202.google.com with SMTP id r142so39330597pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L03s0/cCwSibWbjOlLSetg9NEt3OrkecIhAnIwN841s=;
        b=VrM9+6Jeuyus6gfzx0tt0vpujpOq1lM4J0CpFBP6EbVrDOiOcbDqT6YblvCCw8pIev
         Q27p2U31u9VmZP6HPR/K4hRpiEuyfh7y4GXjmPvJsvFKPuELyq6BPlAPDt4HlZMoSMmr
         OBah55/PaMNagby1o/DB0OIoqe7z6al8HNa/NCbY+hcV7kGFERpajO9Nmtwyq7afiFIg
         mDdIhHATE8xUOsPEriA7GyopHSLkb+ULW/BxNTGOovFIpJZDTHKiRXQYkBLsWWBwISUz
         aS3SXcyErlPtBxQ4CamHiGmmflWNr2eIICs47t7NSkNfNF2z3xawOSaF17yJmdJcjal4
         4wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L03s0/cCwSibWbjOlLSetg9NEt3OrkecIhAnIwN841s=;
        b=bVj/wSBvPvNfTE0PCi210Lir0z2IFzpjavW7WGsYwhDdSG10qucwBnv2McML2bO0f2
         KMQURplCyFNWBtwTVe8BtBHjOQ6cjz73zgBz8c41woLMR55cQDj2BLqXfhC6fdCi0cf4
         cwQBeB50+aETG/j6pdQ/x5X5i8PW3ll38UsYdN2JbW1LFWnKJazitFGt2ACrzlvLBpOF
         XCw7ITQw08gsxKbhHlNC0OI53bD4eLYdTYgBMzD5xI7CYh3/ijOGQCjOAYU0B5MuKFVP
         qoe6mB31RaCzSWwzAlxbxM4UhU/zIgCatfHyWnucwLsQOXti9P9O2RTQEAhUr/hhMUbF
         T2gg==
X-Gm-Message-State: APjAAAU7Np5W0E9i+1scoh6TZxdis7T0dVEHuxLxF+Gq67VMoiPCuJiK
        GomnnPWaewHStSRcvOWD8z3+qrxXVrFiI9E=
X-Google-Smtp-Source: APXvYqzDP8jpkSAzzKbaA1r99wk0GQdAWzUwsLuWQUct0DtdlcQ/Zd9FoZLjcSEA7m0zOZ7OMYAAXnRmeV4DUcc=
X-Received: by 2002:a65:5348:: with SMTP id w8mr105232049pgr.176.1564438284888;
 Mon, 29 Jul 2019 15:11:24 -0700 (PDT)
Date:   Mon, 29 Jul 2019 15:11:00 -0700
In-Reply-To: <20190729221101.228240-1-saravanak@google.com>
Message-Id: <20190729221101.228240-7-saravanak@google.com>
Mime-Version: 1.0
References: <20190729221101.228240-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v8 6/7] of/platform: Create device links for all
 child-supplier depencencies
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A parent device can have child devices that it adds when it probes. But
this probing of the parent device can happen way after kernel init is done
-- for example, when the parent device's driver is loaded as a module.

In such cases, if the child devices depend on a supplier in the system, we
need to make sure the supplier gets the sync_state() callback only after
these child devices are added and probed.

To achieve this, when creating device links for a device by looking at its
DT node, don't just look at DT references at the top node level. Look at DT
references in all the descendant nodes too and create device links from the
ancestor device to all these supplier devices.

This way, when the parent device probes and adds child devices, the child
devices can then create their own device links to the suppliers and further
delay the supplier's sync_state() callback to after the child devices are
probed.

Example:
In this illustration, -> denotes DT references and indentation
represents child status.

Device node A
	Device node B -> D
	Device node C -> B, D

Device node D

Assume all these devices have their drivers loaded as modules.

Without this patch, this is the sequence of events:
1. D is added.
2. A is added.
3. Device D probes.
4. Device D gets its sync_state() callback.
5. Device B and C might malfunction because their resources got
   altered/turned off before they can make active requests for them.

With this patch, this is the sequence of events:
1. D is added.
2. A is added and creates device links to D.
3. Device link from A to B is not added because A is a parent of B.
4. Device D probes.
5. Device D does not get it's sync_state() callback because consumer A
   hasn't probed yet.
5. Device A probes.
5. a. Devices B and C are added.
5. b. Device links from B and C to D are added.
5. c. Device A's probe completes.
6. Device D does not get it's sync_state() callback because consumer A
   has probed but consumers B and C haven't probed yet.
7. Device B and C probe.
8. Device D gets it's sync_state() callback because all its consumers
   have probed.
9. None of the devices malfunction.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 71d6138698ec..41499ddc8d95 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -655,24 +655,35 @@ static bool of_link_property(struct device *dev, struct device_node *con_np,
 	return done ? 0 : -ENODEV;
 }
 
+static int __of_link_to_suppliers(struct device *dev,
+				  struct device_node *con_np)
+{
+	struct device_node *child;
+	struct property *p;
+	bool done = true;
+
+	for_each_property_of_node(con_np, p)
+		if (of_link_property(dev, con_np, p->name))
+			done = false;
+
+	for_each_child_of_node(con_np, child)
+		if (__of_link_to_suppliers(dev, child))
+			done = false;
+
+	return done ? 0 : -ENODEV;
+}
+
 static bool of_devlink;
 core_param(of_devlink, of_devlink, bool, 0);
 
 static int of_link_to_suppliers(struct device *dev)
 {
-	struct property *p;
-	bool done = true;
-
 	if (!of_devlink)
 		return 0;
 	if (unlikely(!dev->of_node))
 		return 0;
 
-	for_each_property_of_node(dev->of_node, p)
-		if (of_link_property(dev, dev->of_node, p->name))
-			done = false;
-
-	return done ? 0 : -ENODEV;
+	return __of_link_to_suppliers(dev, dev->of_node);
 }
 
 #ifndef CONFIG_PPC
-- 
2.22.0.709.g102302147b-goog

