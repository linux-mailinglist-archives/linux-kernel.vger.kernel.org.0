Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4898828E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 02:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfHFA4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 20:56:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:35775 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731351AbfHFAzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:55:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 17:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="198153193"
Received: from sahluwal-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.202.215])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2019 17:55:42 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org,
        Slawomir <slawomir.blauciak@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 10/17] soundwire: add new mclk_freq field for properties
Date:   Mon,  5 Aug 2019 19:55:15 -0500
Message-Id: <20190806005522.22642-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help pass platform-specific values, add a new field that can either
be set by the Master driver or read from firmware (BIOS/DT).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 31d1e8acf25b..b6acc436ac80 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -379,6 +379,7 @@ struct sdw_slave_prop {
  * @dynamic_frame: Dynamic frame shape supported
  * @err_threshold: Number of times that software may retry sending a single
  * command
+ * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
  */
 struct sdw_master_prop {
 	u32 revision;
@@ -393,6 +394,7 @@ struct sdw_master_prop {
 	u32 default_col;
 	bool dynamic_frame;
 	u32 err_threshold;
+	u32 mclk_freq;
 };
 
 int sdw_master_read_prop(struct sdw_bus *bus);
-- 
2.20.1

