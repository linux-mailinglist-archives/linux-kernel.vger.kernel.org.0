Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE20C3213
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 13:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfJALMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 07:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfJALMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:12:46 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C0C21A4A;
        Tue,  1 Oct 2019 11:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928365;
        bh=JfAVjjgUEXOR8W5/QmvNUNfsGdq2sh1oxI5Wsz310UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgd8aIc3GdgmaCWsdPCj7e1lUEjk4RCnETGYNxLVatfdVqbXWhmRnA7fBEAlUJE4b
         YPCDQk3xg0qPpTetpyyAQEXcE/ktZjED/N2SFbg+ZFSC5YC3yXwfajCDig47EpAsth
         nc3+QZulm6Gmjvfw2Y+vAVan7Qalg6Ls9z78edF0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 04/24] tools headers uapi: Sync drm/i915_drm.h with the kernel sources
Date:   Tue,  1 Oct 2019 08:11:56 -0300
Message-Id: <20191001111216.7208-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the change in:

  bf73fc0fa9cf ("drm/i915: Show support for accurate sw PMU busyness tracking")

That don't result in any changes in tooling, just silences this perf
build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-o651nt7vpz93tu3nmx4f3xql@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 328d05e77d9f..469dc512cca3 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -521,6 +521,7 @@ typedef struct drm_i915_irq_wait {
 #define   I915_SCHEDULER_CAP_PRIORITY	(1ul << 1)
 #define   I915_SCHEDULER_CAP_PREEMPTION	(1ul << 2)
 #define   I915_SCHEDULER_CAP_SEMAPHORES	(1ul << 3)
+#define   I915_SCHEDULER_CAP_ENGINE_BUSY_STATS	(1ul << 4)
 
 #define I915_PARAM_HUC_STATUS		 42
 
-- 
2.21.0

