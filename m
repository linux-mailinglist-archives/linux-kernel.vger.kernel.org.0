Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B098DD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfHNSm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfHNSm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:42:28 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 466392173B;
        Wed, 14 Aug 2019 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808147;
        bh=MZ5tUlg6qUmGNoIA7BJ1dU4jWAtdPFWRBWyiCXHte10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHj6La1JM2O6JwvBmm6RbXdtdgYN7o2PO/SfDm8yG5ruCtTAl7ppLDURKtzNtw+U6
         oM0uMHcnkjqIEogvGZ+NMs0C868eEZ2Svp9jd3mL5uOqOIYJLaoA+VTmTygI1Z5FME
         sbIzAY5SFhTEJ2FUXKvYIB/KPUA4lzMa2vy27dKU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH 04/28] perf test vfs_getname: Disable ~/.perfconfig to get default output
Date:   Wed, 14 Aug 2019 15:40:27 -0300
Message-Id: <20190814184051.3125-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the expected output we have to ignore whatever changes the user
has in its ~/.perfconfig file, so set PERF_CONFIG to /dev/null to
achieve that.

Before:

  # egrep 'trace|show_' ~/.perfconfig
  [trace]
  	show_zeros = yes
  	show_duration = no
  	show_timestamp = no
  	show_arg_names = no
  	show_prefix = yes
  # echo $PERF_CONFIG

  # perf test "trace + vfs_getname"
  70: Check open filename arg using perf trace + vfs_getname: FAILED!
  # export PERF_CONFIG=/dev/null
  # perf test "trace + vfs_getname"
  70: Check open filename arg using perf trace + vfs_getname: Ok
  #

After:

  # egrep 'trace|show_' ~/.perfconfig
  [trace]
  	show_zeros = yes
  	show_duration = no
  	show_timestamp = no
  	show_arg_names = no
  	show_prefix = yes
  # echo $PERF_CONFIG

  # perf test "trace + vfs_getname"
  70: Check open filename arg using perf trace + vfs_getname: Ok
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: https://lkml.kernel.org/n/tip-3up27pexg5i3exuzqrvt4m8u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 45d269b0157e..11cc2af13f2b 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -32,6 +32,10 @@ if [ $err -ne 0 ] ; then
 	exit $err
 fi
 
+# Do not use whatever ~/.perfconfig file, it may change the output
+# via trace.{show_timestamp,show_prefix,etc}
+export PERF_CONFIG=/dev/null
+
 trace_open_vfs_getname
 err=$?
 rm -f ${file}
-- 
2.21.0

