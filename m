Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412E613B665
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 01:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgAOAJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 19:09:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:8608 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbgAOAJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:09:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 16:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="273468554"
Received: from emkilgox-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.0.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2020 16:09:40 -0800
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
Subject: [PATCH 03/10] soundwire: bus: fix race condition with initialization_complete signaling
Date:   Tue, 14 Jan 2020 18:08:37 -0600
Message-Id: <20200115000844.14695-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
References: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiting for the enumeration to be complete may not be enough for a
Slave driver, there is a possible race condition between resume
operations and initializations handled in an interrupt thread, which
can results in settings not being fully restored after system or
pm_runtime resume.

This patch builds on the changes added for enumeration_complete,
init_completion() is called when the Slave device becomes UNATTACHED,
as done with enumeration_complete.

The difference with the enumeration_complete case is that complete()
is signaled after the Slave device is fully initialized after the
.update_status() callback is called.

A Slave device driver can decide to wait on either of the two
complete() cases, depending on its initialization code and
requirements.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c   | 8 ++++++++
 drivers/soundwire/slave.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index a2267c3a1d2d..ea04cf5f5bdc 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -621,6 +621,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 			__func__, slave->dev_num);
 
 		init_completion(&slave->enumeration_complete);
+		init_completion(&slave->initialization_complete);
 
 	} else if ((status == SDW_SLAVE_ATTACHED) &&
 		   (slave->status == SDW_SLAVE_UNATTACHED)) {
@@ -1025,6 +1026,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 {
 	enum sdw_slave_status prev_status;
 	struct sdw_slave *slave;
+	bool attached_initializing;
 	int i, ret = 0;
 
 	/* first check if any Slaves fell off the bus */
@@ -1070,6 +1072,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		if (!slave)
 			continue;
 
+		attached_initializing = false;
+
 		switch (status[i]) {
 		case SDW_SLAVE_UNATTACHED:
 			if (slave->status == SDW_SLAVE_UNATTACHED)
@@ -1096,6 +1100,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			if (prev_status == SDW_SLAVE_ALERT)
 				break;
 
+			attached_initializing = true;
+
 			ret = sdw_initialize_slave(slave);
 			if (ret)
 				dev_err(bus->dev,
@@ -1114,6 +1120,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		if (ret)
 			dev_err(slave->bus->dev,
 				"Update Slave status failed:%d\n", ret);
+		if (attached_initializing)
+			complete(&slave->initialization_complete);
 	}
 
 	return ret;
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index e767a78066ee..aace57fae7f8 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -47,6 +47,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
 	init_completion(&slave->enumeration_complete);
+	init_completion(&slave->initialization_complete);
 	slave->dev_num = 0;
 	init_completion(&slave->probe_complete);
 	slave->probed = false;
-- 
2.20.1

