Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD721E77
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 21:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfEQThx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 15:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbfEQThs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:37:48 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971AA21726;
        Fri, 17 May 2019 19:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121867;
        bh=pX558iNOvnPwXmbcVRl+2A1oJ8dGx3Rq0WMmegXfp74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QykkbcK7cI9iIBod69e73n9Rm7sT/mcZN0CSPNxWsX9QcgUYKDQT2zM6RE7gpmF2e
         mUXQO9RJvwxhXW9RpsfivgsdCEotE0qwfZv54CXvxyzF7WqgEOTrNxiCMtXH3JPpsB
         yHTIEFCMexQ4uetX42a7arJYg7L3q2k5kHK0YtGY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Donald Yandt <donald.yandt@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Avi Kivity <avi@scylladb.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yanmin Zhang <yanmin_zhang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/73] perf machine: Null-terminate version char array upon fgets(/proc/version) error
Date:   Fri, 17 May 2019 16:35:18 -0300
Message-Id: <20190517193611.4974-21-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Donald Yandt <donald.yandt@gmail.com>

If fgets() fails due to any other error besides end-of-file, the version
char array may not even be null-terminated.

Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
Link: http://lkml.kernel.org/r/20190514110100.22019-1-donald.yandt@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c520baa198c..28a9541c4835 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1234,8 +1234,9 @@ static char *get_kernel_version(const char *root_dir)
 	if (!file)
 		return NULL;
 
-	version[0] = '\0';
 	tmp = fgets(version, sizeof(version), file);
+	if (!tmp)
+		*version = '\0';
 	fclose(file);
 
 	name = strstr(version, prefix);
-- 
2.20.1

