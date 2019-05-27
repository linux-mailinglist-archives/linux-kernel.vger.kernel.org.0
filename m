Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A262B53D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfE0MaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 08:30:02 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:49454 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0MaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:30:01 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id HQVz2000N3XaVaC01QVzBV; Mon, 27 May 2019 14:29:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVElL-0001Us-KK; Mon, 27 May 2019 14:29:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVElL-0001kN-HZ; Mon, 27 May 2019 14:29:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] cpumask: Remove error message and backtrace on out-of-memory condition
Date:   Mon, 27 May 2019 14:29:58 +0200
Message-Id: <20190527122958.6667-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to print an error message and backtrace if
kmalloc_node() fails, as the memory allocation core already takes care
of that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/cpumask.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 0cb672eb107cef6e..61d85343dd50e61d 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -114,13 +114,6 @@ bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
 {
 	*mask = kmalloc_node(cpumask_size(), flags, node);
 
-#ifdef CONFIG_DEBUG_PER_CPU_MAPS
-	if (!*mask) {
-		printk(KERN_ERR "=> alloc_cpumask_var: failed!\n");
-		dump_stack();
-	}
-#endif
-
 	return *mask != NULL;
 }
 EXPORT_SYMBOL(alloc_cpumask_var_node);
-- 
2.17.1

