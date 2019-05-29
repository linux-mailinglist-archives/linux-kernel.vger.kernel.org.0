Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECDE62DE94
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfE2NjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2Ni5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:38:57 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B04021902;
        Wed, 29 May 2019 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137137;
        bh=BEWPwa95tbpi2kd9Ez0v9Jr5YtYJyUOPyBcWUfzfO60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2kcirECNxyOh9rOdW8QUgGH54qbZMoN0apx7UFd36enB2deh4hc9xUD55NIoHsLC
         KeEHqdRptq2SI2anmhx0ImFKzsRI+BkKONMOtutEgQq8/krzjrT7nGgH85I+LD/x1H
         YHVaa2lzcSvlIgej9QTNmY3vfXIwgOqAYZp7ubao=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 33/41] perf python: Remove -fstack-protector-strong if clang doesn't have it
Date:   Wed, 29 May 2019 10:35:57 -0300
Message-Id: <20190529133605.21118-34-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Some distros put -fstack-protector-strong in the compiler flags to be
used to build python extensions, but then, the clang version in that
distro doesn't know about that, only gcc does.

Check if that is the case and remove it from the set of options used to
build the python binding with clang.

Case at hand:

oraclelinux:7

  $ head -2 /etc/os-release
  NAME="Oracle Linux Server"
  VERSION="7.6"
  $ grep stack-protector /usr/lib64/python2.7/_sysconfigdata.py | head -1 | cut -c-120
 'CFLAGS': '-fno-strict-aliasing -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --para
  $
  gcc version 4.8.5 20150623 (Red Hat 4.8.5-36.0.1) (GCC)
  clang version 3.4.2 (tags/RELEASE_34/dot2-final)

  clang: error: unknown argument: '-fstack-protector-strong'
  clang: error: unknown argument: '-fstack-protector-strong'
  error: command 'clang' failed with exit status 1
  cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such file or directory
  make[2]: *** [/tmp/build/perf/python/perf.so] Error 1

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-brmp2415zxpbhz45etkgjoma@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 5b5a167b43ce..a1a68a2fa917 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -17,6 +17,8 @@ if cc == "clang":
             vars[var] = sub("-fcf-protection", "", vars[var])
         if not clang_has_option("-fstack-clash-protection"):
             vars[var] = sub("-fstack-clash-protection", "", vars[var])
+        if not clang_has_option("-fstack-protector-strong"):
+            vars[var] = sub("-fstack-protector-strong", "", vars[var])
 
 from distutils.core import setup, Extension
 
-- 
2.20.1

