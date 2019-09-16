Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E403B435C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 23:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfIPVnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 17:43:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:54985 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbfIPVnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:43:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:43:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198479878"
Received: from dgitin-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.142.45])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2019 14:43:00 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 02/12] ASoC: SOF: support alternate list of machines
Date:   Mon, 16 Sep 2019 16:42:41 -0500
Message-Id: <20190916214251.13130-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
References: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For cases where an interface can be pin-muxed, we need to assess at
probe time which configuration should be used. In cases such as
SoundWire, we need to maintain an alternate list of machines and walk
through them when the primary detection based on ACPI _HID fails.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/sound/sof.h b/include/sound/sof.h
index 4640566b54fe..479101736ee0 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -61,6 +61,9 @@ struct sof_dev_desc {
 	/* list of machines using this configuration */
 	struct snd_soc_acpi_mach *machines;
 
+	/* alternate list of machines using this configuration */
+	struct snd_soc_acpi_mach *alt_machines;
+
 	/* Platform resource indexes in BAR / ACPI resources. */
 	/* Must set to -1 if not used - add new items to end */
 	int resindex_lpe_base;
-- 
2.20.1

