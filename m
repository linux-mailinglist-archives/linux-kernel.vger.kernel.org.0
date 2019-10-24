Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2400EE365F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503038AbfJXPTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 11:19:04 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:35798 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403837AbfJXPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:19:04 -0400
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id HTK22100Y5USYZQ01TK26f; Thu, 24 Oct 2019 17:19:02 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNetC-0006zB-IB; Thu, 24 Oct 2019 17:19:02 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNetC-0007hC-Gd; Thu, 24 Oct 2019 17:19:02 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] i3c: Spelling s/dicovered/discovered/
Date:   Thu, 24 Oct 2019 17:19:01 +0200
Message-Id: <20191024151901.29519-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspellings of "discovered".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 5c051dba32a51fa8..7f1e11b78371501a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2493,7 +2493,7 @@ int i3c_master_register(struct i3c_master_controller *master,
 
 	/*
 	 * We're done initializing the bus and the controller, we can now
-	 * register I3C devices dicovered during the initial DAA.
+	 * register I3C devices discovered during the initial DAA.
 	 */
 	master->init_done = true;
 	i3c_bus_normaluse_lock(&master->bus);
-- 
2.17.1

