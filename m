Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3745B1349DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 18:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgAHRzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 12:55:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:41182 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgAHRzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:55:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="211617373"
Received: from cozturk-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.17.77])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 09:54:59 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH 2/6] soundwire: stream: update state machine and add state checks
Date:   Wed,  8 Jan 2020 11:54:34 -0600
Message-Id: <20200108175438.13121-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state machine and notes don't accurately explain or allow
transitions from STREAM_DEPREPARED and STREAM_DISABLED.

Add more explanations and allow for more transitions as a result of a
trigger_stop(), trigger_suspend() and prepare(), depending on the
ALSA/ASoC layer behavior defined by the INFO_RESUME and INFO_PAUSE
flags.

Also add basic checks to help debug inconsistent states and illegal
state machine transitions.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 Documentation/driver-api/soundwire/stream.rst | 63 +++++++++++++------
 drivers/soundwire/stream.c                    | 37 +++++++++++
 2 files changed, 82 insertions(+), 18 deletions(-)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
index 5351bd2f34a8..9b7418ff8d59 100644
--- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -156,22 +156,27 @@ Below shows the SoundWire stream states and state transition diagram. ::
 	+-----------+     +------------+     +----------+     +----------+
 	| ALLOCATED +---->| CONFIGURED +---->| PREPARED +---->| ENABLED  |
 	|   STATE   |     |    STATE   |     |  STATE   |     |  STATE   |
-	+-----------+     +------------+     +----------+     +----+-----+
-	                                                           ^
-	                                                           |
-	                                                           |
-	                                                           v
-	         +----------+           +------------+        +----+-----+
+	+-----------+     +------------+     +---+--+---+     +----+-----+
+	                                         ^  ^              ^
+				                 |  |              |
+				               __|  |___________   |
+				              |                 |  |
+	                                      v                 |  v
+	         +----------+           +-----+------+        +-+--+-----+
 	         | RELEASED |<----------+ DEPREPARED |<-------+ DISABLED |
 	         |  STATE   |           |   STATE    |        |  STATE   |
 	         +----------+           +------------+        +----------+
 
-NOTE: State transition between prepare and deprepare is supported in Spec
-but not in the software (subsystem)
+NOTE: State transitions between ``SDW_STREAM_ENABLED`` and
+``SDW_STREAM_DISABLED`` are only relevant when then INFO_PAUSE flag is
+supported at the ALSA/ASoC level. Likewise the transition between
+``SDW_DISABLED_STATE`` and ``SDW_PREPARED_STATE`` depends on the
+INFO_RESUME flag.
 
-NOTE2: Stream state transition checks need to be handled by caller
-framework, for example ALSA/ASoC. No checks for stream transition exist in
-SoundWire subsystem.
+NOTE2: The framework implements basic state transition checks, but
+does not e.g. check if a transition from DISABLED to ENABLED is valid
+on a specific platform. Such tests need to be added at the ALSA/ASoC
+level.
 
 Stream State Operations
 -----------------------
@@ -246,6 +251,9 @@ SDW_STREAM_PREPARED
 
 Prepare state of stream. Operations performed before entering in this state:
 
+  (0) Steps 1 and 2 are omitted in the case of a resume operation,
+      where the bus bandwidth is known.
+
   (1) Bus parameters such as bandwidth, frame shape, clock frequency,
       are computed based on current stream as well as already active
       stream(s) on Bus. Re-computation is required to accommodate current
@@ -270,13 +278,15 @@ Prepare state of stream. Operations performed before entering in this state:
 After all above operations are successful, stream state is set to
 ``SDW_STREAM_PREPARED``.
 
-Bus implements below API for PREPARE state which needs to be called once per
-stream. From ASoC DPCM framework, this stream state is linked to
-.prepare() operation.
+Bus implements below API for PREPARE state which needs to be called
+once per stream. From ASoC DPCM framework, this stream state is linked
+to .prepare() operation. Since the .trigger() operations may not
+follow the .prepare(), a direct transitions from
+``SDW_STREAM_PREPARED`` to ``SDW_STREAM_DEPREPARED`` is allowed.
 
 .. code-block:: c
 
-  int sdw_prepare_stream(struct sdw_stream_runtime * stream);
+  int sdw_prepare_stream(struct sdw_stream_runtime * stream, bool resume);
 
 
 SDW_STREAM_ENABLED
@@ -332,6 +342,14 @@ Bus implements below API for DISABLED state which needs to be called once
 per stream. From ASoC DPCM framework, this stream state is linked to
 .trigger() stop operation.
 
+When the INFO_PAUSE flag is supported, a direct transition to
+``SDW_STREAM_ENABLED`` is allowed.
+
+For resume operations where ASoC will use the .prepare() callback, the
+stream can transition from ``SDW_STREAM_DISABLED`` to
+``SDW_STREAM_PREPARED``, with all required settings restored but
+without updating the bandwidth and bit allocation.
+
 .. code-block:: c
 
   int sdw_disable_stream(struct sdw_stream_runtime * stream);
@@ -353,9 +371,18 @@ state:
 After all above operations are successful, stream state is set to
 ``SDW_STREAM_DEPREPARED``.
 
-Bus implements below API for DEPREPARED state which needs to be called once
-per stream. From ASoC DPCM framework, this stream state is linked to
-.trigger() stop operation.
+Bus implements below API for DEPREPARED state which needs to be called
+once per stream. ALSA/ASoC do not have a concept of 'deprepare', and
+the mapping from this stream state to ALSA/ASoC operation may be
+implementation specific.
+
+When the INFO_PAUSE flag is supported, the stream state is linked to
+the .hw_free() operation - the stream is not deprepared on a
+TRIGGER_STOP.
+
+Other implementations may transition to the ``SDW_STREAM_DEPREPARED``
+state on TRIGGER_STOP, should they require a transition through the
+``SDW_STREAM_PREPARED`` state.
 
 .. code-block:: c
 
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 178ae92b8cc1..6aa0b5d370c0 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1553,8 +1553,18 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state != SDW_STREAM_CONFIGURED &&
+	    stream->state != SDW_STREAM_DEPREPARED &&
+	    stream->state != SDW_STREAM_DISABLED) {
+		pr_err("%s: %s: inconsistent state state %d\n",
+		       __func__, stream->name, stream->state);
+		ret = -EINVAL;
+		goto state_err;
+	}
+
 	ret = _sdw_prepare_stream(stream);
 
+state_err:
 	sdw_release_bus_lock(stream);
 	return ret;
 }
@@ -1619,8 +1629,17 @@ int sdw_enable_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state != SDW_STREAM_PREPARED &&
+	    stream->state != SDW_STREAM_DISABLED) {
+		pr_err("%s: %s: inconsistent state state %d\n",
+		       __func__, stream->name, stream->state);
+		ret = -EINVAL;
+		goto state_err;
+	}
+
 	ret = _sdw_enable_stream(stream);
 
+state_err:
 	sdw_release_bus_lock(stream);
 	return ret;
 }
@@ -1693,8 +1712,16 @@ int sdw_disable_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state != SDW_STREAM_ENABLED) {
+		pr_err("%s: %s: inconsistent state state %d\n",
+		       __func__, stream->name, stream->state);
+		ret = -EINVAL;
+		goto state_err;
+	}
+
 	ret = _sdw_disable_stream(stream);
 
+state_err:
 	sdw_release_bus_lock(stream);
 	return ret;
 }
@@ -1749,8 +1776,18 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 	}
 
 	sdw_acquire_bus_lock(stream);
+
+	if (stream->state != SDW_STREAM_PREPARED &&
+	    stream->state != SDW_STREAM_DISABLED) {
+		pr_err("%s: %s: inconsistent state state %d\n",
+		       __func__, stream->name, stream->state);
+		ret = -EINVAL;
+		goto state_err;
+	}
+
 	ret = _sdw_deprepare_stream(stream);
 
+state_err:
 	sdw_release_bus_lock(stream);
 	return ret;
 }
-- 
2.20.1

