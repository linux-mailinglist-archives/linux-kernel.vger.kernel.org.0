Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB210F8CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 08:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLCHgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 02:36:04 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38837 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfLCHgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:36:04 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xB37ZkLc014023, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xB37ZkLc014023
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Dec 2019 15:35:46 +0800
Received: from james-BS01.localdomain (172.21.190.33) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 3 Dec 2019 15:35:45 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Cheng-Yu Lee <cylee12@realtek.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/6] arm64: Realtek RTD1619 clock and reset controllers
Date:   Tue, 3 Dec 2019 15:35:34 +0800
Message-ID: <20191203073540.9321-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

This series adds clock and reset controllers for the Realtek RTD1619 SoC.

Cc: Andreas Färber <afaerber@suse.de>
Cc: Cheng-Yu Lee <cylee12@realtek.com>
Cc: devicetree@vger.kernel.org

cylee12 (6):
  dt-bindings: clock: add bindings for RTD1619 clocks
  dt-bindings: reset: add bindings for rtd1619 reset controls
  clk: realtek: add common clock support for Realtek SoCs
  clk: realtek: add reset controller support for Realtek SoCs
  clk: realtek: add rtd1619 controllers
  dt-bindings: clk: realtek: add rtd1619 clock controller bindings

 .../bindings/clock/realtek,clocks.txt         |  38 ++
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/realtek/Kconfig                   |  21 +
 drivers/clk/realtek/Makefile                  |  12 +
 drivers/clk/realtek/clk-pll-dif.c             |  81 +++
 drivers/clk/realtek/clk-pll-psaud.c           | 120 ++++
 drivers/clk/realtek/clk-pll.c                 | 400 +++++++++++++
 drivers/clk/realtek/clk-pll.h                 | 151 +++++
 drivers/clk/realtek/clk-regmap-gate.c         |  89 +++
 drivers/clk/realtek/clk-regmap-gate.h         |  26 +
 drivers/clk/realtek/clk-regmap-mux.c          |  63 ++
 drivers/clk/realtek/clk-regmap-mux.h          |  26 +
 drivers/clk/realtek/clk-rtd1619-cc.c          | 553 ++++++++++++++++++
 drivers/clk/realtek/clk-rtd1619-ic.c          | 112 ++++
 drivers/clk/realtek/common.c                  | 320 ++++++++++
 drivers/clk/realtek/common.h                  | 123 ++++
 drivers/clk/realtek/reset.c                   | 107 ++++
 drivers/clk/realtek/reset.h                   |  37 ++
 include/dt-bindings/clock/rtk,clock-rtd1619.h |  88 +++
 include/dt-bindings/reset/rtk,reset-rtd1619.h | 124 ++++
 21 files changed, 2493 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/realtek,clocks.txt
 create mode 100644 drivers/clk/realtek/Kconfig
 create mode 100644 drivers/clk/realtek/Makefile
 create mode 100644 drivers/clk/realtek/clk-pll-dif.c
 create mode 100644 drivers/clk/realtek/clk-pll-psaud.c
 create mode 100644 drivers/clk/realtek/clk-pll.c
 create mode 100644 drivers/clk/realtek/clk-pll.h
 create mode 100644 drivers/clk/realtek/clk-regmap-gate.c
 create mode 100644 drivers/clk/realtek/clk-regmap-gate.h
 create mode 100644 drivers/clk/realtek/clk-regmap-mux.c
 create mode 100644 drivers/clk/realtek/clk-regmap-mux.h
 create mode 100644 drivers/clk/realtek/clk-rtd1619-cc.c
 create mode 100644 drivers/clk/realtek/clk-rtd1619-ic.c
 create mode 100644 drivers/clk/realtek/common.c
 create mode 100644 drivers/clk/realtek/common.h
 create mode 100644 drivers/clk/realtek/reset.c
 create mode 100644 drivers/clk/realtek/reset.h
 create mode 100644 include/dt-bindings/clock/rtk,clock-rtd1619.h
 create mode 100644 include/dt-bindings/reset/rtk,reset-rtd1619.h

-- 
2.24.0

