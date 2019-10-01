Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 287E9C3212
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 13:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbfJALMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 07:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731358AbfJALMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:12:42 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEAE721920;
        Tue,  1 Oct 2019 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928361;
        bh=KSIwqi7udYS1ltCOdZhqaw685LG1hFFg0WYWzZyx40M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYqDTAoHNgNNn86IWeXgp8zj2JEPYNWdLJ7YMzeZyZ9lpitG4vhjOJVyhKUO1hsWQ
         8fz2AWw3zWJrPWulMntJ0QEAbN5nF/vckcWBIhLipJWUwUv5cerBjpMEa1Obo6uUi1
         B17KciCVNN3Q+PxlHVg/IQnFE4Mqx4N58YXfINOA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/24] perf docs: Allow man page date to be specified
Date:   Tue,  1 Oct 2019 08:11:55 -0300
Message-Id: <20191001111216.7208-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

With this change if a perf_date parameter is provided to asciidoc then
it will override the default date written to the man page metadata.

Without this change, or if the perf_date isn't specified, then the
current date is written to the metadata.

Having this parameter allows the metadata to be constant if builds
happen on different dates.

The name of the parameter is intended to be consistent with the existing
perf_version parameter.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20190921041327.155054-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/asciidoc.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/asciidoc.conf b/tools/perf/Documentation/asciidoc.conf
index 356b23a40339..2b62ba1e72b7 100644
--- a/tools/perf/Documentation/asciidoc.conf
+++ b/tools/perf/Documentation/asciidoc.conf
@@ -71,6 +71,9 @@ ifdef::backend-docbook[]
 [header]
 template::[header-declarations]
 <refentry>
+ifdef::perf_date[]
+<refentryinfo><date>{perf_date}</date></refentryinfo>
+endif::perf_date[]
 <refmeta>
 <refentrytitle>{mantitle}</refentrytitle>
 <manvolnum>{manvolnum}</manvolnum>
-- 
2.21.0

