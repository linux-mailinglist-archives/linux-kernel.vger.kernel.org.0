Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B19BE2AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 09:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437937AbfJXHPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 03:15:30 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:56756 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437908AbfJXHP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:15:28 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x9O7E52u080302;
        Thu, 24 Oct 2019 15:14:05 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        masonccyang@mxic.com.tw
Subject: [PATCH v4 0/2] mtd: rawnand: Add support Macronix NAND randomizer 
Date:   Thu, 24 Oct 2019 15:40:05 +0800
Message-Id: <1571902807-10388-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com x9O7E52u080302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

changelog
v4:
coding patch & add a new DTS for randomizer enabled.

v3:
To enable randomizer by specific DT property in children nodes,
mxic,enable-randomizer-otp;

v2:
To enable randomizer by checking chip options NAND_NO_SUBPAGE_WRITE

v1:
To enable randomizer by sys-fs

thanks for your time & review.
Mason

Mason Yang (2):
  mtd: rawnand: Add support for Macronix NAND randomizer
  dt-bindings: mtd: Document Macronix NAND device bindings

 .../devicetree/bindings/mtd/nand-macronix.txt      | 20 +++++++
 drivers/mtd/nand/raw/nand_macronix.c               | 69 ++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nand-macronix.txt

-- 
1.9.1

