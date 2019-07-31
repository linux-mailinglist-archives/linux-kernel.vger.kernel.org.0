Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA37C4A1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfGaOQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 10:16:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37162 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfGaOQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:16:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id i70so21345995pgd.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=WutYOCbT/iqIbWWkRZWVgYZtGDoZae7Lp/SMB5YmhGE=;
        b=E1MvgZ/JNZrbfwhjUjjMYncZnWo7rEgrVUMQH/40yTCNnlEaoIj9m4nQDLCswS7drA
         Hi7tLZBatEaLyE20lkz2Hi/FZ/il2+btnSXlextqk9pRBwgsLWkv4b15cvIYXLwpuONp
         VWsVutDKhoPb+qzNflb8SIqG088eWveKlCNRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=WutYOCbT/iqIbWWkRZWVgYZtGDoZae7Lp/SMB5YmhGE=;
        b=DGZYOT7IlBAQ2XgyXiQ4pwtY+cXB82rDcSX/lMIEkxY/lHzTB2fQeQJtBcrC2ybmQ0
         wkVXRiSC0Eul/5Cu/y89QWx+WUSvWMSAJvw4a1rXMliIkhbiWNPG2nevbm6bBuBMpp5k
         e5UERePvztPtHtMxFoFZ7THB8OZXixSIWZCfUG2U4Xx8MvkDAETqZDGHiarFfkF9h8rE
         I3ISmWx9OrY4uJhCVgFyQ/icjiDrIpxXfP/vmac39HKWuE5BQAdz+PFlc4dwC5HiIFKH
         QO4s+wEYolPsMinQgH5KqXiphbPBXXtN8V62QfcFE+dzzQHwV4jvZ2q4OfuR5iJdjGar
         5uhA==
X-Gm-Message-State: APjAAAWUI03cn0h9xBtZR55fbysYQF8ad31XAXOUZSNOJov1al6eXwka
        aq2N3tPeH+I2dqCZuxnhBNWhUwwgvuzOUA==
X-Google-Smtp-Source: APXvYqw8i4KcEQr8BOcrNEdJVD8I3UtVgwTmeAL1uRg7d1s9OududA0coQFLvuXNaMKlGKsKtUfqEg==
X-Received: by 2002:a17:90a:1aa4:: with SMTP id p33mr3284709pjp.27.1564582584540;
        Wed, 31 Jul 2019 07:16:24 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i74sm7578087pje.16.2019.07.31.07.16.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 07:16:23 -0700 (PDT)
Message-ID: <5d41a2b7.1c69fb81.c8d56.edb6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAK8P3a3Zi=GMvV3=QYBDza4--CV9J_-qNCTBXthCm__-b52Beg@mail.gmail.com>
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-29-swboyd@chromium.org> <CAK8P3a3Zi=GMvV3=QYBDza4--CV9J_-qNCTBXthCm__-b52Beg@mail.gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 28/57] pcie-gadget-spear: Remove dev_err() usage after platform_get_irq()
User-Agent: alot/0.8.1
Date:   Wed, 31 Jul 2019 07:16:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2019-07-30 11:29:45)
> On Tue, Jul 30, 2019 at 8:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > We don't need dev_err() messages when platform_get_irq() fails now that
> > platform_get_irq() prints an error message itself when something goes
> > wrong. Let's remove these prints with a simple semantic patch.
>=20
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > Please apply directly to subsystem trees
>=20
> The patch looks coorrect
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>=20
> I wonder if we should just remove that driver though, it's been marked
> as 'depends on BROKEN' since 2013, and it has never been possible
> to compile it.

I'm happy to replace this patch with a deletion patch.

-----8<-----
From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] misc: Remove spear13xx pcie gadget driver

This driver has been marked broken since 2013, see commit 98097858ccf3
("misc: mark spear13xx-pcie-gadget as broken"). Let's remove this file
now that it's been more than 5 years of existing in a broken state.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/misc/Kconfig                 |   9 -
 drivers/misc/Makefile                |   1 -
 drivers/misc/spear13xx_pcie_gadget.c | 797 ---------------------------
 3 files changed, 807 deletions(-)
 delete mode 100644 drivers/misc/spear13xx_pcie_gadget.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6abfc8e92fcc..964e2242f772 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -375,15 +375,6 @@ config DS1682
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1682.
=20
-config SPEAR13XX_PCIE_GADGET
-	bool "PCIe gadget support for SPEAr13XX platform"
-	depends on ARCH_SPEAR13XX && BROKEN
-	help
-	 This option enables gadget support for PCIe controller. If
-	 board file defines any controller as PCIe endpoint then a sysfs
-	 entry will be created for that controller. User can use these
-	 sysfs node to configure PCIe EP as per his requirements.
-
 config VMWARE_BALLOON
 	tristate "VMware Balloon Driver"
 	depends on VMWARE_VMCI && X86 && HYPERVISOR_GUEST
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index abd8ae249746..9e1eaf523d6e 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -37,7 +37,6 @@ obj-$(CONFIG_C2PORT)		+=3D c2port/
 obj-$(CONFIG_HMC6352)		+=3D hmc6352.o
 obj-y				+=3D eeprom/
 obj-y				+=3D cb710/
-obj-$(CONFIG_SPEAR13XX_PCIE_GADGET)	+=3D spear13xx_pcie_gadget.o
 obj-$(CONFIG_VMWARE_BALLOON)	+=3D vmw_balloon.o
 obj-$(CONFIG_PCH_PHUB)		+=3D pch_phub.o
 obj-y				+=3D ti-st/
diff --git a/drivers/misc/spear13xx_pcie_gadget.c b/drivers/misc/spear13xx_=
pcie_gadget.c
deleted file mode 100644
index ee120dcbb3e6..000000000000
--- a/drivers/misc/spear13xx_pcie_gadget.c
+++ /dev/null
@@ -1,797 +0,0 @@
-/*
- * drivers/misc/spear13xx_pcie_gadget.c
- *
- * Copyright (C) 2010 ST Microelectronics
- * Pratyush Anand<pratyush.anand@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/device.h>
-#include <linux/clk.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/pci_regs.h>
-#include <linux/configfs.h>
-#include <mach/pcie.h>
-#include <mach/misc_regs.h>
-
-#define IN0_MEM_SIZE	(200 * 1024 * 1024 - 1)
-/* In current implementation address translation is done using IN0 only.
- * So IN1 start address and IN0 end address has been kept same
-*/
-#define IN1_MEM_SIZE	(0 * 1024 * 1024 - 1)
-#define IN_IO_SIZE	(20 * 1024 * 1024 - 1)
-#define IN_CFG0_SIZE	(12 * 1024 * 1024 - 1)
-#define IN_CFG1_SIZE	(12 * 1024 * 1024 - 1)
-#define IN_MSG_SIZE	(12 * 1024 * 1024 - 1)
-/* Keep default BAR size as 4K*/
-/* AORAM would be mapped by default*/
-#define INBOUND_ADDR_MASK	(SPEAR13XX_SYSRAM1_SIZE - 1)
-
-#define INT_TYPE_NO_INT	0
-#define INT_TYPE_INTX	1
-#define INT_TYPE_MSI	2
-struct spear_pcie_gadget_config {
-	void __iomem *base;
-	void __iomem *va_app_base;
-	void __iomem *va_dbi_base;
-	char int_type[10];
-	ulong requested_msi;
-	ulong configured_msi;
-	ulong bar0_size;
-	ulong bar0_rw_offset;
-	void __iomem *va_bar0_address;
-};
-
-struct pcie_gadget_target {
-	struct configfs_subsystem subsys;
-	struct spear_pcie_gadget_config config;
-};
-
-struct pcie_gadget_target_attr {
-	struct configfs_attribute	attr;
-	ssize_t		(*show)(struct spear_pcie_gadget_config *config,
-						char *buf);
-	ssize_t		(*store)(struct spear_pcie_gadget_config *config,
-						 const char *buf,
-						 size_t count);
-};
-
-static void enable_dbi_access(struct pcie_app_reg __iomem *app_reg)
-{
-	/* Enable DBI access */
-	writel(readl(&app_reg->slv_armisc) | (1 << AXI_OP_DBI_ACCESS_ID),
-			&app_reg->slv_armisc);
-	writel(readl(&app_reg->slv_awmisc) | (1 << AXI_OP_DBI_ACCESS_ID),
-			&app_reg->slv_awmisc);
-
-}
-
-static void disable_dbi_access(struct pcie_app_reg __iomem *app_reg)
-{
-	/* disable DBI access */
-	writel(readl(&app_reg->slv_armisc) & ~(1 << AXI_OP_DBI_ACCESS_ID),
-			&app_reg->slv_armisc);
-	writel(readl(&app_reg->slv_awmisc) & ~(1 << AXI_OP_DBI_ACCESS_ID),
-			&app_reg->slv_awmisc);
-
-}
-
-static void spear_dbi_read_reg(struct spear_pcie_gadget_config *config,
-		int where, int size, u32 *val)
-{
-	struct pcie_app_reg __iomem *app_reg =3D config->va_app_base;
-	ulong va_address;
-
-	/* Enable DBI access */
-	enable_dbi_access(app_reg);
-
-	va_address =3D (ulong)config->va_dbi_base + (where & ~0x3);
-
-	*val =3D readl(va_address);
-
-	if (size =3D=3D 1)
-		*val =3D (*val >> (8 * (where & 3))) & 0xff;
-	else if (size =3D=3D 2)
-		*val =3D (*val >> (8 * (where & 3))) & 0xffff;
-
-	/* Disable DBI access */
-	disable_dbi_access(app_reg);
-}
-
-static void spear_dbi_write_reg(struct spear_pcie_gadget_config *config,
-		int where, int size, u32 val)
-{
-	struct pcie_app_reg __iomem *app_reg =3D config->va_app_base;
-	ulong va_address;
-
-	/* Enable DBI access */
-	enable_dbi_access(app_reg);
-
-	va_address =3D (ulong)config->va_dbi_base + (where & ~0x3);
-
-	if (size =3D=3D 4)
-		writel(val, va_address);
-	else if (size =3D=3D 2)
-		writew(val, va_address + (where & 2));
-	else if (size =3D=3D 1)
-		writeb(val, va_address + (where & 3));
-
-	/* Disable DBI access */
-	disable_dbi_access(app_reg);
-}
-
-#define PCI_FIND_CAP_TTL	48
-
-static int pci_find_own_next_cap_ttl(struct spear_pcie_gadget_config *conf=
ig,
-		u32 pos, int cap, int *ttl)
-{
-	u32 id;
-
-	while ((*ttl)--) {
-		spear_dbi_read_reg(config, pos, 1, &pos);
-		if (pos < 0x40)
-			break;
-		pos &=3D ~3;
-		spear_dbi_read_reg(config, pos + PCI_CAP_LIST_ID, 1, &id);
-		if (id =3D=3D 0xff)
-			break;
-		if (id =3D=3D cap)
-			return pos;
-		pos +=3D PCI_CAP_LIST_NEXT;
-	}
-	return 0;
-}
-
-static int pci_find_own_next_cap(struct spear_pcie_gadget_config *config,
-			u32 pos, int cap)
-{
-	int ttl =3D PCI_FIND_CAP_TTL;
-
-	return pci_find_own_next_cap_ttl(config, pos, cap, &ttl);
-}
-
-static int pci_find_own_cap_start(struct spear_pcie_gadget_config *config,
-				u8 hdr_type)
-{
-	u32 status;
-
-	spear_dbi_read_reg(config, PCI_STATUS, 2, &status);
-	if (!(status & PCI_STATUS_CAP_LIST))
-		return 0;
-
-	switch (hdr_type) {
-	case PCI_HEADER_TYPE_NORMAL:
-	case PCI_HEADER_TYPE_BRIDGE:
-		return PCI_CAPABILITY_LIST;
-	case PCI_HEADER_TYPE_CARDBUS:
-		return PCI_CB_CAPABILITY_LIST;
-	default:
-		return 0;
-	}
-
-	return 0;
-}
-
-/*
- * Tell if a device supports a given PCI capability.
- * Returns the address of the requested capability structure within the
- * device's PCI configuration space or 0 in case the device does not
- * support it. Possible values for @cap:
- *
- * %PCI_CAP_ID_PM	Power Management
- * %PCI_CAP_ID_AGP	Accelerated Graphics Port
- * %PCI_CAP_ID_VPD	Vital Product Data
- * %PCI_CAP_ID_SLOTID	Slot Identification
- * %PCI_CAP_ID_MSI	Message Signalled Interrupts
- * %PCI_CAP_ID_CHSWP	CompactPCI HotSwap
- * %PCI_CAP_ID_PCIX	PCI-X
- * %PCI_CAP_ID_EXP	PCI Express
- */
-static int pci_find_own_capability(struct spear_pcie_gadget_config *config,
-		int cap)
-{
-	u32 pos;
-	u32 hdr_type;
-
-	spear_dbi_read_reg(config, PCI_HEADER_TYPE, 1, &hdr_type);
-
-	pos =3D pci_find_own_cap_start(config, hdr_type);
-	if (pos)
-		pos =3D pci_find_own_next_cap(config, pos, cap);
-
-	return pos;
-}
-
-static irqreturn_t spear_pcie_gadget_irq(int irq, void *dev_id)
-{
-	return 0;
-}
-
-/*
- * configfs interfaces show/store functions
- */
-
-static struct pcie_gadget_target *to_target(struct config_item *item)
-{
-	return item ?
-		container_of(to_configfs_subsystem(to_config_group(item)),
-				struct pcie_gadget_target, subsys) : NULL;
-}
-
-static ssize_t pcie_gadget_link_show(struct config_item *item, char *buf)
-{
-	struct pcie_app_reg __iomem *app_reg =3D to_target(item)->va_app_base;
-
-	if (readl(&app_reg->app_status_1) & ((u32)1 << XMLH_LINK_UP_ID))
-		return sprintf(buf, "UP");
-	else
-		return sprintf(buf, "DOWN");
-}
-
-static ssize_t pcie_gadget_link_store(struct config_item *item,
-		const char *buf, size_t count)
-{
-	struct pcie_app_reg __iomem *app_reg =3D to_target(item)->va_app_base;
-
-	if (sysfs_streq(buf, "UP"))
-		writel(readl(&app_reg->app_ctrl_0) | (1 << APP_LTSSM_ENABLE_ID),
-			&app_reg->app_ctrl_0);
-	else if (sysfs_streq(buf, "DOWN"))
-		writel(readl(&app_reg->app_ctrl_0)
-				& ~(1 << APP_LTSSM_ENABLE_ID),
-				&app_reg->app_ctrl_0);
-	else
-		return -EINVAL;
-	return count;
-}
-
-static ssize_t pcie_gadget_int_type_show(struct config_item *item, char *b=
uf)
-{
-	return sprintf(buf, "%s", to_target(item)->int_type);
-}
-
-static ssize_t pcie_gadget_int_type_store(struct config_item *item,
-		const char *buf, size_t count)
-{
-	struct spear_pcie_gadget_config *config =3D to_target(item)
-	u32 cap, vec, flags;
-	ulong vector;
-
-	if (sysfs_streq(buf, "INTA"))
-		spear_dbi_write_reg(config, PCI_INTERRUPT_LINE, 1, 1);
-
-	else if (sysfs_streq(buf, "MSI")) {
-		vector =3D config->requested_msi;
-		vec =3D 0;
-		while (vector > 1) {
-			vector /=3D 2;
-			vec++;
-		}
-		spear_dbi_write_reg(config, PCI_INTERRUPT_LINE, 1, 0);
-		cap =3D pci_find_own_capability(config, PCI_CAP_ID_MSI);
-		spear_dbi_read_reg(config, cap + PCI_MSI_FLAGS, 1, &flags);
-		flags &=3D ~PCI_MSI_FLAGS_QMASK;
-		flags |=3D vec << 1;
-		spear_dbi_write_reg(config, cap + PCI_MSI_FLAGS, 1, flags);
-	} else
-		return -EINVAL;
-
-	strcpy(config->int_type, buf);
-
-	return count;
-}
-
-static ssize_t pcie_gadget_no_of_msi_show(struct config_item *item, char *=
buf)
-{
-	struct spear_pcie_gadget_config *config =3D to_target(item)
-	struct pcie_app_reg __iomem *app_reg =3D to_target(item)->va_app_base;
-	u32 cap, vec, flags;
-	ulong vector;
-
-	if ((readl(&app_reg->msg_status) & (1 << CFG_MSI_EN_ID))
-			!=3D (1 << CFG_MSI_EN_ID))
-		vector =3D 0;
-	else {
-		cap =3D pci_find_own_capability(config, PCI_CAP_ID_MSI);
-		spear_dbi_read_reg(config, cap + PCI_MSI_FLAGS, 1, &flags);
-		flags &=3D ~PCI_MSI_FLAGS_QSIZE;
-		vec =3D flags >> 4;
-		vector =3D 1;
-		while (vec--)
-			vector *=3D 2;
-	}
-	config->configured_msi =3D vector;
-
-	return sprintf(buf, "%lu", vector);
-}
-
-static ssize_t pcie_gadget_no_of_msi_store(struct config_item *item,
-		const char *buf, size_t count)
-{
-	int ret;
-
-	ret =3D kstrtoul(buf, 0, &to_target(item)->requested_msi);
-	if (ret)
-		return ret;
-
-	if (config->requested_msi > 32)
-		config->requested_msi =3D 32;
-
-	return count;
-}
-
-static ssize_t pcie_gadget_inta_store(struct config_item *item,
-		const char *buf, size_t count)
-{
-	struct pcie_app_reg __iomem *app_reg =3D to_target(item)->va_app_base;
-	ulong en;
-	int ret;
-
-	ret =3D kstrtoul(buf, 0, &en);
-	if (ret)
-		return ret;
-
-	if (en)
-		writel(readl(&app_reg->app_ctrl_0) | (1 << SYS_INT_ID),
-				&app_reg->app_ctrl_0);
-	else
-		writel(readl(&app_reg->app_ctrl_0) & ~(1 << SYS_INT_ID),
-				&app_reg->app_ctrl_0);
-
-	return count;
-}
-
-static ssize_t pcie_gadget_send_msi_store(struct config_item *item,
-		const char *buf, size_t count)
-{
-	struct spear_pcie_gadget_config *config =3D to_target(item)
-	struct pcie_app_reg __iomem *app_reg =3D config->va_app_base;
-	ulong vector;
-	u32 ven_msi;
-	int ret;
-
-	ret =3D kstrtoul(buf, 0, &vector);
-	if (ret)
-		return ret;
-
-	if (!config->configured_msi)
-		return -EINVAL;
-
-	if (vector >=3D config->configured_msi)
-		return -EINVAL;
-
-	ven_msi =3D readl(&app_reg->ven_msi_1);
-	ven_msi &=3D ~VEN_MSI_FUN_NUM_MASK;
-	ven_msi |=3D 0 << VEN_MSI_FUN_NUM_ID;
-	ven_msi &=3D ~VEN_MSI_TC_MASK;
-	ven_msi |=3D 0 << VEN_MSI_TC_ID;
-	ven_msi &=3D ~VEN_MSI_VECTOR_MASK;
-	ven_msi |=3D vector << VEN_MSI_VECTOR_ID;
-
-	/* generating interrupt for msi vector */
-	ven_msi |=3D VEN_MSI_REQ_EN;
-	writel(ven_msi, &app_reg->ven_msi_1);
-	udelay(1);
-	ven_msi &=3D ~VEN_MSI_REQ_EN;
-	writel(ven_msi, &app_reg->ven_msi_1);
-
-	return count;
-}
-
-static ssize_t pcie_gadget_vendor_id_show(struct config_item *item, char *=
buf)
-{
-	u32 id;
-
-	spear_dbi_read_reg(to_target(item), PCI_VENDOR_ID, 2, &id);
-
-	return sprintf(buf, "%x", id);
-}
-
-static ssize_t pcie_gadget_vendor_id_store(struct config_item *item,
-		const char *buf, size_t count)
-{
-	ulong id;
-	int ret;
-
-	ret =3D kstrtoul(buf, 0, &id);
-	if (ret)
-		return ret;
-
-	spear_dbi_write_reg(to_target(item), PCI_VENDOR_ID, 2, id);
-
-	return count;
-}
-
-static ssize_t pcie_gadget_device_id_show(struct config_item *item, char *=
buf)
-{
-	u32 id;
-
-	spear_dbi_read_reg(to_target(item), PCI_DEVICE_ID, 2, &id);
-
-	return sprintf(buf, "%x", id);
-}
-
-static ssize_t pcie_gadget_device_id_store(struct config_item *item,
-		const char *buf, size_t count)
-{
-	ulong id;
-	int ret;
-
-	ret =3D kstrtoul(buf, 0, &id);
-	if (ret)
-		return ret;
-
-	spear_dbi_write_reg(to_target(item), PCI_DEVICE_ID, 2, id);
-
-	return count;
-}
-
-static ssize_t pcie_gadget_bar0_size_show(struct config_item *item, char *=
buf)
-{
-	return sprintf(buf, "%lx", to_target(item)->bar0_size);
-}
-
-static ssize_t pcie_gadget_bar0_size_store(struct config_item *item,
-		const char *buf, size_t count)
-{
-	struct spear_pcie_gadget_config *config =3D to_target(item)
-	ulong size;
-	u32 pos, pos1;
-	u32 no_of_bit =3D 0;
-	int ret;
-
-	ret =3D kstrtoul(buf, 0, &size);
-	if (ret)
-		return ret;
-
-	/* min bar size is 256 */
-	if (size <=3D 0x100)
-		size =3D 0x100;
-	/* max bar size is 1MB*/
-	else if (size >=3D 0x100000)
-		size =3D 0x100000;
-	else {
-		pos =3D 0;
-		pos1 =3D 0;
-		while (pos < 21) {
-			pos =3D find_next_bit((ulong *)&size, 21, pos);
-			if (pos !=3D 21)
-				pos1 =3D pos + 1;
-			pos++;
-			no_of_bit++;
-		}
-		if (no_of_bit =3D=3D 2)
-			pos1--;
-
-		size =3D 1 << pos1;
-	}
-	config->bar0_size =3D size;
-	spear_dbi_write_reg(config, PCIE_BAR0_MASK_REG, 4, size - 1);
-
-	return count;
-}
-
-static ssize_t pcie_gadget_bar0_address_show(struct config_item *item,
-		char *buf)
-{
-	struct pcie_app_reg __iomem *app_reg =3D to_target(item)->va_app_base;
-
-	u32 address =3D readl(&app_reg->pim0_mem_addr_start);
-
-	return sprintf(buf, "%x", address);
-}
-
-static ssize_t pcie_gadget_bar0_address_store(struct config_item *item,
-		const char *buf, size_t count)
-{
-	struct spear_pcie_gadget_config *config =3D to_target(item)
-	struct pcie_app_reg __iomem *app_reg =3D config->va_app_base;
-	ulong address;
-	int ret;
-
-	ret =3D kstrtoul(buf, 0, &address);
-	if (ret)
-		return ret;
-
-	address &=3D ~(config->bar0_size - 1);
-	if (config->va_bar0_address)
-		iounmap(config->va_bar0_address);
-	config->va_bar0_address =3D ioremap(address, config->bar0_size);
-	if (!config->va_bar0_address)
-		return -ENOMEM;
-
-	writel(address, &app_reg->pim0_mem_addr_start);
-
-	return count;
-}
-
-static ssize_t pcie_gadget_bar0_rw_offset_show(struct config_item *item,
-		char *buf)
-{
-	return sprintf(buf, "%lx", to_target(item)->bar0_rw_offset);
-}
-
-static ssize_t pcie_gadget_bar0_rw_offset_store(struct config_item *item,
-		const char *buf, size_t count)
-{
-	ulong offset;
-	int ret;
-
-	ret =3D kstrtoul(buf, 0, &offset);
-	if (ret)
-		return ret;
-
-	if (offset % 4)
-		return -EINVAL;
-
-	to_target(item)->bar0_rw_offset =3D offset;
-
-	return count;
-}
-
-static ssize_t pcie_gadget_bar0_data_show(struct config_item *item, char *=
buf)
-{
-	struct spear_pcie_gadget_config *config =3D to_target(item)
-	ulong data;
-
-	if (!config->va_bar0_address)
-		return -ENOMEM;
-
-	data =3D readl((ulong)config->va_bar0_address + config->bar0_rw_offset);
-
-	return sprintf(buf, "%lx", data);
-}
-
-static ssize_t pcie_gadget_bar0_data_store(struct config_item *item,
-		const char *buf, size_t count)
-{
-	struct spear_pcie_gadget_config *config =3D to_target(item)
-	ulong data;
-	int ret;
-
-	ret =3D kstrtoul(buf, 0, &data);
-	if (ret)
-		return ret;
-
-	if (!config->va_bar0_address)
-		return -ENOMEM;
-
-	writel(data, (ulong)config->va_bar0_address + config->bar0_rw_offset);
-
-	return count;
-}
-
-CONFIGFS_ATTR(pcie_gadget_, link);
-CONFIGFS_ATTR(pcie_gadget_, int_type);
-CONFIGFS_ATTR(pcie_gadget_, no_of_msi);
-CONFIGFS_ATTR_WO(pcie_gadget_, inta);
-CONFIGFS_ATTR_WO(pcie_gadget_, send_msi);
-CONFIGFS_ATTR(pcie_gadget_, vendor_id);
-CONFIGFS_ATTR(pcie_gadget_, device_id);
-CONFIGFS_ATTR(pcie_gadget_, bar0_size);
-CONFIGFS_ATTR(pcie_gadget_, bar0_address);
-CONFIGFS_ATTR(pcie_gadget_, bar0_rw_offset);
-CONFIGFS_ATTR(pcie_gadget_, bar0_data);
-
-static struct configfs_attribute *pcie_gadget_target_attrs[] =3D {
-	&pcie_gadget_attr_link,
-	&pcie_gadget_attr_int_type,
-	&pcie_gadget_attr_no_of_msi,
-	&pcie_gadget_attr_inta,
-	&pcie_gadget_attr_send_msi,
-	&pcie_gadget_attr_vendor_id,
-	&pcie_gadget_attr_device_id,
-	&pcie_gadget_attr_bar0_size,
-	&pcie_gadget_attr_bar0_address,
-	&pcie_gadget_attr_bar0_rw_offset,
-	&pcie_gadget_attr_bar0_data,
-	NULL,
-};
-
-static struct config_item_type pcie_gadget_target_type =3D {
-	.ct_attrs		=3D pcie_gadget_target_attrs,
-	.ct_owner		=3D THIS_MODULE,
-};
-
-static void spear13xx_pcie_device_init(struct spear_pcie_gadget_config *co=
nfig)
-{
-	struct pcie_app_reg __iomem *app_reg =3D config->va_app_base;
-
-	/*setup registers for outbound translation */
-
-	writel(config->base, &app_reg->in0_mem_addr_start);
-	writel(app_reg->in0_mem_addr_start + IN0_MEM_SIZE,
-			&app_reg->in0_mem_addr_limit);
-	writel(app_reg->in0_mem_addr_limit + 1, &app_reg->in1_mem_addr_start);
-	writel(app_reg->in1_mem_addr_start + IN1_MEM_SIZE,
-			&app_reg->in1_mem_addr_limit);
-	writel(app_reg->in1_mem_addr_limit + 1, &app_reg->in_io_addr_start);
-	writel(app_reg->in_io_addr_start + IN_IO_SIZE,
-			&app_reg->in_io_addr_limit);
-	writel(app_reg->in_io_addr_limit + 1, &app_reg->in_cfg0_addr_start);
-	writel(app_reg->in_cfg0_addr_start + IN_CFG0_SIZE,
-			&app_reg->in_cfg0_addr_limit);
-	writel(app_reg->in_cfg0_addr_limit + 1, &app_reg->in_cfg1_addr_start);
-	writel(app_reg->in_cfg1_addr_start + IN_CFG1_SIZE,
-			&app_reg->in_cfg1_addr_limit);
-	writel(app_reg->in_cfg1_addr_limit + 1, &app_reg->in_msg_addr_start);
-	writel(app_reg->in_msg_addr_start + IN_MSG_SIZE,
-			&app_reg->in_msg_addr_limit);
-
-	writel(app_reg->in0_mem_addr_start, &app_reg->pom0_mem_addr_start);
-	writel(app_reg->in1_mem_addr_start, &app_reg->pom1_mem_addr_start);
-	writel(app_reg->in_io_addr_start, &app_reg->pom_io_addr_start);
-
-	/*setup registers for inbound translation */
-
-	/* Keep AORAM mapped at BAR0 as default */
-	config->bar0_size =3D INBOUND_ADDR_MASK + 1;
-	spear_dbi_write_reg(config, PCIE_BAR0_MASK_REG, 4, INBOUND_ADDR_MASK);
-	spear_dbi_write_reg(config, PCI_BASE_ADDRESS_0, 4, 0xC);
-	config->va_bar0_address =3D ioremap(SPEAR13XX_SYSRAM1_BASE,
-			config->bar0_size);
-
-	writel(SPEAR13XX_SYSRAM1_BASE, &app_reg->pim0_mem_addr_start);
-	writel(0, &app_reg->pim1_mem_addr_start);
-	writel(INBOUND_ADDR_MASK + 1, &app_reg->mem0_addr_offset_limit);
-
-	writel(0x0, &app_reg->pim_io_addr_start);
-	writel(0x0, &app_reg->pim_io_addr_start);
-	writel(0x0, &app_reg->pim_rom_addr_start);
-
-	writel(DEVICE_TYPE_EP | (1 << MISCTRL_EN_ID)
-			| ((u32)1 << REG_TRANSLATION_ENABLE),
-			&app_reg->app_ctrl_0);
-	/* disable all rx interrupts */
-	writel(0, &app_reg->int_mask);
-
-	/* Select INTA as default*/
-	spear_dbi_write_reg(config, PCI_INTERRUPT_LINE, 1, 1);
-}
-
-static int spear_pcie_gadget_probe(struct platform_device *pdev)
-{
-	struct resource *res0, *res1;
-	unsigned int status =3D 0;
-	int irq;
-	struct clk *clk;
-	static struct pcie_gadget_target *target;
-	struct spear_pcie_gadget_config *config;
-	struct config_item		*cg_item;
-	struct configfs_subsystem *subsys;
-
-	target =3D devm_kzalloc(&pdev->dev, sizeof(*target), GFP_KERNEL);
-	if (!target) {
-		dev_err(&pdev->dev, "out of memory\n");
-		return -ENOMEM;
-	}
-
-	cg_item =3D &target->subsys.su_group.cg_item;
-	sprintf(cg_item->ci_namebuf, "pcie_gadget.%d", pdev->id);
-	cg_item->ci_type	=3D &pcie_gadget_target_type;
-	config =3D &target->config;
-
-	/* get resource for application registers*/
-	res0 =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	config->va_app_base =3D devm_ioremap_resource(&pdev->dev, res0);
-	if (IS_ERR(config->va_app_base)) {
-		dev_err(&pdev->dev, "ioremap fail\n");
-		return PTR_ERR(config->va_app_base);
-	}
-
-	/* get resource for dbi registers*/
-	res1 =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	config->base =3D (void __iomem *)res1->start;
-
-	config->va_dbi_base =3D devm_ioremap_resource(&pdev->dev, res1);
-	if (IS_ERR(config->va_dbi_base)) {
-		dev_err(&pdev->dev, "ioremap fail\n");
-		return PTR_ERR(config->va_dbi_base);
-	}
-
-	platform_set_drvdata(pdev, target);
-
-	irq =3D platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no update irq?\n");
-		return irq;
-	}
-
-	status =3D devm_request_irq(&pdev->dev, irq, spear_pcie_gadget_irq,
-				  0, pdev->name, NULL);
-	if (status) {
-		dev_err(&pdev->dev,
-			"pcie gadget interrupt IRQ%d already claimed\n", irq);
-		return status;
-	}
-
-	/* Register configfs hooks */
-	subsys =3D &target->subsys;
-	config_group_init(&subsys->su_group);
-	mutex_init(&subsys->su_mutex);
-	status =3D configfs_register_subsystem(subsys);
-	if (status)
-		return status;
-
-	/*
-	 * init basic pcie application registers
-	 * do not enable clock if it is PCIE0.Ideally , all controller should
-	 * have been independent from others with respect to clock. But PCIE1
-	 * and 2 depends on PCIE0.So PCIE0 clk is provided during board init.
-	 */
-	if (pdev->id =3D=3D 1) {
-		/*
-		 * Ideally CFG Clock should have been also enabled here. But
-		 * it is done currently during board init routne
-		 */
-		clk =3D clk_get_sys("pcie1", NULL);
-		if (IS_ERR(clk)) {
-			pr_err("%s:couldn't get clk for pcie1\n", __func__);
-			return PTR_ERR(clk);
-		}
-		status =3D clk_enable(clk);
-		if (status) {
-			pr_err("%s:couldn't enable clk for pcie1\n", __func__);
-			return status;
-		}
-	} else if (pdev->id =3D=3D 2) {
-		/*
-		 * Ideally CFG Clock should have been also enabled here. But
-		 * it is done currently during board init routne
-		 */
-		clk =3D clk_get_sys("pcie2", NULL);
-		if (IS_ERR(clk)) {
-			pr_err("%s:couldn't get clk for pcie2\n", __func__);
-			return PTR_ERR(clk);
-		}
-		status =3D clk_enable(clk);
-		if (status) {
-			pr_err("%s:couldn't enable clk for pcie2\n", __func__);
-			return status;
-		}
-	}
-	spear13xx_pcie_device_init(config);
-
-	return 0;
-}
-
-static int spear_pcie_gadget_remove(struct platform_device *pdev)
-{
-	static struct pcie_gadget_target *target;
-
-	target =3D platform_get_drvdata(pdev);
-
-	configfs_unregister_subsystem(&target->subsys);
-
-	return 0;
-}
-
-static void spear_pcie_gadget_shutdown(struct platform_device *pdev)
-{
-}
-
-static struct platform_driver spear_pcie_gadget_driver =3D {
-	.probe =3D spear_pcie_gadget_probe,
-	.remove =3D spear_pcie_gadget_remove,
-	.shutdown =3D spear_pcie_gadget_shutdown,
-	.driver =3D {
-		.name =3D "pcie-gadget-spear",
-		.bus =3D &platform_bus_type
-	},
-};
-
-module_platform_driver(spear_pcie_gadget_driver);
-
-MODULE_ALIAS("platform:pcie-gadget-spear");
-MODULE_AUTHOR("Pratyush Anand");
-MODULE_LICENSE("GPL");
--=20
Sent by a computer through tubes

