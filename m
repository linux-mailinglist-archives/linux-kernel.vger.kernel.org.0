Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFEC11C292
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 02:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfLLBpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 20:45:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:65192 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfLLBpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:45:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 17:45:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; 
   d="scan'208";a="296446033"
Received: from gjang-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.252.207.37])
  by orsmga001.jf.intel.com with ESMTP; 11 Dec 2019 17:45:11 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v5 00/11] soundwire: update ASoC interfaces
Date:   Wed, 11 Dec 2019 19:44:56 -0600
Message-Id: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need new fields in existing structures to
a) deal with race conditions on codec probe/enumeration
b) allow for multi-step ACPI scan/probe/startup on Intel plaforms
c) deal with MSI issues using a single handler/threads for all audio
interrupts
d) deal with access to registers shared across multiple links on Intel
platforms

These structures for a) will be used by the SOF driver as well as
codec drivers. The b) c) and d) cases are only for the Intel-specific
implementation.

To avoid conflicts between ASoC and Soundwire trees, these 11 patches
are provided out-of-order, before the functionality enabled in these
header files is added in follow-up patch series which can be applied
separately in the ASoC and Soundwire trees. As discussed earlier,
Vinod would need to provide an immutable tag for Mark Brown, and the
integration on the ASoC side of SOF changes and new codecs drivers can
proceed in parallel with SoundWire core changes.

I had multiple offline discussions with Vinod/Mark/Takashi on how to
proceed withe volume of SoundWire changes. Now that v5.5-rc1 is out we
should go ahead with these interface changes.

The next patchset "[PATCH v3 00/15] soundwire: intel: implement new
ASoC interfaces​" can still be reviewed but will not apply as is due to
a one-line conflict. An update will be provided when Vinod applies
this series to avoid noise on mailing lists.

An update for the series "[PATCH v3 00/22] soundwire: code hardening
and suspend-resume support" is ready but will be provided when both
the interfaces changes and the implementation changes are merged.

Comments and feedback welcome
~Pierre

Changes since v4:
One line change to remove EXPORT_SYMBOL(sdw_intel_init)
Fix build issue with randconfig reported by kbuild (missing include of
linux/irqreturn.h)

Changes since v3:
Reordered code and added kernel doc comments
Added prototypes and fields needed to deal with SoundWire interrupts
in a single handler/thread, following what is already done on the DSP
side.
Added mutex to control access to registers shared across links
Added initial definitions for clock stop support on Intel
platforms. Depending on power and latency requirements, different
"quirks" can be supported.

Changes since v2:
Added new field to deal with a race condition leading to a timeout
when the codec goes through a pm_runtime suspend/resume transition
while the Master remains active.
Clarified commit messages with detailed explanations what those race
conditions are and why the changes were introduced.
Reordered fields for Intel routines
Added kernel-doc definitions for structures
Modified the patch subjects to make the mapping between interface definition
and implementation straightforward.

Changes since v1 (no feedback received since October 23)
additional initialization_complete utility to help codec drivers with
their resume operation, waiting for the enumeration to complete is not
always enough.

Changes since v3:
Reordered code and added kernel doc comments
Added prototypes and fields needed to deal with SoundWire interrupts
in a single handler/thread, following what is already done on the DSP
side.
Added mutex to control access to registers shared across links
Added initial definitions for clock stop support on Intel
platforms. Depending on power and latency requirements, different
"quirks" can be supported.

Changes since v2:
Added new field to deal with a race condition leading to a timeout
when the codec goes through a pm_runtime suspend/resume transition
while the Master remains active.
Clarified commit messages with detailed explanations what those race
conditions are and why the changes were introduced.
Reordered fields for Intel routines
Added kernel-doc definitions for structures
Modified the patch subjects to make the mapping between interface definition
and implementation straightforward.

Changes since v1 (no feedback received since October 23)
additional initialization_complete utility to help codec drivers with
their resume operation, waiting for the enumeration to complete is not
always enough.

Bard Liao (2):
  soundwire: intel: update headers for interrupts
  soundwire: intel: add link_list to handle interrupts with a single
    thread

Pierre-Louis Bossart (7):
  soundwire: sdw_slave: add probe_complete structure and new fields
  soundwire: sdw_slave: add enumeration_complete structure
  soundwire: sdw_slave: add initialization_complete definition
  soundwire: sdw_slave: track unattach_request to handle all init
    sequences
  soundwire: intel: update interfaces between ASoC and SoundWire
  soundwire: intel: add mutex for shared SHIM register access
  soundwire: intel: add clock stop quirks

Rander Wang (2):
  soundwire: intel: update stream callbacks for hwparams/free stream
    operations
  soundwire: intel: add prototype for WAKEEN interrupt processing

 drivers/soundwire/intel.c           |  20 ++--
 drivers/soundwire/intel.h           |  13 ++-
 drivers/soundwire/intel_init.c      |  32 ++----
 include/linux/soundwire/sdw.h       |  19 ++++
 include/linux/soundwire/sdw_intel.h | 156 ++++++++++++++++++++++++++--
 5 files changed, 196 insertions(+), 44 deletions(-)

-- 
2.20.1

