Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD408DC90E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505283AbfJRPmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 11:42:55 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43493 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505206AbfJRPmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:47 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MG9Xu-1iFzg916oG-00GVSz; Fri, 18 Oct 2019 17:42:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 45/46] ARM: mmp: rename pxa_register_device
Date:   Fri, 18 Oct 2019 17:42:00 +0200
Message-Id: <20191018154201.1276638-45-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1MdzDA9G4pdCO6aafQrVQzUXLRMu2MrkIvw1HqWUc0hHeFGp5Wt
 Q+ii75wOSdD0W+UocFW3fL7kS8nha8wHDK5rby9fV28FRRZ48tKUHFQcDkCJdE5NE4uBocZ
 nXhAR8qFxdyUftT5Tj8w4Wr7pHNq5frw8tdlAZaMYTuFlutypq5ikqhjiNii7Ot1N6DojIw
 8XIlgDo7V21Gs5V6vJm6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jbY3gw+N3Sw=:6JF8OKi205HHhYxB9S4xRI
 E1sg/yBFeMLiVSnVGAg4fJ0Tp7s5dg5QhB+eoksXe5CEsuOhdJniTQPDxkUnLs4fZiXDA7tgs
 QPGPfE1huZzz4cdRC/3VPCd5xOv71bV8rnIMUX/2NS2iQPFv3APfWfTgKBepoFejFvjAICWJt
 ZwTTkZWqr4lOJjSnhBWqrn+cBIcEztYfS5+zJ84ZRVXQO5gpaDCL+eZ4yFan/A3IBG7hu6Q4j
 MOsUFw98Fq/c/NBwCCPS/gfC9gA+iZxR23EObhRWXuqpgjEMLxH3fDaBSQkDTDueqVy37jU96
 VJLxrpWHV+rZMdRSirBHri4mcJPv0AAO7lgyHwI1mo4zHfd6nDnlpX/2FDaeIQOq4UPK/TWFY
 pjeqUt/tDSEK+ADJwawO+0wo1BIrQLYL0J32/hyaCqZ4hCVLvO5lISdEDqjzeAn2+zFd4jOVE
 e79pHgIpnasra20wkntaF0n4m/9COw9/bUseyJmGrQZOPeU1DdPtmfRvAmHNFifp7TwbKYirr
 P3SrIOhEEgB07G5cvRs5WAn85F2dUq6NpBUs1SvWstvRPakzPX2JnrJF+Hit7Z/xJ7MKYQk1V
 qqh0zBKIVmLnqpRWMczliMc4ECJjXEl3VoaznJ+BcXiNRravgqOp6vECwx/jcIHrWUCy0ZqwU
 zHu2NnoJ5guisS4i83B9q0FAmu1Spa3D7r8LAEiBZZSGqvOSUD/IppE37XCedjnbbauIi9tFY
 qjpwe4iGZqljFOi36iWEBzARx8Cp6eEd4UKBCeAxoq9VTJhNLk4T8gQsbfkJeHItZ/LA7/1+d
 sW+8mNsG6W0SfU3cG9sXDu+RhQj/4EMXipDwkzkuHTGupL5wCbjwgqMwAmscHSwJNOTpOkVr+
 EHgWV9iB8/HqgnuPws+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a multiplatform kernel that includes both pxa and mmp, we get a link
failure from the clash of two pxa_register_device functions.

Rename the one in mach-mmp to mmp_register_device, along with with the
rename of pxa_device_desc.

Cc: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/devices.c |  2 +-
 arch/arm/mach-mmp/devices.h | 10 +++----
 arch/arm/mach-mmp/mmp2.h    | 48 ++++++++++++++---------------
 arch/arm/mach-mmp/pxa168.h  | 60 ++++++++++++++++++-------------------
 arch/arm/mach-mmp/pxa910.h  | 38 +++++++++++------------
 arch/arm/mach-mmp/ttc_dkb.c |  6 ++--
 6 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index 130c1a603ba2..a9e6fd8d390d 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -14,7 +14,7 @@
 #include "cputype.h"
 #include "regs-usb.h"
 
-int __init pxa_register_device(struct pxa_device_desc *desc,
+int __init mmp_register_device(struct mmp_device_desc *desc,
 				void *data, size_t size)
 {
 	struct platform_device *pdev;
diff --git a/arch/arm/mach-mmp/devices.h b/arch/arm/mach-mmp/devices.h
index 4df596c5c201..d4920ebfebc5 100644
--- a/arch/arm/mach-mmp/devices.h
+++ b/arch/arm/mach-mmp/devices.h
@@ -7,7 +7,7 @@
 #define MAX_RESOURCE_DMA	2
 
 /* structure for describing the on-chip devices */
-struct pxa_device_desc {
+struct mmp_device_desc {
 	const char	*dev_name;
 	const char	*drv_name;
 	int		id;
@@ -18,7 +18,7 @@ struct pxa_device_desc {
 };
 
 #define PXA168_DEVICE(_name, _drv, _id, _irq, _start, _size, _dma...)	\
-struct pxa_device_desc pxa168_device_##_name __initdata = {		\
+struct mmp_device_desc pxa168_device_##_name __initdata = {		\
 	.dev_name	= "pxa168-" #_name,				\
 	.drv_name	= _drv,						\
 	.id		= _id,						\
@@ -29,7 +29,7 @@ struct pxa_device_desc pxa168_device_##_name __initdata = {		\
 };
 
 #define PXA910_DEVICE(_name, _drv, _id, _irq, _start, _size, _dma...)	\
-struct pxa_device_desc pxa910_device_##_name __initdata = {		\
+struct mmp_device_desc pxa910_device_##_name __initdata = {		\
 	.dev_name	= "pxa910-" #_name,				\
 	.drv_name	= _drv,						\
 	.id		= _id,						\
@@ -40,7 +40,7 @@ struct pxa_device_desc pxa910_device_##_name __initdata = {		\
 };
 
 #define MMP2_DEVICE(_name, _drv, _id, _irq, _start, _size, _dma...)	\
-struct pxa_device_desc mmp2_device_##_name __initdata = {		\
+struct mmp_device_desc mmp2_device_##_name __initdata = {		\
 	.dev_name	= "mmp2-" #_name,				\
 	.drv_name	= _drv,						\
 	.id		= _id,						\
@@ -50,7 +50,7 @@ struct pxa_device_desc mmp2_device_##_name __initdata = {		\
 	.dma		= { _dma },					\
 }
 
-extern int pxa_register_device(struct pxa_device_desc *, void *, size_t);
+extern int mmp_register_device(struct mmp_device_desc *, void *, size_t);
 extern int pxa_usb_phy_init(void __iomem *phy_reg);
 extern void pxa_usb_phy_deinit(void __iomem *phy_reg);
 
diff --git a/arch/arm/mach-mmp/mmp2.h b/arch/arm/mach-mmp/mmp2.h
index adafc4fba8f4..3ebc1bb13f71 100644
--- a/arch/arm/mach-mmp/mmp2.h
+++ b/arch/arm/mach-mmp/mmp2.h
@@ -15,28 +15,28 @@ extern void mmp2_clear_pmic_int(void);
 
 #include "devices.h"
 
-extern struct pxa_device_desc mmp2_device_uart1;
-extern struct pxa_device_desc mmp2_device_uart2;
-extern struct pxa_device_desc mmp2_device_uart3;
-extern struct pxa_device_desc mmp2_device_uart4;
-extern struct pxa_device_desc mmp2_device_twsi1;
-extern struct pxa_device_desc mmp2_device_twsi2;
-extern struct pxa_device_desc mmp2_device_twsi3;
-extern struct pxa_device_desc mmp2_device_twsi4;
-extern struct pxa_device_desc mmp2_device_twsi5;
-extern struct pxa_device_desc mmp2_device_twsi6;
-extern struct pxa_device_desc mmp2_device_sdh0;
-extern struct pxa_device_desc mmp2_device_sdh1;
-extern struct pxa_device_desc mmp2_device_sdh2;
-extern struct pxa_device_desc mmp2_device_sdh3;
-extern struct pxa_device_desc mmp2_device_asram;
-extern struct pxa_device_desc mmp2_device_isram;
+extern struct mmp_device_desc mmp2_device_uart1;
+extern struct mmp_device_desc mmp2_device_uart2;
+extern struct mmp_device_desc mmp2_device_uart3;
+extern struct mmp_device_desc mmp2_device_uart4;
+extern struct mmp_device_desc mmp2_device_twsi1;
+extern struct mmp_device_desc mmp2_device_twsi2;
+extern struct mmp_device_desc mmp2_device_twsi3;
+extern struct mmp_device_desc mmp2_device_twsi4;
+extern struct mmp_device_desc mmp2_device_twsi5;
+extern struct mmp_device_desc mmp2_device_twsi6;
+extern struct mmp_device_desc mmp2_device_sdh0;
+extern struct mmp_device_desc mmp2_device_sdh1;
+extern struct mmp_device_desc mmp2_device_sdh2;
+extern struct mmp_device_desc mmp2_device_sdh3;
+extern struct mmp_device_desc mmp2_device_asram;
+extern struct mmp_device_desc mmp2_device_isram;
 
 extern struct platform_device mmp2_device_gpio;
 
 static inline int mmp2_add_uart(int id)
 {
-	struct pxa_device_desc *d = NULL;
+	struct mmp_device_desc *d = NULL;
 
 	switch (id) {
 	case 1: d = &mmp2_device_uart1; break;
@@ -47,13 +47,13 @@ static inline int mmp2_add_uart(int id)
 		return -EINVAL;
 	}
 
-	return pxa_register_device(d, NULL, 0);
+	return mmp_register_device(d, NULL, 0);
 }
 
 static inline int mmp2_add_twsi(int id, struct i2c_pxa_platform_data *data,
 				  struct i2c_board_info *info, unsigned size)
 {
-	struct pxa_device_desc *d = NULL;
+	struct mmp_device_desc *d = NULL;
 	int ret;
 
 	switch (id) {
@@ -71,12 +71,12 @@ static inline int mmp2_add_twsi(int id, struct i2c_pxa_platform_data *data,
 	if (ret)
 		return ret;
 
-	return pxa_register_device(d, data, sizeof(*data));
+	return mmp_register_device(d, data, sizeof(*data));
 }
 
 static inline int mmp2_add_sdhost(int id, struct sdhci_pxa_platdata *data)
 {
-	struct pxa_device_desc *d = NULL;
+	struct mmp_device_desc *d = NULL;
 
 	switch (id) {
 	case 0: d = &mmp2_device_sdh0; break;
@@ -87,17 +87,17 @@ static inline int mmp2_add_sdhost(int id, struct sdhci_pxa_platdata *data)
 		return -EINVAL;
 	}
 
-	return pxa_register_device(d, data, sizeof(*data));
+	return mmp_register_device(d, data, sizeof(*data));
 }
 
 static inline int mmp2_add_asram(struct sram_platdata *data)
 {
-	return pxa_register_device(&mmp2_device_asram, data, sizeof(*data));
+	return mmp_register_device(&mmp2_device_asram, data, sizeof(*data));
 }
 
 static inline int mmp2_add_isram(struct sram_platdata *data)
 {
-	return pxa_register_device(&mmp2_device_isram, data, sizeof(*data));
+	return mmp_register_device(&mmp2_device_isram, data, sizeof(*data));
 }
 
 #endif /* __ASM_MACH_MMP2_H */
diff --git a/arch/arm/mach-mmp/pxa168.h b/arch/arm/mach-mmp/pxa168.h
index 0331c58b07a2..6dd17986e360 100644
--- a/arch/arm/mach-mmp/pxa168.h
+++ b/arch/arm/mach-mmp/pxa168.h
@@ -21,24 +21,24 @@ extern void pxa168_clear_keypad_wakeup(void);
 #include "devices.h"
 #include "cputype.h"
 
-extern struct pxa_device_desc pxa168_device_uart1;
-extern struct pxa_device_desc pxa168_device_uart2;
-extern struct pxa_device_desc pxa168_device_uart3;
-extern struct pxa_device_desc pxa168_device_twsi0;
-extern struct pxa_device_desc pxa168_device_twsi1;
-extern struct pxa_device_desc pxa168_device_pwm1;
-extern struct pxa_device_desc pxa168_device_pwm2;
-extern struct pxa_device_desc pxa168_device_pwm3;
-extern struct pxa_device_desc pxa168_device_pwm4;
-extern struct pxa_device_desc pxa168_device_ssp1;
-extern struct pxa_device_desc pxa168_device_ssp2;
-extern struct pxa_device_desc pxa168_device_ssp3;
-extern struct pxa_device_desc pxa168_device_ssp4;
-extern struct pxa_device_desc pxa168_device_ssp5;
-extern struct pxa_device_desc pxa168_device_nand;
-extern struct pxa_device_desc pxa168_device_fb;
-extern struct pxa_device_desc pxa168_device_keypad;
-extern struct pxa_device_desc pxa168_device_eth;
+extern struct mmp_device_desc pxa168_device_uart1;
+extern struct mmp_device_desc pxa168_device_uart2;
+extern struct mmp_device_desc pxa168_device_uart3;
+extern struct mmp_device_desc pxa168_device_twsi0;
+extern struct mmp_device_desc pxa168_device_twsi1;
+extern struct mmp_device_desc pxa168_device_pwm1;
+extern struct mmp_device_desc pxa168_device_pwm2;
+extern struct mmp_device_desc pxa168_device_pwm3;
+extern struct mmp_device_desc pxa168_device_pwm4;
+extern struct mmp_device_desc pxa168_device_ssp1;
+extern struct mmp_device_desc pxa168_device_ssp2;
+extern struct mmp_device_desc pxa168_device_ssp3;
+extern struct mmp_device_desc pxa168_device_ssp4;
+extern struct mmp_device_desc pxa168_device_ssp5;
+extern struct mmp_device_desc pxa168_device_nand;
+extern struct mmp_device_desc pxa168_device_fb;
+extern struct mmp_device_desc pxa168_device_keypad;
+extern struct mmp_device_desc pxa168_device_eth;
 
 /* pdata can be NULL */
 extern int __init pxa168_add_usb_host(struct mv_usb_platform_data *pdata);
@@ -48,7 +48,7 @@ extern struct platform_device pxa168_device_gpio;
 
 static inline int pxa168_add_uart(int id)
 {
-	struct pxa_device_desc *d = NULL;
+	struct mmp_device_desc *d = NULL;
 
 	switch (id) {
 	case 1: d = &pxa168_device_uart1; break;
@@ -59,13 +59,13 @@ static inline int pxa168_add_uart(int id)
 	if (d == NULL)
 		return -EINVAL;
 
-	return pxa_register_device(d, NULL, 0);
+	return mmp_register_device(d, NULL, 0);
 }
 
 static inline int pxa168_add_twsi(int id, struct i2c_pxa_platform_data *data,
 				  struct i2c_board_info *info, unsigned size)
 {
-	struct pxa_device_desc *d = NULL;
+	struct mmp_device_desc *d = NULL;
 	int ret;
 
 	switch (id) {
@@ -79,12 +79,12 @@ static inline int pxa168_add_twsi(int id, struct i2c_pxa_platform_data *data,
 	if (ret)
 		return ret;
 
-	return pxa_register_device(d, data, sizeof(*data));
+	return mmp_register_device(d, data, sizeof(*data));
 }
 
 static inline int pxa168_add_pwm(int id)
 {
-	struct pxa_device_desc *d = NULL;
+	struct mmp_device_desc *d = NULL;
 
 	switch (id) {
 	case 1: d = &pxa168_device_pwm1; break;
@@ -95,12 +95,12 @@ static inline int pxa168_add_pwm(int id)
 		return -EINVAL;
 	}
 
-	return pxa_register_device(d, NULL, 0);
+	return mmp_register_device(d, NULL, 0);
 }
 
 static inline int pxa168_add_ssp(int id)
 {
-	struct pxa_device_desc *d = NULL;
+	struct mmp_device_desc *d = NULL;
 
 	switch (id) {
 	case 1: d = &pxa168_device_ssp1; break;
@@ -111,17 +111,17 @@ static inline int pxa168_add_ssp(int id)
 	default:
 		return -EINVAL;
 	}
-	return pxa_register_device(d, NULL, 0);
+	return mmp_register_device(d, NULL, 0);
 }
 
 static inline int pxa168_add_nand(struct pxa3xx_nand_platform_data *info)
 {
-	return pxa_register_device(&pxa168_device_nand, info, sizeof(*info));
+	return mmp_register_device(&pxa168_device_nand, info, sizeof(*info));
 }
 
 static inline int pxa168_add_fb(struct pxa168fb_mach_info *mi)
 {
-	return pxa_register_device(&pxa168_device_fb, mi, sizeof(*mi));
+	return mmp_register_device(&pxa168_device_fb, mi, sizeof(*mi));
 }
 
 static inline int pxa168_add_keypad(struct pxa27x_keypad_platform_data *data)
@@ -129,11 +129,11 @@ static inline int pxa168_add_keypad(struct pxa27x_keypad_platform_data *data)
 	if (cpu_is_pxa168())
 		data->clear_wakeup_event = pxa168_clear_keypad_wakeup;
 
-	return pxa_register_device(&pxa168_device_keypad, data, sizeof(*data));
+	return mmp_register_device(&pxa168_device_keypad, data, sizeof(*data));
 }
 
 static inline int pxa168_add_eth(struct pxa168_eth_platform_data *data)
 {
-	return pxa_register_device(&pxa168_device_eth, data, sizeof(*data));
+	return mmp_register_device(&pxa168_device_eth, data, sizeof(*data));
 }
 #endif /* __ASM_MACH_PXA168_H */
diff --git a/arch/arm/mach-mmp/pxa910.h b/arch/arm/mach-mmp/pxa910.h
index 2dfe38e4acc1..6ace5a8aa15b 100644
--- a/arch/arm/mach-mmp/pxa910.h
+++ b/arch/arm/mach-mmp/pxa910.h
@@ -13,28 +13,28 @@ extern void __init pxa910_init_irq(void);
 
 #include "devices.h"
 
-extern struct pxa_device_desc pxa910_device_uart1;
-extern struct pxa_device_desc pxa910_device_uart2;
-extern struct pxa_device_desc pxa910_device_twsi0;
-extern struct pxa_device_desc pxa910_device_twsi1;
-extern struct pxa_device_desc pxa910_device_pwm1;
-extern struct pxa_device_desc pxa910_device_pwm2;
-extern struct pxa_device_desc pxa910_device_pwm3;
-extern struct pxa_device_desc pxa910_device_pwm4;
-extern struct pxa_device_desc pxa910_device_nand;
+extern struct mmp_device_desc pxa910_device_uart1;
+extern struct mmp_device_desc pxa910_device_uart2;
+extern struct mmp_device_desc pxa910_device_twsi0;
+extern struct mmp_device_desc pxa910_device_twsi1;
+extern struct mmp_device_desc pxa910_device_pwm1;
+extern struct mmp_device_desc pxa910_device_pwm2;
+extern struct mmp_device_desc pxa910_device_pwm3;
+extern struct mmp_device_desc pxa910_device_pwm4;
+extern struct mmp_device_desc pxa910_device_nand;
 extern struct platform_device pxa168_device_usb_phy;
 extern struct platform_device pxa168_device_u2o;
 extern struct platform_device pxa168_device_u2ootg;
 extern struct platform_device pxa168_device_u2oehci;
-extern struct pxa_device_desc pxa910_device_disp;
-extern struct pxa_device_desc pxa910_device_fb;
-extern struct pxa_device_desc pxa910_device_panel;
+extern struct mmp_device_desc pxa910_device_disp;
+extern struct mmp_device_desc pxa910_device_fb;
+extern struct mmp_device_desc pxa910_device_panel;
 extern struct platform_device pxa910_device_gpio;
 extern struct platform_device pxa910_device_rtc;
 
 static inline int pxa910_add_uart(int id)
 {
-	struct pxa_device_desc *d = NULL;
+	struct mmp_device_desc *d = NULL;
 
 	switch (id) {
 	case 1: d = &pxa910_device_uart1; break;
@@ -44,13 +44,13 @@ static inline int pxa910_add_uart(int id)
 	if (d == NULL)
 		return -EINVAL;
 
-	return pxa_register_device(d, NULL, 0);
+	return mmp_register_device(d, NULL, 0);
 }
 
 static inline int pxa910_add_twsi(int id, struct i2c_pxa_platform_data *data,
 				  struct i2c_board_info *info, unsigned size)
 {
-	struct pxa_device_desc *d = NULL;
+	struct mmp_device_desc *d = NULL;
 	int ret;
 
 	switch (id) {
@@ -64,12 +64,12 @@ static inline int pxa910_add_twsi(int id, struct i2c_pxa_platform_data *data,
 	if (ret)
 		return ret;
 
-	return pxa_register_device(d, data, sizeof(*data));
+	return mmp_register_device(d, data, sizeof(*data));
 }
 
 static inline int pxa910_add_pwm(int id)
 {
-	struct pxa_device_desc *d = NULL;
+	struct mmp_device_desc *d = NULL;
 
 	switch (id) {
 	case 1: d = &pxa910_device_pwm1; break;
@@ -80,11 +80,11 @@ static inline int pxa910_add_pwm(int id)
 		return -EINVAL;
 	}
 
-	return pxa_register_device(d, NULL, 0);
+	return mmp_register_device(d, NULL, 0);
 }
 
 static inline int pxa910_add_nand(struct pxa3xx_nand_platform_data *info)
 {
-	return pxa_register_device(&pxa910_device_nand, info, sizeof(*info));
+	return mmp_register_device(&pxa910_device_nand, info, sizeof(*info));
 }
 #endif /* __ASM_MACH_PXA910_H */
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 4f240760d4aa..345b2e6d5c7e 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -253,12 +253,12 @@ static struct spi_board_info spi_board_info[] __initdata = {
 
 static void __init add_disp(void)
 {
-	pxa_register_device(&pxa910_device_disp,
+	mmp_register_device(&pxa910_device_disp,
 		&dkb_disp_info, sizeof(dkb_disp_info));
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
-	pxa_register_device(&pxa910_device_fb,
+	mmp_register_device(&pxa910_device_fb,
 		&dkb_fb_info, sizeof(dkb_fb_info));
-	pxa_register_device(&pxa910_device_panel,
+	mmp_register_device(&pxa910_device_panel,
 		&dkb_tpo_panel_info, sizeof(dkb_tpo_panel_info));
 }
 #endif
-- 
2.20.0

