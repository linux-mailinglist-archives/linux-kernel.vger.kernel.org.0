Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A0B16C0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 13:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgBYMU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 07:20:29 -0500
Received: from foss.arm.com ([217.140.110.172]:50088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbgBYMU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 07:20:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 322FC1063;
        Tue, 25 Feb 2020 03:57:46 -0800 (PST)
Received: from e121896.warwick.arm.com (e121896.warwick.arm.com [10.32.36.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FA803F6CF;
        Tue, 25 Feb 2020 03:57:44 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     adrian.hunter@intel.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, James Clark <james.clark@arm.com>
Subject: [PATCH v5 0/4] perf tools: Add support for some spe events and precise ip
Date:   Tue, 25 Feb 2020 11:57:35 +0000
Message-Id: <20200225115739.18740-1-james.clark@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <768a33f2-8694-270e-d3e8-3da4c65e96b3@intel.com>
References: <768a33f2-8694-270e-d3e8-3da4c65e96b3@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

I've added the itrace arguments to ITRACE_HELP and also added the evsel->core.attr.type == PERF_TYPE_HARDWARE
comparison.

Thanks
James

Tan Xiaojun (4):
  perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
  perf tools: Add support for "report" for some spe events
  perf report: Add SPE options to --itrace argument
  perf tools: Support "branch-misses:pp" on arm64

 tools/perf/Documentation/itrace.txt           |   5 +-
 tools/perf/arch/arm/util/auxtrace.c           |  39 +
 tools/perf/builtin-record.c                   |   5 +
 tools/perf/util/Build                         |   2 +-
 tools/perf/util/arm-spe-decoder/Build         |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 225 ++++++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  66 ++
 .../arm-spe-pkt-decoder.c                     |   0
 .../arm-spe-pkt-decoder.h                     |   2 +
 tools/perf/util/arm-spe.c                     | 756 +++++++++++++++++-
 tools/perf/util/arm-spe.h                     |   3 +
 tools/perf/util/auxtrace.c                    |  13 +
 tools/perf/util/auxtrace.h                    |  19 +-
 13 files changed, 1094 insertions(+), 42 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (96%)

-- 
2.17.1

