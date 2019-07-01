Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B9347DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 11:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfFQJHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 05:07:23 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:49426 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfFQJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:07:23 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id Rl7F2000E3XaVaC01l7FRk; Mon, 17 Jun 2019 11:07:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcnbf-0000nG-Ae; Mon, 17 Jun 2019 11:07:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcnbf-0002kb-8Q; Mon, 17 Jun 2019 11:07:15 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Geoff Levand <geoff@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ps3: Use [] to denote a flexible array member
Date:   Mon, 17 Jun 2019 11:07:13 +0200
Message-Id: <20190617090713.10532-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flexible array members should be denoted using [] instead of [0], else
gcc will not warn when they are no longer at the end of the structure.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/powerpc/include/asm/ps3stor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ps3stor.h b/arch/powerpc/include/asm/ps3stor.h
index d9f6589bc107bafa..1d8279014f226926 100644
--- a/arch/powerpc/include/asm/ps3stor.h
+++ b/arch/powerpc/include/asm/ps3stor.h
@@ -39,7 +39,7 @@ struct ps3_storage_device {
 	unsigned int num_regions;
 	unsigned long accessible_regions;
 	unsigned int region_idx;		/* first accessible region */
-	struct ps3_storage_region regions[0];	/* Must be last */
+	struct ps3_storage_region regions[];	/* Must be last */
 };
 
 static inline struct ps3_storage_device *to_ps3_storage_device(struct device *dev)
-- 
2.17.1

