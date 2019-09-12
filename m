Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3794B0ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 11:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfILJDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 05:03:21 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:42872 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730083AbfILJDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:03:20 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x8C91p8g011595;
        Thu, 12 Sep 2019 12:01:51 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 774EA628F1; Thu, 12 Sep 2019 12:01:51 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     mpm@selenic.com, herbert@gondor.apana.org.au, arnd@arndb.de,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, sumit.garg@linaro.org,
        jens.wiklander@linaro.org, vkoul@kernel.org, tglx@linutronix.de,
        joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 0/2] hwrng: npcm: add NPCM RNG driver support
Date:   Thu, 12 Sep 2019 12:01:47 +0300
Message-Id: <20190912090149.7521-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds Random Number Generator (RNG) support 
for the Nuvoton NPCM Baseboard Management Controller (BMC).

The RNG driver we use power consumption when the RNG 
is not required.

The NPCM RNG driver tested on NPCM750 evaluation board.

Addressed comments from:.
 - Daniel Thompson: https://lkml.org/lkml/2019/9/10/352
 - Milton Miller II : https://lkml.org/lkml/2019/9/10/847
 - Daniel Thompson: https://lkml.org/lkml/2019/9/10/294

Changes since version 2:
 - Rearrange wait parameter in npcm_rng_read function.
 - Calling pm_runtime_enable function before hwrng_register function 
   called to enable the hwrng before add_early_randomness called.
 - Remove quality dt-binding parameter in the driver and documentation.
 - Disable CONFIG_PM if devm_hwrng_register failed.
 - Remove owner setting in the driver struct.

Changes since version 1:
 - Define timout in real-world units.
 - Using readl_poll_timeout in rng_read function.
 - Honor wait parameter in rng_read function.
 - Using local variable instead of #ifndef.
 - Remove probe print.

Tomer Maimon (2):
  dt-binding: hwrng: add NPCM RNG documentation
  hwrng: npcm: add NPCM RNG driver

 .../bindings/rng/nuvoton,npcm-rng.txt         |  12 ++
 drivers/char/hw_random/Kconfig                |  13 ++
 drivers/char/hw_random/Makefile               |   1 +
 drivers/char/hw_random/npcm-rng.c             | 186 ++++++++++++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
 create mode 100644 drivers/char/hw_random/npcm-rng.c

-- 
2.18.0

