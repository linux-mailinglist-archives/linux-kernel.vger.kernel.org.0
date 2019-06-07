Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F43891D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfFGLfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 07:35:15 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:33620 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfFGLfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:35:15 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id MnbC2000V3XaVaC01nbC0d; Fri, 07 Jun 2019 13:35:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD9M-0004Fw-SF; Fri, 07 Jun 2019 13:35:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD9M-0003vC-Py; Fri, 07 Jun 2019 13:35:12 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] mm/vmalloc: Spelling s/configuraion/configuration/
Date:   Fri,  7 Jun 2019 13:35:09 +0200
Message-Id: <20190607113509.15032-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7350a124524bb4b2..08b8b5a117576561 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2783,7 +2783,7 @@ static int aligned_vwrite(char *buf, char *addr, unsigned long count)
  * Note: In usual ops, vread() is never necessary because the caller
  * should know vmalloc() area is valid and can use memcpy().
  * This is for routines which have to access vmalloc area without
- * any informaion, as /dev/kmem.
+ * any information, as /dev/kmem.
  *
  * Return: number of bytes for which addr and buf should be increased
  * (same number as @count) or %0 if [addr...addr+count) doesn't
@@ -2862,7 +2862,7 @@ long vread(char *buf, char *addr, unsigned long count)
  * Note: In usual ops, vwrite() is never necessary because the caller
  * should know vmalloc() area is valid and can use memcpy().
  * This is for routines which have to access vmalloc area without
- * any informaion, as /dev/kmem.
+ * any information, as /dev/kmem.
  *
  * Return: number of bytes for which addr and buf should be
  * increased (same number as @count) or %0 if [addr...addr+count)
-- 
2.17.1

