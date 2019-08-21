Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239F49856A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfHUUR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 16:17:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:3444 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbfHUUR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:17:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:17:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="186344083"
Received: from smasango-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.139.100])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Aug 2019 13:17:26 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/5] ASoC: SOF: Intel: SoundWire initial integration
Date:   Wed, 21 Aug 2019 15:17:15 -0500
Message-Id: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC is the companion of the other RFC 'soundwire: intel: simplify
DAI/PDI handling​'. Our purpose at this point is to gather feedback on
the interfaces between the Intel SOF parts and the SoundWire code.

The suggested solution is a simple init/release inserted at
probe/remove and resume/suspend, as well as two callbacks for the SOF
driver to generate IPC configurations with the firmware. That level of
separation completely hides the details of the SoundWire DAIs and will
allow for 'transparent' multi-cpu DAI support, which will be handled
in the machine driver and the soundwire DAIs.

This solution was tested on IceLake and CometLake, and captures the
feedback from SOF contributors on an initial integration that was
deemed too complicated (and rightly so).

Pierre-Louis Bossart (5):
  ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
  ASoC: SOF: Intel: hda: add helper to initialize SoundWire IP
  ASoC: SOF: Intel: hda: add SoundWire IP support
  ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
  ASoC: SOF: Intel: add support for SoundWire suspend/resume

 include/sound/sof/dai-intel.h |  18 ++--
 sound/soc/sof/intel/hda-dsp.c |  11 +++
 sound/soc/sof/intel/hda.c     | 157 ++++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h     |  11 +++
 4 files changed, 188 insertions(+), 9 deletions(-)


base-commit: 3b3aaa017e8072b1bfddda92be296b3463d870be
-- 
2.20.1

