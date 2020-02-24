Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2722716A018
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 09:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgBXIe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 03:34:56 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:40247 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgBXIe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:34:56 -0500
Received: from [109.168.11.45] (port=57856 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1j69CW-000pN8-1J; Mon, 24 Feb 2020 09:34:52 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-i3c@lists.infradead.org
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH] i3c: master: use 'dev' variable in dev_err
Date:   Mon, 24 Feb 2020 09:34:39 +0100
Message-Id: <20200224083439.3487-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_i3c_master_add_i2c_boardinfo() already has a handy 'dev' variable, use
it and simplify code.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7f8f896fa0c3..b56207bbed2b 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1953,7 +1953,7 @@ of_i3c_master_add_i2c_boardinfo(struct i3c_master_controller *master,
 	 * DEFSLVS command.
 	 */
 	if (boardinfo->base.flags & I2C_CLIENT_TEN) {
-		dev_err(&master->dev, "I2C device with 10 bit address not supported.");
+		dev_err(dev, "I2C device with 10 bit address not supported.");
 		return -ENOTSUPP;
 	}
 
-- 
2.25.0

