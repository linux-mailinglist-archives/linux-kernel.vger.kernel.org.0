Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA7F398523
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 22:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfHUUFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 16:05:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:53248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfHUUFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:05:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="196069740"
Received: from smasango-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.139.100])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 13:05:29 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 01/11] soundwire: intel: fix intel_register_dai PDI offsets and numbers
Date:   Wed, 21 Aug 2019 15:05:11 -0500
Message-Id: <20190821200521.17283-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
References: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

There are two issues, likely copy/paste:

1. Use cdns->pcm.num_in instead of stream_num_in for consistency with
the rest of the code. This was not detected earlier since platforms did
not have input-only PDIs.

2. use the correct offset for bi-dir PDM, based on IN and OUT
PDIs. Again this was not detected since PDM was not supported earlier.

Reported-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c02b17a92ac2..c95222f18c75 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -980,7 +980,7 @@ static int intel_register_dai(struct sdw_intel *sdw)
 	/* Create PCM DAIs */
 	stream = &cdns->pcm;
 
-	ret = intel_create_dai(cdns, dais, INTEL_PDI_IN, stream->num_in,
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_IN, cdns->pcm.num_in,
 			       off, stream->num_ch_in, true);
 	if (ret)
 		return ret;
@@ -1011,7 +1011,7 @@ static int intel_register_dai(struct sdw_intel *sdw)
 	if (ret)
 		return ret;
 
-	off += cdns->pdm.num_bd;
+	off += cdns->pdm.num_out;
 	ret = intel_create_dai(cdns, dais, INTEL_PDI_BD, cdns->pdm.num_bd,
 			       off, stream->num_ch_bd, false);
 	if (ret)
-- 
2.20.1

