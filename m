Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3114ABE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfFRUei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 16:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730577AbfFRUeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:34:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86112AD72;
        Tue, 18 Jun 2019 20:34:36 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/3] fonts: Use BUILD_BUG_ON() for checking empty font table
Date:   Tue, 18 Jun 2019 22:34:24 +0200
Message-Id: <20190618203425.10723-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190618203425.10723-1-tiwai@suse.de>
References: <20190618203425.10723-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a nice macro, and the check of emptiness of the font table can
be done in a simpler way.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 lib/fonts/fonts.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index 269a829fcbb7..a8e31e9d6fc5 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -20,55 +20,41 @@
 #endif
 #include <linux/font.h>
 
-#define NO_FONTS
-
 static const struct font_desc *fonts[] = {
 #ifdef CONFIG_FONT_8x8
-#undef NO_FONTS
 	&font_vga_8x8,
 #endif
 #ifdef CONFIG_FONT_8x16
-#undef NO_FONTS
 	&font_vga_8x16,
 #endif
 #ifdef CONFIG_FONT_6x11
-#undef NO_FONTS
 	&font_vga_6x11,
 #endif
 #ifdef CONFIG_FONT_7x14
-#undef NO_FONTS
 	&font_7x14,
 #endif
 #ifdef CONFIG_FONT_SUN8x16
-#undef NO_FONTS
 	&font_sun_8x16,
 #endif
 #ifdef CONFIG_FONT_SUN12x22
-#undef NO_FONTS
 	&font_sun_12x22,
 #endif
 #ifdef CONFIG_FONT_10x18
-#undef NO_FONTS
 	&font_10x18,
 #endif
 #ifdef CONFIG_FONT_ACORN_8x8
-#undef NO_FONTS
 	&font_acorn_8x8,
 #endif
 #ifdef CONFIG_FONT_PEARL_8x8
-#undef NO_FONTS
 	&font_pearl_8x8,
 #endif
 #ifdef CONFIG_FONT_MINI_4x6
-#undef NO_FONTS
 	&font_mini_4x6,
 #endif
 #ifdef CONFIG_FONT_6x10
-#undef NO_FONTS
 	&font_6x10,
 #endif
 #ifdef CONFIG_FONT_TER16x32
-#undef NO_FONTS
 	&font_ter_16x32,
 #endif
 };
@@ -94,6 +80,7 @@ const struct font_desc *find_font(const char *name)
 {
 	unsigned int i;
 
+	BUILD_BUG_ON(!num_fonts);
 	for (i = 0; i < num_fonts; i++)
 		if (!strcmp(fonts[i]->name, name))
 			return fonts[i];
-- 
2.16.4

