Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE29DA7A34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 06:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfIDEna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 00:43:30 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6730 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfIDEn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:43:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f40f20000>; Tue, 03 Sep 2019 21:43:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Sep 2019 21:43:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Sep 2019 21:43:27 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:27 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 04:43:27 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f40ec0000>; Tue, 03 Sep 2019 21:43:27 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shardar Shariff Md <smohammed@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH V2 03/12] serial: tegra: flush the RX fifo on frame error
Date:   Wed, 4 Sep 2019 10:12:58 +0530
Message-ID: <1567572187-29820-4-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567572210; bh=g90VEPEHWm8eVVr0LKNmphQAbJn/mFFL2ejhgcIDvy0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=mYCLzTQ8n6xoNkAEj9TvYUcigXWfHtxoJPxIonkOdS3QbESNNcdwQJh96pws03jf3
         nkF2rgw4AoKBlBwEDvqzh35bfD/RvWOVogXjUgVxBDGByAITDPYtwRyj9/ELtC+2xU
         CyfBeCl9B0BLLYJaMs9kJeqiQKEr3IVd7SzGrrPUniRq+H6zvQ+m7iAVjKfWIlvZ82
         EcmuWTY9TpZfBV0jmDH4LEswQSu2MjdMHMAT5WBC3HWqdfpr8mcd2EQrwlm7ul4Qww
         1F4aQFiRKeU/KL7oLX1Tk6iZeoRco7otO1GjR9qnakd88t8GmgZtWbnAIW7r6vHBeK
         l32yqHtkrneNQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shardar Shariff Md <smohammed@nvidia.com>

FIFO reset/flush code implemented now does not follow programming
guidelines. RTS line has to be turned off while flushing FIFOs to
avoid new transfers. Also check LSR bits UART_LSR_TEMT and UART_LSR_DR
to confirm FIFOs are flushed.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 29bf7b7..4cd6d5f 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -266,6 +266,10 @@ static void tegra_uart_wait_sym_time(struct tegra_uart_port *tup,
 static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 {
 	unsigned long fcr = tup->fcr_shadow;
+	unsigned int lsr, tmout = 10000;
+
+	if (tup->rts_active)
+		set_rts(tup, false);
 
 	if (tup->cdata->allow_txfifo_reset_fifo_mode) {
 		fcr |= fcr_bits & (UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
@@ -289,6 +293,16 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 	 * to propagate, otherwise data could be lost.
 	 */
 	tegra_uart_wait_cycle_time(tup, 32);
+
+	do {
+		lsr = tegra_uart_read(tup, UART_LSR);
+		if ((lsr | UART_LSR_TEMT) && !(lsr & UART_LSR_DR))
+			break;
+		udelay(1);
+	} while (--tmout);
+
+	if (tup->rts_active)
+		set_rts(tup, true);
 }
 
 static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
-- 
2.7.4

