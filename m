Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2236138719
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 17:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbgALQuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 11:50:06 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:53700 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgALQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:49:53 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id pUpr210055USYZQ01UprS1; Sun, 12 Jan 2020 17:49:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQw-0007yK-VU; Sun, 12 Jan 2020 17:49:50 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQw-0005Gp-Ub; Sun, 12 Jan 2020 17:49:50 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/5] zorro: Remove unused zorro_dev_driver()
Date:   Sun, 12 Jan 2020 17:49:48 +0100
Message-Id: <20200112164949.20196-5-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200112164949.20196-1-geert@linux-m68k.org>
References: <20200112164949.20196-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function was never used.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/zorro.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/zorro.h b/include/linux/zorro.h
index cb72515b0ac17040..22f3f80fbcb5afe6 100644
--- a/include/linux/zorro.h
+++ b/include/linux/zorro.h
@@ -70,10 +70,6 @@ struct zorro_driver {
 /* New-style probing */
 extern int zorro_register_driver(struct zorro_driver *);
 extern void zorro_unregister_driver(struct zorro_driver *);
-static inline struct zorro_driver *zorro_dev_driver(const struct zorro_dev *z)
-{
-    return z->driver;
-}
 
 
 extern unsigned int zorro_num_autocon;	/* # of autoconfig devices found */
-- 
2.17.1

