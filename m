Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4907192E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 17:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgCYQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 12:41:00 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:55874 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbgCYQk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:40:59 -0400
Received: by mail-pj1-f74.google.com with SMTP id y21so2091370pjn.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QQlmwmvyhM5ffUQK0/If9vVW3XeaSkhBNfKa5UWeFk4=;
        b=ZcDOCz7gERkxui7ejEW6sPXgWIA1mIFEtpFH818ntgGIjUDxfpP+E70RxvU9BSXo1s
         rcpJ6ND8bMOZwqMSaECwQQdNaKzzLv1EGers5ZQ4Gji+hUFsQDOBetRbS67YVvdPqDX8
         q+KFOEw3z1DH6u9Pz9eikOzhsbWQP9dUP5sG3IouJRp0Njnfeg+1ji9dzAi/F6Rwb9sf
         99kyKdvP6rVJg00yLGOgQmEbE4Ds6zvIUYnSgMhPJ6alaRiFoMNNdh21+TgSyp13QUh1
         RgFzwAo91Y+mCCbQEd/WNjsTgbxEJUddUKfb2OdM8ZPTaFPPzgmgfFEtW/whNr1SSolT
         /XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QQlmwmvyhM5ffUQK0/If9vVW3XeaSkhBNfKa5UWeFk4=;
        b=ERYp4Ag7Oq+W+E+96Fe2y/7Ta0aAIEIRR+nAd+l0VUc1z269SiaQGRY/apSStT2K2U
         TbhEMpyTbMOqvwRtcAlgKs8XHcoopVh1seeQQuwdhPNbVjQNpQ6sk2DODyG092z+KI5E
         xw+GD0W+9teQ1gLGLIrUSqS39h4EtKgxssxf4Fb8+39Jva6XDFcVSBzswVXPDGgRw7C6
         rXy0K8R8Kcp4iyaNX27/DpmyAXXRSRut+e1CUMWC/llM8dASWlE+1mgtB/voc5cKXTWm
         3PwMKctiRMgQKD6c2HS9T1XSCPsdSaO0T4MF84d37qlhVRockxBOIcIpWEHoS7bPKgbJ
         tMAg==
X-Gm-Message-State: ANhLgQ1UtaDd8n3hCRB+fMXrJxpT4iWsjR1gH6CgMkwXVlAveAiGaUKm
        yVcdO0HUqpOMFxhb9PUsbGgebmK+ZQQp
X-Google-Smtp-Source: ADFU+vtObopVuBBWzlezT7hN54bUUKtluYdeW+xJJHvhzakoCOVbPQ0es7kp603MkrtqNC/r2x3r0DZMQzUH
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr4280096pjb.186.1585154456219;
 Wed, 25 Mar 2020 09:40:56 -0700 (PDT)
Date:   Wed, 25 Mar 2020 09:40:22 -0700
Message-Id: <20200325164022.41385-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] perf parse-events: add defensive null check
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terms may have a null config in which case a strcmp will segv. This can
be reproduced with:
  perf stat -e '*/event=?,nr/' sleep 1
Add a null check to avoid this. This was caught by LLVM's libfuzzer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 616fbda7c3fc..ef6a63f3d386 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -984,12 +984,11 @@ static int pmu_resolve_param_term(struct parse_events_term *term,
 	struct parse_events_term *t;
 
 	list_for_each_entry(t, head_terms, list) {
-		if (t->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
-			if (!strcmp(t->config, term->config)) {
-				t->used = true;
-				*value = t->val.num;
-				return 0;
-			}
+		if (t->type_val == PARSE_EVENTS__TERM_TYPE_NUM &&
+		    t->config && !strcmp(t->config, term->config)) {
+			t->used = true;
+			*value = t->val.num;
+			return 0;
 		}
 	}
 
-- 
2.25.1.696.g5e7596f4ac-goog

