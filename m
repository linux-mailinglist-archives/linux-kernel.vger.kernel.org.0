Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26BF480D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 13:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfFQLey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 07:34:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:54390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfFQLev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:34:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 04:34:51 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2019 04:34:49 -0700
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
Subject: [PATCH v2 00/11] Fix driver reload issues
Date:   Mon, 17 Jun 2019 13:36:33 +0200
Message-Id: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series of patches introduces fixes to various issues found while
trying to unload all snd* modules and then loading them again. This
allows for modules to be really _modules_ and be unloaded and loaded on
demand, making it easier to develop and test them without constant
system reboots.

There are some fixes in flow, either we don't initialize things before
cleaning them up, clean up in wrong places or don't clean up at all.
Other patches fix memory management problems, mostly things are not
being freed. And finally there is few miscellaneous patches, please
refer to specific patches to see what they do.

This series was tested on SKL, BXT, GLK & KBL.

Changes from previous patchset:
  * followed suggetion by Pierre in "ALSA: hdac: Fix codec name after
machine driver is unloaded and reloaded"
  * dropped patches which were merged

Amadeusz Sławiński (11):
  ASoC: Intel: Skylake: Initialize lists before access so they are safe
    to use
  ALSA: hdac: Fix codec name after machine driver is unloaded and
    reloaded
  ASoC: compress: Fix memory leak from snd_soc_new_compress
  ASoC: Intel: Skylake: Don't return failure on machine driver reload
  ASoC: Intel: Skylake: Remove static table index when parsing topology
  ASoC: Intel: Skylake: Add function to cleanup debugfs interface
  ASoC: Intel: Skylake: Properly cleanup on component removal
  ASoC: Intel: Skylake: Fix NULL ptr dereference when unloading clk dev
  ASoC: Intel: hdac_hdmi: Set ops to NULL on remove
  ASoC: topology: Consolidate how dtexts and dvalues are freed
  ASoC: topology: Consolidate and fix asoc_tplg_dapm_widget_*_create
    flow

 sound/hda/ext/hdac_ext_bus.c           |   8 +-
 sound/soc/codecs/hdac_hdmi.c           |   6 ++
 sound/soc/intel/skylake/skl-debug.c    |   9 ++
 sound/soc/intel/skylake/skl-pcm.c      |  16 ++--
 sound/soc/intel/skylake/skl-ssp-clk.c  |  16 ++--
 sound/soc/intel/skylake/skl-topology.c |  50 ++++++-----
 sound/soc/intel/skylake/skl-topology.h |   2 +
 sound/soc/intel/skylake/skl.c          |   7 +-
 sound/soc/intel/skylake/skl.h          |   5 ++
 sound/soc/soc-compress.c               |  17 ++--
 sound/soc/soc-topology.c               | 114 ++++++++++++-------------
 11 files changed, 136 insertions(+), 114 deletions(-)

-- 
2.17.1

