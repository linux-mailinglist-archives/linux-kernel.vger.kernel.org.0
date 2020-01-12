Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C24138716
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 17:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbgALQty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 11:49:54 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:53696 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbgALQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:49:53 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id pUpr210045USYZQ01UprS0; Sun, 12 Jan 2020 17:49:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQw-0007yF-U7; Sun, 12 Jan 2020 17:49:50 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQw-0005Gi-TK; Sun, 12 Jan 2020 17:49:50 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/5] zorro: Fix zorro_bus_match() kerneldoc
Date:   Sun, 12 Jan 2020 17:49:46 +0100
Message-Id: <20200112164949.20196-3-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200112164949.20196-1-geert@linux-m68k.org>
References: <20200112164949.20196-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kerneldoc for zorro_bus_match() was obviously copied from
zorro_match_device(), but wasnt't updated for the different calling
context and semantics.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/zorro/zorro-driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/zorro/zorro-driver.c b/drivers/zorro/zorro-driver.c
index 84ac94aecb7966b8..67e68880554245e1 100644
--- a/drivers/zorro/zorro-driver.c
+++ b/drivers/zorro/zorro-driver.c
@@ -119,9 +119,9 @@ EXPORT_SYMBOL(zorro_unregister_driver);
      *  @ids: array of Zorro device id structures to search in
      *  @dev: the Zorro device structure to match against
      *
-     *  Used by a driver to check whether a Zorro device present in the
-     *  system is in its list of supported devices.Returns the matching
-     *  zorro_device_id structure or %NULL if there is no match.
+     *  Used by the driver core to check whether a Zorro device present in the
+     *  system is in a driver's list of supported devices.  Returns 1 if
+     *  supported, and 0 if there is no match.
      */
 
 static int zorro_bus_match(struct device *dev, struct device_driver *drv)
-- 
2.17.1

