Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4FF151C99
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 15:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgBDOwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 09:52:34 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39790 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgBDOwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:52:34 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 014EqC8b008030, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 014EqC8b008030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Feb 2020 22:52:13 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Feb 2020 22:52:12 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Feb 2020 22:52:12 +0800
Received: from james-BS01.localdomain (172.21.190.33) by
 RTEXMB01.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server id
 15.1.1779.2 via Frontend Transport; Tue, 4 Feb 2020 22:52:12 +0800
From:   James Tai <james.tai@realtek.com>
To:     <linux-realtek-soc@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] Initial RTD1319 SoC and Realtek PymParticle EVB support
Date:   Tue, 4 Feb 2020 22:52:05 +0800
Message-ID: <20200204145207.28622-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.25.0
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

The v3 correct the GIC redistributor address range and adding the virtual
maintenance interrupt for architecture timer.

v2 -> v3:
* Add virtual maintenance interrupt for architecture timer
* Correct the GIC redistributor address range

v1 -> v2:
* Reserve the boot ROM address
* Reserve boot loader address
* Reserve audio/video FW address
* Reserve RPC and ring buffer address
* Reserve TEE address
* Support 1 GiB RAM by default
* Reduce rbus range to 2 MiB
* Apply the syscon for ISO,MISC,CRT,SB2,SCPU_WRAPPER
* Adjust compatible strings order in document

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andreas Färber <afaerber@suse.de>

James Tai (2):
  dt-bindings: arm: realtek: Document RTD1319 and Realtek PymParticle
    EVB
  arm64: dts: realtek: Add RTD1319 SoC and Realtek PymParticle EVB

 .../devicetree/bindings/arm/realtek.yaml      |   6 +
 arch/arm64/boot/dts/realtek/Makefile          |   2 +
 .../boot/dts/realtek/rtd1319-pymparticle.dts  |  43 ++++
 arch/arm64/boot/dts/realtek/rtd1319.dtsi      |  12 +
 arch/arm64/boot/dts/realtek/rtd13xx.dtsi      | 213 ++++++++++++++++++
 5 files changed, 276 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd13xx.dtsi

-- 
2.25.0

