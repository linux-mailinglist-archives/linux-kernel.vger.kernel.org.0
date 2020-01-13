Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB8D139245
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 14:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgAMNhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 08:37:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728346AbgAMNhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:37:19 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D703BC1F72A7DF8864C3;
        Mon, 13 Jan 2020 21:37:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 13 Jan 2020 21:37:08 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH next] ASoC: atmel: fix build error with CONFIG_SND_ATMEL_SOC_DMA=m
Date:   Mon, 13 Jan 2020 21:32:42 +0800
Message-ID: <20200113133242.144550-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_SND_ATMEL_SOC_DMA=m, build error:

sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
(.text+0x7cd): undefined reference to `atmel_pcm_dma_platform_register'

Function atmel_pcm_dma_platform_register is defined under
CONFIG SND_ATMEL_SOC_DMA, so select SND_ATMEL_SOC_DMA in
CONFIG SND_ATMEL_SOC_SSC, same to CONFIG_SND_ATMEL_SOC_PDC.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 sound/soc/atmel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index f118c22..d1dc8e6 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -19,6 +19,8 @@ config SND_ATMEL_SOC_DMA
 
 config SND_ATMEL_SOC_SSC
 	tristate
+	select SND_ATMEL_SOC_DMA
+	select SND_ATMEL_SOC_PDC
 
 config SND_ATMEL_SOC_SSC_PDC
 	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
-- 
2.7.4

