Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA418A2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 20:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCRTAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 15:00:12 -0400
Received: from ms11p00im-qufo17291701.me.com ([17.58.38.46]:43380 "EHLO
        ms11p00im-qufo17291701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbgCRTAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584558008; bh=Wx3SLcGZbU7wK702DkuJhWDsfT3JOl+X/0ZhHZWG+9Q=;
        h=From:To:Subject:Date:Message-Id:Content-Type;
        b=yJbuHbEfX2NujboAIQTVDGAu5WfhdMVC/lg/2pNrzNDVdh5Q3mFVLpfTHvct6++Q3
         BDDDNIGdA4p2MJ13xwDmAdXYWPiVP0EcGu4Fsh54SQPSQsKBJl4qRX7ptPW12wJlBb
         URnD/kCq/Sa1U74/Bp1QJwVK2k+p3mJm+LhtFvT9hMBKk2DYtHUmHm245XkcmZmx/9
         jrmvt9aPPjIu3TF7IWTrLvZC49QfKI36k8D/NHCmX5/lTUBygrfpuN3dIaDDnSJ3zg
         7M8rQGoDwOvDxAl7H5MoXmesVyg/FiCznFhW0IB8vWDKHVWrCN40wJ2HY3eQixumPI
         sahhNy1XEcftw==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by ms11p00im-qufo17291701.me.com (Postfix) with ESMTPSA id C6BE76409A4;
        Wed, 18 Mar 2020 19:00:07 +0000 (UTC)
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
        linux-perf-users@vger.kernel.org
Subject: [PATCH v6 0/3] perf vendor events amd: latest PMU events for zen1/zen2
Date:   Wed, 18 Mar 2020 14:59:59 -0400
Message-Id: <20200318190002.307290-1-vijaythakkar@me.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003180085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches brings the PMU events for AMD family 17h series
of processors up to date with the latest versions of the AMD processor
programming reference manuals.

The first patch changes the pmu events mapfile to be more selective for
the model number rather than blanket detecting all f17h processors to
have the same events directory. This is required for the later patch
where we add events for zen2 based processors.

The second patch adds the PMU events for zen2.

Finally the third patch updates the zen1 PMU events to be in accordance
with the latest PPR version and bumps up the events version to v2.

Vijay Thakkar (3):
  perf vendor events amd: restrict model detection for zen1 based
    processors
  perf vendor events amd: add Zen2 events
  perf vendor events amd: update Zen1 events to V2

 .../pmu-events/arch/x86/amdfam17h/branch.json |  12 -
 .../pmu-events/arch/x86/amdfam17h/cache.json  | 329 -----------------
 .../pmu-events/arch/x86/amdfam17h/other.json  |  65 ----
 .../pmu-events/arch/x86/amdzen1/branch.json   |  23 ++
 .../pmu-events/arch/x86/amdzen1/cache.json    | 294 +++++++++++++++
 .../arch/x86/{amdfam17h => amdzen1}/core.json |  15 +-
 .../floating-point.json                       |  64 +++-
 .../x86/{amdfam17h => amdzen1}/memory.json    |  82 +++--
 .../pmu-events/arch/x86/amdzen1/other.json    |  56 +++
 .../pmu-events/arch/x86/amdzen2/branch.json   |  52 +++
 .../pmu-events/arch/x86/amdzen2/cache.json    | 338 +++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/core.json     | 130 +++++++
 .../arch/x86/amdzen2/floating-point.json      | 140 +++++++
 .../pmu-events/arch/x86/amdzen2/memory.json   | 341 ++++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/other.json    | 115 ++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
 16 files changed, 1606 insertions(+), 453 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/cache.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json (87%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (61%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (63%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json

-- 
2.25.2

