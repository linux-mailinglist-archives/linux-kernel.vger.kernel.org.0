Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCFB634F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 13:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfGILdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 07:33:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52419 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfGILdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:33:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69BWnhX1893145
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 04:32:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69BWnhX1893145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562671970;
        bh=kIaI3QJg0A2Q+Nl28encKQ1WPVyjwyufocDbo46jmW0=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=JaAgrGGlNPH4Vb5uDro7xqlN6VEdPDKz4KZ9NuIdzh6+BSzR7l7vX2XKKoc3mkYIa
         LqKgky6lL1Taw0DJZPe8ML+3jApao+Y1BkrfJS0r1hhNsmg8+HQlZj0ztDIG0FeHET
         YuaIRFAgdc2fRdVi6JysSjx8LKHxAwuOgLoSWGoJBdPsgAR5WXvvBI5/2JqUsm1NpW
         xT/xc/9RliE2Z6glo9QCZBj86r9cnqKABifJQPqX4WQT12rnHB6XAPJJSfDwepY3xY
         u/0OC6DZgvGCN0Xa9f7l6Vxr3/gvag3MqUg8NpXHA8bW1E/RY7LTvMJmf+CzhzicK+
         hLLP2kZzH3khg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69BWnSm1893142;
        Tue, 9 Jul 2019 04:32:49 -0700
Date:   Tue, 9 Jul 2019 04:32:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-brmp2415zxpbhz45etkgjoma@git.kernel.org>
Cc:     namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, acme@redhat.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          hpa@zytor.com, mingo@kernel.org, jolsa@kernel.org,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf python: Remove -fstack-protector-strong if
 clang doesn't have it
Git-Commit-ID: c18ae6327a13a6d707f6139c31597057103aa85b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c18ae6327a13a6d707f6139c31597057103aa85b
Gitweb:     https://git.kernel.org/tip/c18ae6327a13a6d707f6139c31597057103aa85b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 28 May 2019 17:36:46 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sun, 7 Jul 2019 12:32:46 -0300

perf python: Remove -fstack-protector-strong if clang doesn't have it

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
 
