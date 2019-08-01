Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C95217D3AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 05:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfHADbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 23:31:02 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:29249 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbfHADbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:31:01 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x713UuOU087114;
        Thu, 1 Aug 2019 11:30:56 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, marek.vasut@gmail.com,
        bbrezillon@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, vigneshr@ti.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        juliensu@mxic.com.tw, paul.burton@mips.com, liang.yang@amlogic.com,
        lee.jones@linaro.org, masonccyang@mxic.com.tw,
        anders.roxell@linaro.org, christophe.kerello@st.com,
        paul@crapouillou.net, devicetree@vger.kernel.org
Subject: [PATCH v6 0/2] Add Macronix raw NAND controller driver
Date:   Thu,  1 Aug 2019 11:55:08 +0800
Message-Id: <1564631710-30276-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com x713UuOU087114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

 .../devicetree/bindings/mtd/mxic-nand.txt          |  19 +
 drivers/mtd/nand/raw/Kconfig                       |   6 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/mxic_nand.c                   | 554 +++++++++++++++++++++
 4 files changed, 580 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt
 create mode 100644 drivers/mtd/nand/raw/mxic_nand.c

-- 
1.9.1

