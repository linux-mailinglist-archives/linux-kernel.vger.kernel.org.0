Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB5C1378BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 22:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgAJV5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 16:57:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:3026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgAJV5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:57:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 13:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="218782773"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.183.94])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2020 13:57:36 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] soundwire: cadence: better logs and error handling
Date:   Fri, 10 Jan 2020 15:57:25 -0600
Message-Id: <20200110215731.30747-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a stand-alone set of patches to improve error handling and
provide better information to the platform integrator.

As suggested by Vinod, these patches are shared first - with the risk
that they are separated from the actual steps where they are needed.

For reference, the complete set of 100+ patches required for SoundWire
on Intel platforms is available here:

https://github.com/thesofproject/linux/pull/1692

Pierre-Louis Bossart (4):
  soundwire: cadence_master: filter out bad interrupts
  soundwire: cadence_master: log more useful information during timeouts
  soundwire: cadence_master: handle multiple status reports per Slave
  soundwire: bus: check first if Slaves become UNATTACHED

Rander Wang (2):
  soundwire: cadence_master: clear interrupt status before enabling
    interrupt
  soundwire: cadence_master: remove config update for interrupt setting

 drivers/soundwire/bus.c            | 18 +++++++++
 drivers/soundwire/cadence_master.c | 60 +++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 10 deletions(-)


base-commit: b637124800a157c4df3699d1137d8533394f7678
-- 
2.20.1

