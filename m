Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8AEE10FF80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 15:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLCOAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 09:00:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38602 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfLCOAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WklViDGV4ss23T8TYmp/6HDrwSgv4pa+ni2ckZv2ukA=; b=EhF8fwwsQD8e
        +LPePrNs6c1NQEUZHT48PyPOErBMS+qsBoRown40Qej1KcIbGAh5lR2ow4xIJUL9l1BtUsWqk/LcT
        +ND5VRZVD8GoMZ1CCG+znS4Ix9vWzkKH4tn5P7QKMSuMyFXyo4MlSYb/XKphLK7rc+8P87FxdSy48
        jzFVE=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ic8iG-0002bn-6B; Tue, 03 Dec 2019 13:59:36 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 917CBD002FA; Tue,  3 Dec 2019 13:59:35 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alexios.zavras@intel.com, allison@lohutok.net,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        cezary.rojewski@intel.com, gregkh@linuxfoundation.org,
        Hulk Robot <hulkci@huawei.com>,
        liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        tglx@linutronix.de, tiwai@suse.com, yang.jie@linux.intel.com,
        yuehaibing@huawei.com
Subject: Applied "ASoC: Intel: sst: Add missing include <linux/io.h>" to the asoc tree
In-Reply-To: <20191128135853.8360-1-yuehaibing@huawei.com>
Message-Id: <applied-20191128135853.8360-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Date:   Tue,  3 Dec 2019 13:59:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: sst: Add missing include <linux/io.h>

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From d5ee9108adacfbed140e0ac2371941ce7ca1fc54 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 28 Nov 2019 21:58:53 +0800
Subject: [PATCH] ASoC: Intel: sst: Add missing include <linux/io.h>

Fix build error:

sound/soc/intel/atom/sst/sst.c: In function intel_sst_interrupt_mrfld:
sound/soc/intel/atom/sst/sst.c:93:5: error: implicit declaration of function memcpy_fromio;
 did you mean memcpy32_fromio? [-Werror=implicit-function-declaration]
     memcpy_fromio(msg->mailbox_data,
     ^~~~~~~~~~~~~
     memcpy32_fromio

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191128135853.8360-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index fbecbb74350b..68bcec5241f7 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/firmware.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
-- 
2.20.1

