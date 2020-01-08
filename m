Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32E31349D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 18:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgAHRy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 12:54:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:41182 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgAHRy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:54:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="211617351"
Received: from cozturk-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.17.77])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 09:54:55 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] soundwire: stream: fix state machines and transitions
Date:   Wed,  8 Jan 2020 11:54:32 -0600
Message-Id: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing stream support works fine with simple cases, but does not
map well with ALSA transitions for underflows/resume where prepare()
can be called multiple times. Concurrency with multiple devices per
links or multiple streams enabled on the same link also needs to be
fixed.

These patches are the result of hours of validation on the Intel side
and should benefit other implementations since there is nothing
hardware-specific. The Intel-specific changes being reviewed do depend
on those stream changes though to be functional.

Bard Liao (1):
  soundwire: stream: only prepare stream when it is configured.

Pierre-Louis Bossart (3):
  soundwire: stream: remove redundant pr_err traces
  soundwire: stream: update state machine and add state checks
  soundwire: stream: do not update parameters during DISABLED-PREPARED
    transition

Rander Wang (2):
  soundwire: stream: fix support for multiple Slaves on the same link
  soundwire: stream: don't program ports for a stream that has not been
    prepared

 Documentation/driver-api/soundwire/stream.rst | 63 ++++++++----
 drivers/soundwire/stream.c                    | 97 +++++++++++++++----
 2 files changed, 124 insertions(+), 36 deletions(-)


base-commit: 09f6a72d014386939d21899921dd379006471a4b
-- 
2.20.1

