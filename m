Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E74883EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 22:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfHIU3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 16:29:07 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38499 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbfHIU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:29:04 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MowT0-1ifiHM1SxC-00qQ8w; Fri, 09 Aug 2019 22:28:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 09/16] fbdev: remove w90x900/nuc900 platform drivers
Date:   Fri,  9 Aug 2019 22:27:37 +0200
Message-Id: <20190809202749.742267-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190809202749.742267-1-arnd@arndb.de>
References: <20190809202749.742267-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OWJd8Mlp6GosttFVeesvPBCF6H1qMbR45XoNLn6QCIT09DzgB8Z
 B3G2a3xY+i5R2Bbqyu7WNSaHKBB4iBms9lawabi7zdxxdzONbZvOuM1xtwd5CjGziCp/VhN
 Xioqckvrd1jLLowbm78XLPjlfGd8t+cTEjUzfyMOtD8oZt639ZEVYh7cmk5Qgw7kRprEGbo
 2yJdqc/5i5Fmij08/qryg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0m+dLqi+nP4=:2upQrvmukfpBS3SC2UnNKt
 PAu/rKUBjYp1S8hqobJgJKhd54h2O0S0PuBpuzW6+UmIrZmc04L1xQW40uuksIyk2x3vpWSOG
 Is5yDwAKXD2t14cjHcDTUkEtr6vPkopDMrCUlT0wMV7I2mlK90BeHtv8TMM0UDC0NOFBJLTj9
 QSdKkZ8NzEPvVcbNXy1qUM6ix2ofk4th0tHQoQMmnaV0pAcqu4UMP8aR1+zP4gNmZKLReIcdu
 ZzJCFxgeY1fo1HwkfRqCWWBQmhNqVOpgQX3p6pwi5Nr0MShyvRKMfUgGEkBY79b3pso+aOVd5
 tzpLSj5jcT0m5z0keKaAbsioW29Y6vkxez43xjOmeSeQ9zzKvrd7GrBkap9IUEhFjzeryT54/
 fpyZRMkhgKPZKcPTP+A7mQP8wD4+v8XAdASHeymPYhu/b3/dDAr9DrRqSzAZBiKIzWSwBMFp1
 0t2+5c6+rTil83khVdnyFJxB586quyaUEvl7Zhk6nwJWAs+QLXcxv+8HaclZmtr1ojUosAOvc
 WoKhR5Ju7pJU6Ezlmmzm/34m2Pqnz6ZRm011wB5b8sHPzS2XWsOcPUR0bf2HL80n0hUW9m5Xw
 4bzeLnhw1mbfv/26goOU3Gy4EmjiH7W6IDZ4vCfyGJ7+MNsuCr558bsA2zAEGugg9exSk6iNR
 DELZJnfSDQ6moTRednZqlTJkfavblwOw61cNB7E9eJikUU91J1AtNs/vkBiBLtuLN1bHTDr6/
 fMRneNx8QrS7yc3R0LnvqxoNVgCRmW3BORB6dw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM w90x900 platform is getting removed, so this driver is obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/Kconfig                  |  14 -
 drivers/video/fbdev/Makefile                 |   1 -
 drivers/video/fbdev/nuc900fb.c               | 760 -------------------
 drivers/video/fbdev/nuc900fb.h               |  51 --
 include/Kbuild                               |   1 -
 include/linux/platform_data/video-nuc900fb.h |  79 --
 6 files changed, 906 deletions(-)
 delete mode 100644 drivers/video/fbdev/nuc900fb.c
 delete mode 100644 drivers/video/fbdev/nuc900fb.h
 delete mode 100644 include/linux/platform_data/video-nuc900fb.h

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 6b2de93bd302..5f83cd715387 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1924,20 +1924,6 @@ config FB_S3C2410_DEBUG
 	  Turn on debugging messages. Note that you can set/unset at run time
 	  through sysfs
 
-config FB_NUC900
-	tristate "NUC900 LCD framebuffer support"
-	depends on FB && ARCH_W90X900
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	---help---
-	  Frame buffer driver for the built-in LCD controller in the Nuvoton
-	  NUC900 processor
-
-config GPM1040A0_320X240
-	bool "Giantplus Technology GPM1040A0 320x240 Color TFT LCD"
-	depends on FB_NUC900
-
 config FB_SM501
 	tristate "Silicon Motion SM501 framebuffer support"
 	depends on FB && MFD_SM501
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 7dc4861a93e6..aab7155884ea 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -116,7 +116,6 @@ obj-y                             += omap2/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
 obj-$(CONFIG_FB_CARMINE)          += carminefb.o
 obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
-obj-$(CONFIG_FB_NUC900)           += nuc900fb.o
 obj-$(CONFIG_FB_JZ4740)		  += jz4740_fb.o
 obj-$(CONFIG_FB_PUV3_UNIGFX)      += fb-puv3.o
 obj-$(CONFIG_FB_HYPERV)		  += hyperv_fb.o
diff --git a/drivers/video/fbdev/nuc900fb.c b/drivers/video/fbdev/nuc900fb.c
deleted file mode 100644
index 4fd851598584..000000000000
--- a/drivers/video/fbdev/nuc900fb.c
+++ /dev/null
@@ -1,760 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *
- * Copyright (c) 2009 Nuvoton technology corporation
- * All rights reserved.
- *
- *  Description:
- *    Nuvoton LCD Controller Driver
- *  Author:
- *    Wang Qiang (rurality.linux@gmail.com) 2009/12/11
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/tty.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/fb.h>
-#include <linux/init.h>
-#include <linux/dma-mapping.h>
-#include <linux/interrupt.h>
-#include <linux/workqueue.h>
-#include <linux/wait.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/cpufreq.h>
-#include <linux/io.h>
-#include <linux/pm.h>
-#include <linux/device.h>
-
-#include <mach/map.h>
-#include <mach/regs-clock.h>
-#include <mach/regs-ldm.h>
-#include <linux/platform_data/video-nuc900fb.h>
-
-#include "nuc900fb.h"
-
-
-/*
- *  Initialize the nuc900 video (dual) buffer address
- */
-static void nuc900fb_set_lcdaddr(struct fb_info *info)
-{
-	struct nuc900fb_info *fbi = info->par;
-	void __iomem *regs = fbi->io;
-	unsigned long vbaddr1, vbaddr2;
-
-	vbaddr1  = info->fix.smem_start;
-	vbaddr2  = info->fix.smem_start;
-	vbaddr2 += info->fix.line_length * info->var.yres;
-
-	/* set frambuffer start phy addr*/
-	writel(vbaddr1, regs + REG_LCM_VA_BADDR0);
-	writel(vbaddr2, regs + REG_LCM_VA_BADDR1);
-
-	writel(fbi->regs.lcd_va_fbctrl, regs + REG_LCM_VA_FBCTRL);
-	writel(fbi->regs.lcd_va_scale, regs + REG_LCM_VA_SCALE);
-}
-
-/*
- *	calculate divider for lcd div
- */
-static unsigned int nuc900fb_calc_pixclk(struct nuc900fb_info *fbi,
-					 unsigned long pixclk)
-{
-	unsigned long clk = fbi->clk_rate;
-	unsigned long long div;
-
-	/* pixclk is in picseconds. our clock is in Hz*/
-	/* div = (clk * pixclk)/10^12 */
-	div = (unsigned long long)clk * pixclk;
-	div >>= 12;
-	do_div(div, 625 * 625UL * 625);
-
-	dev_dbg(fbi->dev, "pixclk %ld, divisor is %lld\n", pixclk, div);
-
-	return div;
-}
-
-/*
- *	Check the video params of 'var'.
- */
-static int nuc900fb_check_var(struct fb_var_screeninfo *var,
-			       struct fb_info *info)
-{
-	struct nuc900fb_info *fbi = info->par;
-	struct nuc900fb_mach_info *mach_info = dev_get_platdata(fbi->dev);
-	struct nuc900fb_display *display = NULL;
-	struct nuc900fb_display *default_display = mach_info->displays +
-						   mach_info->default_display;
-	int i;
-
-	dev_dbg(fbi->dev, "check_var(var=%p, info=%p)\n", var, info);
-
-	/* validate x/y resolution */
-	/* choose default mode if possible */
-	if (var->xres == default_display->xres &&
-	    var->yres == default_display->yres &&
-	    var->bits_per_pixel == default_display->bpp)
-		display = default_display;
-	else
-		for (i = 0; i < mach_info->num_displays; i++)
-			if (var->xres == mach_info->displays[i].xres &&
-			    var->yres == mach_info->displays[i].yres &&
-			    var->bits_per_pixel == mach_info->displays[i].bpp) {
-				display = mach_info->displays + i;
-				break;
-			}
-
-	if (display == NULL) {
-		printk(KERN_ERR "wrong resolution or depth %dx%d at %d bit per pixel\n",
-			var->xres, var->yres, var->bits_per_pixel);
-		return -EINVAL;
-	}
-
-	/* it should be the same size as the display */
-	var->xres_virtual	= display->xres;
-	var->yres_virtual	= display->yres;
-	var->height		= display->height;
-	var->width		= display->width;
-
-	/* copy lcd settings */
-	var->pixclock		= display->pixclock;
-	var->left_margin	= display->left_margin;
-	var->right_margin	= display->right_margin;
-	var->upper_margin	= display->upper_margin;
-	var->lower_margin	= display->lower_margin;
-	var->vsync_len		= display->vsync_len;
-	var->hsync_len		= display->hsync_len;
-
-	var->transp.offset	= 0;
-	var->transp.length	= 0;
-
-	fbi->regs.lcd_dccs = display->dccs;
-	fbi->regs.lcd_device_ctrl = display->devctl;
-	fbi->regs.lcd_va_fbctrl = display->fbctrl;
-	fbi->regs.lcd_va_scale = display->scale;
-
-	/* set R/G/B possions */
-	switch (var->bits_per_pixel) {
-	case 1:
-	case 2:
-	case 4:
-	case 8:
-	default:
-		var->red.offset 	= 0;
-		var->red.length 	= var->bits_per_pixel;
-		var->green 		= var->red;
-		var->blue		= var->red;
-		break;
-	case 12:
-		var->red.length		= 4;
-		var->green.length	= 4;
-		var->blue.length	= 4;
-		var->red.offset		= 8;
-		var->green.offset	= 4;
-		var->blue.offset	= 0;
-		break;
-	case 16:
-		var->red.length		= 5;
-		var->green.length	= 6;
-		var->blue.length	= 5;
-		var->red.offset		= 11;
-		var->green.offset	= 5;
-		var->blue.offset	= 0;
-		break;
-	case 18:
-		var->red.length		= 6;
-		var->green.length	= 6;
-		var->blue.length	= 6;
-		var->red.offset		= 12;
-		var->green.offset	= 6;
-		var->blue.offset	= 0;
-		break;
-	case 32:
-		var->red.length		= 8;
-		var->green.length	= 8;
-		var->blue.length	= 8;
-		var->red.offset		= 16;
-		var->green.offset	= 8;
-		var->blue.offset	= 0;
-		break;
-	}
-
-	return 0;
-}
-
-/*
- *	Calculate lcd register values from var setting & save into hw
- */
-static void nuc900fb_calculate_lcd_regs(const struct fb_info *info,
-					struct nuc900fb_hw *regs)
-{
-	const struct fb_var_screeninfo *var = &info->var;
-	int vtt = var->height + var->upper_margin + var->lower_margin;
-	int htt = var->width + var->left_margin + var->right_margin;
-	int hsync = var->width + var->right_margin;
-	int vsync = var->height + var->lower_margin;
-
-	regs->lcd_crtc_size = LCM_CRTC_SIZE_VTTVAL(vtt) |
-			      LCM_CRTC_SIZE_HTTVAL(htt);
-	regs->lcd_crtc_dend = LCM_CRTC_DEND_VDENDVAL(var->height) |
-			      LCM_CRTC_DEND_HDENDVAL(var->width);
-	regs->lcd_crtc_hr = LCM_CRTC_HR_EVAL(var->width + 5) |
-			    LCM_CRTC_HR_SVAL(var->width + 1);
-	regs->lcd_crtc_hsync = LCM_CRTC_HSYNC_EVAL(hsync + var->hsync_len) |
-			       LCM_CRTC_HSYNC_SVAL(hsync);
-	regs->lcd_crtc_vr = LCM_CRTC_VR_EVAL(vsync + var->vsync_len) |
-			    LCM_CRTC_VR_SVAL(vsync);
-
-}
-
-/*
- *	Activate (set) the controller from the given framebuffer
- *	information
- */
-static void nuc900fb_activate_var(struct fb_info *info)
-{
-	struct nuc900fb_info *fbi = info->par;
-	void __iomem *regs = fbi->io;
-	struct fb_var_screeninfo *var = &info->var;
-	int clkdiv;
-
-	clkdiv = nuc900fb_calc_pixclk(fbi, var->pixclock) - 1;
-	if (clkdiv < 0)
-		clkdiv = 0;
-
-	nuc900fb_calculate_lcd_regs(info, &fbi->regs);
-
-	/* set the new lcd registers*/
-
-	dev_dbg(fbi->dev, "new lcd register set:\n");
-	dev_dbg(fbi->dev, "dccs       = 0x%08x\n", fbi->regs.lcd_dccs);
-	dev_dbg(fbi->dev, "dev_ctl    = 0x%08x\n", fbi->regs.lcd_device_ctrl);
-	dev_dbg(fbi->dev, "crtc_size  = 0x%08x\n", fbi->regs.lcd_crtc_size);
-	dev_dbg(fbi->dev, "crtc_dend  = 0x%08x\n", fbi->regs.lcd_crtc_dend);
-	dev_dbg(fbi->dev, "crtc_hr    = 0x%08x\n", fbi->regs.lcd_crtc_hr);
-	dev_dbg(fbi->dev, "crtc_hsync = 0x%08x\n", fbi->regs.lcd_crtc_hsync);
-	dev_dbg(fbi->dev, "crtc_vr    = 0x%08x\n", fbi->regs.lcd_crtc_vr);
-
-	writel(fbi->regs.lcd_device_ctrl, regs + REG_LCM_DEV_CTRL);
-	writel(fbi->regs.lcd_crtc_size, regs + REG_LCM_CRTC_SIZE);
-	writel(fbi->regs.lcd_crtc_dend, regs + REG_LCM_CRTC_DEND);
-	writel(fbi->regs.lcd_crtc_hr, regs + REG_LCM_CRTC_HR);
-	writel(fbi->regs.lcd_crtc_hsync, regs + REG_LCM_CRTC_HSYNC);
-	writel(fbi->regs.lcd_crtc_vr, regs + REG_LCM_CRTC_VR);
-
-	/* set lcd address pointers */
-	nuc900fb_set_lcdaddr(info);
-
-	writel(fbi->regs.lcd_dccs, regs + REG_LCM_DCCS);
-}
-
-/*
- *      Alters the hardware state.
- *
- */
-static int nuc900fb_set_par(struct fb_info *info)
-{
-	struct fb_var_screeninfo *var = &info->var;
-
-	switch (var->bits_per_pixel) {
-	case 32:
-	case 24:
-	case 18:
-	case 16:
-	case 12:
-		info->fix.visual = FB_VISUAL_TRUECOLOR;
-		break;
-	case 1:
-		info->fix.visual = FB_VISUAL_MONO01;
-		break;
-	default:
-		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-		break;
-	}
-
-	info->fix.line_length = (var->xres_virtual * var->bits_per_pixel) / 8;
-
-	/* activate this new configuration */
-	nuc900fb_activate_var(info);
-	return 0;
-}
-
-static inline unsigned int chan_to_field(unsigned int chan,
-					 struct fb_bitfield *bf)
-{
-	chan &= 0xffff;
-	chan >>= 16 - bf->length;
-	return chan << bf->offset;
-}
-
-static int nuc900fb_setcolreg(unsigned regno,
-			       unsigned red, unsigned green, unsigned blue,
-			       unsigned transp, struct fb_info *info)
-{
-	unsigned int val;
-
-	switch (info->fix.visual) {
-	case FB_VISUAL_TRUECOLOR:
-		/* true-colour, use pseuo-palette */
-		if (regno < 16) {
-			u32 *pal = info->pseudo_palette;
-
-			val  = chan_to_field(red, &info->var.red);
-			val |= chan_to_field(green, &info->var.green);
-			val |= chan_to_field(blue, &info->var.blue);
-			pal[regno] = val;
-		}
-		break;
-
-	default:
-		return 1;   /* unknown type */
-	}
-	return 0;
-}
-
-/**
- *      nuc900fb_blank
- *
- */
-static int nuc900fb_blank(int blank_mode, struct fb_info *info)
-{
-
-	return 0;
-}
-
-static struct fb_ops nuc900fb_ops = {
-	.owner			= THIS_MODULE,
-	.fb_check_var		= nuc900fb_check_var,
-	.fb_set_par		= nuc900fb_set_par,
-	.fb_blank		= nuc900fb_blank,
-	.fb_setcolreg		= nuc900fb_setcolreg,
-	.fb_fillrect		= cfb_fillrect,
-	.fb_copyarea		= cfb_copyarea,
-	.fb_imageblit		= cfb_imageblit,
-};
-
-
-static inline void modify_gpio(void __iomem *reg,
-			       unsigned long set, unsigned long mask)
-{
-	unsigned long tmp;
-	tmp = readl(reg) & ~mask;
-	writel(tmp | set, reg);
-}
-
-/*
- * Initialise LCD-related registers
- */
-static int nuc900fb_init_registers(struct fb_info *info)
-{
-	struct nuc900fb_info *fbi = info->par;
-	struct nuc900fb_mach_info *mach_info = dev_get_platdata(fbi->dev);
-	void __iomem *regs = fbi->io;
-
-	/*reset the display engine*/
-	writel(0, regs + REG_LCM_DCCS);
-	writel(readl(regs + REG_LCM_DCCS) | LCM_DCCS_ENG_RST,
-	       regs + REG_LCM_DCCS);
-	ndelay(100);
-	writel(readl(regs + REG_LCM_DCCS) & (~LCM_DCCS_ENG_RST),
-	       regs + REG_LCM_DCCS);
-	ndelay(100);
-
-	writel(0, regs + REG_LCM_DEV_CTRL);
-
-	/* config gpio output */
-	modify_gpio(W90X900_VA_GPIO + 0x54, mach_info->gpio_dir,
-		    mach_info->gpio_dir_mask);
-	modify_gpio(W90X900_VA_GPIO + 0x58, mach_info->gpio_data,
-		    mach_info->gpio_data_mask);
-
-	return 0;
-}
-
-
-/*
- *    Alloc the SDRAM region of NUC900 for the frame buffer.
- *    The buffer should be a non-cached, non-buffered, memory region
- *    to allow palette and pixel writes without flushing the cache.
- */
-static int nuc900fb_map_video_memory(struct fb_info *info)
-{
-	struct nuc900fb_info *fbi = info->par;
-	dma_addr_t map_dma;
-	unsigned long map_size = PAGE_ALIGN(info->fix.smem_len);
-
-	dev_dbg(fbi->dev, "nuc900fb_map_video_memory(fbi=%p) map_size %lu\n",
-		fbi, map_size);
-
-	info->screen_base = dma_alloc_wc(fbi->dev, map_size, &map_dma,
-					 GFP_KERNEL);
-
-	if (!info->screen_base)
-		return -ENOMEM;
-
-	memset(info->screen_base, 0x00, map_size);
-	info->fix.smem_start = map_dma;
-
-	return 0;
-}
-
-static inline void nuc900fb_unmap_video_memory(struct fb_info *info)
-{
-	struct nuc900fb_info *fbi = info->par;
-	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
-		    info->screen_base, info->fix.smem_start);
-}
-
-static irqreturn_t nuc900fb_irqhandler(int irq, void *dev_id)
-{
-	struct nuc900fb_info *fbi = dev_id;
-	void __iomem *regs = fbi->io;
-	void __iomem *irq_base = fbi->irq_base;
-	unsigned long lcdirq = readl(regs + REG_LCM_INT_CS);
-
-	if (lcdirq & LCM_INT_CS_DISP_F_STATUS) {
-		writel(readl(irq_base) | 1<<30, irq_base);
-
-		/* wait VA_EN low */
-		if ((readl(regs + REG_LCM_DCCS) &
-		    LCM_DCCS_SINGLE) == LCM_DCCS_SINGLE)
-			while ((readl(regs + REG_LCM_DCCS) &
-			       LCM_DCCS_VA_EN) == LCM_DCCS_VA_EN)
-				;
-		/* display_out-enable */
-		writel(readl(regs + REG_LCM_DCCS) | LCM_DCCS_DISP_OUT_EN,
-			regs + REG_LCM_DCCS);
-		/* va-enable*/
-		writel(readl(regs + REG_LCM_DCCS) | LCM_DCCS_VA_EN,
-			regs + REG_LCM_DCCS);
-	} else if (lcdirq & LCM_INT_CS_UNDERRUN_INT) {
-		writel(readl(irq_base) | LCM_INT_CS_UNDERRUN_INT, irq_base);
-	} else if (lcdirq & LCM_INT_CS_BUS_ERROR_INT) {
-		writel(readl(irq_base) | LCM_INT_CS_BUS_ERROR_INT, irq_base);
-	}
-
-	return IRQ_HANDLED;
-}
-
-#ifdef CONFIG_CPU_FREQ
-
-static int nuc900fb_cpufreq_transition(struct notifier_block *nb,
-				       unsigned long val, void *data)
-{
-	struct nuc900fb_info *info;
-	struct fb_info *fbinfo;
-	long delta_f;
-	info = container_of(nb, struct nuc900fb_info, freq_transition);
-	fbinfo = dev_get_drvdata(info->dev);
-
-	delta_f = info->clk_rate - clk_get_rate(info->clk);
-
-	if ((val == CPUFREQ_POSTCHANGE && delta_f > 0) ||
-	   (val == CPUFREQ_PRECHANGE && delta_f < 0)) {
-		info->clk_rate = clk_get_rate(info->clk);
-		nuc900fb_activate_var(fbinfo);
-	}
-
-	return 0;
-}
-
-static inline int nuc900fb_cpufreq_register(struct nuc900fb_info *fbi)
-{
-	fbi->freq_transition.notifier_call = nuc900fb_cpufreq_transition;
-	return cpufreq_register_notifier(&fbi->freq_transition,
-				  CPUFREQ_TRANSITION_NOTIFIER);
-}
-
-static inline void nuc900fb_cpufreq_deregister(struct nuc900fb_info *fbi)
-{
-	cpufreq_unregister_notifier(&fbi->freq_transition,
-				    CPUFREQ_TRANSITION_NOTIFIER);
-}
-#else
-static inline int nuc900fb_cpufreq_transition(struct notifier_block *nb,
-				       unsigned long val, void *data)
-{
-	return 0;
-}
-
-static inline int nuc900fb_cpufreq_register(struct nuc900fb_info *fbi)
-{
-	return 0;
-}
-
-static inline void nuc900fb_cpufreq_deregister(struct nuc900fb_info *info)
-{
-}
-#endif
-
-static char driver_name[] = "nuc900fb";
-
-static int nuc900fb_probe(struct platform_device *pdev)
-{
-	struct nuc900fb_info *fbi;
-	struct nuc900fb_display *display;
-	struct fb_info	   *fbinfo;
-	struct nuc900fb_mach_info *mach_info;
-	struct resource *res;
-	int ret;
-	int irq;
-	int i;
-	int size;
-
-	dev_dbg(&pdev->dev, "devinit\n");
-	mach_info = dev_get_platdata(&pdev->dev);
-	if (mach_info == NULL) {
-		dev_err(&pdev->dev,
-			"no platform data for lcd, cannot attach\n");
-		return -EINVAL;
-	}
-
-	if (mach_info->default_display > mach_info->num_displays) {
-		dev_err(&pdev->dev,
-			"default display No. is %d but only %d displays \n",
-			mach_info->default_display, mach_info->num_displays);
-		return -EINVAL;
-	}
-
-
-	display = mach_info->displays + mach_info->default_display;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for device\n");
-		return -ENOENT;
-	}
-
-	fbinfo = framebuffer_alloc(sizeof(struct nuc900fb_info), &pdev->dev);
-	if (!fbinfo)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, fbinfo);
-
-	fbi = fbinfo->par;
-	fbi->dev = &pdev->dev;
-
-#ifdef CONFIG_CPU_NUC950
-	fbi->drv_type = LCDDRV_NUC950;
-#endif
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	size = resource_size(res);
-	fbi->mem = request_mem_region(res->start, size, pdev->name);
-	if (fbi->mem == NULL) {
-		dev_err(&pdev->dev, "failed to alloc memory region\n");
-		ret = -ENOENT;
-		goto free_fb;
-	}
-
-	fbi->io = ioremap(res->start, size);
-	if (fbi->io == NULL) {
-		dev_err(&pdev->dev, "ioremap() of lcd registers failed\n");
-		ret = -ENXIO;
-		goto release_mem_region;
-	}
-
-	fbi->irq_base = fbi->io + REG_LCM_INT_CS;
-
-
-	/* Stop the LCD */
-	writel(0, fbi->io + REG_LCM_DCCS);
-
-	/* fill the fbinfo*/
-	strcpy(fbinfo->fix.id, driver_name);
-	fbinfo->fix.type		= FB_TYPE_PACKED_PIXELS;
-	fbinfo->fix.type_aux		= 0;
-	fbinfo->fix.xpanstep		= 0;
-	fbinfo->fix.ypanstep		= 0;
-	fbinfo->fix.ywrapstep		= 0;
-	fbinfo->fix.accel		= FB_ACCEL_NONE;
-	fbinfo->var.nonstd		= 0;
-	fbinfo->var.activate		= FB_ACTIVATE_NOW;
-	fbinfo->var.accel_flags		= 0;
-	fbinfo->var.vmode		= FB_VMODE_NONINTERLACED;
-	fbinfo->fbops			= &nuc900fb_ops;
-	fbinfo->flags			= FBINFO_FLAG_DEFAULT;
-	fbinfo->pseudo_palette		= &fbi->pseudo_pal;
-
-	ret = request_irq(irq, nuc900fb_irqhandler, 0, pdev->name, fbi);
-	if (ret) {
-		dev_err(&pdev->dev, "cannot register irq handler %d -err %d\n",
-			irq, ret);
-		ret = -EBUSY;
-		goto release_regs;
-	}
-
-	fbi->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(fbi->clk)) {
-		printk(KERN_ERR "nuc900-lcd:failed to get lcd clock source\n");
-		ret = PTR_ERR(fbi->clk);
-		goto release_irq;
-	}
-
-	clk_enable(fbi->clk);
-	dev_dbg(&pdev->dev, "got and enabled clock\n");
-
-	fbi->clk_rate = clk_get_rate(fbi->clk);
-
-	/* calutate the video buffer size */
-	for (i = 0; i < mach_info->num_displays; i++) {
-		unsigned long smem_len = mach_info->displays[i].xres;
-		smem_len *= mach_info->displays[i].yres;
-		smem_len *= mach_info->displays[i].bpp;
-		smem_len >>= 3;
-		if (fbinfo->fix.smem_len < smem_len)
-			fbinfo->fix.smem_len = smem_len;
-	}
-
-	/* Initialize Video Memory */
-	ret = nuc900fb_map_video_memory(fbinfo);
-	if (ret) {
-		printk(KERN_ERR "Failed to allocate video RAM: %x\n", ret);
-		goto release_clock;
-	}
-
-	dev_dbg(&pdev->dev, "got video memory\n");
-
-	fbinfo->var.xres = display->xres;
-	fbinfo->var.yres = display->yres;
-	fbinfo->var.bits_per_pixel = display->bpp;
-
-	nuc900fb_init_registers(fbinfo);
-
-	nuc900fb_check_var(&fbinfo->var, fbinfo);
-
-	ret = nuc900fb_cpufreq_register(fbi);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register cpufreq\n");
-		goto free_video_memory;
-	}
-
-	ret = register_framebuffer(fbinfo);
-	if (ret) {
-		printk(KERN_ERR "failed to register framebuffer device: %d\n",
-			ret);
-		goto free_cpufreq;
-	}
-
-	fb_info(fbinfo, "%s frame buffer device\n", fbinfo->fix.id);
-
-	return 0;
-
-free_cpufreq:
-	nuc900fb_cpufreq_deregister(fbi);
-free_video_memory:
-	nuc900fb_unmap_video_memory(fbinfo);
-release_clock:
-	clk_disable(fbi->clk);
-	clk_put(fbi->clk);
-release_irq:
-	free_irq(irq, fbi);
-release_regs:
-	iounmap(fbi->io);
-release_mem_region:
-	release_mem_region(res->start, size);
-free_fb:
-	framebuffer_release(fbinfo);
-	return ret;
-}
-
-/*
- * shutdown the lcd controller
- */
-static void nuc900fb_stop_lcd(struct fb_info *info)
-{
-	struct nuc900fb_info *fbi = info->par;
-	void __iomem *regs = fbi->io;
-
-	writel((~LCM_DCCS_DISP_INT_EN) | (~LCM_DCCS_VA_EN) | (~LCM_DCCS_OSD_EN),
-		regs + REG_LCM_DCCS);
-}
-
-/*
- *  Cleanup
- */
-static int nuc900fb_remove(struct platform_device *pdev)
-{
-	struct fb_info *fbinfo = platform_get_drvdata(pdev);
-	struct nuc900fb_info *fbi = fbinfo->par;
-	int irq;
-
-	nuc900fb_stop_lcd(fbinfo);
-	msleep(1);
-
-	unregister_framebuffer(fbinfo);
-	nuc900fb_cpufreq_deregister(fbi);
-	nuc900fb_unmap_video_memory(fbinfo);
-
-	iounmap(fbi->io);
-
-	irq = platform_get_irq(pdev, 0);
-	free_irq(irq, fbi);
-
-	release_resource(fbi->mem);
-	kfree(fbi->mem);
-
-	framebuffer_release(fbinfo);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-
-/*
- *	suspend and resume support for the lcd controller
- */
-
-static int nuc900fb_suspend(struct platform_device *dev, pm_message_t state)
-{
-	struct fb_info	   *fbinfo = platform_get_drvdata(dev);
-	struct nuc900fb_info *info = fbinfo->par;
-
-	nuc900fb_stop_lcd(fbinfo);
-	msleep(1);
-	clk_disable(info->clk);
-	return 0;
-}
-
-static int nuc900fb_resume(struct platform_device *dev)
-{
-	struct fb_info	   *fbinfo = platform_get_drvdata(dev);
-	struct nuc900fb_info *fbi = fbinfo->par;
-
-	printk(KERN_INFO "nuc900fb resume\n");
-
-	clk_enable(fbi->clk);
-	msleep(1);
-
-	nuc900fb_init_registers(fbinfo);
-	nuc900fb_activate_var(fbinfo);
-
-	return 0;
-}
-
-#else
-#define nuc900fb_suspend NULL
-#define nuc900fb_resume  NULL
-#endif
-
-static struct platform_driver nuc900fb_driver = {
-	.probe		= nuc900fb_probe,
-	.remove		= nuc900fb_remove,
-	.suspend	= nuc900fb_suspend,
-	.resume		= nuc900fb_resume,
-	.driver		= {
-		.name	= "nuc900-lcd",
-	},
-};
-
-module_platform_driver(nuc900fb_driver);
-
-MODULE_DESCRIPTION("Framebuffer driver for the NUC900");
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/nuc900fb.h b/drivers/video/fbdev/nuc900fb.h
deleted file mode 100644
index 055ae9297931..000000000000
--- a/drivers/video/fbdev/nuc900fb.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *
- * Copyright (c) 2009 Nuvoton technology corporation
- * All rights reserved.
- *
- *   Author:
- *        Wang Qiang(rurality.linux@gmail.com)  2009/12/16
- */
-
-#ifndef __NUC900FB_H
-#define __NUC900FB_H
-
-#include <mach/map.h>
-#include <linux/platform_data/video-nuc900fb.h>
-
-enum nuc900_lcddrv_type {
-	LCDDRV_NUC910,
-	LCDDRV_NUC930,
-	LCDDRV_NUC932,
-	LCDDRV_NUC950,
-	LCDDRV_NUC960,
-};
-
-
-#define PALETTE_BUFFER_SIZE	256
-#define PALETTE_BUFF_CLEAR 	(0x80000000) /* entry is clear/invalid */
-
-struct nuc900fb_info {
-	struct device		*dev;
-	struct clk		*clk;
-
-	struct resource		*mem;
-	void __iomem		*io;
-	void __iomem		*irq_base;
-	int 			drv_type;
-	struct nuc900fb_hw	regs;
-	unsigned long		clk_rate;
-
-#ifdef CONFIG_CPU_FREQ
-	struct notifier_block	freq_transition;
-#endif
-
-	/* keep these registers in case we need to re-write palette */
-	u32			palette_buffer[PALETTE_BUFFER_SIZE];
-	u32			pseudo_pal[16];
-};
-
-int nuc900fb_init(void);
-
-#endif /* __NUC900FB_H */
diff --git a/include/Kbuild b/include/Kbuild
index 5e0642d79dce..4d5a03a81fb5 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -568,7 +568,6 @@ header-test-			+= linux/platform_data/usb3503.h
 header-test-			+= linux/platform_data/ux500_wdt.h
 header-test-			+= linux/platform_data/video-clcd-versatile.h
 header-test-			+= linux/platform_data/video-imxfb.h
-header-test-			+= linux/platform_data/video-nuc900fb.h
 header-test-			+= linux/platform_data/video-pxafb.h
 header-test-			+= linux/platform_data/video_s3c.h
 header-test-			+= linux/platform_data/voltage-omap.h
diff --git a/include/linux/platform_data/video-nuc900fb.h b/include/linux/platform_data/video-nuc900fb.h
deleted file mode 100644
index 3da504460c91..000000000000
--- a/include/linux/platform_data/video-nuc900fb.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* linux/include/asm/arch-nuc900/fb.h
- *
- * Copyright (c) 2008 Nuvoton technology corporation
- * All rights reserved.
- *
- * Changelog:
- *
- *   2008/08/26     vincen.zswan modify this file for LCD.
- */
-
-#ifndef __ASM_ARM_FB_H
-#define __ASM_ARM_FB_H
-
-
-
-/* LCD Controller Hardware Desc */
-struct nuc900fb_hw {
-	unsigned int lcd_dccs;
-	unsigned int lcd_device_ctrl;
-	unsigned int lcd_mpulcd_cmd;
-	unsigned int lcd_int_cs;
-	unsigned int lcd_crtc_size;
-	unsigned int lcd_crtc_dend;
-	unsigned int lcd_crtc_hr;
-	unsigned int lcd_crtc_hsync;
-	unsigned int lcd_crtc_vr;
-	unsigned int lcd_va_baddr0;
-	unsigned int lcd_va_baddr1;
-	unsigned int lcd_va_fbctrl;
-	unsigned int lcd_va_scale;
-	unsigned int lcd_va_test;
-	unsigned int lcd_va_win;
-	unsigned int lcd_va_stuff;
-};
-
-/* LCD Display Description */
-struct nuc900fb_display {
-	/* LCD Image type */
-	unsigned type;
-
-	/* LCD Screen Size */
-	unsigned short width;
-	unsigned short height;
-
-	/* LCD Screen Info */
-	unsigned short xres;
-	unsigned short yres;
-	unsigned short bpp;
-
-	unsigned long pixclock;
-	unsigned short left_margin;
-	unsigned short right_margin;
-	unsigned short hsync_len;
-	unsigned short upper_margin;
-	unsigned short lower_margin;
-	unsigned short vsync_len;
-
-	/* hardware special register value */
-	unsigned int dccs;
-	unsigned int devctl;
-	unsigned int fbctrl;
-	unsigned int scale;
-};
-
-struct nuc900fb_mach_info {
-	struct nuc900fb_display *displays;
-	unsigned num_displays;
-	unsigned default_display;
-	/* GPIO Setting  Info */
-	unsigned gpio_dir;
-	unsigned gpio_dir_mask;
-	unsigned gpio_data;
-	unsigned gpio_data_mask;
-};
-
-extern void __init nuc900_fb_set_platdata(struct nuc900fb_mach_info *);
-
-#endif /* __ASM_ARM_FB_H */
-- 
2.20.0

