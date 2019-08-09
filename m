Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4B18862B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 00:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfHIWnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 18:43:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:9706 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfHIWnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:43:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:43:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="175279558"
Received: from rmmeyer-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.138.140])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2019 15:43:44 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] soundwire: debugfs support for 5.4
Date:   Fri,  9 Aug 2019 17:43:38 -0500
Message-Id: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables debugfs support and corrects all the feedback
provided on an earlier RFC ('soundwire: updates for 5.4')

There is one remaining hard-coded value in intel.c that will need to
be fixed in a follow-up patchset not specific to debugfs: we need to
remove hard-coded Intel-specific configurations from cadence_master.c
(PDI offsets, etc).

Changes since RFC (Feedback from GKH, Vinod, Guennadi, Cezary, Sanyog):
removed error checks
used DEFINE_SHOW_ATTRIBUTE and seq_file
fixed copyright dates
fixed SPDX license info to use GPL2.0 only
fixed Makefile to include debugfs only if CONFIG_DEBUG_FS is selected
used static inlines for fallback compilation
removed intermediate variables
removed hard-coded constants in loops (used registers offsets and
hardware capabilities)
squashed patch 3

Pierre-Louis Bossart (3):
  soundwire: add debugfs support
  soundwire: cadence_master: add debugfs register dump
  soundwire: intel: add debugfs register dump

 drivers/soundwire/Makefile         |   5 +
 drivers/soundwire/bus.c            |   6 ++
 drivers/soundwire/bus.h            |  24 +++++
 drivers/soundwire/bus_type.c       |   3 +
 drivers/soundwire/cadence_master.c | 104 ++++++++++++++++++++
 drivers/soundwire/cadence_master.h |   2 +
 drivers/soundwire/debugfs.c        | 151 +++++++++++++++++++++++++++++
 drivers/soundwire/intel.c          | 114 ++++++++++++++++++++++
 drivers/soundwire/slave.c          |   1 +
 include/linux/soundwire/sdw.h      |   4 +
 10 files changed, 414 insertions(+)
 create mode 100644 drivers/soundwire/debugfs.c

-- 
2.20.1

