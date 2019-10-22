Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00742E0EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 01:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbfJVXsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 19:48:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:55767 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732393AbfJVXso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:48:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 16:48:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; 
   d="scan'208";a="399211273"
Received: from srajamoh-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.20.203])
  by fmsmga006.fm.intel.com with ESMTP; 22 Oct 2019 16:48:41 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] soundwire: use UniqueID only when relevant
Date:   Tue, 22 Oct 2019 18:48:05 -0500
Message-Id: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware UniqueID, typically enabled with pin-strapping, is
required during enumeration to avoid conflicts between devices of the
same type.

When there are no devices of the same type, using the UniqueID is
overkill and results in a lot of probe errors due to mismatches
between ACPI tables and hardware capabilities. For example it's not
uncommon for BIOS vendors to copy/paste the same settings between
platforms but the hardware pin-strapping is different. This is
perfectly legit and permitted by MIPI specs.

With this patchset, the UniqueID is only used when multiple devices of
the same type are detected. The loop to detect multiple identical
devices is not super efficient but with typically fewer than 4 devices
per link there's no real incentive to be smarter.

This change is only implemented for ACPI platforms, for DeviceTree
there is no change.

Pierre-Louis Bossart (3):
  soundwire: remove bitfield for unique_id, use u8
  soundwire: slave: add helper to extract slave ID
  soundwire: ignore uniqueID when irrelevant

 drivers/soundwire/bus.c       |  7 +--
 drivers/soundwire/slave.c     | 98 +++++++++++++++++++++++++++--------
 include/linux/soundwire/sdw.h |  4 +-
 3 files changed, 84 insertions(+), 25 deletions(-)

-- 
2.20.1

