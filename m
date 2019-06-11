Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB203D60A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407154AbfFKTAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 15:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404869AbfFKTAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E9B217D6;
        Tue, 11 Jun 2019 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279607;
        bh=fKKPp6CykN9eMyZT0InrAxCRz0WxvpfQlmOY3Qh0eIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyJR/3cZ9MRaggfKHLux1KZUSzzgP5EUdzq/0nJ4fiAusQSQ/ATv1/RTV0zPz2fng
         MzG3tzKITh2O8HyjVzzmgOGB4LuWFyjB905quGviJjI6bGjdybzI/AAr7LgYP6HOfO
         FlzS740aVCO9GdnWWzhI+Tb1rVDx73IerbyrAM+c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/85] perf intel-pt: Re-factor TIP cases in intel_pt_walk_to_ip
Date:   Tue, 11 Jun 2019 15:57:59 -0300
Message-Id: <20190611185911.11645-14-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

To make it easier to add new code for different TIP cases, separate each
case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index a2384a314990..99773445872d 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2128,18 +2128,29 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
 		switch (decoder->packet.type) {
 		case INTEL_PT_TIP_PGD:
 			decoder->continuous_period = false;
-			__fallthrough;
+			decoder->pge = false;
+			if (intel_pt_have_ip(decoder))
+				intel_pt_set_ip(decoder);
+			if (!decoder->ip)
+				break;
+			decoder->state.type |= INTEL_PT_TRACE_END;
+			return 0;
+
 		case INTEL_PT_TIP_PGE:
+			decoder->pge = true;
+			if (intel_pt_have_ip(decoder))
+				intel_pt_set_ip(decoder);
+			if (!decoder->ip)
+				break;
+			decoder->state.type |= INTEL_PT_TRACE_BEGIN;
+			return 0;
+
 		case INTEL_PT_TIP:
-			decoder->pge = decoder->packet.type != INTEL_PT_TIP_PGD;
+			decoder->pge = true;
 			if (intel_pt_have_ip(decoder))
 				intel_pt_set_ip(decoder);
 			if (!decoder->ip)
 				break;
-			if (decoder->packet.type == INTEL_PT_TIP_PGE)
-				decoder->state.type |= INTEL_PT_TRACE_BEGIN;
-			if (decoder->packet.type == INTEL_PT_TIP_PGD)
-				decoder->state.type |= INTEL_PT_TRACE_END;
 			return 0;
 
 		case INTEL_PT_FUP:
-- 
2.20.1

