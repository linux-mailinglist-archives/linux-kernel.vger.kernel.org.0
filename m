Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5E185852
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 03:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCOCDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 22:03:22 -0400
Received: from st43p00im-ztdg10063201.me.com ([17.58.63.182]:53982 "EHLO
        st43p00im-ztdg10063201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727576AbgCOCDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584161099; bh=EEEbp3jzZyM6DiXaanP9VVmhXwPwBmSyVm9WJG3Nf1U=;
        h=From:To:Subject:Date:Message-Id;
        b=jal2nhQhbJ/qJmnmFj2CyHkwd92uqAJYtQtilwinxetNQXQ4PwTLbOTbPYM7Gsatg
         +uDL82vb/O/7lznF+QSqroi+Ta0UrBmh9QdpR914pE/Hn92Cr6ka3DWy0cUgK26zuI
         Jxg1oEIE8Tzjnq09Hp7APSXO1thwB6BGPxScZSDriTYGL0pJuIC5xP4vArfodVxBWk
         4H4Ov2K6hIeinfKuEhqb1CDLIprYNE4jTe01Iun1PeydoWithlQFN84l3AV7ukD524
         jGpIOPRGdaLtXjQP/sm9BmLzWr6rEbmmM4diA7WI6pMikihoJHwgKRH0aoXailbT9R
         8DxyWMiSkhnEg==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id 23AFB5405EA;
        Sat, 14 Mar 2020 04:44:59 +0000 (UTC)
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Vijay Thakkar <vijaythakkar@me.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, thakkarv <thakkarv@gatech.edu>
Subject: [PATCH v4 1/3] perf vendor events amd: restrict model detection for zen1 based processors
Date:   Sat, 14 Mar 2020 00:44:51 -0400
Message-Id: <20200314044453.82554-2-vijaythakkar@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200314044453.82554-1-vijaythakkar@me.com>
References: <20200314044453.82554-1-vijaythakkar@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003140024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the previous blanket detection of AMD Family 17h
processors to be more specific to Zen1 core based products only by
replacing model detection regex pattern [[:xdigit:]]+ with
([12][0-9A-F]|[0-9A-F]), restricting to models 0 though 2f only.

This change is required to allow for the addition of separate PMU events
for Zen2 core based models in the following patches as those belong to family
17h but have different PMCs. Current PMU events directory has also been
renamed to "amdzen1" from "amdfam17h" to reflect this specificity.

Note that although this change does not break PMU counters for existing
zen1 based systems, it does disable the current set of counters for zen2
based systems. Counters for zen2 have been added in the following
patches in this patchset.

Signed-off-by: thakkarv <thakkarv@gatech.edu>
---
Changes in v2:
    - Change Zen1 model detection regex to include all models in range 0
    through 2F inclusive.

 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/branch.json | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json  | 0
 tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json | 0
 .../arch/x86/{amdfam17h => amdzen1}/floating-point.json         | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json  | 0
 tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
 7 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/branch.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json (100%)

diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/branch.json b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/branch.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/cache.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/core.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/core.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/memory.json b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/memory.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/other.json b/tools/perf/pmu-events/arch/x86/amdzen1/other.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/other.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/other.json
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 745ced083844..82a9db00125e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -36,4 +36,4 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
-AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
+AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v1,amdzen1,core
-- 
2.25.1

