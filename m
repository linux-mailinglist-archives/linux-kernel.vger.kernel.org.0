Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377E197094
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 05:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfHUD4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 23:56:10 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:17940 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfHUDz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:55:56 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7L3tQp2016439;
        Wed, 21 Aug 2019 12:55:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7L3tQp2016439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566359728;
        bh=vmQBAhaSJK2tNhLoMYDnGiXN0DBL3oiw2A5oHUe77Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BeqOvx+l3wYKOpFmrXRx1YZKFYf6ISYrjN9OdzhjVHLKdfQN0n0wuYwOrJYUwddl5
         IlfxPZXvkek1mxO5aTudwFQULJ2hZ4BDH/3wP4sjE2UAA93cyoz5zaJehikzqVdw3N
         Yp+5SOK656uLWcByPD+FV6Jcg7FmZb2AtwIZrtiWcTptreC03qSXMW7yB5783v7002
         EzrPjw6X/Ne+Ks9i0bMDS0pE/PWc0OLqlA4d5ggQARTuimoS7HV152sh+OxV+o6n2T
         4nSeM3Xy7OtJXWNwyTcHtdn6qZFt7/UakXm1PUGi11zuKNRlk4UsKMdet1KM9Dx4aH
         8SW25SFooxCZQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] video/logo: remove unneeded *.o pattern from clean-files
Date:   Wed, 21 Aug 2019 12:55:13 +0900
Message-Id: <20190821035517.21671-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821035517.21671-1-yamada.masahiro@socionext.com>
References: <20190821035517.21671-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern *.o is cleaned up globally by the top Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/video/logo/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 228a89b9bdd1..10b75ce3ce09 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -56,4 +56,4 @@ $(obj)/%_gray256.c: $(src)/%_gray256.pgm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
 # Files generated that shall be removed upon make clean
-clean-files := *.o *_mono.c *_vga16.c *_clut224.c *_gray256.c
+clean-files := *_mono.c *_vga16.c *_clut224.c *_gray256.c
-- 
2.17.1

