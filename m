Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD08B410E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 21:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390923AbfIPTXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 15:23:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:60613 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387404AbfIPTXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:23:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 12:23:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="270291161"
Received: from jvhicko1-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.104.227])
  by orsmga001.jf.intel.com with ESMTP; 16 Sep 2019 12:23:51 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] soundwire: intel/cadence: simplify PDI handling
Date:   Mon, 16 Sep 2019 14:23:42 -0500
Message-Id: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches were originally submitted as '[RFC PATCH 00/11]
soundwire: intel: simplify DAI/PDI handling'. There were no comments
received.

This series only provides the PDI changes, which makes it simpler to
review. The DAI changes will be provided with the complete series for
ASoC/SOF integration, which is a larger change.

Bard Liao (3):
  soundwire: intel: fix intel_register_dai PDI offsets and numbers
  soundwire: intel: remove playback/capture stream_name
  soundwire: cadence_master: improve PDI allocation

Pierre-Louis Bossart (3):
  soundwire: remove DAI_ID_RANGE definitions
  soundwire: cadence/intel: simplify PDI/port mapping
  soundwire: intel: don't filter out PDI0/1

 drivers/soundwire/cadence_master.c | 158 +++++++----------------------
 drivers/soundwire/cadence_master.h |  34 ++-----
 drivers/soundwire/intel.c          | 155 ++++++----------------------
 include/linux/soundwire/sdw.h      |   3 -
 4 files changed, 73 insertions(+), 277 deletions(-)

-- 
2.20.1

