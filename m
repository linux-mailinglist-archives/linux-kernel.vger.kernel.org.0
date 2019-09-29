Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75094C1397
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 08:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfI2GYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 02:24:20 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:15311 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfI2GYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 02:24:20 -0400
Received: from droid12-sz.software.amlogic (10.28.8.22) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Sun, 29 Sep 2019
 14:24:19 +0800
From:   Xingyu Chen <xingyu.chen@amlogic.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/3] reset: meson: add Meson-A1 SoC support
Date:   Sun, 29 Sep 2019 14:24:12 +0800
Message-ID: <1569738255-3941-1-git-send-email-xingyu.chen@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.22]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for Meson-A1 SoC Reset Controller. A new struct
meson_reset_param is introduced to describe the register differences between
Meson-A1 and previous SoCs.

Changes since v2 at [1]:
- add comments in header file to indicate holes
- reorder the Signed-off-by and Reviewed-by
- remove Jianxin's Signed-off-by
- add Kevin's Reviewed-by

Changes since v1 at [0]:
- rebase on linux-next
- add Neil's Reviewed-by

[0] https://lore.kernel.org/linux-amlogic/1568808746-1153-1-git-send-email-xingyu.chen@amlogic.com
[1] https://lore.kernel.org/linux-amlogic/1569227661-4261-1-git-send-email-xingyu.chen@amlogic.com

Xingyu Chen (3):
  arm64: dts: meson: add reset controller for Meson-A1 SoC
  dt-bindings: reset: add bindings for the Meson-A1 SoC Reset Controller
  reset: add support for the Meson-A1 SoC Reset Controller

 .../bindings/reset/amlogic,meson-reset.yaml        |  1 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |  6 ++
 drivers/reset/reset-meson.c                        | 35 ++++++++--
 include/dt-bindings/reset/amlogic,meson-a1-reset.h | 74 ++++++++++++++++++++++
 4 files changed, 109 insertions(+), 7 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

-- 
2.7.4

