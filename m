Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 210AC10A5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 17:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfEAP6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 11:58:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:12796 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfEAP6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:58:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 08:58:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,418,1549958400"; 
   d="scan'208";a="296115657"
Received: from modiarvi-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.134.211])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2019 08:58:09 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v4 01/22] soundwire: Kconfig: fix help format
Date:   Wed,  1 May 2019 10:57:24 -0500
Message-Id: <20190501155745.21806-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move to the regular help format, --help-- is no longer recommended.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 19c8efb9a5ee..84876a74874f 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig SOUNDWIRE
 	bool "SoundWire support"
-	---help---
+	help
 	  SoundWire is a 2-Pin interface with data and clock line ratified
 	  by the MIPI Alliance. SoundWire is used for transporting data
 	  typically related to audio functions. SoundWire interface is
-- 
2.17.1

