Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F31EE6A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 02:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfJ1Bpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 21:45:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47968 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728141AbfJ1Bpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 21:45:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A6D1890E3AA43C01C4FF;
        Mon, 28 Oct 2019 09:45:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 28 Oct 2019 09:45:31 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.de>, <pierre-louis.bossart@linux.intel.com>,
        <daniel.baluta@nxp.com>, <rdunlap@infradead.org>,
        <ranjani.sridharan@linux.intel.com>, <arnd@arndb.de>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next] ASoC: SOF: select SND_INTEL_DSP_CONFIG in SND_SOC_SOF_PCI
Date:   Mon, 28 Oct 2019 09:45:11 +0800
Message-ID: <20191028014511.73472-1-maowenan@huawei.com>
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

When SND_SOC_SOF_PCI=y, and SND_INTEL_DSP_CONFIG=m, below
errors can be seen:
sound/soc/sof/sof-pci-dev.o: In function `sof_pci_probe':
sof-pci-dev.c:(.text+0xb9): undefined reference to
`snd_intel_dsp_driver_probe'

After commit 82d9d54a6c0e ("ALSA: hda: add Intel DSP
configuration / probe code"), sof_pci_probe() will call
snd_intel_dsp_driver_probe(), so it should select
SND_INTEL_DSP_CONFIG in Kconfig SND_SOC_SOF_PCI.

Fixes: 82d9d54a6c0e ("ALSA: hda: add Intel DSP configuration / probe code")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 sound/soc/sof/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index 56a3ab6..a9b2be2 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -16,6 +16,7 @@ config SND_SOC_SOF_PCI
 	select SND_SOC_ACPI if ACPI
 	select SND_SOC_SOF_OPTIONS
 	select SND_SOC_SOF_INTEL_PCI if SND_SOC_SOF_INTEL_TOPLEVEL
+	select SND_INTEL_DSP_CONFIG
 	help
 	  This adds support for PCI enumeration. This option is
 	  required to enable Intel Skylake+ devices
-- 
2.7.4

