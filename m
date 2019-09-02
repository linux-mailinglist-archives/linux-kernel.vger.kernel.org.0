Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0375A55A6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbfIBMM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 08:12:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbfIBMM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:12:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B274EA909;
        Mon,  2 Sep 2019 12:12:58 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BAE260C05;
        Mon,  2 Sep 2019 12:12:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 0/3] perf stat: Add --per-numa option
Date:   Mon,  2 Sep 2019 14:12:52 +0200
Message-Id: <20190902121255.536-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 02 Sep 2019 12:12:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
adding --per-numa option to aggregate stats per NUMA nodes,
you can get now use stat command like:
    
  # perf stat  -a -I 1000 -e cycles --per-numa
  #           time numa   cpus             counts unit events
       1.000542550 N0       20          6,202,097      cycles
       1.000542550 N1       20            639,559      cycles
       2.002040063 N0       20          7,412,495      cycles
       2.002040063 N1       20          2,185,577      cycles
       3.003451699 N0       20          6,508,917      cycles
       3.003451699 N1       20            765,607      cycles
  ...

thanks,
jirka


---
Jiri Olsa (3):
      libperf: Add perf_cpu_map__max function
      perf tools: Add perf_env__numa_node function
      perf stat: Add --per-numa agregation support

 tools/perf/Documentation/perf-stat.txt |  5 +++++
 tools/perf/builtin-stat.c              | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 tools/perf/lib/cpumap.c                | 12 ++++++++++++
 tools/perf/lib/include/perf/cpumap.h   |  1 +
 tools/perf/lib/libperf.map             |  1 +
 tools/perf/util/cpumap.c               | 18 ++++++++++++++++++
 tools/perf/util/cpumap.h               |  3 +++
 tools/perf/util/env.c                  | 35 +++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h                  |  6 ++++++
 tools/perf/util/stat-display.c         | 15 +++++++++++++++
 tools/perf/util/stat.c                 |  1 +
 tools/perf/util/stat.h                 |  1 +
 12 files changed, 148 insertions(+), 10 deletions(-)
