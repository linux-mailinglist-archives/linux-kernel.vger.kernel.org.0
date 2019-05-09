Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 661F719364
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 22:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfEIUaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 16:30:11 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43613 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfEIUaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 16:30:10 -0400
Received: by mail-yw1-f67.google.com with SMTP id p19so2908895ywe.10;
        Thu, 09 May 2019 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s82+opXHpmp64Nz4MPGFV0t/BAuzu71N7INCBgfaQTY=;
        b=K5bD6V37E1rdQ5p1wr2nXyvqaLA0XYp2KfF6z7BOX3FuTRXXoR6e8NuS/cQreCmBjl
         mvNn8xBdXpj8mnVaxAG+DjKzqSM3+CgFa3daukKCoxorjoHJAQ/n3lCm1sf8uAFxBjY/
         zsSnzn1stvCG6VL06lr9oqVCGlx4Bd8weSpaeA2Ot4KeXBKT3BsLlslMy40HopsWTQeF
         lRanxQVrzvQ1h9Lv3iRH53K89tDuLmMlzUvtIRIHcLl5tvgW2oQp4XB1Pj+YRhjYCv4G
         wNIrovNokoFmBaLAjrLjxWOYI+Oe0oU/zDMDyWckXjCj5NhX8GKIRCjoG/3oXFA2V2DU
         PKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s82+opXHpmp64Nz4MPGFV0t/BAuzu71N7INCBgfaQTY=;
        b=SODG629kHRkCIj4PE2pHdiCblBvwGk6eo9Gv4YhfMgsVz6+oqlztUn6xmE2Xg2dTkk
         k32E/ueq2oxjXYf21EVNhMEoYamXmnntawOAi+x3f2OPaS2E0EqBU2oZu0MiAOMVSm99
         nQZyvFe6EDDSbj6unSdPy6u2cTGF9mEFc3wtlx99mV95DLoHQDOmwyGmK9a3NTQXXxJr
         JwtfMHL7NiPBZmmezyUaF3WTV94ZZCJWRbEXNY/rMjP8CYL1RVDOeI3I7zYkt5OB4nFs
         5cApjNMtQyIsMWGKrLHaweq2D7ly9lwXXMC9CjgE+NkI8rPcQp88PFZISlPaBNMOQv82
         3DeA==
X-Gm-Message-State: APjAAAXXt2F1dFrokg7ReN/lslSB4nW3v6wKIckA0oDAATsYlnHqrYyj
        rH3sL7HDm9aeKRBJc05T8eA=
X-Google-Smtp-Source: APXvYqycsKBXgzsG4nnPFWn4Y3kSf1S0adpWyhRFkOVyDdZohaHIFPUuOT/xwTEGFXuWaKefbgo/NQ==
X-Received: by 2002:a81:9850:: with SMTP id p77mr3445959ywg.176.1557433809152;
        Thu, 09 May 2019 13:30:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id u6sm896150ywl.71.2019.05.09.13.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 13:30:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        eric@anholt.net, stefan.wahren@i2se.com
Subject: [PATCH 1/2] clk: bcm: Make BCM2835 clock drivers selectable
Date:   Thu,  9 May 2019 13:29:55 -0700
Message-Id: <20190509202956.6320-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509202956.6320-1-f.fainelli@gmail.com>
References: <20190509202956.6320-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the BCM2835 clock driver selectable by other
architectures/platforms. ARCH_BRCMSTB will be selecting that driver in
the next commit since new chips like 7211 use the same CPRMAN clock
controller that this driver supports.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/clk/bcm/Kconfig  | 9 +++++++++
 drivers/clk/bcm/Makefile | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
index 4c4bd85f707c..0b873e23f128 100644
--- a/drivers/clk/bcm/Kconfig
+++ b/drivers/clk/bcm/Kconfig
@@ -1,3 +1,12 @@
+config CLK_BCM2835
+	bool "Broadcom BCM2835 clock support"
+	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on COMMON_CLK
+	default ARCH_BCM2835
+	help
+	  Enable common clock framework support for Broadcom BCM2835
+	  SoCs.
+
 config CLK_BCM_63XX
 	bool "Broadcom BCM63xx clock support"
 	depends on ARCH_BCM_63XX || COMPILE_TEST
diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
index 002661d39128..e924f25bc6c8 100644
--- a/drivers/clk/bcm/Makefile
+++ b/drivers/clk/bcm/Makefile
@@ -5,8 +5,8 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona-setup.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
 obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
-obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
-obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835-aux.o
+obj-$(CONFIG_CLK_BCM2835)	+= clk-bcm2835.o
+obj-$(CONFIG_CLK_BCM2835)	+= clk-bcm2835-aux.o
 obj-$(CONFIG_ARCH_BCM_53573)	+= clk-bcm53573-ilp.o
 obj-$(CONFIG_CLK_BCM_CYGNUS)	+= clk-cygnus.o
 obj-$(CONFIG_CLK_BCM_HR2)	+= clk-hr2.o
-- 
2.17.1

