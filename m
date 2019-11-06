Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50233F1E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 20:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfKFTWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 14:22:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:50594 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfKFTWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:22:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:22:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="403835062"
Received: from vidhipat-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.33.70])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2019 11:22:27 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 00/19] soundwire: code hardening and suspend-resume support
Date:   Wed,  6 Nov 2019 13:22:04 -0600
Message-Id: <20191106192223.6003-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patchset applies on top of "[PATCH v2 00/14] soundwire: intel:
implement new ASoC interfaces".

It implements a series of improvements for:
a) interrupt handling on Intel platforms in MSI mode
b) race conditions on codec probe and enumeration
c) suspend-resume issues (clock-stop mode not supported for now)
d) underflow handling
e) updates to the stream state machine which did not support valid
ALSA transitions.

These patches were tested extensively on 4 different platforms and are
viewed as required for any sort of SoundWire-based product.

Changes since v1: (no feedback received since October 23)
added support for initialization_complete, integration with Realtek
codecs exposed an additional race condition between the resume
operation and restoration of settings in separate thread triggered by
Slave status change.
No other functional change

Bard Liao (3):
  soundwire: intel/cadence: fix timeouts in MSI mode
  soundwire: stream: only prepare stream when it is configured.
  soundwire: intel: reinitialize IP+DSP in .prepare()

Pierre-Louis Bossart (16):
  soundwire: fix race between driver probe and update_status callback
  soundwire: bus: add PM/no-PM versions of read/write functions
  soundwire: bus: write Slave Device Number without runtime_pm
  soundwire: intel: add helpers for link power down and shim wake
  soundwire: intel: Add basic power management support
  soundwire: intel: add pm_runtime support
  soundwire: intel: reset pm_runtime status during system resume
  soundwire: bus: add helper to reset Slave status to UNATTACHED
  soundwire: intel: call helper to reset Slave states on resume
  soundwire: bus: check first if Slaves become UNATTACHED
  soundwire: add enumeration_complete signaling
  soundwire: bus: add initialization_complete signaling
  soundwire: intel: disable pm_runtime when removing a master
  soundwire: bus: disable pm_runtime in sdw_slave_delete
  soundwire: stream: update state machine and add state checks
  soundwire: stream: do not update parameters during DISABLED-PREPARED
    transition

 Documentation/driver-api/soundwire/stream.rst |  63 +++-
 drivers/soundwire/bus.c                       | 165 +++++++--
 drivers/soundwire/bus.h                       |   3 +
 drivers/soundwire/bus_type.c                  |   5 +
 drivers/soundwire/cadence_master.c            |  17 +-
 drivers/soundwire/cadence_master.h            |   4 +
 drivers/soundwire/intel.c                     | 328 ++++++++++++++++--
 drivers/soundwire/intel.h                     |   2 +
 drivers/soundwire/intel_init.c                |  45 ++-
 drivers/soundwire/slave.c                     |   4 +
 drivers/soundwire/stream.c                    |  64 +++-
 include/linux/soundwire/sdw.h                 |   1 +
 include/linux/soundwire/sdw_intel.h           |   2 +
 13 files changed, 632 insertions(+), 71 deletions(-)

-- 
2.20.1

