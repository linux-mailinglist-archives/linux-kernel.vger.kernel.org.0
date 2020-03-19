Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F0818C056
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 20:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgCST3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 15:29:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33785 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgCST3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:29:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id p6so4460220qkm.0;
        Thu, 19 Mar 2020 12:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nvWF6M+b3mCkDJv7fjXrYleSEiMuc4JiGA/Ixiv8Avo=;
        b=azylzJn1pd6KxWy8F8g5vScug+fIe7p3WhdUztxA60qNKvcpkaEWnDyhP1iPLGOiJm
         EHuh2xLriqoQ01+6ByuUEWsXu71esKj/vwXdhSXMJNdTef0d3L3Qr7hZajXBVg15pUd8
         WuP3vYDBCuZu2FXJS1U5a+ruY0HK42MABWWEA8t/RirD1mClRLpXbMlAuy1iAnEsdrH7
         NOeNSQFYHKZYjb/wGuCJM1sdU0ojEROiag61mVIkx4qBPsUacY39tJLYutujBnC47N7/
         a+bgOgCiucAvA1Wwo6yjHPArKrL6HRPi+UfRoUmM9EZ5trrfvIF9NDDJlFpzPb6qXCpd
         eRvQ==
X-Gm-Message-State: ANhLgQ0CZVU172ckL3fGCH7qwlpmF0yYj1rsmyIhfuolQ2QRnwNs1rVh
        eqTGJNCIGxieCpuZ1qGCY4E=
X-Google-Smtp-Source: ADFU+vvk8e2FVM0gEpudMoEK3BZ5/2oNngVxHTmj4mS0dpjfnsPvNuXMcZ/o7LeJjye+O+iFU5crPw==
X-Received: by 2002:ae9:eb0b:: with SMTP id b11mr4559277qkg.75.1584646146796;
        Thu, 19 Mar 2020 12:29:06 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:29:06 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] efi/gop: Allow specifying mode number on command line
Date:   Thu, 19 Mar 2020 15:28:52 -0400
Message-Id: <20200319192855.29876-12-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to choose a video mode for the selected gop by using a
command-line argument of the form
	video=efifb:mode=<n>

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 Documentation/fb/efifb.rst                    |  20 +++-
 .../firmware/efi/libstub/efi-stub-helper.c    |   3 +
 drivers/firmware/efi/libstub/efistub.h        |   2 +
 drivers/firmware/efi/libstub/gop.c            | 107 ++++++++++++++++++
 4 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/Documentation/fb/efifb.rst b/Documentation/fb/efifb.rst
index 04840331a00e..367fbda2f4da 100644
--- a/Documentation/fb/efifb.rst
+++ b/Documentation/fb/efifb.rst
@@ -2,8 +2,10 @@
 What is efifb?
 ==============
 
-This is a generic EFI platform driver for Intel based Apple computers.
-efifb is only for EFI booted Intel Macs.
+This is a generic EFI platform driver for systems with UEFI firmware. The
+system must be booted via the EFI stub for this to be usable. efifb supports
+both firmware with Graphics Output Protocol (GOP) displays as well as older
+systems with only Universal Graphics Adapter (UGA) displays.
 
 Supported Hardware
 ==================
@@ -12,11 +14,14 @@ Supported Hardware
 - Macbook
 - Macbook Pro 15"/17"
 - MacMini
+- ARM/ARM64/X86 systems with UEFI firmware
 
 How to use it?
 ==============
 
-efifb does not have any kind of autodetection of your machine.
+For UGA displays, efifb does not have any kind of autodetection of your
+machine.
+
 You have to add the following kernel parameters in your elilo.conf::
 
 	Macbook :
@@ -28,6 +33,9 @@ You have to add the following kernel parameters in your elilo.conf::
 	Macbook Pro 17", iMac 20" :
 		video=efifb:i20
 
+For GOP displays, efifb can autodetect the display's resolution and framebuffer
+address, so these should work out of the box without any special parameters.
+
 Accepted options:
 
 ======= ===========================================================
@@ -36,4 +44,10 @@ nowc	Don't map the framebuffer write combined. This can be used
 	when large amounts of console data are written.
 ======= ===========================================================
 
+Options for GOP displays:
+
+mode=n
+        The EFI stub will set the mode of the display to mode number n if
+        possible.
+
 Edgar Hucek <gimli@dark-green.com>
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 9f34c7242939..c6092b6038cf 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -105,6 +105,9 @@ efi_status_t efi_parse_options(char const *cmdline)
 				efi_disable_pci_dma = true;
 			if (parse_option_str(val, "no_disable_early_pci_dma"))
 				efi_disable_pci_dma = false;
+		} else if (!strcmp(param, "video") &&
+			   val && strstarts(val, "efifb:")) {
+			efi_parse_option_graphics(val + strlen("efifb:"));
 		}
 	}
 	efi_bs_call(free_pool, buf);
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c400fd88fe38..4844c3bd40df 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -650,6 +650,8 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 
 efi_status_t efi_parse_options(char const *cmdline);
 
+void efi_parse_option_graphics(char *option);
+
 efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
 			   unsigned long size);
 
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 2d91699e3061..34b55715d372 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -8,11 +8,115 @@
 #include <linux/bitops.h>
 #include <linux/efi.h>
 #include <linux/screen_info.h>
+#include <linux/string.h>
 #include <asm/efi.h>
 #include <asm/setup.h>
 
 #include "efistub.h"
 
+enum efi_cmdline_option {
+	EFI_CMDLINE_NONE,
+	EFI_CMDLINE_MODE_NUM,
+};
+
+static struct {
+	enum efi_cmdline_option option;
+	u32 mode;
+} __efistub_global cmdline = { .option = EFI_CMDLINE_NONE };
+
+static bool parse_modenum(char *option, char **next)
+{
+	u32 m;
+
+	if (!strstarts(option, "mode="))
+		return false;
+	option += strlen("mode=");
+	m = simple_strtoull(option, &option, 0);
+	if (*option && *option++ != ',')
+		return false;
+	cmdline.option = EFI_CMDLINE_MODE_NUM;
+	cmdline.mode   = m;
+
+	*next = option;
+	return true;
+}
+
+void efi_parse_option_graphics(char *option)
+{
+	while (*option) {
+		if (parse_modenum(option, &option))
+			continue;
+
+		while (*option && *option++ != ',')
+			;
+	}
+}
+
+static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
+{
+	efi_status_t status;
+
+	efi_graphics_output_protocol_mode_t *mode;
+	efi_graphics_output_mode_info_t *info;
+	unsigned long info_size;
+
+	u32 max_mode, cur_mode;
+	int pf;
+
+	mode = efi_table_attr(gop, mode);
+
+	cur_mode = efi_table_attr(mode, mode);
+	if (cmdline.mode == cur_mode)
+		return cur_mode;
+
+	max_mode = efi_table_attr(mode, max_mode);
+	if (cmdline.mode >= max_mode) {
+		efi_printk("Requested mode is invalid\n");
+		return cur_mode;
+	}
+
+	status = efi_call_proto(gop, query_mode, cmdline.mode,
+				&info_size, &info);
+	if (status != EFI_SUCCESS) {
+		efi_printk("Couldn't get mode information\n");
+		return cur_mode;
+	}
+
+	pf = info->pixel_format;
+
+	efi_bs_call(free_pool, info);
+
+	if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX) {
+		efi_printk("Invalid PixelFormat\n");
+		return cur_mode;
+	}
+
+	return cmdline.mode;
+}
+
+static void set_mode(efi_graphics_output_protocol_t *gop)
+{
+	efi_graphics_output_protocol_mode_t *mode;
+	u32 cur_mode, new_mode;
+
+	switch (cmdline.option) {
+	case EFI_CMDLINE_NONE:
+		return;
+	case EFI_CMDLINE_MODE_NUM:
+		new_mode = choose_mode_modenum(gop);
+		break;
+	}
+
+	mode = efi_table_attr(gop, mode);
+	cur_mode = efi_table_attr(mode, mode);
+
+	if (new_mode == cur_mode)
+		return;
+
+	if (efi_call_proto(gop, set_mode, new_mode) != EFI_SUCCESS)
+		efi_printk("Failed to set requested mode\n");
+}
+
 static void find_bits(u32 mask, u8 *pos, u8 *size)
 {
 	if (!mask) {
@@ -124,6 +228,9 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 	if (!gop)
 		return EFI_NOT_FOUND;
 
+	/* Change mode if requested */
+	set_mode(gop);
+
 	/* EFI framebuffer */
 	mode = efi_table_attr(gop, mode);
 	info = efi_table_attr(mode, info);
-- 
2.24.1

