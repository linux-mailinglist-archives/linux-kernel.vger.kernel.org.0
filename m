Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC1983D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfHUS6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 14:58:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:47792 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfHUS6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:58:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 11:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="262586595"
Received: from dbarua-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.198.189])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2019 11:58:33 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 0/4] soundwire: debugfs support for 5.4
Date:   Wed, 21 Aug 2019 13:58:17 -0500
Message-Id: <20190821185821.12690-1-pierre-louis.bossart@linux.intel.com>
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

Changes since v2:
No code change, just rebase to soundwire/next
Added GKH and Sanyog's tags 
Also added patch4 submitted earlier in another series which depends on
debugfs

Changes since v1 (Feedback from GKH)
Handle debugfs in a more self-contained way (no dentry as return or parameter)
Used CONFIG_DEBUG_FS in structures and code to make it easier to
remove if need be.
No functional change for register dumps.

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

Pierre-Louis Bossart (4):
  soundwire: add debugfs support
  soundwire: cadence_master: add debugfs register dump
  soundwire: intel: add debugfs register dump
  soundwire: intel: handle disabled links

 drivers/soundwire/Makefile         |   4 +
 drivers/soundwire/bus.c            |   6 ++
 drivers/soundwire/bus.h            |  16 +++
 drivers/soundwire/bus_type.c       |   3 +
 drivers/soundwire/cadence_master.c | 107 ++++++++++++++++++++
 drivers/soundwire/cadence_master.h |   4 +
 drivers/soundwire/debugfs.c        | 151 +++++++++++++++++++++++++++++
 drivers/soundwire/intel.c          | 145 ++++++++++++++++++++++++++-
 drivers/soundwire/slave.c          |   1 +
 include/linux/soundwire/sdw.h      |  10 ++
 10 files changed, 444 insertions(+), 3 deletions(-)
 create mode 100644 drivers/soundwire/debugfs.c


base-commit: 183c7687802e4132eb782808a8bf80689a9219c1
-- 
2.20.1

