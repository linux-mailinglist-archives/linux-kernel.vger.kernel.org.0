Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2BFCC31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 18:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKNRyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 12:54:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:8277 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfKNRyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:54:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 09:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="203133014"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
  by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2019 09:54:00 -0800
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
Subject: [PATCH v3 4/6] soundwire: sdw_slave: track unattach_request to handle all init sequences
Date:   Thu, 14 Nov 2019 11:53:43 -0600
Message-Id: <20191114175345.21836-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114175345.21836-1-pierre-louis.bossart@linux.intel.com>
References: <20191114175345.21836-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Slave device initialization can be split in 4 different cases:

1. Master-initiated hardware reset, system suspend-resume and
pm_runtime based on clock-stop mode1. To avoid timeouts and a bad
audio experience, the Slave device resume operations need to wait for
the Slave device to be re-enumerated and its settings restored.

2. Exit from clock-stop mode0. In this case, the Slave device is
required to remain enumerated and its context preserved while the
clock is stopped, so no re-initialization or wait_for_completion() is
necessary.

3. Slave-initiated pm_runtime D3 transition. With the parent child
relationship, it is possible that a Slave device becomes 'suspended'
while its parent is still 'active' with the bus clock still
toggling. In this case, during the pm_runtime resume operation, there
is no need to wait for any settings to be restored.

4. Slave reset (sync loss or implementation-defined). In that case the
bus remains operational and the Slave device will be re-initialized
when it becomes ATTACHED again.

In previous patches, we suggested the use of wait_for_completion() to
deal with the case #1, but case #2 and #3 do not need any wait.

To account for those differences, this patch adds an unattach_request
field. The field is explicitly set by the Master for the case #1, and
if non-zero the Slave device shall wait on resume. In all other cases,
the Slave resume operations can proceed without wait.

The only request tracked so far is Master HardReset, but the request
is declared as a bit mask for future extensions (if needed). The
definition for this value is added in bus.h and does not need to be
exposed in sdw.h

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ed42cd79eab7..b7c9eca4332a 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -556,6 +556,11 @@ struct sdw_slave_ops {
  * Slave device
  * @initialization_complete: completion utility to control potential races
  * on startup between device enumeration and settings being restored
+ * @unattach_request: mask field to keep track why the Slave re-attached and
+ * was re-initialized. This is useful to deal with potential race conditions
+ * between the Master suspending and the codec resuming, and make sure that
+ * when the Master triggered a reset the Slave is properly enumerated and
+ * initialized
  */
 struct sdw_slave {
 	struct sdw_slave_id id;
@@ -574,6 +579,7 @@ struct sdw_slave {
 	struct completion probe_complete;
 	struct completion enumeration_complete;
 	struct completion initialization_complete;
+	u32 unattach_request;
 };
 
 #define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
-- 
2.20.1

