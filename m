Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14273F1E5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 20:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfKFTOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 14:14:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:4046 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfKFTOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:14:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:14:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="402465639"
Received: from vidhipat-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.33.70])
  by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2019 11:14:02 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 00/14] soundwire: intel: implement new ASoC interfaces
Date:   Wed,  6 Nov 2019 13:13:44 -0600
Message-Id: <20191106191358.5712-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset applies on top of the series "[PATCH v2 0/5] soundwire:
update ASoC interfaces"

The changes are essentially a removal of the platform devices and the
implementation of the new interfaces required to scan the ACPI tables,
probe the links and start them.

The missing prepare, trigger and setup ASoC callbacks are also
implemented. The hw_params and free callbacks use the new interfaces
as well.

While there are quite a few lines of code changed, this is mostly
about interface changes. The next series will contain more functional
changes and deal with race conditions on probe, enumeration and
suspend/resume issues.

Changes since v1:
fix typo (Vinod)
removed uevent open for Master (Vinod)
clarified commit messages (Cezary)
no functionality change

Bard Liao (1):
  soundwire: add device driver to sdw_md_driver

Pierre-Louis Bossart (10):
  soundwire: renames to prepare support for master drivers/devices
  soundwire: rename dev_to_sdw_dev macro
  soundwire: rename drv_to_sdw_slave_driver macro
  soundwire: bus_type: rename sdw_drv_ to sdw_slave_drv
  soundwire: intel: rename res field as link_res
  soundwire: add support for sdw_slave_type
  soundwire: add initial definitions for sdw_master_device
  soundwire: intel: remove platform devices and provide new interface
  soundwire: intel: free all resources on hw_free()
  soundwire: intel_init: add implementation of sdw_intel_enable_irq()

Rander Wang (3):
  soundwire: intel: add prepare support in sdw dai driver
  soundwire: intel: add trigger support in sdw dai driver
  soundwire: intel: add sdw_stream_setup helper for .startup callback

 drivers/base/regmap/regmap-sdw.c   |   4 +-
 drivers/soundwire/Makefile         |   2 +-
 drivers/soundwire/bus.c            |   2 +-
 drivers/soundwire/bus_type.c       |  57 +++---
 drivers/soundwire/intel.c          | 280 ++++++++++++++++++++++-----
 drivers/soundwire/intel.h          |   8 +-
 drivers/soundwire/intel_init.c     | 300 ++++++++++++++++++++++-------
 drivers/soundwire/master.c         |  64 ++++++
 drivers/soundwire/slave.c          |   9 +-
 include/linux/soundwire/sdw.h      |  39 +++-
 include/linux/soundwire/sdw_type.h |  34 +++-
 11 files changed, 639 insertions(+), 160 deletions(-)
 create mode 100644 drivers/soundwire/master.c

-- 
2.20.1

