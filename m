Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD231138734
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 18:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbgALRRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 12:17:09 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:41796 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgALRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:17:08 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id pVH62100a5USYZQ01VH6BR; Sun, 12 Jan 2020 18:17:06 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgrK-0008Hr-KN; Sun, 12 Jan 2020 18:17:06 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgrK-0005tF-J1; Sun, 12 Jan 2020 18:17:06 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: amiga: Fix Denise detection on OCS
Date:   Sun, 12 Jan 2020 18:17:05 +0100
Message-Id: <20200112171705.22600-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "default" statement for detecting an original Denise chip seems to
be misplaced, causing original Denise chips not being detected.

Fix this by moving it from the outer to the inner "switch" statement.

Fortunately no code relies on this, but the detected version is printed
during boot, and available through /proc/hardware.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Untested due to lack of hardware.

  - Anyone with an old A2000 with accelerator running Linux?
  - The initital version of Denise does not have the DENISEID register,
    and reading it returns random data (last value seen on the bus).
    Has anyone ever seen it being mis-identified by Linux as Denise HR
    or Lisa?
---
 arch/m68k/amiga/config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index c32ab8041cf6b8dc..95bcd4a13bf86741 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -278,11 +278,11 @@ static void __init amiga_identify(void)
 			case 0x08:
 				AMIGAHW_SET(LISA);
 				break;
+			default:
+				AMIGAHW_SET(DENISE);
+				break;
 			}
 			break;
-		default:
-			AMIGAHW_SET(DENISE);
-			break;
 		}
 		switch ((amiga_custom.vposr>>8) & 0x7f) {
 		case 0x00:
-- 
2.17.1

