Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A33C12457B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 12:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfLRLR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 06:17:56 -0500
Received: from foss.arm.com ([217.140.110.172]:42378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLRLRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:17:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D947711B3;
        Wed, 18 Dec 2019 03:17:53 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 362D23F6CF;
        Wed, 18 Dec 2019 03:17:53 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 07/11] firmware: arm_scmi: Skip protocol initialisation for additional devices
Date:   Wed, 18 Dec 2019 11:17:38 +0000
Message-Id: <20191218111742.29731-8-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218111742.29731-1-sudeep.holla@arm.com>
References: <20191218111742.29731-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scmi bus now supports adding multiple devices per protocol,
and since scmi_protocol_init is called for each scmi device created,
we must avoid allocating protocol private data and initialising the
protocol itself if it is already initialised.

In order to achieve the same, we can simple replace the idr pointer
from protocol initialisation function to a dummy function.

Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 3714e6307b05..db55c43a2cbd 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -60,6 +60,11 @@ static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
 	return fn(handle);
 }
 
+static int scmi_protocol_dummy_init(struct scmi_handle *handle)
+{
+	return 0;
+}
+
 static int scmi_dev_probe(struct device *dev)
 {
 	struct scmi_driver *scmi_drv = to_scmi_driver(dev->driver);
@@ -78,6 +83,10 @@ static int scmi_dev_probe(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Skip protocol initialisation for additional devices */
+	idr_replace(&scmi_protocols, &scmi_protocol_dummy_init,
+		    scmi_dev->protocol_id);
+
 	return scmi_drv->probe(scmi_dev);
 }
 
-- 
2.17.1

