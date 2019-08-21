Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033D2970D6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 06:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfHUENY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 00:13:24 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:47122 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfHUENW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:13:22 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7L4CeQD002060;
        Wed, 21 Aug 2019 13:12:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7L4CeQD002060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566360763;
        bh=Ffstt/8PGJwwxtxBre1W6DSDJ2YVkbwk2UqRJAoaJEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OR1LHhnA+Er5vOgGTRCZgC6jIKc4dC9Cg8YnqwHrVxpuDe1cNnaqI+14NwtxYfVRM
         sXbQVJgkzv+jrrZWYk5cwFWdJnrFLYbiKlbcRVlGB4OU2sASwY/0aC4spw1ahBK3aB
         e5zW3Y8TYY/PBBBGydwMY5kGdhT0Ow/lQ3l7p/+x80OGDAFNPMkssOAb2O35zeG7f8
         WacOTdhvNMquR4qzPDRi5Nu6/9ZR3MnMC7lp1gjAm5EWlTpFRdf+81xf9jVNMwFt/5
         GsFcVcsNDNWllRzXFsknLgQPhPatzS5EOUyKz3XDlw3QX1EAq7vPFn5/VLv48xHoM+
         xD48ux/rBy3kQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] video/logo: simplify cmd_logo
Date:   Wed, 21 Aug 2019 13:12:36 +0900
Message-Id: <20190821041237.23197-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821041237.23197-1-yamada.masahiro@socionext.com>
References: <20190821041237.23197-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the code. It still works in the same way.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/video/logo/Makefile | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 16f60c1e1766..7d672d40bf01 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -22,20 +22,15 @@ pnmtologo := scripts/pnmtologo
 
 # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
 quiet_cmd_logo = LOGO    $@
-	cmd_logo = $(pnmtologo) \
-			-t $(patsubst $*_%,%,$(notdir $(basename $<))) \
-			-n $(notdir $(basename $<)) -o $@ $<
+      cmd_logo = $(pnmtologo) -t $(lastword $(subst _, ,$*)) -n $* -o $@ $<
 
-$(obj)/%_mono.c: $(src)/%_mono.pbm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.pbm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
-$(obj)/%_vga16.c: $(src)/%_vga16.ppm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.ppm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
-$(obj)/%_clut224.c: $(src)/%_clut224.ppm $(pnmtologo) FORCE
-	$(call if_changed,logo)
-
-$(obj)/%_gray256.c: $(src)/%_gray256.pgm $(pnmtologo) FORCE
+$(obj)/%.c: $(src)/%.pgm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
 # generated C files
-- 
2.17.1

