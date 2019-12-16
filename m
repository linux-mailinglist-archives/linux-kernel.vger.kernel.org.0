Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A531205DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 13:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfLPMgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 07:36:51 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:15210 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfLPMgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:36:50 -0500
Received: from localhost.localdomain (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Mon, 16 Dec 2019
 20:37:24 +0800
From:   Qianggui Song <qianggui.song@amlogic.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
CC:     Qianggui Song <qianggui.song@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 0/4] irqchip/meson-gpio: Add support for Meson-A1 SoC
Date:   Mon, 16 Dec 2019 20:36:41 +0800
Message-ID: <20191216123645.10099-1-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.19]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for GPIO interrupt controller of Meson-A1 SoC
which use new register layout, two main things are done in the patchset
1. rework current driver
2. add a1 support

changes since v1 at [0]
 - place initial macro after the definition of param structure
 - make common data as parameter of initial macro
 - add dummy init function for previous chips

[0]https://lore.kernel.org/linux-amlogic/20191206121714.14579-1-qianggui.song@amlogic.com

Qianggui Song (4):
  dt-bindings: interrupt-controller: New binding for Meson-A1 SoCs
  irqchip/meson-gpio: rework meson irqchip driver to support meson-A1
    SoCs
  irqchip/meson-gpio: Add support for meson a1 SoCs
  arm64: dts: meson: a1: add gpio interrupt controller support

 .../amlogic,meson-gpio-intc.txt               |   1 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   9 ++
 drivers/irqchip/irq-meson-gpio.c              | 137 ++++++++++++++----
 3 files changed, 122 insertions(+), 25 deletions(-)

-- 
2.24.0

