Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBAD9EA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfH0OMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 10:12:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:10800 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfH0OMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:12:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 07:12:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="264282374"
Received: from xxx.igk.intel.com ([10.237.93.170])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2019 07:12:48 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 0/6] Small fixes
Date:   Tue, 27 Aug 2019 16:17:06 +0200
Message-Id: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series of small fixes:
* fixes few issues found during checking code with static checkers
* fix few prints
* define function in header, like it should be
* release topology when done with it

Amadeusz Sławiński (6):
  ASoC: Intel: Skylake: Use correct function to access iomem space
  ASoC: Intel: Fix use of potentially uninitialized variable
  ASoC: dapm: Expose snd_soc_dapm_new_control_unlocked properly
  ASoC: Intel: Skylake: Print module type instead of id
  ASoC: Intel: Skylake: Release topology when we are done with it
  ASoC: Intel: NHLT: Fix debug print format

 include/sound/soc-dapm.h               |  3 +++
 sound/soc/intel/common/sst-ipc.c       |  2 ++
 sound/soc/intel/skylake/skl-debug.c    |  2 +-
 sound/soc/intel/skylake/skl-messages.c |  5 +++--
 sound/soc/intel/skylake/skl-nhlt.c     |  2 +-
 sound/soc/intel/skylake/skl-topology.c | 20 ++++++++++----------
 sound/soc/intel/skylake/skl.h          |  1 -
 sound/soc/soc-topology.c               |  6 ------
 8 files changed, 20 insertions(+), 21 deletions(-)

-- 
2.17.1

