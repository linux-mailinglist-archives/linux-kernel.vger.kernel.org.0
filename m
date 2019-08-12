Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B4F897DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 09:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfHLHa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 03:30:26 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:54498 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfHLHa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:30:26 -0400
Received: from ramsan ([84.194.98.4])
        by baptiste.telenet-ops.be with bizsmtp
        id o7WN2000105gfCL017WN0K; Mon, 12 Aug 2019 09:30:22 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hx4mb-0007Nm-VU; Mon, 12 Aug 2019 09:30:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hx4mb-0004yw-Sd; Mon, 12 Aug 2019 09:30:21 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     kbuild test robot <lkp@intel.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: atari: Rename shifter to shifter_st to avoid conflict
Date:   Mon, 12 Aug 2019 09:30:20 +0200
Message-Id: <20190812073020.19109-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When test-compiling the BCM2835 pin control driver on m68k:

    In file included from arch/m68k/include/asm/io_mm.h:32:0,
                     from arch/m68k/include/asm/io.h:8,
                     from include/linux/io.h:13,
                     from include/linux/irq.h:20,
                     from include/linux/gpio/driver.h:7,
                     from drivers/pinctrl/bcm/pinctrl-bcm2835.c:17:
    drivers/pinctrl/bcm/pinctrl-bcm2835.c: In function 'bcm2711_pull_config_set':
    arch/m68k/include/asm/atarihw.h:190:22: error: expected identifier or '(' before 'volatile'
     # define shifter ((*(volatile struct SHIFTER *)SHF_BAS))

"shifter" is a too generic name for a global definition.

As the corresponding definition for Atari TT is already called
"shifter_tt", fix this by renaming the definition for Atari ST to
"shifter_st".

Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k tree for v5.4.

 arch/m68k/atari/config.c        |  6 ++---
 arch/m68k/include/asm/atarihw.h |  4 ++--
 drivers/video/fbdev/atafb.c     | 42 ++++++++++++++++-----------------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index 902255e7b5b2ad56..73bf5ea9ee1bf1cf 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -246,9 +246,9 @@ void __init config_atari(void)
 	} else if (hwreg_present(tt_palette)) {
 		ATARIHW_SET(TT_SHIFTER);
 		pr_cont(" TT_SHIFTER");
-	} else if (hwreg_present(&shifter.bas_hi)) {
-		if (hwreg_present(&shifter.bas_lo) &&
-		    (shifter.bas_lo = 0x0aau, shifter.bas_lo == 0x0aau)) {
+	} else if (hwreg_present(&shifter_st.bas_hi)) {
+		if (hwreg_present(&shifter_st.bas_lo) &&
+		    (shifter_st.bas_lo = 0x0aau, shifter_st.bas_lo == 0x0aau)) {
 			ATARIHW_SET(EXTD_SHIFTER);
 			pr_cont(" EXTD_SHIFTER");
 		} else {
diff --git a/arch/m68k/include/asm/atarihw.h b/arch/m68k/include/asm/atarihw.h
index 533008262b691ad9..13828dcc45ff79ac 100644
--- a/arch/m68k/include/asm/atarihw.h
+++ b/arch/m68k/include/asm/atarihw.h
@@ -170,7 +170,7 @@ static inline void dma_cache_maintenance( unsigned long paddr,
 #define TT_HIGH 6
 
 #define SHF_BAS (0xffff8200)
-struct SHIFTER
+struct SHIFTER_ST
  {
 	u_char pad1;
 	u_char bas_hi;
@@ -187,7 +187,7 @@ struct SHIFTER
 	u_char pad7;
 	u_char bas_lo;
  };
-# define shifter ((*(volatile struct SHIFTER *)SHF_BAS))
+# define shifter_st ((*(volatile struct SHIFTER_ST *)SHF_BAS))
 
 #define SHF_FBAS (0xffff820e)
 struct SHIFTER_F030
diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index fc9dfb0a95afc03e..51f5d1c56fd9c675 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -763,17 +763,17 @@ static void tt_get_par(struct atafb_par *par)
 {
 	unsigned long addr;
 	par->hw.tt.mode = shifter_tt.tt_shiftmode;
-	par->hw.tt.sync = shifter.syncmode;
-	addr = ((shifter.bas_hi & 0xff) << 16) |
-	       ((shifter.bas_md & 0xff) << 8)  |
-	       ((shifter.bas_lo & 0xff));
+	par->hw.tt.sync = shifter_st.syncmode;
+	addr = ((shifter_st.bas_hi & 0xff) << 16) |
+	       ((shifter_st.bas_md & 0xff) << 8)  |
+	       ((shifter_st.bas_lo & 0xff));
 	par->screen_base = atari_stram_to_virt(addr);
 }
 
 static void tt_set_par(struct atafb_par *par)
 {
 	shifter_tt.tt_shiftmode = par->hw.tt.mode;
-	shifter.syncmode = par->hw.tt.sync;
+	shifter_st.syncmode = par->hw.tt.sync;
 	/* only set screen_base if really necessary */
 	if (current_par.screen_base != par->screen_base)
 		fbhw->set_screen_base(par->screen_base);
@@ -1543,7 +1543,7 @@ static void falcon_get_par(struct atafb_par *par)
 	hw->f_shift = videl.f_shift;
 	hw->vid_control = videl.control;
 	hw->vid_mode = videl.mode;
-	hw->sync = shifter.syncmode & 0x1;
+	hw->sync = shifter_st.syncmode & 0x1;
 	hw->xoffset = videl.xoffset & 0xf;
 	hw->hht = videl.hht;
 	hw->hbb = videl.hbb;
@@ -1558,9 +1558,9 @@ static void falcon_get_par(struct atafb_par *par)
 	hw->vde = videl.vde;
 	hw->vss = videl.vss;
 
-	addr = (shifter.bas_hi & 0xff) << 16 |
-	       (shifter.bas_md & 0xff) << 8  |
-	       (shifter.bas_lo & 0xff);
+	addr = (shifter_st.bas_hi & 0xff) << 16 |
+	       (shifter_st.bas_md & 0xff) << 8  |
+	       (shifter_st.bas_lo & 0xff);
 	par->screen_base = atari_stram_to_virt(addr);
 
 	/* derived parameters */
@@ -1605,7 +1605,7 @@ static irqreturn_t falcon_vbl_switcher(int irq, void *dummy)
 			/* Turn off external clocks. Read sets all output bits to 1. */
 			*(volatile unsigned short *)0xffff9202;
 		}
-		shifter.syncmode = hw->sync;
+		shifter_st.syncmode = hw->sync;
 
 		videl.hht = hw->hht;
 		videl.hbb = hw->hbb;
@@ -1952,18 +1952,18 @@ static void stste_get_par(struct atafb_par *par)
 {
 	unsigned long addr;
 	par->hw.st.mode = shifter_tt.st_shiftmode;
-	par->hw.st.sync = shifter.syncmode;
-	addr = ((shifter.bas_hi & 0xff) << 16) |
-	       ((shifter.bas_md & 0xff) << 8);
+	par->hw.st.sync = shifter_st.syncmode;
+	addr = ((shifter_st.bas_hi & 0xff) << 16) |
+	       ((shifter_st.bas_md & 0xff) << 8);
 	if (ATARIHW_PRESENT(EXTD_SHIFTER))
-		addr |= (shifter.bas_lo & 0xff);
+		addr |= (shifter_st.bas_lo & 0xff);
 	par->screen_base = atari_stram_to_virt(addr);
 }
 
 static void stste_set_par(struct atafb_par *par)
 {
 	shifter_tt.st_shiftmode = par->hw.st.mode;
-	shifter.syncmode = par->hw.st.sync;
+	shifter_st.syncmode = par->hw.st.sync;
 	/* only set screen_base if really necessary */
 	if (current_par.screen_base != par->screen_base)
 		fbhw->set_screen_base(par->screen_base);
@@ -2018,10 +2018,10 @@ static void stste_set_screen_base(void *s_base)
 	unsigned long addr;
 	addr = atari_stram_to_phys(s_base);
 	/* Setup Screen Memory */
-	shifter.bas_hi = (unsigned char)((addr & 0xff0000) >> 16);
-	shifter.bas_md = (unsigned char)((addr & 0x00ff00) >> 8);
+	shifter_st.bas_hi = (unsigned char)((addr & 0xff0000) >> 16);
+	shifter_st.bas_md = (unsigned char)((addr & 0x00ff00) >> 8);
 	if (ATARIHW_PRESENT(EXTD_SHIFTER))
-		shifter.bas_lo = (unsigned char)(addr & 0x0000ff);
+		shifter_st.bas_lo = (unsigned char)(addr & 0x0000ff);
 }
 
 #endif /* ATAFB_STE */
@@ -2265,9 +2265,9 @@ static void set_screen_base(void *s_base)
 
 	addr = atari_stram_to_phys(s_base);
 	/* Setup Screen Memory */
-	shifter.bas_hi = (unsigned char)((addr & 0xff0000) >> 16);
-	shifter.bas_md = (unsigned char)((addr & 0x00ff00) >> 8);
-	shifter.bas_lo = (unsigned char)(addr & 0x0000ff);
+	shifter_st.bas_hi = (unsigned char)((addr & 0xff0000) >> 16);
+	shifter_st.bas_md = (unsigned char)((addr & 0x00ff00) >> 8);
+	shifter_st.bas_lo = (unsigned char)(addr & 0x0000ff);
 }
 
 static int pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
-- 
2.17.1

