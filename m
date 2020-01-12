Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECDD138718
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 17:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbgALQuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 11:50:04 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:33000 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbgALQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:49:53 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id pUpr210055USYZQ01UprH8; Sun, 12 Jan 2020 17:49:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQw-0007yI-Um; Sun, 12 Jan 2020 17:49:50 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQw-0005Gm-Tv; Sun, 12 Jan 2020 17:49:50 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/5] zorro: Use zorro_match_device() helper in zorro_bus_match()
Date:   Sun, 12 Jan 2020 17:49:47 +0100
Message-Id: <20200112164949.20196-4-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200112164949.20196-1-geert@linux-m68k.org>
References: <20200112164949.20196-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make zorro_bus_match() use the existing zorro_match_device() helper,
instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/zorro/zorro-driver.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/zorro/zorro-driver.c b/drivers/zorro/zorro-driver.c
index 67e68880554245e1..0dd7cbcec2b0d478 100644
--- a/drivers/zorro/zorro-driver.c
+++ b/drivers/zorro/zorro-driver.c
@@ -133,12 +133,7 @@ static int zorro_bus_match(struct device *dev, struct device_driver *drv)
 	if (!ids)
 		return 0;
 
-	while (ids->id) {
-		if (ids->id == ZORRO_WILDCARD || ids->id == z->id)
-			return 1;
-		ids++;
-	}
-	return 0;
+	return !!zorro_match_device(ids, z);
 }
 
 static int zorro_uevent(struct device *dev, struct kobj_uevent_env *env)
-- 
2.17.1

