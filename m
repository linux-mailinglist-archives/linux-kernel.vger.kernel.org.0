Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5E199284
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgCaJmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 05:42:08 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34136 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbgCaJmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:42:07 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f4Rc024512;
        Tue, 31 Mar 2020 11:41:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 05/23] floppy: use symbolic register names in the powerpc port
Date:   Tue, 31 Mar 2020 11:40:36 +0200
Message-Id: <20200331094054.24441-6-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we can use FD_STATUS and FD_DATA instead of 4 or 5, let's do
this, and also use STATUS_DMA and STATUS_READY for the status bits.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/powerpc/include/asm/floppy.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/floppy.h b/arch/powerpc/include/asm/floppy.h
index ed467eb0c4c8..7af9a68fd949 100644
--- a/arch/powerpc/include/asm/floppy.h
+++ b/arch/powerpc/include/asm/floppy.h
@@ -61,21 +61,22 @@ static irqreturn_t floppy_hardint(int irq, void *dev_id)
 	st = 1;
 	for (lcount=virtual_dma_count, lptr=virtual_dma_addr;
 	     lcount; lcount--, lptr++) {
-		st=inb(virtual_dma_port+4) & 0xa0 ;
-		if (st != 0xa0)
+		st = inb(virtual_dma_port + FD_STATUS);
+		st &= STATUS_DMA | STATUS_READY;
+		if (st != (STATUS_DMA | STATUS_READY))
 			break;
 		if (virtual_dma_mode)
-			outb_p(*lptr, virtual_dma_port+5);
+			outb_p(*lptr, virtual_dma_port + FD_DATA);
 		else
-			*lptr = inb_p(virtual_dma_port+5);
+			*lptr = inb_p(virtual_dma_port + FD_DATA);
 	}
 	virtual_dma_count = lcount;
 	virtual_dma_addr = lptr;
-	st = inb(virtual_dma_port+4);
+	st = inb(virtual_dma_port + FD_STATUS);
 
-	if (st == 0x20)
+	if (st == STATUS_DMA)
 		return IRQ_HANDLED;
-	if (!(st & 0x20)) {
+	if (!(st & STATUS_DMA)) {
 		virtual_dma_residue += virtual_dma_count;
 		virtual_dma_count=0;
 		doing_vdma = 0;
-- 
2.20.1

