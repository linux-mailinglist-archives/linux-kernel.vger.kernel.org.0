Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736DD113CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 09:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfLEI0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 03:26:25 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:56098 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLEI0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:26:24 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xB58Q1t2024515, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xB58Q1t2024515
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 5 Dec 2019 16:26:01 +0800
Received: from james-BS01.localdomain (172.21.190.33) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 5 Dec 2019 16:26:00 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-realtek-soc@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] Initial RTD1319 SoC and Realtek PymParticle EVB support
Date:   Thu, 5 Dec 2019 16:25:53 +0800
Message-ID: <20191205082555.22633-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

This series adds Device Trees for the Realtek RTD1319 SoC and Realtek's
PymParticle EVB.

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andreas Färber <afaerber@suse.de>

James Tai (2):
  dt-bindings: arm: realtek: Document RTD1319 and Realtek PymParticle
    EVB
  arm64: dts: realtek: Add RTD1319 SoC and Realtek PymParticle EVB

 .../devicetree/bindings/arm/realtek.yaml      |   6 +
 arch/arm64/boot/dts/realtek/Makefile          |   2 +
 .../boot/dts/realtek/rtd1319-pymparticle.dts  |  43 ++++++
 arch/arm64/boot/dts/realtek/rtd1319.dtsi      |  12 ++
 arch/arm64/boot/dts/realtek/rtd13xx.dtsi      | 137 ++++++++++++++++++
 5 files changed, 200 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd13xx.dtsi

-- 
2.24.0

