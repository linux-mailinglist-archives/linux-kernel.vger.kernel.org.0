Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE9012F28D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 02:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgACBFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 20:05:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgACBFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bQk6UhNptTRNZtOX3CzbH6IJEv5R27ETcPn7R4b6Ns4=; b=OSOd/eOaoXQv
        EmX9jJsIMBWchql+tbGiJWaKWOio/4qqCIWwRWVfKEK/Mx2Mjl5TaiM94HAYTqU7lKNZo0c/a2zv0
        eSDu8Q5jMUtO+vc/wbNpCXztx+0Baalp5y8EbVOvWrFaLQS1Qknd9nsFL81hZHXLvT/oZ4UX1js1R
        96cI0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1inBPK-0003N6-3h; Fri, 03 Jan 2020 01:05:42 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 944EBD057C8; Fri,  3 Jan 2020 01:05:41 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Naveen Manohar <naveen.m@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: Intel: boards: Fix compile-testing RT1011/RT5682" to the asoc tree
In-Reply-To: <20200102135322.1841053-1-arnd@arndb.de>
Message-Id: <applied-20200102135322.1841053-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Date:   Fri,  3 Jan 2020 01:05:41 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: boards: Fix compile-testing RT1011/RT5682

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

From ff3b57417012fcc963ec281f5705bed837e4b1ac Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 2 Jan 2020 14:52:55 +0100
Subject: [PATCH] ASoC: Intel: boards: Fix compile-testing RT1011/RT5682

On non-x86, the new driver results in a build failure:

sound/soc/intel/boards/cml_rt1011_rt5682.c:14:10: fatal error: asm/cpu_device_id.h: No such file or directory

The asm/cpu_device_id.h header is not actually needed here,
so don't include it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200102135322.1841053-1-arnd@arndb.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cml_rt1011_rt5682.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
index a22f97234201..5f1bf6d3800c 100644
--- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
+++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
@@ -11,7 +11,6 @@
 #include <linux/clk.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
-#include <asm/cpu_device_id.h>
 #include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/jack.h>
-- 
2.20.1

