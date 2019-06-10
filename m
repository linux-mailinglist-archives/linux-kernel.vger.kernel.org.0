Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB153B71E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403803AbfFJOTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 10:19:40 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:35856 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390789AbfFJOTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:19:40 -0400
X-Greylist: delayed 2771 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jun 2019 10:19:39 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x5ADWkmM029719;
        Mon, 10 Jun 2019 16:32:46 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5E7F361FCC; Mon, 10 Jun 2019 16:32:46 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     olof@lixom.net, gregkh@linuxfoundation.org, arnd@arndb.de,
        robh+dt@kernel.org, mark.rutland@arm.com, avifishman70@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] soc: add NPCM LPC BPC driver support 
Date:   Mon, 10 Jun 2019 16:32:43 +0300
Message-Id: <20190610133245.306812-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds LPC BIOS Post code (BPC) support for the
Nuvoton NPCM Baseboard Management Controller (BMC).

Nuvoton BMC NPCM LPC BIOS Post Code (BPC) monitoring two
configurable I/O addresses written by the host on the
Low Pin Count (LPC) bus, the capture data stored in 128-word FIFO.

NPCM BPC can support capture double words.

The NPCM7xx BPC driver tested on NPCM750 evaluation board.

NPCM BPC driver upstream process start few months ago on misc folder
http://lkml.iu.edu/hypermail/linux/kernel/1904.2/00412.html

The NPCM LPC BPC is similar to Aspeed LPC snoop, last 
kernel 5.0.2 Aspeed LPC snoop driver moved from misc folder to 
soc folder, so it seems NPCM BPC dirver should upstream to soc 
as well.
https://lkml.org/lkml/2019/4/22/377

I have created common lpc-snoop documentation for both 
Nuvoton and Aspeed drivers as Andrew suggested.
Andrew Jeffery: https://patchwork.kernel.org/patch/10506269/ 

I add Andrew and Rob reviewed signature because they already reviewed 
and signed  the lpc-snoop documentation in the misc folder
https://lkml.org/lkml/2019/4/29/998 

Tomer Maimon (2):
  dt-binding: soc: Add common LPC snoop documentation
  soc: nuvoton: add NPCM LPC BPC driver

 .../devicetree/bindings/soc/lpc/lpc-snoop.txt |  27 ++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/nuvoton/Kconfig                   |  16 +
 drivers/soc/nuvoton/Makefile                  |   2 +
 drivers/soc/nuvoton/npcm-lpc-bpc-snoop.c      | 387 ++++++++++++++++++
 6 files changed, 434 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/lpc/lpc-snoop.txt
 create mode 100644 drivers/soc/nuvoton/Kconfig
 create mode 100644 drivers/soc/nuvoton/Makefile
 create mode 100644 drivers/soc/nuvoton/npcm-lpc-bpc-snoop.c

-- 
2.18.0

