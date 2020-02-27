Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CD217154D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 11:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgB0KqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 05:46:07 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40727 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgB0KqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:46:07 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1j7Gfv-0004MP-4D; Thu, 27 Feb 2020 11:45:51 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1j7Gft-0008Vq-Ch; Thu, 27 Feb 2020 11:45:49 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        rmk+kernel@arm.linux.org.uk, linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] component: allow missing unbind callback
Date:   Thu, 27 Feb 2020 11:45:47 +0100
Message-Id: <20200227104547.30085-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The component framework reuses the devres managed functions. There is no
need to specify an unbind() callback if the driver only wants to release
the devres managed resources. The bind/unbind is like the probe/remove
pair. The bind/probe is necessary and the unbind/remove is optional.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/base/component.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index c7879f5ae2fb..e97704104784 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -528,7 +528,8 @@ static void component_unbind(struct component *component,
 {
 	WARN_ON(!component->bound);
 
-	component->ops->unbind(component->dev, master->dev, data);
+	if (component->ops && component->ops->unbind)
+		component->ops->unbind(component->dev, master->dev, data);
 	component->bound = false;
 
 	/* Release all resources claimed in the binding of this component */
-- 
2.20.1

