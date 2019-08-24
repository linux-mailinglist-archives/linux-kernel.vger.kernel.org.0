Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552A49BD21
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfHXKtx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Aug 2019 06:49:53 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:47663 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfHXKtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 06:49:52 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A269A100005;
        Sat, 24 Aug 2019 10:49:44 +0000 (UTC)
Date:   Sat, 24 Aug 2019 12:49:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Piotr Sroka <piotrs@cadence.com>, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, linux-mtd@lists.infradead.org,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Subject: Re: [v5 1/2] mtd: nand: Add new Cadence NAND driver to MTD
 subsystem
Message-ID: <20190824124942.455018ee@xps13>
In-Reply-To: <da7a99b4-36e9-9a52-6ec3-f6c31343d90e@gmail.com>
References: <20190725145804.8886-1-piotrs@cadence.com>
        <20190725150012.14416-1-piotrs@cadence.com>
        <da7a99b4-36e9-9a52-6ec3-f6c31343d90e@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Dmitry Osipenko <digetx@gmail.com> wrote on Thu, 25 Jul 2019 18:11:43
+0300:

> 25.07.2019 18:00, Piotr Sroka пишет:
> > Add new Cadence NAND driver to MTD subsystem
> > 
> > Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> > ---
> > Changes for v5:
> > - fix "ecc config strength" field size
> > - remove unused macros
> > - fix address of timing2 register
> > - add guard for accessing data_control_size register
> > - simplify the driver by use the same function 
> >   for accessing main area and oob area
> > - add comment to the driver describing main controller modes
> > - change compatible name from cdns,hpnfc to cdns,hp-nfc
> > Changes for v4:
> > - fix comments issues like typos, missing capitals, missing dots etc.
> > - remove unnecessary PHY options phy_dll_aging and phy_per_bit_deskew
> > - replace all register access functions to "relaxed" version
> > - remove all unnecessary variables initializations
> > - handle error inside cadence_nand_get_ecc_strength_idx function in case 
> >   correnction strength is not found
> > - add commit message
> > Changes for v3:
> > - remove definitions of unused registers
> > - remove configuring registers which are not expected to be configured in
> >   asynchronous mode
> > - remove not needed function reading timing registers
> > - remove information about oob size and write size from cdns_nand_chip type
> >   and use vales from mtd_info directly
> > - use nand_cleanup instead of nand_release if mtd device is not registered yet
> > - fix cadence_nand_chips_init function add garbage collection 
> >   if a chip init fails
> > - simplify PHY calculations
> > Changes for v2:
> > - create one universal wait function for all events instead of one
> >   function per event.
> > - split one big function executing nand operations to separate
> >   functions one per each type of operation.
> > - add erase atomic operation to nand operation parser
> > - remove unnecessary includes.
> > - remove unused register defines 
> > - add support for multiple nand chips
> > - remove all code using legacy functions
> > - remove chip dependents parameters from dts bindings, they were
> >   attached to the SoC specific compatible at the driver level
> > - simplify interrupt handling
> > - simplify timing calculations
> > - fix calculation of maximum supported cs signals
> > - simplify ecc size calculation
> > - remove header file and put whole code to one c file
> > ---
> >  drivers/mtd/nand/raw/Kconfig                   |    7 +
> >  drivers/mtd/nand/raw/Makefile                  |    1 +
> >  drivers/mtd/nand/raw/cadence-nand-controller.c | 3021 ++++++++++++++++++++++++
> >  3 files changed, 3029 insertions(+)
> >  create mode 100644 drivers/mtd/nand/raw/cadence-nand-controller.c
> > 
> > diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> > index e604625e2dfa..4d2ce3b5b2ae 100644
> > --- a/drivers/mtd/nand/raw/Kconfig
> > +++ b/drivers/mtd/nand/raw/Kconfig
> > @@ -557,5 +557,12 @@ config MTD_NAND_MESON
> >  	help
> >  	  Enables support for NAND controller on Amlogic's Meson SoCs.
> >  	  This controller is found on Meson SoCs.
> > +config MTD_NAND_CADENCE
> > +	tristate "Support Cadence NAND (HPNFC) controller"
> > +	depends on OF
> > +	help
> > +	  Enable the driver for NAND flash on platforms using a Cadence NAND
> > +	  controller.
> > +
> >  
> >  endif # MTD_NAND
> > diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> > index 5a5a72f0793e..f4b099f276f7 100644
> > --- a/drivers/mtd/nand/raw/Makefile
> > +++ b/drivers/mtd/nand/raw/Makefile
> > @@ -58,6 +58,7 @@ obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
> >  obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
> >  obj-$(CONFIG_MTD_NAND_STM32_FMC2)	+= stm32_fmc2_nand.o
> >  obj-$(CONFIG_MTD_NAND_MESON)		+= meson_nand.o
> > +obj-$(CONFIG_MTD_NAND_CADENCE)		+= cadence-nand-controller.o
> >  
> >  nand-objs := nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_ids.o
> >  nand-objs += nand_onfi.o
> > diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
> > new file mode 100644
> > index 000000000000..a7ff4e4585d3
> > --- /dev/null
> > +++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
> > @@ -0,0 +1,3021 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Cadence NAND flash controller driver
> > + *
> > + * Copyright (C) 2019 Cadence
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/mtd/mtd.h>
> > +#include <linux/mtd/rawnand.h>
> > +#include <linux/of_device.h>
> > +#include <linux/iopoll.h>
> > +
> > +/*
> > + * HPNFC can work in 3 modes:
> > + * -  PIO - can work in master or slave DMA.
> > + * -  CDMA - needs Master DMA for accessing command descriptors.
> > + * -  Generic mode - can use only slave DMA.
> > + * CDMA and PIO modes can be used to execute only base commands.
> > + * Generic mode can be used to execute any command
> > + * on NAND flash memory. Driver uses CDMA mode for
> > + * block erasing, page reading, page programing.
> > + * Generic mode is used for executing rest of commands.
> > + */
> > +
> > +#define MAX_OOB_SIZE_PER_SECTOR	32
> > +#define MAX_ADDRESS_CYC		6
> > +#define MAX_ERASE_ADDRESS_CYC	3
> > +#define MAX_DATA_SIZE		0xFFFC
> > +
> > +/* Register definition. */
> > +/*
> > + * Command register 0.
> > + * Writing data to this register will initiate a new transaction
> > + * of the NF controller.
> > + */
> > +#define CMD_REG0			0x0000
> > +/* Command type field mask. */
> > +#define		CMD_REG0_CT		GENMASK(31, 30)
> > +/* Command type CDMA. */
> > +#define		CMD_REG0_CT_CDMA	0uL
> > +/* Command type generic. */
> > +#define		CMD_REG0_CT_GEN		3uL
> > +/* Command thread number field mask. */
> > +#define		CMD_REG0_TN		GENMASK(27, 24)
> > +
> > +/* Command register 2. */
> > +#define CMD_REG2			0x0008
> > +/* Command register 3. */
> > +#define CMD_REG3			0x000C
> > +/* Pointer register to select which thread status will be selected. */
> > +#define CMD_STATUS_PTR			0x0010
> > +/* Command status register for selected thread. */
> > +#define CMD_STATUS			0x0014
> > +
> > +/* Interrupt status register. */
> > +#define INTR_STATUS			0x0110
> > +#define		INTR_STATUS_SDMA_ERR	BIT(22)
> > +#define		INTR_STATUS_SDMA_TRIGG	BIT(21)
> > +#define		INTR_STATUS_UNSUPP_CMD	BIT(19)
> > +#define		INTR_STATUS_DDMA_TERR	BIT(18)
> > +#define		INTR_STATUS_CDMA_TERR	BIT(17)
> > +#define		INTR_STATUS_CDMA_IDL	BIT(16)
> > +
> > +/* Interrupt enable register. */
> > +#define INTR_ENABLE				0x0114
> > +#define		INTR_ENABLE_INTR_EN		BIT(31)
> > +#define		INTR_ENABLE_SDMA_ERR_EN		BIT(22)
> > +#define		INTR_ENABLE_SDMA_TRIGG_EN	BIT(21)
> > +#define		INTR_ENABLE_UNSUPP_CMD_EN	BIT(19)
> > +#define		INTR_ENABLE_DDMA_TERR_EN	BIT(18)
> > +#define		INTR_ENABLE_CDMA_TERR_EN	BIT(17)
> > +#define		INTR_ENABLE_CDMA_IDLE_EN	BIT(16)
> > +
> > +/* Controller internal state. */
> > +#define CTRL_STATUS				0x0118
> > +#define		CTRL_STATUS_INIT_COMP		BIT(9)
> > +#define		CTRL_STATUS_CTRL_BUSY		BIT(8)
> > +
> > +/* Command Engine threads state. */
> > +#define TRD_STATUS				0x0120
> > +
> > +/* Command Engine interrupt thread error status. */
> > +#define TRD_ERR_INT_STATUS			0x0128
> > +/* Command Engine interrupt thread error enable. */
> > +#define TRD_ERR_INT_STATUS_EN			0x0130
> > +/* Command Engine interrupt thread complete status. */
> > +#define TRD_COMP_INT_STATUS			0x0138
> > +
> > +/*
> > + * Transfer config 0 register.
> > + * Configures data transfer parameters.
> > + */
> > +#define TRAN_CFG_0				0x0400
> > +/* Offset value from the beginning of the page. */
> > +#define		TRAN_CFG_0_OFFSET		GENMASK(31, 16)
> > +/* Numbers of sectors to transfer within singlNF device's page. */
> > +#define		TRAN_CFG_0_SEC_CNT		GENMASK(7, 0)
> > +
> > +/*
> > + * Transfer config 1 register.
> > + * Configures data transfer parameters.
> > + */
> > +#define TRAN_CFG_1				0x0404
> > +/* Size of last data sector. */
> > +#define		TRAN_CFG_1_LAST_SEC_SIZE	GENMASK(31, 16)
> > +/* Size of not-last data sector. */
> > +#define		TRAN_CFG_1_SECTOR_SIZE		GENMASK(15, 0)
> > +
> > +/* ECC engine configuration register 0. */
> > +#define ECC_CONFIG_0				0x0428
> > +/* Correction strength. */
> > +#define		ECC_CONFIG_0_CORR_STR		GENMASK(10, 8)
> > +/* Enable erased pages detection mechanism. */
> > +#define		ECC_CONFIG_0_ERASE_DET_EN	BIT(1)
> > +/* Enable controller ECC check bits generation and correction. */
> > +#define		ECC_CONFIG_0_ECC_EN		BIT(0)
> > +
> > +/* ECC engine configuration register 1. */
> > +#define ECC_CONFIG_1				0x042C
> > +
> > +/* Multiplane settings register. */
> > +#define MULTIPLANE_CFG				0x0434
> > +/* Cache operation settings. */
> > +#define CACHE_CFG				0x0438
> > +
> > +/* DMA settings register. */
> > +#define DMA_SETINGS				0x043C
> > +/* Enable SDMA error report on access unprepared slave DMA interface. */
> > +#define		DMA_SETINGS_SDMA_ERR_RSP	BIT(17)
> > +
> > +/* Transferred data block size for the slave DMA module. */
> > +#define SDMA_SIZE				0x0440
> > +
> > +/* Thread number associated with transferred data block
> > + * for the slave DMA module.
> > + */
> > +#define SDMA_TRD_NUM				0x0444
> > +/* Thread number mask. */
> > +#define		SDMA_TRD_NUM_SDMA_TRD		GENMASK(2, 0)
> > +
> > +#define CONTROL_DATA_CTRL			0x0494
> > +/* Thread number mask. */
> > +#define		CONTROL_DATA_CTRL_SIZE		GENMASK(15, 0)
> > +
> > +#define CTRL_VERSION				0x800
> > +
> > +/* Available hardware features of the controller. */
> > +#define CTRL_FEATURES				0x804
> > +/* Support for NV-DDR2/3 work mode. */
> > +#define		CTRL_FEATURES_NVDDR_2_3		BIT(28)
> > +/* Support for NV-DDR work mode. */
> > +#define		CTRL_FEATURES_NVDDR		BIT(27)
> > +/* Support for asynchronous work mode. */
> > +#define		CTRL_FEATURES_ASYNC		BIT(26)
> > +/* Support for asynchronous work mode. */
> > +#define		CTRL_FEATURES_N_BANKS		GENMASK(25, 24)
> > +/* Slave and Master DMA data width. */
> > +#define		CTRL_FEATURES_DMA_DWITH64	BIT(21)
> > +/* Availability of Control Data feature.*/
> > +#define		CTRL_FEATURES_CONTROL_DATA	BIT(10)
> > +
> > +/* BCH Engine identification register 0 - correction strengths. */
> > +#define BCH_CFG_0				0x838
> > +#define		BCH_CFG_0_CORR_CAP_0		GENMASK(7, 0)
> > +#define		BCH_CFG_0_CORR_CAP_1		GENMASK(15, 8)
> > +#define		BCH_CFG_0_CORR_CAP_2		GENMASK(23, 16)
> > +#define		BCH_CFG_0_CORR_CAP_3		GENMASK(31, 24)
> > +
> > +/* BCH Engine identification register 1 - correction strengths. */
> > +#define BCH_CFG_1				0x83C
> > +#define		BCH_CFG_1_CORR_CAP_4		GENMASK(7, 0)
> > +#define		BCH_CFG_1_CORR_CAP_5		GENMASK(15, 8)
> > +#define		BCH_CFG_1_CORR_CAP_6		GENMASK(23, 16)
> > +#define		BCH_CFG_1_CORR_CAP_7		GENMASK(31, 24)
> > +
> > +/* BCH Engine identification register 2 - sector sizes. */
> > +#define BCH_CFG_2				0x840
> > +#define		BCH_CFG_2_SECT_0		GENMASK(15, 0)
> > +#define		BCH_CFG_2_SECT_1		GENMASK(31, 16)
> > +
> > +/* BCH Engine identification register 3. */
> > +#define BCH_CFG_3				0x844
> > +
> > +/* Ready/Busy# line status. */
> > +#define RBN_SETINGS				0x1004
> > +
> > +/* Common settings. */
> > +#define COMMON_SET				0x1008
> > +/* 16 bit device connected to the NAND Flash interface. */
> > +#define		COMMON_SET_DEVICE_16BIT		BIT(8)
> > +
> > +/* Skip_bytes registers. */
> > +#define SKIP_BYTES_CONF				0x100C
> > +#define		SKIP_BYTES_MARKER_VALUE		GENMASK(31, 16)
> > +#define		SKIP_BYTES_NUM_OF_BYTES		GENMASK(7, 0)
> > +
> > +#define SKIP_BYTES_OFFSET			0x1010
> > +#define		 SKIP_BYTES_OFFSET_VALUE	GENMASK(23, 0)
> > +
> > +/* Timings configuration. */
> > +#define ASYNC_TOGGLE_TIMINGS			0x101c
> > +#define		ASYNC_TOGGLE_TIMINGS_TRH	GENMASK(28, 24)
> > +#define		ASYNC_TOGGLE_TIMINGS_TRP	GENMASK(20, 16)
> > +#define		ASYNC_TOGGLE_TIMINGS_TWH	GENMASK(12, 8)
> > +#define		ASYNC_TOGGLE_TIMINGS_TWP	GENMASK(4, 0)
> > +
> > +#define	TIMINGS0				0x1024
> > +#define		TIMINGS0_TADL			GENMASK(31, 24)
> > +#define		TIMINGS0_TCCS			GENMASK(23, 16)
> > +#define		TIMINGS0_TWHR			GENMASK(15, 8)
> > +#define		TIMINGS0_TRHW			GENMASK(7, 0)
> > +
> > +#define	TIMINGS1				0x1028
> > +#define		TIMINGS1_TRHZ			GENMASK(31, 24)
> > +#define		TIMINGS1_TWB			GENMASK(23, 16)
> > +#define		TIMINGS1_TVDLY			GENMASK(7, 0)
> > +
> > +#define	TIMINGS2				0x102c
> > +#define		TIMINGS2_TFEAT			GENMASK(25, 16)
> > +#define		TIMINGS2_CS_HOLD_TIME		GENMASK(13, 8)
> > +#define		TIMINGS2_CS_SETUP_TIME		GENMASK(5, 0)
> > +
> > +/* Configuration of the resynchronization of slave DLL of PHY. */
> > +#define DLL_PHY_CTRL				0x1034
> > +#define		DLL_PHY_CTRL_DLL_RST_N		BIT(24)
> > +#define		DLL_PHY_CTRL_EXTENDED_WR_MODE	BIT(17)
> > +#define		DLL_PHY_CTRL_EXTENDED_RD_MODE	BIT(16)
> > +#define		DLL_PHY_CTRL_RS_HIGH_WAIT_CNT	GENMASK(11, 8)
> > +#define		DLL_PHY_CTRL_RS_IDLE_CNT	GENMASK(7, 0)
> > +
> > +/* Register controlling DQ related timing. */
> > +#define PHY_DQ_TIMING				0x2000
> > +/* Register controlling DSQ related timing.  */
> > +#define PHY_DQS_TIMING				0x2004
> > +#define		PHY_DQS_TIMING_DQS_SEL_OE_END	GENMASK(3, 0)
> > +#define		PHY_DQS_TIMING_PHONY_DQS_SEL	BIT(16)
> > +#define		PHY_DQS_TIMING_USE_PHONY_DQS	BIT(20)
> > +
> > +/* Register controlling the gate and loopback control related timing. */
> > +#define PHY_GATE_LPBK_CTRL			0x2008
> > +#define		PHY_GATE_LPBK_CTRL_RDS		GENMASK(24, 19)
> > +
> > +/* Register holds the control for the master DLL logic. */
> > +#define PHY_DLL_MASTER_CTRL			0x200C
> > +#define		PHY_DLL_MASTER_CTRL_BYPASS_MODE	BIT(23)
> > +
> > +/* Register holds the control for the slave DLL logic. */
> > +#define PHY_DLL_SLAVE_CTRL			0x2010
> > +
> > +/* This register handles the global control settings for the PHY. */
> > +#define PHY_CTRL				0x2080
> > +#define		PHY_CTRL_SDR_DQS		BIT(14)
> > +#define		PHY_CTRL_PHONY_DQS		GENMASK(9, 4)
> > +
> > +/*
> > + * This register handles the global control settings
> > + * for the termination selects for reads.
> > + */
> > +#define PHY_TSEL				0x2084
> > +
> > +/* Generic command layout. */
> > +#define GCMD_LAY_CS			GENMASK_ULL(11, 8)
> > +/*
> > + * This bit informs the minicotroller if it has to wait for tWB
> > + * after sending the last CMD/ADDR/DATA in the sequence.
> > + */
> > +#define GCMD_LAY_TWB			BIT_ULL(6)
> > +/* Type of generic instruction. */
> > +#define GCMD_LAY_INSTR			GENMASK_ULL(5, 0)
> > +
> > +/* Generic CMD sequence type. */
> > +#define		GCMD_LAY_INSTR_CMD	0
> > +/* Generic ADDR sequence type. */
> > +#define		GCMD_LAY_INSTR_ADDR	1
> > +/* Generic data transfer sequence type. */
> > +#define		GCMD_LAY_INSTR_DATA	2
> > +
> > +/* Input part of generic command type of input is command. */
> > +#define GCMD_LAY_INPUT_CMD		GENMASK_ULL(23, 16)
> > +
> > +/* Generic command address sequence - address fields. */
> > +#define GCMD_LAY_INPUT_ADDR		GENMASK_ULL(63, 16)
> > +/* Generic command address sequence - address size. */
> > +#define GCMD_LAY_INPUT_ADDR_SIZE	GENMASK_ULL(13, 11)
> > +
> > +/* Transfer direction field of generic command data sequence. */
> > +#define GCMD_DIR			BIT_ULL(11)
> > +/* Read transfer direction of generic command data sequence. */
> > +#define		GCMD_DIR_READ		0
> > +/* Write transfer direction of generic command data sequence. */
> > +#define		GCMD_DIR_WRITE		1
> > +
> > +/* ECC enabled flag of generic command data sequence - ECC enabled. */
> > +#define GCMD_ECC_EN			BIT_ULL(12)
> > +/* Generic command data sequence - sector size. */
> > +#define GCMD_SECT_SIZE			GENMASK_ULL(31, 16)
> > +/* Generic command data sequence - sector count. */
> > +#define GCMD_SECT_CNT			GENMASK_ULL(39, 32)
> > +/* Generic command data sequence - last sector size. */
> > +#define GCMD_LAST_SIZE			GENMASK_ULL(55, 40)
> > +
> > +/* CDMA descriptor fields. */
> > +/* Erase command type of CDMA descriptor. */
> > +#define CDMA_CT_ERASE		0x1000
> > +/* Program page command type of CDMA descriptor. */
> > +#define CDMA_CT_WR		0x2100
> > +/* Read page command type of CDMA descriptor. */
> > +#define CDMA_CT_RD		0x2200
> > +
> > +/* Flash pointer memory shift. */
> > +#define CDMA_CFPTR_MEM_SHIFT	24
> > +/* Flash pointer memory mask. */
> > +#define CDMA_CFPTR_MEM		GENMASK(26, 24)
> > +
> > +/*
> > + * Command DMA descriptor flags. If set causes issue interrupt after
> > + * the completion of descriptor processing.
> > + */
> > +#define CDMA_CF_INT		BIT(8)
> > +/*
> > + * Command DMA descriptor flags - the next descriptor
> > + * address field is valid and descriptor processing should continue.
> > + */
> > +#define CDMA_CF_CONT		BIT(9)
> > +/* DMA master flag of command DMA descriptor. */
> > +#define CDMA_CF_DMA_MASTER	BIT(10)
> > +
> > +/* Operation complete status of command descriptor. */
> > +#define CDMA_CS_COMP		BIT(15)
> > +/* Operation complete status of command descriptor. */
> > +/* Command descriptor status - operation fail. */
> > +#define CDMA_CS_FAIL		BIT(14)
> > +/* Command descriptor status - page erased. */
> > +#define CDMA_CS_ERP		BIT(11)
> > +/* Command descriptor status - timeout occurred. */
> > +#define CDMA_CS_TOUT		BIT(10)
> > +/*
> > + * Maximum amount of correction applied to one ECC sector.
> > + * It is part of command descriptor status.
> > + */
> > +#define CDMA_CS_MAXERR		GENMASK(9, 2)
> > +/* Command descriptor status - uncorrectable ECC error. */
> > +#define CDMA_CS_UNCE		BIT(1)
> > +/* Command descriptor status - descriptor error. */
> > +#define CDMA_CS_ERR		BIT(0)
> > +
> > +/* Status of operation - OK. */
> > +#define STAT_OK			0
> > +/* Status of operation - FAIL. */
> > +#define STAT_FAIL		2
> > +/* Status of operation - uncorrectable ECC error. */
> > +#define STAT_ECC_UNCORR		3
> > +/* Status of operation - page erased. */
> > +#define STAT_ERASED		5
> > +/* Status of operation - correctable ECC error. */
> > +#define STAT_ECC_CORR		6
> > +/* Status of operation - unsuspected state. */
> > +#define STAT_UNKNOWN		7
> > +/* Status of operation - operation is not completed yet. */
> > +#define STAT_BUSY		0xFF
> > +
> > +#define BCH_MAX_NUM_CORR_CAPS		8
> > +#define BCH_MAX_NUM_SECTOR_SIZES	2
> > +
> > +struct cadence_nand_timings {
> > +	u32 async_toggle_timings;
> > +	u32 timings0;
> > +	u32 timings1;
> > +	u32 timings2;
> > +	u32 dll_phy_ctrl;
> > +	u32 phy_ctrl;
> > +	u32 phy_dqs_timing;
> > +	u32 phy_gate_lpbk_ctrl;
> > +};
> > +
> > +/* Command DMA descriptor. */
> > +struct cadence_nand_cdma_desc {
> > +	/* Next descriptor address. */
> > +	u64 next_pointer;
> > +
> > +	/* Flash address is a 32-bit address comprising of BANK and ROW ADDR. */
> > +	u32 flash_pointer;
> > +	u32 rsvd0;
> > +
> > +	/* Operation the controller needs to perform. */
> > +	u16 command_type;
> > +	u16 rsvd1;
> > +	/* Flags for operation of this command. */
> > +	u16 command_flags;
> > +	u16 rsvd2;
> > +
> > +	/* System/host memory address required for data DMA commands. */
> > +	u64 memory_pointer;
> > +
> > +	/* Status of operation. */
> > +	u32 status;
> > +	u32 rsvd3;
> > +
> > +	/* Address pointer to sync buffer location. */
> > +	u64 sync_flag_pointer;
> > +
> > +	/* Controls the buffer sync mechanism. */
> > +	u32 sync_arguments;
> > +	u32 rsvd4;
> > +
> > +	/* Control data pointer. */
> > +	u64 ctrl_data_ptr;
> > +};
> > +
> > +/* Interrupt status. */
> > +struct cadence_nand_irq_status {
> > +	/* Thread operation complete status. */
> > +	u32 trd_status;
> > +	/* Thread operation error. */
> > +	u32 trd_error;
> > +	/* Controller status. */
> > +	u32 status;
> > +};
> > +
> > +/* Cadence NAND flash controller capabilities get from driver data. */
> > +struct cadence_nand_dt_devdata {
> > +	/* Skew value of the output signals of the NAND Flash interface. */
> > +	u32 if_skew;
> > +	/* It informs if slave DMA interface is connected to DMA engine. */
> > +	unsigned int has_dma:1;
> > +};
> > +
> > +/* Cadence NAND flash controller capabilities read from registers. */
> > +struct cdns_nand_caps {
> > +	/* Maximum number of banks supported by hardware. */
> > +	u8 max_banks;
> > +	/* Slave and Master DMA data width in bytes (4 or 8). */
> > +	u8 data_dma_width;
> > +	/* Control Data feature supported. */
> > +	u8 data_control_supp;
> > +	/* Is PHY type DLL. */
> > +	u8 is_phy_type_dll;  
> 
> I'd make 'data_control_supp' and 'is_phy_type_dll' u8:1 or unsigned
> int:1 as you did for 'has_dma', for consistency.

Or just booleans. I know under certain circumstances it can be badly
handled but I don't think we care here.


Thanks,
Miquèl
