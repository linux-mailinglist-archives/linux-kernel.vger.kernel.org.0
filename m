Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88B0768A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 15:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbfGZNqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 09:46:18 -0400
Received: from foss.arm.com ([217.140.110.172]:44048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388648AbfGZNqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:46:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84532152D;
        Fri, 26 Jul 2019 06:46:08 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C3E33F694;
        Fri, 26 Jul 2019 06:46:07 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 3/6] firmware: arm_scmi: Remove extra check for invalid length message responses
Date:   Fri, 26 Jul 2019 14:45:28 +0100
Message-Id: <20190726134531.8928-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726134531.8928-1-sudeep.holla@arm.com>
References: <20190726134531.8928-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scmi_xfer_get_init ensures both transmit and receive buffer lengths are
within the maximum limits. If receive buffer length is not supplied by
the caller, it's set to the maximum limit value. Receive buffer length
is never modified after that. So there's no need for the extra check
when receive transmit completion for a command essage.

Further, if the response header length is greater than the prescribed
receive buffer length, the response buffer is truncated to the latter.

Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b5bc4c7a8fab..6ef652940099 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -230,12 +230,6 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
 	xfer = &minfo->xfer_block[xfer_id];
 
 	scmi_dump_header_dbg(dev, &xfer->hdr);
-	/* Is the message of valid length? */
-	if (xfer->rx.len > info->desc->max_msg_size) {
-		dev_err(dev, "unable to handle %zu xfer(max %d)\n",
-			xfer->rx.len, info->desc->max_msg_size);
-		return;
-	}
 
 	scmi_fetch_response(xfer, mem);
 	complete(&xfer->done);
-- 
2.17.1

