Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E51117BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 00:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLIXzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 18:55:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:13468 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfLIXzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:55:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 15:55:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; 
   d="scan'208";a="210273606"
Received: from bbower-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.65.172])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2019 15:55:29 -0800
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
Subject: [PATCH v4 02/11] soundwire: sdw_slave: add enumeration_complete structure
Date:   Mon,  9 Dec 2019 17:55:10 -0600
Message-Id: <20191209235520.18727-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191209235520.18727-1-pierre-louis.bossart@linux.intel.com>
References: <20191209235520.18727-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Master starts the bus (be it during the initial boot or
system resume), it usually performs a HardReset to make sure
electrical levels are correct, then enables the control channel.

While the PM framework guarantees that the Slave devices will only
become 'active' once the Master completes the bus initialization,
there is still a risk of a race condition: the Slave enumeration is
handled in a separate interrupt thread triggered by hardware status
changes, so the Slave device may not be ready to accept commands when
the Slave driver tries to access the registers and restore settings in
its resume or pm_runtime_resume callbacks. In those cases, any
read/write commands from/to the Slave device will result in a timeout.

This patch adds an enumeration_complete structure. When the bus is
goes through a HardReset sequence and restarted, the Slave will be
marked as UNATTACHED, which will result in a call to
init_completion().

When the Slave reports its presence during PING frames as a non-zero
Device, the Master hardware will issue an interrupt and the bus driver
will invoke complete(). The order between init_completion()/complete()
is predictable since this is a Master-initiated transition.

The Slave driver may use wait_for_completion() in its resume callback.
When regmap is used, the Slave driver will typically set its regmap in
cache-only mode on suspend, then on resume block on
wait_for_completion(&enumeration_complete) to guarantee it is safe to
start read/write transactions. It may then exit the cache-only mode
and use a regmap_sync to restore settings. All these steps are
optional, their use completely depends on the Slave device
capabilities and how the Slave driver is implemented.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index cb1db4a7475d..3fa8d875b16b 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -551,6 +551,9 @@ struct sdw_slave_ops {
  * @probe_complete: completion utility to control potential races
  * on startup between driver probe/initialization and SoundWire
  * Slave state changes/implementation-defined interrupts
+ * @enumeration_complete: completion utility to control potential races
+ * on startup between device enumeration and read/write access to the
+ * Slave device
  */
 struct sdw_slave {
 	struct sdw_slave_id id;
@@ -567,6 +570,7 @@ struct sdw_slave {
 	u16 dev_num;
 	bool probed;
 	struct completion probe_complete;
+	struct completion enumeration_complete;
 };
 
 #define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
-- 
2.20.1

