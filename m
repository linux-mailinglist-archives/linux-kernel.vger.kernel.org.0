Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5478214F667
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 05:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgBAEUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 23:20:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:63622 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgBAEUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 23:20:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 20:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,388,1574150400"; 
   d="scan'208";a="218805370"
Received: from ydowling-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.252.199.23])
  by orsmga007.jf.intel.com with ESMTP; 31 Jan 2020 20:20:22 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/2] soundwire: add master_device/driver support
Date:   Fri, 31 Jan 2020 22:20:09 -0600
Message-Id: <20200201042011.5781-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoundWire master representation needs to evolve to take into account:

a) a May 2019 recommendation from Greg KH to remove platform devices

b) the need on Intel platforms to support hardware startup only once
the power rail dependencies are settled. The SoundWire master is not
an independent IP at all.

c) the need to deal with external wakes handled by the PCI subsystem
in specific low-power modes

In case it wasn't clear, the SoundWire subsystem is currently unusable
with v5.5 on devices hitting the shelves very soon (race conditions,
power management, suspend/resume, etc). v5.6 will only provide
interface changes and no functional improvement. We've circled on the
same concepts since September 2019, and I hope this direction is now
aligned with the suggestions from Vinod Koul and that we can target
v5.7 as the 'SoundWire just works(tm)' version.

This series is provided as an RFC since it depends on patches already
for review.

Pierre-Louis Bossart (2):
  soundwire: bus_type: add master_device/driver support
  soundwire: intel: transition to sdw_master_device/driver support

 drivers/soundwire/Makefile         |   2 +-
 drivers/soundwire/bus_type.c       | 141 +++++++++++++-
 drivers/soundwire/intel.c          |  96 ++++++----
 drivers/soundwire/intel.h          |   8 +-
 drivers/soundwire/intel_init.c     | 283 ++++++++++++++++++++++-------
 drivers/soundwire/master.c         | 119 ++++++++++++
 drivers/soundwire/slave.c          |   7 +-
 include/linux/soundwire/sdw.h      |  83 +++++++++
 include/linux/soundwire/sdw_type.h |  36 +++-
 9 files changed, 662 insertions(+), 113 deletions(-)
 create mode 100644 drivers/soundwire/master.c

-- 
2.20.1

