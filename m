Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DD4A7A45
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 06:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfIDEnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 00:43:50 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6769 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfIDEnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:43:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f41050000>; Tue, 03 Sep 2019 21:43:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Sep 2019 21:43:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Sep 2019 21:43:46 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:46 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 04:43:46 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f40fe0002>; Tue, 03 Sep 2019 21:43:45 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: [PATCH V2 08/12] serial: tegra: add support to use 8 bytes trigger
Date:   Wed, 4 Sep 2019 10:13:03 +0530
Message-ID: <1567572187-29820-9-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567572229; bh=4hgSDwLVb765F0tlze4Az6gfpujrPiGYar4obPhcxic=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=dqYKXhnpIJrpo8rjrKOcf+rZ7D5idIv8w3PD6NgQnUkrmbFxT6Bjlq66yLU7NY5sm
         Or9AcocJb0ksW3ldo8mOEHoxC8PK70poaIqyqSGjsllUKVv3c+c0mr0Ac0iu9DgjFy
         RvsasWQvknBVVnBP00r7jupC49nOvTdZRh6S7B08BQw85skTNQHxT/AuGoOq4uyrZa
         sayAwsztVwvg0on7NF2rgeOowAb1yIU4tOH16EEF0Ccu6MldF8qVhV3iWS7Vh4PeIH
         284irqb+wesVkGi56Kce/RESZpNmYYBV5JgKl47OBsal69DxH8ShCcDeQeBQumP/Ud
         ONuJQCa1QZ4mg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to use 8 bytes trigger for Tegra186 SOC.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 8422516..02f8535 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -88,6 +88,7 @@ struct tegra_uart_chip_data {
 	bool	support_clk_src_div;
 	bool	fifo_mode_enable_status;
 	int	uart_max_port;
+	int	max_dma_burst_bytes;
 };
 
 struct tegra_uart_port {
@@ -931,7 +932,12 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 * programmed in the DMA registers.
 	 */
 	tup->fcr_shadow = UART_FCR_ENABLE_FIFO;
-	tup->fcr_shadow |= UART_FCR_R_TRIG_01;
+
+	if (tup->cdata->max_dma_burst_bytes == 8)
+		tup->fcr_shadow |= UART_FCR_R_TRIG_10;
+	else
+		tup->fcr_shadow |= UART_FCR_R_TRIG_01;
+
 	tup->fcr_shadow |= TEGRA_UART_TX_TRIG_16B;
 	tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
 
@@ -1045,7 +1051,7 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 		}
 		dma_sconfig.src_addr = tup->uport.mapbase;
 		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		dma_sconfig.src_maxburst = 4;
+		dma_sconfig.src_maxburst = tup->cdata->max_dma_burst_bytes;
 		tup->rx_dma_chan = dma_chan;
 		tup->rx_dma_buf_virt = dma_buf;
 		tup->rx_dma_buf_phys = dma_phys;
@@ -1324,6 +1330,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.support_clk_src_div		= false,
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
+	.max_dma_burst_bytes		= 4,
 };
 
 static struct tegra_uart_chip_data tegra30_uart_chip_data = {
@@ -1332,6 +1339,7 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.support_clk_src_div		= true,
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
+	.max_dma_burst_bytes		= 4,
 };
 
 static struct tegra_uart_chip_data tegra186_uart_chip_data = {
@@ -1340,6 +1348,7 @@ static struct tegra_uart_chip_data tegra186_uart_chip_data = {
 	.support_clk_src_div		= true,
 	.fifo_mode_enable_status	= true,
 	.uart_max_port			= 8,
+	.max_dma_burst_bytes		= 8,
 };
 
 static const struct of_device_id tegra_uart_of_match[] = {
-- 
2.7.4

