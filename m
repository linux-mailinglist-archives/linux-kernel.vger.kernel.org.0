Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D2EFAC3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 09:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfKMIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 03:51:15 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:56338 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfKMIvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:51:15 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: lra+25VO4pTiK58An5EnMXM4HMYFjq/Kv3La71l+jNO6qoRoYEBfbpgPbTjYIi4TJdWYcbd0fW
 wVqHr1uelE3zj5T2bCkwkCAiBXn7geXh5W56caI8nc1gvq/8ysv1eN0ladp55yADnycLj4RELs
 ghERICgNRp+huiZv80PMr+KefeNBByE4Q1dCq/4R+kKld6Knmws1t7Gxb7OjQGqLuX07vTefRp
 Ln2rXDO2aBwERBrHYS7qSl39kfRoN14f7wO/LGfJ6R2ohE09+nzfc/Eo99aGa8A9MufQQytJc8
 /Yc=
X-IronPort-AV: E=Sophos;i="5.68,299,1569308400"; 
   d="scan'208";a="54106703"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2019 01:51:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 01:51:14 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 Nov 2019 01:51:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 00/13] add defconfig support for SAM9X60
Date:   Wed, 13 Nov 2019 10:50:56 +0200
Message-ID: <1573635069-30883-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series enables proper support for SAM9X60 in Kconfig and
defconfig.

Thank you,
Claudiu Beznea

Claudiu Beznea (8):
  ARM: at91: Kconfig: add sam9x60 pll config flag
  ARM: at91: Kconfig: add config flag for SAM9X60 SoC
  ARM: at91/defconfig: use savedefconfig
  ARM: at91/defconfig: add config option for SAM9X60 SoC
  ARM: at91/defconfig: enable atmel maxtouch
  ARM: at91/defconfig: enable SAMA5D2's SHDWC
  ARM: at91/defconfig: enable flexcom
  ARM: at91/defconfig: enable XDMAC

Codrin Ciubotariu (3):
  ARM: at91/defconfig: Add I2S Multi-channel driver
  ARM: at91/defconfig: Add driver for Audio PROTO board
  ARM: at91/defconfig: enable CLASSD

Tudor Ambarus (2):
  ARM: at91/defconfig: enable AT91_SAMA5D2_ADC
  ARM: at91/defconfig: enable ATMEL_QUADSPI

 arch/arm/configs/at91_dt_defconfig | 56 ++++++++++++++++++--------------------
 arch/arm/mach-at91/Kconfig         | 13 +++++++++
 2 files changed, 39 insertions(+), 30 deletions(-)

-- 
2.7.4

