Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEA3188A57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 17:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgCQQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 12:34:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:47605 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgCQQeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:34:19 -0400
IronPort-SDR: ksGGUzsNNasTPagt1n7OiTsym+pnSWsaGatxogzx+N1Kc/zPumFuRMOiM3XtVCMOmyaa14S3fu
 gyHniXCrm6yQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 09:34:19 -0700
IronPort-SDR: HyT1TPChOrW6vpkgbS82P658Bd6ZHQKWlsawAuD8djEcHF3p9FIyzksel4vFhivDNuCLn+5L28
 v78ICazdzo2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="244533157"
Received: from aavila-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.36.39])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 09:34:16 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 05/17] soundwire: cadence: add clock_stop/restart routines
Date:   Tue, 17 Mar 2020 11:33:17 -0500
Message-Id: <20200317163329.25501-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
References: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

Add support for clock stop and restart, with two configuration
parameters:

1) when entering the ClockStop mode, Slave-initiated wakes can be
prevented.

2) When exiting the ClockStop mode, the caller can request a Bus Reset
(either if all Slaves were configured in ClockStopMode1 or the Master
IP lost context and enumeration is required)

The code handles the case where no Slaves are present by configuring
the IP to treat COMMAND_IGNORED as success.

The exit_reset part can be dealt with in the caller, along with the
required syncArm/syncGo sequence in multi-link mode.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 157 +++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h |   2 +
 2 files changed, 159 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index d7f01d39767b..dc29556eaf94 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -231,6 +231,24 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
 	return -EAGAIN;
 }
 
+static int cdns_set_wait(struct sdw_cdns *cdns, int offset, u32 mask, u32 value)
+{
+	int timeout = 10;
+	u32 reg_read;
+
+	/* Wait for bit to be set */
+	do {
+		reg_read = readl(cdns->registers + offset);
+		if ((reg_read & mask) == value)
+			return 0;
+
+		timeout--;
+		usleep_range(50, 100);
+	} while (timeout != 0);
+
+	return -ETIMEDOUT;
+}
+
 /*
  * all changes to the MCP_CONFIG, MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL
  * need to be confirmed with a write to MCP_CONFIG_UPDATE
@@ -1223,6 +1241,145 @@ bool sdw_cdns_is_clock_stop(struct sdw_cdns *cdns)
 }
 EXPORT_SYMBOL(sdw_cdns_is_clock_stop);
 
+/**
+ * sdw_cdns_clock_stop: Cadence clock stop configuration routine
+ *
+ * @cdns: Cadence instance
+ * @block_wake: prevent wakes if required by the platform
+ */
+int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
+{
+	bool slave_present = false;
+	struct sdw_slave *slave;
+	int ret;
+
+	/* Check suspend status */
+	if (sdw_cdns_is_clock_stop(cdns)) {
+		dev_dbg(cdns->dev, "Clock is already stopped\n");
+		return 0;
+	}
+
+	/*
+	 * For specific platforms, it is required to be able to put
+	 * master into a state in which it ignores wake-up trials
+	 * in clock stop state
+	 */
+	if (block_wake)
+		cdns_updatel(cdns, CDNS_MCP_CONTROL,
+			     CDNS_MCP_CONTROL_BLOCK_WAKEUP,
+			     CDNS_MCP_CONTROL_BLOCK_WAKEUP);
+
+	list_for_each_entry(slave, &cdns->bus.slaves, node) {
+		if (slave->status == SDW_SLAVE_ATTACHED ||
+		    slave->status == SDW_SLAVE_ALERT) {
+			slave_present = true;
+			break;
+		}
+	}
+
+	/*
+	 * This CMD_ACCEPT should be used when there are no devices
+	 * attached on the link when entering clock stop mode. If this is
+	 * not set and there is a broadcast write then the command ignored
+	 * will be treated as a failure
+	 */
+	if (!slave_present)
+		cdns_updatel(cdns, CDNS_MCP_CONTROL,
+			     CDNS_MCP_CONTROL_CMD_ACCEPT,
+			     CDNS_MCP_CONTROL_CMD_ACCEPT);
+	else
+		cdns_updatel(cdns, CDNS_MCP_CONTROL,
+			     CDNS_MCP_CONTROL_CMD_ACCEPT, 0);
+
+	/* commit changes */
+	ret = cdns_config_update(cdns);
+	if (ret < 0) {
+		dev_err(cdns->dev, "%s: config_update failed\n", __func__);
+		return ret;
+	}
+
+	/* Prepare slaves for clock stop */
+	ret = sdw_bus_prep_clk_stop(&cdns->bus);
+	if (ret < 0) {
+		dev_err(cdns->dev, "prepare clock stop failed %d", ret);
+		return ret;
+	}
+
+	/*
+	 * Enter clock stop mode and only report errors if there are
+	 * Slave devices present (ALERT or ATTACHED)
+	 */
+	ret = sdw_bus_clk_stop(&cdns->bus);
+	if (ret < 0 && slave_present && ret != -ENODATA) {
+		dev_err(cdns->dev, "bus clock stop failed %d", ret);
+		return ret;
+	}
+
+	ret = cdns_set_wait(cdns, CDNS_MCP_STAT,
+			    CDNS_MCP_STAT_CLK_STOP,
+			    CDNS_MCP_STAT_CLK_STOP);
+	if (ret < 0)
+		dev_err(cdns->dev, "Clock stop failed %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_cdns_clock_stop);
+
+/**
+ * sdw_cdns_clock_restart: Cadence PM clock restart configuration routine
+ *
+ * @cdns: Cadence instance
+ * @bus_reset: context may be lost while in low power modes and the bus
+ * may require a Severe Reset and re-enumeration after a wake.
+ */
+int sdw_cdns_clock_restart(struct sdw_cdns *cdns, bool bus_reset)
+{
+	int ret;
+
+	ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
+			     CDNS_MCP_CONTROL_CLK_STOP_CLR);
+	if (ret < 0) {
+		dev_err(cdns->dev, "Couldn't exit from clock stop\n");
+		return ret;
+	}
+
+	ret = cdns_set_wait(cdns, CDNS_MCP_STAT, CDNS_MCP_STAT_CLK_STOP, 0);
+	if (ret < 0) {
+		dev_err(cdns->dev, "clock stop exit failed %d\n", ret);
+		return ret;
+	}
+
+	cdns_updatel(cdns, CDNS_MCP_CONTROL,
+		     CDNS_MCP_CONTROL_BLOCK_WAKEUP, 0);
+
+	/*
+	 * clear CMD_ACCEPT so that the command ignored
+	 * will be treated as a failure during a broadcast write
+	 */
+	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT, 0);
+
+	if (!bus_reset) {
+
+		/* enable bus operations with clock and data */
+		cdns_updatel(cdns, CDNS_MCP_CONFIG,
+			     CDNS_MCP_CONFIG_OP,
+			     CDNS_MCP_CONFIG_OP_NORMAL);
+
+		ret = cdns_config_update(cdns);
+		if (ret < 0) {
+			dev_err(cdns->dev, "%s: config_update failed\n", __func__);
+			return ret;
+		}
+
+		ret = sdw_bus_exit_clk_stop(&cdns->bus);
+		if (ret < 0)
+			dev_err(cdns->dev, "bus failed to exit clock stop %d\n", ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_cdns_clock_restart);
+
 /**
  * sdw_cdns_probe() - Cadence probe routine
  * @cdns: Cadence instance
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 691faa386889..e8fa5c7e09f4 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -145,6 +145,8 @@ int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state);
 
 bool sdw_cdns_is_clock_stop(struct sdw_cdns *cdns);
+int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake);
+int sdw_cdns_clock_restart(struct sdw_cdns *cdns, bool bus_reset);
 
 #ifdef CONFIG_DEBUG_FS
 void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
-- 
2.20.1

