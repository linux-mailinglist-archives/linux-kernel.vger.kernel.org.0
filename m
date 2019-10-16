Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148EED8CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 11:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbfJPJkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 05:40:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33862 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726689AbfJPJkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:40:36 -0400
X-UUID: 9e313d7b323847c79e32cb187a31c71b-20191016
X-UUID: 9e313d7b323847c79e32cb187a31c71b-20191016
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1927384563; Wed, 16 Oct 2019 17:40:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Oct 2019 17:40:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Oct 2019 17:40:28 +0800
From:   Wen Su <Wen.Su@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <wsd_upstream@mediatek.com>, <wen.su@mediatek.com>
Subject: [PATCH 0/4] Add Support for MediaTek PMIC MT6359 Regulator
Date:   Wed, 16 Oct 2019 17:39:42 +0800
Message-ID: <1571218786-15073-1-git-send-email-Wen.Su@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support to MT6359 PMIC regulator. MT6359 is primary
PMIC for MT6779 platform.


wen.su (4):
  dt-bindings: regulator: Add document for MT6359 regulator
  mfd: Add for PMIC MT6359 registers definition
  regulator: mt6359: Add support for MT6359 regulator
  arm64: dts: mt6359: add PMIC MT6359 related nodes

 .../bindings/regulator/mt6359-regulator.txt        |  59 ++
 arch/arm64/boot/dts/mediatek/mt6359.dtsi           | 312 ++++++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mt6359-regulator.c               | 859 +++++++++++++++++++++
 include/linux/mfd/mt6359/registers.h               | 531 +++++++++++++
 include/linux/regulator/mt6359-regulator.h         |  58 ++
 7 files changed, 1829 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6359-regulator.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6359.dtsi
 create mode 100644 drivers/regulator/mt6359-regulator.c
 create mode 100644 include/linux/mfd/mt6359/registers.h
 create mode 100644 include/linux/regulator/mt6359-regulator.h

-- 
1.9.1

