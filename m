Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29C6F2DA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfGUL2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:28:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfGUL2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:28:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E49C78535D;
        Sun, 21 Jul 2019 11:28:19 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60D545D9D3;
        Sun, 21 Jul 2019 11:28:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 25/79] libperf: Add libperf in python.so compilation
Date:   Sun, 21 Jul 2019 13:24:12 +0200
Message-Id: <20190721112506.12306-26-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 21 Jul 2019 11:28:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link libperf.a with python.so.

Link: http://lkml.kernel.org/n/tip-kxsfxvj7e2noz2kzhyf2ifck@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.perf | 1 +
 tools/perf/util/setup.py | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 6e7e7d44ffac..67512a12276b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -307,6 +307,7 @@ LIBBPF = $(BPF_PATH)libbpf.a
 LIBSUBCMD = $(SUBCMD_PATH)libsubcmd.a
 
 LIBPERF = $(LIBPERF_PATH)libperf.a
+export LIBPERF
 
 # python extension build directories
 PYTHON_EXTBUILD     := $(OUTPUT)python_ext_build/
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index a1a68a2fa917..d48f9cd58964 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -48,6 +48,7 @@ build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
 libtraceevent = getenv('LIBTRACEEVENT')
 libapikfs = getenv('LIBAPI')
+libperf = getenv('LIBPERF')
 
 ext_sources = [f.strip() for f in open('util/python-ext-sources')
 				if len(f.strip()) > 0 and f[0] != '#']
@@ -64,7 +65,7 @@ perf = Extension('perf',
 		  include_dirs = ['util/include'],
 		  libraries = extra_libraries,
 		  extra_compile_args = cflags,
-		  extra_objects = [libtraceevent, libapikfs],
+		  extra_objects = [libtraceevent, libapikfs, libperf],
                  )
 
 setup(name='perf',
-- 
2.21.0

