Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97223179FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 07:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgCEGBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 01:01:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38753 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgCEGBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:01:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so2208999pgh.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 22:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+crT0pBWSfuXBvsoxmaazzTBpnM/2/pQconS/hbBjSE=;
        b=CflcryATJ3b/FURJquNJlND9mLY4WDEwsbNpyJgV7+X7a16X7mWxQ8LoU8cDZI9rdr
         GI2Kc/NheE0BNdceo46E5+J4dTEt6FhdPCD/9gO0tfuLykTDFRmArPpN/mbTc0FhWSOR
         K8cqaftg39gR0DiOX9YBEbpGPVpk8mhT1zq28D/aLfmBT+j6NYsIMjZHCujV5WZTajcF
         xNVleNiKbjEqFlFSm8M11pl4tV6EO2KDNJTTL6oSA5iJ35RQj93hWJbcdOgjX6CPN/uo
         LdTzU/2Exnfr3fgbVMm+Ak1/kiP1vPIUvS+8szG7hJ9coag1Ne9P699SykPE4m8ZGmkx
         Q8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+crT0pBWSfuXBvsoxmaazzTBpnM/2/pQconS/hbBjSE=;
        b=Ke0DPeyinhIF536gAx28QrVRtFXRBWFX2DKgba/mMCgLDRH3Wuj6RtrJjIqaQxLv1h
         flL18i5rnzgfIg7+oF3eWOvEc0AP0mHEiCqYeEGupxfl6t/GhdABtLuCnN1f1SksGECj
         F8BFlUEcknV7viziBezgZ6FT96DixUcfxvkAz9fSTRVrPJ7vV4nzKch3S8fV0JAcXanH
         fvs36Lb1fYZWb8iWJgpf6nOvHW4NyukhhTNYJti2S4zJ2F+lte7H1DH2PYU2lOPu87wr
         cI7MbJBokRJAU5xUUe0L7jriYOfX6ibXEcX9EIsjv5e7vN7AeFcePQGSrxVbiPY7vmq4
         0qGg==
X-Gm-Message-State: ANhLgQ0f0KAklCHwF0X/dG/T8SFrIMGPJ9Djey3t8ip42d3pqF4BPRRq
        gBysk8u7vYyswA57gtgb9RJamXnz
X-Google-Smtp-Source: ADFU+vvHjIS0y6Haki+xnAkKnWAaibQMrBK4UejzhrMNkhA0XNRzbYHbqwwN9JidnZp/UGRI/O9pUw==
X-Received: by 2002:a62:1dc6:: with SMTP id d189mr6807646pfd.153.1583388064938;
        Wed, 04 Mar 2020 22:01:04 -0800 (PST)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t19sm29508372pgg.23.2020.03.04.22.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Mar 2020 22:01:04 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: sprd: Allow the MCDT driver to build into modules
Date:   Thu,  5 Mar 2020 14:00:53 +0800
Message-Id: <9306f2b99641136653ae4fe6cf9e859b7f698f77.1583387748.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the config to 'tristate' for MCDT driver to allow it to build into
modules, as well as changing to use IS_ENABLED() to validate if need supply
dummy functions when building the MCDT driver as a module.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 sound/soc/sprd/Kconfig     | 2 +-
 sound/soc/sprd/sprd-mcdt.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sprd/Kconfig b/sound/soc/sprd/Kconfig
index 5474fd3..5e0ac82 100644
--- a/sound/soc/sprd/Kconfig
+++ b/sound/soc/sprd/Kconfig
@@ -8,7 +8,7 @@ config SND_SOC_SPRD
 	  the Spreadtrum SoCs' Audio interfaces.
 
 config SND_SOC_SPRD_MCDT
-	bool "Spreadtrum multi-channel data transfer support"
+	tristate "Spreadtrum multi-channel data transfer support"
 	depends on SND_SOC_SPRD
 	help
 	  Say y here to enable multi-channel data transfer support. It
diff --git a/sound/soc/sprd/sprd-mcdt.h b/sound/soc/sprd/sprd-mcdt.h
index 9cc7e207..679e3af 100644
--- a/sound/soc/sprd/sprd-mcdt.h
+++ b/sound/soc/sprd/sprd-mcdt.h
@@ -48,7 +48,7 @@ struct sprd_mcdt_chan {
 	struct list_head list;
 };
 
-#ifdef CONFIG_SND_SOC_SPRD_MCDT
+#if IS_ENABLED(CONFIG_SND_SOC_SPRD_MCDT)
 struct sprd_mcdt_chan *sprd_mcdt_request_chan(u8 channel,
 					      enum sprd_mcdt_channel_type type);
 void sprd_mcdt_free_chan(struct sprd_mcdt_chan *chan);
-- 
1.9.1

