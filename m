Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4349FB40AD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 20:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732370AbfIPS54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 14:57:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:50422 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbfIPS5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:57:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 11:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="216307621"
Received: from jvhicko1-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.104.227])
  by fmsmga002.fm.intel.com with ESMTP; 16 Sep 2019 11:57:52 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] soundwire: Kconfig/build improvements
Date:   Mon, 16 Sep 2019 13:57:37 -0500
Message-Id: <20190916185739.32184-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel kbuild test reported issues with COMPILE_TEST or
cross-compilation when SOF is enabled, fix. This has no functional
impact.

Pierre-Louis Bossart (2):
  soundwire: intel: add missing headers for cross-compilation
  soundwire: intel: remove X86 dependency

 drivers/soundwire/Kconfig      | 2 +-
 drivers/soundwire/intel.c      | 1 +
 drivers/soundwire/intel_init.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.20.1

