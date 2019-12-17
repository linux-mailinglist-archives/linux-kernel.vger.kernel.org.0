Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB6122AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 13:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfLQMLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 07:11:07 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:37388 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfLQMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:11:06 -0500
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihBgt-00062E-Iw; Tue, 17 Dec 2019 12:11:03 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1ihBgt-008xPS-Aj; Tue, 17 Dec 2019 12:11:03 +0000
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     ben.dooks@codethink.co.uk
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: make 'i3c_bus_set_mode' static
Date:   Tue, 17 Dec 2019 12:01:50 +0000
Message-Id: <20191217120150.2134326-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function i3c_bus_set_mode() is not declared or
exported, so make it static to avoid the following
warning:

drivers/i3c/master.c:530:5: warning: symbol 'i3c_bus_set_mode' was not declared. Should it be static?

If it is needed in the future, then it should be declared
and suitably exported.

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/i3c/master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 043691656245..7f8f896fa0c3 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -527,8 +527,8 @@ static const struct device_type i3c_masterdev_type = {
 	.groups	= i3c_masterdev_groups,
 };
 
-int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
-		     unsigned long max_i2c_scl_rate)
+static int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
+			    unsigned long max_i2c_scl_rate)
 {
 	struct i3c_master_controller *master = i3c_bus_to_i3c_master(i3cbus);
 
-- 
2.24.0

