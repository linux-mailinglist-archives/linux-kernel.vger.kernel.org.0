Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614BCA9B2A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 09:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfIEHID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 03:08:03 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:16472 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfIEHID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:08:03 -0400
Received: from droid13.amlogic.com (116.236.93.172) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Thu, 5 Sep 2019
 15:08:52 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
Subject: [PATCH v2 0/4] arm64: Add basic support for Amlogic A1 SoC Family
Date:   Thu, 5 Sep 2019 03:07:26 -0400
Message-ID: <1567667251-33466-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [116.236.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A1 is an application processor designed for smart audio and IoT applications,
with Dual core ARM Cortex-A35 CPU. Unlike the previous GXL and G12 series,
there is no Cortex-M3 AO CPU in it.

This serial add basic support for the Amlogic A1 based Amlogic AD401 board:
which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
Timer, UART. It's capable of booting up into the serial console.

The pclk for uart_AO_B need to be fixed once A1 clock driver is merged.
In this version, it rely on bootloader to enable the pclk gate

Changes since v1 [0]:
 - fix coding style
 - collect Reviewed-by

[0] https://lore.kernel.org/linux-amlogic/1567493475-75451-1-git-send-email-jianxin.pan@amlogic.com/

Jianxin Pan (4):
  soc: amlogic: meson-gx-socinfo: Add A1 and A113L IDs
  dt-bindings: arm: amlogic: add A1 bindings
  dt-bindings: arm: amlogic: add Amlogic AD401 bindings
  arm64: dts: add support for A1 based Amlogic AD401

 Documentation/devicetree/bindings/arm/amlogic.yaml |   6 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 arch/arm64/boot/dts/amlogic/meson-a1-ad401.dts     |  31 ++++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          | 122 +++++++++++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c             |   2 +
 5 files changed, 162 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-a1-ad401.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-a1.dtsi

-- 
2.7.4

