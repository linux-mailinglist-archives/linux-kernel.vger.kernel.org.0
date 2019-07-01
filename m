Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40A594D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 09:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfF1H2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 03:28:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57691 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfF1H2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:28:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ZpJl60q6z9s8m;
        Fri, 28 Jun 2019 17:28:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561706889;
        bh=KQj2LQ089BlTd7dI5gyCt+bO+s0CuBtt7KRYn+23UWM=;
        h=Date:From:To:Cc:Subject:From;
        b=TtZxRuTjAOW4dMuwmUVT8Jxa6QxP83VgtLzcsh0sRk+W5TT/KAPtVuur+1CGOJHXQ
         Tu3XHFGb4K237CCHWUzfcAypymI1wit8kiTE6Kn3KjMlBagCJ/Y7mGGyqS1fdyWvym
         wmiA2/5Olz3P3ZRHfnQIQFstqWG1SPqwseq273w3QMbOummQ1Kt9yr2Ekplen/mOks
         OwJrzkPVV/dbKr958ye3CIGmprw+NaRBo5HgeTN8EsXvSMN4sUaM9Yqx5yUAURerKH
         oCNw9+pQn3xSNqR70WjLU+w8RaV+xcJYNqoQBAyAHePbqpO4tDHHd9ILxG6FieRdkg
         WUC4VCBDDVcRg==
Date:   Fri, 28 Jun 2019 17:28:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: linux-next: manual merge of the gpio tree with the mfd tree
Message-ID: <20190628172807.4ae7edfc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jkUecS8sT4EF7dVutwrIyrx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jkUecS8sT4EF7dVutwrIyrx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the gpio tree got a conflict in:

  drivers/gpio/Makefile

between commit:

  18bc64b3aebf ("gpio: Initial support for ROHM bd70528 GPIO block")

from the mfd tree and commit:

  db16bad6efd9 ("gpio: Sort GPIO drivers in Makefile")

from the gpio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpio/Makefile
index 10efc4f743fe,9e400e34e300..000000000000
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@@ -17,155 -17,154 +17,155 @@@ obj-$(CONFIG_GPIO_GENERIC)	+=3D gpio-gene
  # directly supported by gpio-generic
  gpio-generic-$(CONFIG_GPIO_GENERIC)	+=3D gpio-mmio.o
 =20
- obj-$(CONFIG_GPIO_104_DIO_48E)	+=3D gpio-104-dio-48e.o
- obj-$(CONFIG_GPIO_104_IDIO_16)	+=3D gpio-104-idio-16.o
- obj-$(CONFIG_GPIO_104_IDI_48)	+=3D gpio-104-idi-48.o
- obj-$(CONFIG_GPIO_74X164)	+=3D gpio-74x164.o
- obj-$(CONFIG_GPIO_74XX_MMIO)	+=3D gpio-74xx-mmio.o
- obj-$(CONFIG_GPIO_ADNP)		+=3D gpio-adnp.o
- obj-$(CONFIG_GPIO_ADP5520)	+=3D gpio-adp5520.o
- obj-$(CONFIG_GPIO_ADP5588)	+=3D gpio-adp5588.o
- obj-$(CONFIG_GPIO_ALTERA)  	+=3D gpio-altera.o
- obj-$(CONFIG_GPIO_ALTERA_A10SR)	+=3D gpio-altera-a10sr.o
- obj-$(CONFIG_GPIO_AMD_FCH)	+=3D gpio-amd-fch.o
- obj-$(CONFIG_GPIO_AMD8111)	+=3D gpio-amd8111.o
- obj-$(CONFIG_GPIO_AMDPT)	+=3D gpio-amdpt.o
- obj-$(CONFIG_GPIO_ARIZONA)	+=3D gpio-arizona.o
- obj-$(CONFIG_GPIO_ATH79)	+=3D gpio-ath79.o
- obj-$(CONFIG_GPIO_ASPEED)	+=3D gpio-aspeed.o
- obj-$(CONFIG_GPIO_RASPBERRYPI_EXP)	+=3D gpio-raspberrypi-exp.o
- obj-$(CONFIG_GPIO_BCM_KONA)	+=3D gpio-bcm-kona.o
- obj-$(CONFIG_GPIO_BD70528) 	+=3D gpio-bd70528.o
- obj-$(CONFIG_GPIO_BD9571MWV)	+=3D gpio-bd9571mwv.o
- obj-$(CONFIG_GPIO_BRCMSTB)	+=3D gpio-brcmstb.o
- obj-$(CONFIG_GPIO_BT8XX)	+=3D gpio-bt8xx.o
- obj-$(CONFIG_GPIO_CADENCE)	+=3D gpio-cadence.o
- obj-$(CONFIG_GPIO_CLPS711X)	+=3D gpio-clps711x.o
- obj-$(CONFIG_GPIO_CS5535)	+=3D gpio-cs5535.o
- obj-$(CONFIG_GPIO_CRYSTAL_COVE)	+=3D gpio-crystalcove.o
- obj-$(CONFIG_GPIO_DA9052)	+=3D gpio-da9052.o
- obj-$(CONFIG_GPIO_DA9055)	+=3D gpio-da9055.o
- obj-$(CONFIG_GPIO_DAVINCI)	+=3D gpio-davinci.o
- obj-$(CONFIG_GPIO_DLN2)		+=3D gpio-dln2.o
- obj-$(CONFIG_GPIO_DWAPB)	+=3D gpio-dwapb.o
- obj-$(CONFIG_GPIO_EIC_SPRD)	+=3D gpio-eic-sprd.o
- obj-$(CONFIG_GPIO_EM)		+=3D gpio-em.o
- obj-$(CONFIG_GPIO_EP93XX)	+=3D gpio-ep93xx.o
- obj-$(CONFIG_GPIO_EXAR)		+=3D gpio-exar.o
- obj-$(CONFIG_GPIO_F7188X)	+=3D gpio-f7188x.o
- obj-$(CONFIG_GPIO_FTGPIO010)	+=3D gpio-ftgpio010.o
- obj-$(CONFIG_GPIO_GE_FPGA)	+=3D gpio-ge.o
- obj-$(CONFIG_GPIO_GPIO_MM)	+=3D gpio-gpio-mm.o
- obj-$(CONFIG_GPIO_GRGPIO)	+=3D gpio-grgpio.o
- obj-$(CONFIG_GPIO_GW_PLD)	+=3D gpio-gw-pld.o
- obj-$(CONFIG_GPIO_HLWD)		+=3D gpio-hlwd.o
- obj-$(CONFIG_HTC_EGPIO)		+=3D gpio-htc-egpio.o
- obj-$(CONFIG_GPIO_ICH)		+=3D gpio-ich.o
- obj-$(CONFIG_GPIO_IOP)		+=3D gpio-iop.o
- obj-$(CONFIG_GPIO_IXP4XX)	+=3D gpio-ixp4xx.o
- obj-$(CONFIG_GPIO_IT87)		+=3D gpio-it87.o
- obj-$(CONFIG_GPIO_JANZ_TTL)	+=3D gpio-janz-ttl.o
- obj-$(CONFIG_GPIO_KEMPLD)	+=3D gpio-kempld.o
- obj-$(CONFIG_ARCH_KS8695)	+=3D gpio-ks8695.o
- obj-$(CONFIG_GPIO_INTEL_MID)	+=3D gpio-intel-mid.o
- obj-$(CONFIG_GPIO_LOONGSON)	+=3D gpio-loongson.o
- obj-$(CONFIG_GPIO_LP3943)	+=3D gpio-lp3943.o
- obj-$(CONFIG_GPIO_LPC18XX)	+=3D gpio-lpc18xx.o
- obj-$(CONFIG_ARCH_LPC32XX)	+=3D gpio-lpc32xx.o
- obj-$(CONFIG_GPIO_LP873X)	+=3D gpio-lp873x.o
- obj-$(CONFIG_GPIO_LP87565)	+=3D gpio-lp87565.o
- obj-$(CONFIG_GPIO_LYNXPOINT)	+=3D gpio-lynxpoint.o
- obj-$(CONFIG_GPIO_MADERA)	+=3D gpio-madera.o
- obj-$(CONFIG_GPIO_MAX3191X)	+=3D gpio-max3191x.o
- obj-$(CONFIG_GPIO_MAX730X)	+=3D gpio-max730x.o
- obj-$(CONFIG_GPIO_MAX7300)	+=3D gpio-max7300.o
- obj-$(CONFIG_GPIO_MAX7301)	+=3D gpio-max7301.o
- obj-$(CONFIG_GPIO_MAX732X)	+=3D gpio-max732x.o
- obj-$(CONFIG_GPIO_MAX77620)	+=3D gpio-max77620.o
- obj-$(CONFIG_GPIO_MAX77650)	+=3D gpio-max77650.o
- obj-$(CONFIG_GPIO_MB86S7X)	+=3D gpio-mb86s7x.o
- obj-$(CONFIG_GPIO_MENZ127)	+=3D gpio-menz127.o
- obj-$(CONFIG_GPIO_MERRIFIELD)	+=3D gpio-merrifield.o
- obj-$(CONFIG_GPIO_MC33880)	+=3D gpio-mc33880.o
- obj-$(CONFIG_GPIO_MC9S08DZ60)	+=3D gpio-mc9s08dz60.o
- obj-$(CONFIG_GPIO_MLXBF)	+=3D gpio-mlxbf.o
- obj-$(CONFIG_GPIO_ML_IOH)	+=3D gpio-ml-ioh.o
- obj-$(CONFIG_GPIO_MM_LANTIQ)	+=3D gpio-mm-lantiq.o
- obj-$(CONFIG_GPIO_MOCKUP)      +=3D gpio-mockup.o
- obj-$(CONFIG_GPIO_MPC5200)	+=3D gpio-mpc5200.o
- obj-$(CONFIG_GPIO_MPC8XXX)	+=3D gpio-mpc8xxx.o
- obj-$(CONFIG_GPIO_MSIC)		+=3D gpio-msic.o
+ obj-$(CONFIG_GPIO_104_DIO_48E)		+=3D gpio-104-dio-48e.o
+ obj-$(CONFIG_GPIO_104_IDI_48)		+=3D gpio-104-idi-48.o
+ obj-$(CONFIG_GPIO_104_IDIO_16)		+=3D gpio-104-idio-16.o
+ obj-$(CONFIG_GPIO_74X164)		+=3D gpio-74x164.o
+ obj-$(CONFIG_GPIO_74XX_MMIO)		+=3D gpio-74xx-mmio.o
+ obj-$(CONFIG_GPIO_ADNP)			+=3D gpio-adnp.o
+ obj-$(CONFIG_GPIO_ADP5520)		+=3D gpio-adp5520.o
+ obj-$(CONFIG_GPIO_ADP5588)		+=3D gpio-adp5588.o
+ obj-$(CONFIG_GPIO_ALTERA_A10SR)		+=3D gpio-altera-a10sr.o
+ obj-$(CONFIG_GPIO_ALTERA)  		+=3D gpio-altera.o
+ obj-$(CONFIG_GPIO_AMD8111)		+=3D gpio-amd8111.o
+ obj-$(CONFIG_GPIO_AMD_FCH)		+=3D gpio-amd-fch.o
+ obj-$(CONFIG_GPIO_AMDPT)		+=3D gpio-amdpt.o
+ obj-$(CONFIG_GPIO_ARIZONA)		+=3D gpio-arizona.o
+ obj-$(CONFIG_GPIO_ASPEED)		+=3D gpio-aspeed.o
+ obj-$(CONFIG_GPIO_ATH79)		+=3D gpio-ath79.o
+ obj-$(CONFIG_GPIO_BCM_KONA)		+=3D gpio-bcm-kona.o
++obj-$(CONFIG_GPIO_BD70528) 		+=3D gpio-bd70528.o
+ obj-$(CONFIG_GPIO_BD9571MWV)		+=3D gpio-bd9571mwv.o
+ obj-$(CONFIG_GPIO_BRCMSTB)		+=3D gpio-brcmstb.o
+ obj-$(CONFIG_GPIO_BT8XX)		+=3D gpio-bt8xx.o
+ obj-$(CONFIG_GPIO_CADENCE)		+=3D gpio-cadence.o
+ obj-$(CONFIG_GPIO_CLPS711X)		+=3D gpio-clps711x.o
+ obj-$(CONFIG_GPIO_SNPS_CREG)		+=3D gpio-creg-snps.o
+ obj-$(CONFIG_GPIO_CRYSTAL_COVE)		+=3D gpio-crystalcove.o
+ obj-$(CONFIG_GPIO_CS5535)		+=3D gpio-cs5535.o
+ obj-$(CONFIG_GPIO_DA9052)		+=3D gpio-da9052.o
+ obj-$(CONFIG_GPIO_DA9055)		+=3D gpio-da9055.o
+ obj-$(CONFIG_GPIO_DAVINCI)		+=3D gpio-davinci.o
+ obj-$(CONFIG_GPIO_DLN2)			+=3D gpio-dln2.o
+ obj-$(CONFIG_GPIO_DWAPB)		+=3D gpio-dwapb.o
+ obj-$(CONFIG_GPIO_EIC_SPRD)		+=3D gpio-eic-sprd.o
+ obj-$(CONFIG_GPIO_EM)			+=3D gpio-em.o
+ obj-$(CONFIG_GPIO_EP93XX)		+=3D gpio-ep93xx.o
+ obj-$(CONFIG_GPIO_EXAR)			+=3D gpio-exar.o
+ obj-$(CONFIG_GPIO_F7188X)		+=3D gpio-f7188x.o
+ obj-$(CONFIG_GPIO_FTGPIO010)		+=3D gpio-ftgpio010.o
+ obj-$(CONFIG_GPIO_GE_FPGA)		+=3D gpio-ge.o
+ obj-$(CONFIG_GPIO_GPIO_MM)		+=3D gpio-gpio-mm.o
+ obj-$(CONFIG_GPIO_GRGPIO)		+=3D gpio-grgpio.o
+ obj-$(CONFIG_GPIO_GW_PLD)		+=3D gpio-gw-pld.o
+ obj-$(CONFIG_GPIO_HLWD)			+=3D gpio-hlwd.o
+ obj-$(CONFIG_HTC_EGPIO)			+=3D gpio-htc-egpio.o
+ obj-$(CONFIG_GPIO_ICH)			+=3D gpio-ich.o
+ obj-$(CONFIG_GPIO_INTEL_MID)		+=3D gpio-intel-mid.o
+ obj-$(CONFIG_GPIO_IOP)			+=3D gpio-iop.o
+ obj-$(CONFIG_GPIO_IT87)			+=3D gpio-it87.o
+ obj-$(CONFIG_GPIO_IXP4XX)		+=3D gpio-ixp4xx.o
+ obj-$(CONFIG_GPIO_JANZ_TTL)		+=3D gpio-janz-ttl.o
+ obj-$(CONFIG_GPIO_KEMPLD)		+=3D gpio-kempld.o
+ obj-$(CONFIG_ARCH_KS8695)		+=3D gpio-ks8695.o
+ obj-$(CONFIG_GPIO_LOONGSON1)		+=3D gpio-loongson1.o
+ obj-$(CONFIG_GPIO_LOONGSON)		+=3D gpio-loongson.o
+ obj-$(CONFIG_GPIO_LP3943)		+=3D gpio-lp3943.o
+ obj-$(CONFIG_GPIO_LP873X)		+=3D gpio-lp873x.o
+ obj-$(CONFIG_GPIO_LP87565)		+=3D gpio-lp87565.o
+ obj-$(CONFIG_GPIO_LPC18XX)		+=3D gpio-lpc18xx.o
+ obj-$(CONFIG_ARCH_LPC32XX)		+=3D gpio-lpc32xx.o
+ obj-$(CONFIG_GPIO_LYNXPOINT)		+=3D gpio-lynxpoint.o
+ obj-$(CONFIG_GPIO_MADERA)		+=3D gpio-madera.o
+ obj-$(CONFIG_GPIO_MAX3191X)		+=3D gpio-max3191x.o
+ obj-$(CONFIG_GPIO_MAX7300)		+=3D gpio-max7300.o
+ obj-$(CONFIG_GPIO_MAX7301)		+=3D gpio-max7301.o
+ obj-$(CONFIG_GPIO_MAX730X)		+=3D gpio-max730x.o
+ obj-$(CONFIG_GPIO_MAX732X)		+=3D gpio-max732x.o
+ obj-$(CONFIG_GPIO_MAX77620)		+=3D gpio-max77620.o
+ obj-$(CONFIG_GPIO_MAX77650)		+=3D gpio-max77650.o
+ obj-$(CONFIG_GPIO_MB86S7X)		+=3D gpio-mb86s7x.o
+ obj-$(CONFIG_GPIO_MC33880)		+=3D gpio-mc33880.o
+ obj-$(CONFIG_GPIO_MC9S08DZ60)		+=3D gpio-mc9s08dz60.o
+ obj-$(CONFIG_GPIO_MENZ127)		+=3D gpio-menz127.o
+ obj-$(CONFIG_GPIO_MERRIFIELD)		+=3D gpio-merrifield.o
+ obj-$(CONFIG_GPIO_ML_IOH)		+=3D gpio-ml-ioh.o
+ obj-$(CONFIG_GPIO_MLXBF)		+=3D gpio-mlxbf.o
+ obj-$(CONFIG_GPIO_MM_LANTIQ)		+=3D gpio-mm-lantiq.o
+ obj-$(CONFIG_GPIO_MOCKUP)		+=3D gpio-mockup.o
+ obj-$(CONFIG_GPIO_MPC5200)		+=3D gpio-mpc5200.o
+ obj-$(CONFIG_GPIO_MPC8XXX)		+=3D gpio-mpc8xxx.o
+ obj-$(CONFIG_GPIO_MSIC)			+=3D gpio-msic.o
  obj-$(CONFIG_GPIO_MT7621)		+=3D gpio-mt7621.o
- obj-$(CONFIG_GPIO_MVEBU)        +=3D gpio-mvebu.o
- obj-$(CONFIG_GPIO_MXC)		+=3D gpio-mxc.o
- obj-$(CONFIG_GPIO_MXS)		+=3D gpio-mxs.o
- obj-$(CONFIG_GPIO_OCTEON)	+=3D gpio-octeon.o
- obj-$(CONFIG_GPIO_OMAP)		+=3D gpio-omap.o
- obj-$(CONFIG_GPIO_PCA953X)	+=3D gpio-pca953x.o
- obj-$(CONFIG_GPIO_PCF857X)	+=3D gpio-pcf857x.o
- obj-$(CONFIG_GPIO_PCH)		+=3D gpio-pch.o
- obj-$(CONFIG_GPIO_PCI_IDIO_16)	+=3D gpio-pci-idio-16.o
- obj-$(CONFIG_GPIO_PCIE_IDIO_24)	+=3D gpio-pcie-idio-24.o
- obj-$(CONFIG_GPIO_PISOSR)	+=3D gpio-pisosr.o
- obj-$(CONFIG_GPIO_PL061)	+=3D gpio-pl061.o
+ obj-$(CONFIG_GPIO_MVEBU)		+=3D gpio-mvebu.o
+ obj-$(CONFIG_GPIO_MXC)			+=3D gpio-mxc.o
+ obj-$(CONFIG_GPIO_MXS)			+=3D gpio-mxs.o
+ obj-$(CONFIG_GPIO_OCTEON)		+=3D gpio-octeon.o
+ obj-$(CONFIG_GPIO_OMAP)			+=3D gpio-omap.o
+ obj-$(CONFIG_GPIO_PALMAS)		+=3D gpio-palmas.o
+ obj-$(CONFIG_GPIO_PCA953X)		+=3D gpio-pca953x.o
+ obj-$(CONFIG_GPIO_PCF857X)		+=3D gpio-pcf857x.o
+ obj-$(CONFIG_GPIO_PCH)			+=3D gpio-pch.o
+ obj-$(CONFIG_GPIO_PCIE_IDIO_24)		+=3D gpio-pcie-idio-24.o
+ obj-$(CONFIG_GPIO_PCI_IDIO_16)		+=3D gpio-pci-idio-16.o
+ obj-$(CONFIG_GPIO_PISOSR)		+=3D gpio-pisosr.o
+ obj-$(CONFIG_GPIO_PL061)		+=3D gpio-pl061.o
  obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)	+=3D gpio-pmic-eic-sprd.o
- obj-$(CONFIG_GPIO_PXA)		+=3D gpio-pxa.o
- obj-$(CONFIG_GPIO_RC5T583)	+=3D gpio-rc5t583.o
- obj-$(CONFIG_GPIO_RDC321X)	+=3D gpio-rdc321x.o
- obj-$(CONFIG_GPIO_RCAR)		+=3D gpio-rcar.o
- obj-$(CONFIG_GPIO_REG)		+=3D gpio-reg.o
- obj-$(CONFIG_ARCH_SA1100)	+=3D gpio-sa1100.o
+ obj-$(CONFIG_GPIO_PXA)			+=3D gpio-pxa.o
+ obj-$(CONFIG_GPIO_RASPBERRYPI_EXP)	+=3D gpio-raspberrypi-exp.o
+ obj-$(CONFIG_GPIO_RC5T583)		+=3D gpio-rc5t583.o
+ obj-$(CONFIG_GPIO_RCAR)			+=3D gpio-rcar.o
+ obj-$(CONFIG_GPIO_RDC321X)		+=3D gpio-rdc321x.o
+ obj-$(CONFIG_GPIO_REG)			+=3D gpio-reg.o
+ obj-$(CONFIG_ARCH_SA1100)		+=3D gpio-sa1100.o
  obj-$(CONFIG_GPIO_SAMA5D2_PIOBU)	+=3D gpio-sama5d2-piobu.o
- obj-$(CONFIG_GPIO_SCH)		+=3D gpio-sch.o
- obj-$(CONFIG_GPIO_SCH311X)	+=3D gpio-sch311x.o
- obj-$(CONFIG_GPIO_SNPS_CREG)	+=3D gpio-creg-snps.o
- obj-$(CONFIG_GPIO_SODAVILLE)	+=3D gpio-sodaville.o
- obj-$(CONFIG_GPIO_SPEAR_SPICS)	+=3D gpio-spear-spics.o
- obj-$(CONFIG_GPIO_SPRD)		+=3D gpio-sprd.o
- obj-$(CONFIG_GPIO_STA2X11)	+=3D gpio-sta2x11.o
- obj-$(CONFIG_GPIO_STMPE)	+=3D gpio-stmpe.o
- obj-$(CONFIG_GPIO_STP_XWAY)	+=3D gpio-stp-xway.o
- obj-$(CONFIG_GPIO_SYSCON)	+=3D gpio-syscon.o
- obj-$(CONFIG_GPIO_TB10X)	+=3D gpio-tb10x.o
- obj-$(CONFIG_GPIO_TC3589X)	+=3D gpio-tc3589x.o
- obj-$(CONFIG_GPIO_TEGRA)	+=3D gpio-tegra.o
- obj-$(CONFIG_GPIO_TEGRA186)	+=3D gpio-tegra186.o
- obj-$(CONFIG_GPIO_THUNDERX)	+=3D gpio-thunderx.o
- obj-$(CONFIG_GPIO_TIMBERDALE)	+=3D gpio-timberdale.o
- obj-$(CONFIG_GPIO_PALMAS)	+=3D gpio-palmas.o
- obj-$(CONFIG_GPIO_SIOX)		+=3D gpio-siox.o
- obj-$(CONFIG_GPIO_TPIC2810)	+=3D gpio-tpic2810.o
- obj-$(CONFIG_GPIO_TPS65086)	+=3D gpio-tps65086.o
- obj-$(CONFIG_GPIO_TPS65218)	+=3D gpio-tps65218.o
- obj-$(CONFIG_GPIO_TPS6586X)	+=3D gpio-tps6586x.o
- obj-$(CONFIG_GPIO_TPS65910)	+=3D gpio-tps65910.o
- obj-$(CONFIG_GPIO_TPS65912)	+=3D gpio-tps65912.o
- obj-$(CONFIG_GPIO_TPS68470)	+=3D gpio-tps68470.o
- obj-$(CONFIG_GPIO_TQMX86)	+=3D gpio-tqmx86.o
- obj-$(CONFIG_GPIO_TS4800)	+=3D gpio-ts4800.o
- obj-$(CONFIG_GPIO_TS4900)	+=3D gpio-ts4900.o
- obj-$(CONFIG_GPIO_TS5500)	+=3D gpio-ts5500.o
- obj-$(CONFIG_GPIO_TWL4030)	+=3D gpio-twl4030.o
- obj-$(CONFIG_GPIO_TWL6040)	+=3D gpio-twl6040.o
- obj-$(CONFIG_GPIO_UCB1400)	+=3D gpio-ucb1400.o
- obj-$(CONFIG_GPIO_UNIPHIER)	+=3D gpio-uniphier.o
- obj-$(CONFIG_GPIO_VF610)	+=3D gpio-vf610.o
- obj-$(CONFIG_GPIO_VIPERBOARD)	+=3D gpio-viperboard.o
- obj-$(CONFIG_GPIO_VR41XX)	+=3D gpio-vr41xx.o
- obj-$(CONFIG_GPIO_VX855)	+=3D gpio-vx855.o
- obj-$(CONFIG_GPIO_WHISKEY_COVE)	+=3D gpio-wcove.o
- obj-$(CONFIG_GPIO_WINBOND)	+=3D gpio-winbond.o
- obj-$(CONFIG_GPIO_WM831X)	+=3D gpio-wm831x.o
- obj-$(CONFIG_GPIO_WM8350)	+=3D gpio-wm8350.o
- obj-$(CONFIG_GPIO_WM8994)	+=3D gpio-wm8994.o
- obj-$(CONFIG_GPIO_WS16C48)	+=3D gpio-ws16c48.o
- obj-$(CONFIG_GPIO_XGENE)	+=3D gpio-xgene.o
- obj-$(CONFIG_GPIO_XGENE_SB)	+=3D gpio-xgene-sb.o
- obj-$(CONFIG_GPIO_XILINX)	+=3D gpio-xilinx.o
- obj-$(CONFIG_GPIO_XLP)		+=3D gpio-xlp.o
- obj-$(CONFIG_GPIO_XRA1403)	+=3D gpio-xra1403.o
- obj-$(CONFIG_GPIO_XTENSA)	+=3D gpio-xtensa.o
- obj-$(CONFIG_GPIO_ZEVIO)	+=3D gpio-zevio.o
- obj-$(CONFIG_GPIO_ZYNQ)		+=3D gpio-zynq.o
- obj-$(CONFIG_GPIO_ZX)		+=3D gpio-zx.o
- obj-$(CONFIG_GPIO_LOONGSON1)	+=3D gpio-loongson1.o
+ obj-$(CONFIG_GPIO_SCH311X)		+=3D gpio-sch311x.o
+ obj-$(CONFIG_GPIO_SCH)			+=3D gpio-sch.o
+ obj-$(CONFIG_GPIO_SIOX)			+=3D gpio-siox.o
+ obj-$(CONFIG_GPIO_SODAVILLE)		+=3D gpio-sodaville.o
+ obj-$(CONFIG_GPIO_SPEAR_SPICS)		+=3D gpio-spear-spics.o
+ obj-$(CONFIG_GPIO_SPRD)			+=3D gpio-sprd.o
+ obj-$(CONFIG_GPIO_STA2X11)		+=3D gpio-sta2x11.o
+ obj-$(CONFIG_GPIO_STMPE)		+=3D gpio-stmpe.o
+ obj-$(CONFIG_GPIO_STP_XWAY)		+=3D gpio-stp-xway.o
+ obj-$(CONFIG_GPIO_SYSCON)		+=3D gpio-syscon.o
+ obj-$(CONFIG_GPIO_TB10X)		+=3D gpio-tb10x.o
+ obj-$(CONFIG_GPIO_TC3589X)		+=3D gpio-tc3589x.o
+ obj-$(CONFIG_GPIO_TEGRA186)		+=3D gpio-tegra186.o
+ obj-$(CONFIG_GPIO_TEGRA)		+=3D gpio-tegra.o
+ obj-$(CONFIG_GPIO_THUNDERX)		+=3D gpio-thunderx.o
+ obj-$(CONFIG_GPIO_TIMBERDALE)		+=3D gpio-timberdale.o
+ obj-$(CONFIG_GPIO_TPIC2810)		+=3D gpio-tpic2810.o
+ obj-$(CONFIG_GPIO_TPS65086)		+=3D gpio-tps65086.o
+ obj-$(CONFIG_GPIO_TPS65218)		+=3D gpio-tps65218.o
+ obj-$(CONFIG_GPIO_TPS6586X)		+=3D gpio-tps6586x.o
+ obj-$(CONFIG_GPIO_TPS65910)		+=3D gpio-tps65910.o
+ obj-$(CONFIG_GPIO_TPS65912)		+=3D gpio-tps65912.o
+ obj-$(CONFIG_GPIO_TPS68470)		+=3D gpio-tps68470.o
+ obj-$(CONFIG_GPIO_TQMX86)		+=3D gpio-tqmx86.o
+ obj-$(CONFIG_GPIO_TS4800)		+=3D gpio-ts4800.o
+ obj-$(CONFIG_GPIO_TS4900)		+=3D gpio-ts4900.o
+ obj-$(CONFIG_GPIO_TS5500)		+=3D gpio-ts5500.o
+ obj-$(CONFIG_GPIO_TWL4030)		+=3D gpio-twl4030.o
+ obj-$(CONFIG_GPIO_TWL6040)		+=3D gpio-twl6040.o
+ obj-$(CONFIG_GPIO_UCB1400)		+=3D gpio-ucb1400.o
+ obj-$(CONFIG_GPIO_UNIPHIER)		+=3D gpio-uniphier.o
+ obj-$(CONFIG_GPIO_VF610)		+=3D gpio-vf610.o
+ obj-$(CONFIG_GPIO_VIPERBOARD)		+=3D gpio-viperboard.o
+ obj-$(CONFIG_GPIO_VR41XX)		+=3D gpio-vr41xx.o
+ obj-$(CONFIG_GPIO_VX855)		+=3D gpio-vx855.o
+ obj-$(CONFIG_GPIO_WHISKEY_COVE)		+=3D gpio-wcove.o
+ obj-$(CONFIG_GPIO_WINBOND)		+=3D gpio-winbond.o
+ obj-$(CONFIG_GPIO_WM831X)		+=3D gpio-wm831x.o
+ obj-$(CONFIG_GPIO_WM8350)		+=3D gpio-wm8350.o
+ obj-$(CONFIG_GPIO_WM8994)		+=3D gpio-wm8994.o
+ obj-$(CONFIG_GPIO_WS16C48)		+=3D gpio-ws16c48.o
+ obj-$(CONFIG_GPIO_XGENE)		+=3D gpio-xgene.o
+ obj-$(CONFIG_GPIO_XGENE_SB)		+=3D gpio-xgene-sb.o
+ obj-$(CONFIG_GPIO_XILINX)		+=3D gpio-xilinx.o
+ obj-$(CONFIG_GPIO_XLP)			+=3D gpio-xlp.o
+ obj-$(CONFIG_GPIO_XRA1403)		+=3D gpio-xra1403.o
+ obj-$(CONFIG_GPIO_XTENSA)		+=3D gpio-xtensa.o
+ obj-$(CONFIG_GPIO_ZEVIO)		+=3D gpio-zevio.o
+ obj-$(CONFIG_GPIO_ZX)			+=3D gpio-zx.o
+ obj-$(CONFIG_GPIO_ZYNQ)			+=3D gpio-zynq.o

--Sig_/jkUecS8sT4EF7dVutwrIyrx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0VwYcACgkQAVBC80lX
0GzAywf+NoxgvYEfqneZ6H5qA6ce6GqAxOZJtAIeh/esadU3YY0EFFvl2+N8ROMc
sVqxLvOy15qgNY6lz37XluDJw/xq85EH5zL95mkBX0LhIZEqsOcWv3RDGiBPdxQt
GRCEOQRCjY5DxOBFJJgYSJHBxD0eqyMr9iusrf7zYgfYelyubMyu7JfJ/iwD4A3Q
m3kzwe5tWs07zsRUV7EGiCR5TfI1k+nKUDqjMKToTzJ4Wca/S+6/8CEL6pHjFfiB
/KXt70nEgQZvATCtZkr29m0txT2c5UV3/2nWH38FwDTelZUkuM8YCIsuple3lBxd
oSOPWkId9BEajc69Yu+tmQ8Umj4hDQ==
=E933
-----END PGP SIGNATURE-----

--Sig_/jkUecS8sT4EF7dVutwrIyrx--
