Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A563BCBAD8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 14:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbfJDMwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 08:52:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387545AbfJDMwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:52:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59CBAB125;
        Fri,  4 Oct 2019 12:52:32 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     wahrenst@gmx.net, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-iproc: fix spurious interrupts on Multiblock reads with bcm2711
Date:   Fri,  4 Oct 2019 14:52:26 +0200
Message-Id: <20191004125226.27037-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Raspberry Pi 4 SDHCI hardware seems to automatically issue CMD12
after multiblock reads even when ACMD12 is disabled. This triggers
spurious interrupts after the data transfer is done with the following
message:

  mmc1: Got data interrupt 0x00000002 even though no data operation was in progress.
  mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
  mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
  mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
  mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000033
  mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000017
  mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
  mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
  mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
  mmc1: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
  mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
  mmc1: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
  mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00080008
  mmc1: sdhci: Resp[0]:   0x00000b00 | Resp[1]:  0x00edc87f
  mmc1: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00400e00
  mmc1: sdhci: Host ctl2: 0x00000001
  mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf3025208
  mmc1: sdhci: ============================================

Enable SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 to enable ACMD12 on multiblock
reads and suppress the spurious interrupts.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/mmc/host/sdhci-iproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 2b9cdcd1dd9d..f4f5f0a70cda 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -262,6 +262,7 @@ static const struct sdhci_iproc_data bcm2835_data = {
 };
 
 static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
+	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
 	.ops = &sdhci_iproc_32only_ops,
 };
 
-- 
2.23.0

