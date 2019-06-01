Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4973196C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 06:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfFAEEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 00:04:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfFAEEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 00:04:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8CF64136B7EF2269589D;
        Sat,  1 Jun 2019 12:04:03 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 1 Jun 2019 12:03:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Allison Randal" <allison@lohutok.net>
CC:     YueHaibing <yuehaibing@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ALSA: lx6464es - Remove set but not used variables 'orun_mask, urun_mask'
Date:   Sat, 1 Jun 2019 04:12:14 +0000
Message-ID: <20190601041214.99366-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/pci/lx6464es/lx_core.c: In function 'lx_interrupt_handle_async_events':
sound/pci/lx6464es/lx_core.c:990:6: warning:
 variable 'urun_mask' set but not used [-Wunused-but-set-variable]
sound/pci/lx6464es/lx_core.c:989:6: warning:
 variable 'orun_mask' set but not used [-Wunused-but-set-variable]

They are never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/pci/lx6464es/lx_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 9236a1a8c49b..dd3a873777eb 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -986,8 +986,6 @@ static int lx_interrupt_handle_async_events(struct lx6464es *chip, u32 irqsrc,
 	 * Stat[8]	LSB overrun
 	 * */
 
-	u64 orun_mask;
-	u64 urun_mask;
 	int eb_pending_out = (irqsrc & MASK_SYS_STATUS_EOBO) ? 1 : 0;
 	int eb_pending_in  = (irqsrc & MASK_SYS_STATUS_EOBI) ? 1 : 0;
 
@@ -1010,9 +1008,6 @@ static int lx_interrupt_handle_async_events(struct lx6464es *chip, u32 irqsrc,
 			    *r_notified_out_pipe_mask);
 	}
 
-	orun_mask = ((u64)stat[7] << 32) + stat[8];
-	urun_mask = ((u64)stat[5] << 32) + stat[6];
-
 	/* todo: handle xrun notification */
 
 	return err;





