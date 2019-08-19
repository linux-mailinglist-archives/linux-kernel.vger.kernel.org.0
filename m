Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484AE91D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 08:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfHSGyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 02:54:31 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:37735 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfHSGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:54:30 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x7J6sIRI002951;
        Mon, 19 Aug 2019 14:54:18 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com, robh+dt@kernel.org,
        stefan@agner.ch, mark.rutland@arm.com
Cc:     lee.jones@linaro.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, paul.burton@mips.com,
        liang.yang@amlogic.com, linux-mtd@lists.infradead.org,
        masonccyang@mxic.com.tw, anders.roxell@linaro.org,
        christophe.kerello@st.com, paul@crapouillou.net,
        devicetree@vger.kernel.org
Subject: [PATCH v7 0/2] Add Macronix raw NAND controller driver
Date:   Mon, 19 Aug 2019 15:19:07 +0800
Message-Id: <1566199149-5669-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com x7J6sIRI002951
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

v7 patch including:
1. compatible rename to "mxic,multi-itfc-v009-nand-controller"
2. using interrupts instead of polling RY/#BS pin
3. removed sdr timing setup in mxic_nfc_hw_init().
4. And other patches based on Boris comments.

v6 patch including:
1. compatible rename to "mxicy,multi-itfc-v009-nand-morph"
2. remove xxx_clk to xxx in DTS and driver.
3. patch mxic_nfc_data_xfer()

v5 patch including:
1. compatible rename to "macronix,nand-controller"
2. handle three clock in one
3. other minor patches

v4 patch back to only raw NAND controller driver instead of MFD,
raw NAND and SPI driver. This is based on MFD maintainer, Lee Jones
comments:
MFD is for registering child devices of chips which offer genuine
cross-subsystem functionality.
It is not designed for mode selecting, or as a place to shove shared code 
just because a better location doesn't appear to exist. 

v3 patch is to rename the title of SPI controller driver.
"Patch Macronix SPI controller driver according to MX25F0A MFD driver"

v2s patches is to support Macronix MX25F0A MFD driver 
for raw nand and spi controller which is separated 
form previous patchset:

https://patchwork.kernel.org/patch/10874679/

thanks for your review.

best regards,
Mason

Mason Yang (2):
  mtd: rawnand: Add Macronix raw NAND controller driver
  dt-bindings: mtd: Document Macronix raw NAND controller bindings

 .../devicetree/bindings/mtd/mxic-nand.txt          |  36 ++
 drivers/mtd/nand/raw/Kconfig                       |   6 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/mxic_nand.c                   | 584 +++++++++++++++++++++
 4 files changed, 627 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt
 create mode 100644 drivers/mtd/nand/raw/mxic_nand.c

-- 
1.9.1

