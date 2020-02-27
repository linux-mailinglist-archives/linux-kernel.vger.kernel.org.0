Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0FC172775
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 19:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgB0SYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 13:24:36 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39684 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbgB0SWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:22:43 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182241euoutp01a0c5fed92ff846381010aa2a5920dc88~3VXZl03Ju1217012170euoutp01g
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 18:22:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182241euoutp01a0c5fed92ff846381010aa2a5920dc88~3VXZl03Ju1217012170euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827761;
        bh=7gyvG9A7mtY2H7MnNSm+sr9cp9SQ0awJRftKDdaeH6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1GUtVY94d9v/ffCvHHb1unWeBvlPB2GFRMiPpIPQtvjEbW9EC/b/PePNx+wNs2VH
         HdFURaA0KybFQzjHLLex/dt+2+EOlmZbph/m3hCXT5h97L45Lueo/g2YHSrH1SgFPt
         GfP46FvUzWzP5sPztF1920Dsa1yVubDRmM6lF5vI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227182240eucas1p124e6010ba5c72d6fed97e1a95cb4f968~3VXZK3kCN1392413924eucas1p16;
        Thu, 27 Feb 2020 18:22:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B4.5F.60679.0F8085E5; Thu, 27
        Feb 2020 18:22:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182240eucas1p1035546a1fb97cfb9920542af289bf5ca~3VXY32zdT1935419354eucas1p1q;
        Thu, 27 Feb 2020 18:22:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182240eusmtrp15f48c870e402f28f3cfc676d9b672c54~3VXY3Lqip0185901859eusmtrp1d;
        Thu, 27 Feb 2020 18:22:40 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-aa-5e5808f034d3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 41.61.07950.0F8085E5; Thu, 27
        Feb 2020 18:22:40 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182239eusmtip274f4deb5fe658279f064569c3d903fe5~3VXYSk0uP1203512035eusmtip2L;
        Thu, 27 Feb 2020 18:22:39 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 03/27] ata: make SATA_PMP option selectable only if any
 SATA host driver is enabled
Date:   Thu, 27 Feb 2020 19:22:02 +0100
Message-Id: <20200227182226.19188-4-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO+fs7Gw4O07DN80uo8ysLLMfh27Y/UB/hMxC0tryOC1vbGla
        fwwvyZK0VKxZNKe4qXnNyzIdsqEmohgamKhJqFhppJZU5sx1lPz3vM/le94XPgqXWgRuVGTM
        TU4VI4+SkWKiof1Xz95v1KXQ/VV5Hkz5cBbJ1DyuEjATgy0YU1rehjH6gQaMaTd9xJi+pqck
        YxirwBlDhw1jnqXlC/3F7CvtsJDt645nLdYMxGbrWxHbmTZPsK/fJ5PszPggwT6oK0PsXO3m
        AFGw+EgYFxWZwKn2HbsqjlhMXSLjFgITp4vnhcmo9IQGiSigD0L3aBahQWJKShsRaIZGhfzw
        HYG1IkvAD3MIjClmcjXyYb54JWJA0FKU+j9Sp23D7C6SPgQP75UhO3aht0LmQilpN+F0PwZl
        UzqBXXCmI8DYvLAsUBRB74B+vYOdltBH4e6kBuPbtkD9/Ow/u4g+BgMPGkne4wSdT8YIO8aX
        PSn1Bbj9faDbhVAyNbISPgXG3JcCHjvD5446IY83QVdOJsEHKhEsZkyupBsRGHJsK4cehqGe
        3/+2w+ldUNW0j6ePQ65pSmingXaEgWknfglHeNSQj/O0BDLSpbzbE6pLqsnVWs2rUpzHLLwt
        aiWz0TbtmnO0a87R/u/VIbwMuXLx6mglpz4Qw93yUcuj1fExSp9rsdG1aPlnddk6vptQ0x+F
        BdEUkjlIdKaLoVKBPEGdFG1BQOEyF0nNjwuhUkmYPOk2p4q9ooqP4tQW5E4RMleJn/5TiJRW
        ym9yNzgujlOtqhglcktG7td1oIgKZjfm59mMgaLtId0jG8wlzxV+Ho3hre8ODF2eXbJaC+/s
        3nwmp8f8gpyxdnnZ/Hq9zBVUUuHOzMzKAO9m/1sFd3Xepx1lEzU9hj0lX6mf6+vP1yT37tKN
        JxSk59V9qbCeVFg8fSenQ8I7NAND98vXnc3PfhMUdG42USkj1BFyX29cpZb/BWgXC2VVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xe7ofOCLiDL785bRYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFohvbmCyO7XjEZHF51xw2i+VP1jJbLD/+j8libut0dgcuj52z7rJ7XD5b
        6nHocAejx4RFBxg9TrZ+Y/HYfbOBzePj01ssHn1bVjF6fN4kF8AZpWdTlF9akqqQkV9cYqsU
        bWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxt+U/W8HvkIq3S76xNzCudOpi
        5OSQEDCRuP9tCUsXIxeHkMBSRokpd54wdjFyACVkJI6vL4OoEZb4c62LDaLmE6PEt3czGEES
        bAJWEhPbV4HZIgIKEj2/V4IVMQvcYpJ4eaAbLCEskCbx5u8pdpChLAKqElcW8YCEeQVsJRpf
        dDFBLJCX2PrtEyuIzSlgJ3GjbzsbiC0EVNPV8ZQRol5Q4uTMJywgNjNQffPW2cwTGAVmIUnN
        QpJawMi0ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzCuth37uWUHY9e74EOMAhyMSjy8HtvC
        44RYE8uKK3MPMUpwMCuJ8G78GhonxJuSWFmVWpQfX1Sak1p8iNEU6IeJzFKiyfnAmM8riTc0
        NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cAoufPAtVuH2zcFpp7WUuvp
        2/Fj2ckYf1O9s/1dC5+K7FawX7SKfcG04/9PxfgvXSsotN9vyqwrltfvVky8HPaQf6WXSIIz
        u9uTWSLdH14UJod8Nlr2N/Gc5lOtLyt4585O6mD+6aq59/cJ90n5Pk8eLpJu4zt86M3nzH//
        5k7NiVSZalyYo7XtuRJLcUaioRZzUXEiABrWnpHBAgAA
X-CMS-MailID: 20200227182240eucas1p1035546a1fb97cfb9920542af289bf5ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182240eucas1p1035546a1fb97cfb9920542af289bf5ca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182240eucas1p1035546a1fb97cfb9920542af289bf5ca
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182240eucas1p1035546a1fb97cfb9920542af289bf5ca@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to expose SATA_PMP config option when no SATA
host drivers are enabled. To fix it add SATA_HOST config option,
make all SATA host drivers select it and finally make SATA_PMP
config options depend on it.

This also serves as preparation for the future changes which
optimize libata core code size on PATA only setups.

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com> # for SCSI bits
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig         | 40 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/Kconfig        |  1 +
 drivers/scsi/libsas/Kconfig |  1 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a6beb2c5a692..ad7760656f71 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -34,6 +34,9 @@ if ATA
 config ATA_NONSTANDARD
        bool
 
+config SATA_HOST
+	bool
+
 config ATA_VERBOSE_ERROR
 	bool "Verbose ATA error reporting"
 	default y
@@ -73,6 +76,7 @@ config SATA_ZPODD
 
 config SATA_PMP
 	bool "SATA Port Multiplier support"
+	depends on SATA_HOST
 	default y
 	help
 	  This option adds support for SATA Port Multipliers
@@ -85,6 +89,7 @@ comment "Controllers with non-SFF native interface"
 config SATA_AHCI
 	tristate "AHCI SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for AHCI Serial ATA.
 
@@ -111,6 +116,7 @@ config SATA_MOBILE_LPM_POLICY
 
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"
+	select SATA_HOST
 	help
 	  This option enables support for Platform AHCI Serial ATA
 	  controllers.
@@ -121,6 +127,7 @@ config AHCI_BRCM
 	tristate "Broadcom AHCI SATA support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP || \
 		   ARCH_BCM_63XX
+	select SATA_HOST
 	help
 	  This option enables support for the AHCI SATA3 controller found on
 	  Broadcom SoC's.
@@ -130,6 +137,7 @@ config AHCI_BRCM
 config AHCI_DA850
 	tristate "DaVinci DA850 AHCI SATA support"
 	depends on ARCH_DAVINCI_DA850
+	select SATA_HOST
 	help
 	  This option enables support for the DaVinci DA850 SoC's
 	  onboard AHCI SATA.
@@ -139,6 +147,7 @@ config AHCI_DA850
 config AHCI_DM816
 	tristate "DaVinci DM816 AHCI SATA support"
 	depends on ARCH_OMAP2PLUS
+	select SATA_HOST
 	help
 	  This option enables support for the DaVinci DM816 SoC's
 	  onboard AHCI SATA controller.
@@ -148,6 +157,7 @@ config AHCI_DM816
 config AHCI_ST
 	tristate "ST AHCI SATA support"
 	depends on ARCH_STI
+	select SATA_HOST
 	help
 	  This option enables support for ST AHCI SATA controller.
 
@@ -157,6 +167,7 @@ config AHCI_IMX
 	tristate "Freescale i.MX AHCI SATA support"
 	depends on MFD_SYSCON && (ARCH_MXC || COMPILE_TEST)
 	depends on (HWMON && (THERMAL || !THERMAL_OF)) || !HWMON
+	select SATA_HOST
 	help
 	  This option enables support for the Freescale i.MX SoC's
 	  onboard AHCI SATA.
@@ -166,6 +177,7 @@ config AHCI_IMX
 config AHCI_CEVA
 	tristate "CEVA AHCI SATA support"
 	depends on OF
+	select SATA_HOST
 	help
 	  This option enables support for the CEVA AHCI SATA.
 	  It can be found on the Xilinx Zynq UltraScale+ MPSoC.
@@ -176,6 +188,7 @@ config AHCI_MTK
 	tristate "MediaTek AHCI SATA support"
 	depends on ARCH_MEDIATEK
 	select MFD_SYSCON
+	select SATA_HOST
 	help
 	  This option enables support for the MediaTek SoC's
 	  onboard AHCI SATA controller.
@@ -185,6 +198,7 @@ config AHCI_MTK
 config AHCI_MVEBU
 	tristate "Marvell EBU AHCI SATA support"
 	depends on ARCH_MVEBU
+	select SATA_HOST
 	help
 	  This option enables support for the Marvebu EBU SoC's
 	  onboard AHCI SATA.
@@ -203,6 +217,7 @@ config AHCI_OCTEON
 config AHCI_SUNXI
 	tristate "Allwinner sunxi AHCI SATA support"
 	depends on ARCH_SUNXI
+	select SATA_HOST
 	help
 	  This option enables support for the Allwinner sunxi SoC's
 	  onboard AHCI SATA.
@@ -212,6 +227,7 @@ config AHCI_SUNXI
 config AHCI_TEGRA
 	tristate "NVIDIA Tegra AHCI SATA support"
 	depends on ARCH_TEGRA
+	select SATA_HOST
 	help
 	  This option enables support for the NVIDIA Tegra SoC's
 	  onboard AHCI SATA.
@@ -221,12 +237,14 @@ config AHCI_TEGRA
 config AHCI_XGENE
 	tristate "APM X-Gene 6.0Gbps AHCI SATA host controller support"
 	depends on PHY_XGENE
+	select SATA_HOST
 	help
 	 This option enables support for APM X-Gene SoC SATA host controller.
 
 config AHCI_QORIQ
 	tristate "Freescale QorIQ AHCI SATA support"
 	depends on OF
+	select SATA_HOST
 	help
 	  This option enables support for the Freescale QorIQ AHCI SoC's
 	  onboard AHCI SATA.
@@ -236,6 +254,7 @@ config AHCI_QORIQ
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
 	depends on FSL_SOC
+	select SATA_HOST
 	help
 	  This option enables support for Freescale 3.0Gbps SATA controller.
 	  It can be found on MPC837x and MPC8315.
@@ -245,6 +264,7 @@ config SATA_FSL
 config SATA_GEMINI
 	tristate "Gemini SATA bridge support"
 	depends on ARCH_GEMINI || COMPILE_TEST
+	select SATA_HOST
 	default ARCH_GEMINI
 	help
 	  This enabled support for the FTIDE010 to SATA bridge
@@ -255,6 +275,7 @@ config SATA_GEMINI
 config SATA_AHCI_SEATTLE
 	tristate "AMD Seattle 6.0Gbps AHCI SATA host controller support"
 	depends on ARCH_SEATTLE
+	select SATA_HOST
 	help
 	 This option enables support for AMD Seattle SATA host controller.
 
@@ -263,12 +284,14 @@ config SATA_AHCI_SEATTLE
 config SATA_INIC162X
 	tristate "Initio 162x SATA support (Very Experimental)"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Initio 162x Serial ATA.
 
 config SATA_ACARD_AHCI
 	tristate "ACard AHCI variant (ATP 8620)"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Acard.
 
@@ -277,6 +300,7 @@ config SATA_ACARD_AHCI
 config SATA_SIL24
 	tristate "Silicon Image 3124/3132 SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Silicon Image 3124/3132 Serial ATA.
 
@@ -326,6 +350,7 @@ config PATA_OCTEON_CF
 config SATA_QSTOR
 	tristate "Pacific Digital SATA QStor support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Pacific Digital Serial ATA QStor.
 
@@ -334,6 +359,7 @@ config SATA_QSTOR
 config SATA_SX4
 	tristate "Promise SATA SX4 support (Experimental)"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Promise Serial ATA SX4.
 
@@ -357,6 +383,7 @@ comment "SATA SFF controllers with BMDMA"
 config ATA_PIIX
 	tristate "Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for ICH5/6/7/8 Serial ATA
 	  and support for PATA on the Intel ESB/ICH/PIIX3/PIIX4 series
@@ -368,6 +395,7 @@ config SATA_DWC
 	tristate "DesignWare Cores SATA support"
 	depends on DMADEVICES
 	select GENERIC_PHY
+	select SATA_HOST
 	help
 	  This option enables support for the on-chip SATA controller of the
 	  AppliedMicro processor 460EX.
@@ -398,6 +426,7 @@ config SATA_DWC_VDEBUG
 config SATA_HIGHBANK
 	tristate "Calxeda Highbank SATA support"
 	depends on ARCH_HIGHBANK || COMPILE_TEST
+	select SATA_HOST
 	help
 	  This option enables support for the Calxeda Highbank SoC's
 	  onboard SATA.
@@ -409,6 +438,7 @@ config SATA_MV
 	depends on PCI || ARCH_DOVE || ARCH_MV78XX0 || \
 		   ARCH_MVEBU || ARCH_ORION5X || COMPILE_TEST
 	select GENERIC_PHY
+	select SATA_HOST
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] PCI(-X) chips,
@@ -419,6 +449,7 @@ config SATA_MV
 config SATA_NV
 	tristate "NVIDIA SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for NVIDIA Serial ATA.
 
@@ -427,6 +458,7 @@ config SATA_NV
 config SATA_PROMISE
 	tristate "Promise SATA TX2/TX4 support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Promise Serial ATA TX2/TX4.
 
@@ -435,6 +467,7 @@ config SATA_PROMISE
 config SATA_RCAR
 	tristate "Renesas R-Car SATA support"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	select SATA_HOST
 	help
 	  This option enables support for Renesas R-Car Serial ATA.
 
@@ -443,6 +476,7 @@ config SATA_RCAR
 config SATA_SIL
 	tristate "Silicon Image SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Silicon Image Serial ATA.
 
@@ -452,6 +486,7 @@ config SATA_SIS
 	tristate "SiS 964/965/966/180 SATA support"
 	depends on PCI
 	select PATA_SIS
+	select SATA_HOST
 	help
 	  This option enables support for SiS Serial ATA on
 	  SiS 964/965/966/180 and Parallel ATA on SiS 180.
@@ -462,6 +497,7 @@ config SATA_SIS
 config SATA_SVW
 	tristate "ServerWorks Frodo / Apple K2 SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Broadcom/Serverworks/Apple K2
 	  SATA support.
@@ -471,6 +507,7 @@ config SATA_SVW
 config SATA_ULI
 	tristate "ULi Electronics SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for ULi Electronics SATA.
 
@@ -479,6 +516,7 @@ config SATA_ULI
 config SATA_VIA
 	tristate "VIA SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for VIA Serial ATA.
 
@@ -487,6 +525,7 @@ config SATA_VIA
 config SATA_VITESSE
 	tristate "VITESSE VSC-7174 / INTEL 31244 SATA support"
 	depends on PCI
+	select SATA_HOST
 	help
 	  This option enables support for Vitesse VSC7174 and Intel 31244 Serial ATA.
 
@@ -1113,6 +1152,7 @@ config PATA_ACPI
 config ATA_GENERIC
 	tristate "Generic ATA support"
 	depends on PCI && ATA_BMDMA
+	select SATA_HOST
 	help
 	  This option enables support for generic BIOS configured
 	  ATA controllers via the new ATA layer
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 2b882b96e0d4..a790d360ceaa 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -980,6 +980,7 @@ config SCSI_SYM53C8XX_MMIO
 config SCSI_IPR
 	tristate "IBM Power Linux RAID adapter support"
 	depends on PCI && SCSI && ATA
+	select SATA_HOST
 	select FW_LOADER
 	select IRQ_POLL
 	select SGL_ALLOC
diff --git a/drivers/scsi/libsas/Kconfig b/drivers/scsi/libsas/Kconfig
index 5c6a5eff2f8e..052ee3a26f6e 100644
--- a/drivers/scsi/libsas/Kconfig
+++ b/drivers/scsi/libsas/Kconfig
@@ -19,6 +19,7 @@ config SCSI_SAS_ATA
 	bool "ATA support for libsas (requires libata)"
 	depends on SCSI_SAS_LIBSAS
 	depends on ATA = y || ATA = SCSI_SAS_LIBSAS
+	select SATA_HOST
 	help
 		Builds in ATA support into libsas.  Will necessitate
 		the loading of libata along with libsas.
-- 
2.24.1

