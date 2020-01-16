Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3829E13DC5A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 14:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgAPNtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 08:49:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgAPNtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:49:05 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E90D207FF;
        Thu, 16 Jan 2020 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579182544;
        bh=gVEym5ChMLGuNJn/GMGLtZ5ZZEdpQSUgpatWS1nHA7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvDggVD+xCQEbe4ee8I0hNAWvwBKPN3BcfwYa6GnYREl75z39ChmFc+7jL+mpGy7w
         zLxdyCQoHueARZ0xO068fBVUgzTePkyMNIJrd30a+qZTMul6gouUQmAwMt14G5mqeH
         lBzTnT16UryzZoFIEmCFITNHOPN29KmbJSyxAuMs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/12] perf header: Use last modification time for timestamp
Date:   Thu, 16 Jan 2020 10:48:14 -0300
Message-Id: <20200116134814.8811-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

Using .st_ctime clobbers the timestamp information in perf report header
whenever any operation is done with the file. Even tar-ing and untar-ing
the perf.data file (which preserves the file last modification timestamp)
doesn't prevent that:

    [Michael@Diego tmp]$ ls -l perf.data
->	-rw-------. 1 Michael Michael 169888 Dec  2 15:23 perf.data

	[Michael@Diego tmp]$ perf report --header-only
	# ========
->	# captured on    : Mon Dec  2 15:23:42 2019
	 [...]

	[Michael@Diego tmp]$ tar c perf.data | xz > perf.data.tar.xz
	[Michael@Diego tmp]$ mkdir aaa
	[Michael@Diego tmp]$ cd aaa
	[Michael@Diego aaa]$ xzcat ../perf.data.tar.xz | tar x
	[Michael@Diego aaa]$ ls -l -a
	total 172
	drwxrwxr-x. 2 Michael Michael     23 Jan 14 11:26 .
	drwxrwxr-x. 6 Michael Michael   4096 Jan 14 11:26 ..
->	-rw-------. 1 Michael Michael 169888 Dec  2 15:23 perf.data

	[Michael@Diego aaa]$ perf report --header-only
	# ========
->	# captured on    : Tue Jan 14 11:26:16 2020
	 [...]

When using .st_mtime instead, correct information is printed:

	[Michael@Diego aaa]$ ~/acme/tools/perf/perf report --header-only
	# ========
->	# captured on    : Mon Dec  2 15:23:42 2019
	 [...]

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20200114104236.31555-1-mpetlan@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 93ad27830e2b..4246e7447e54 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2922,7 +2922,7 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	if (ret == -1)
 		return -1;
 
-	stctime = st.st_ctime;
+	stctime = st.st_mtime;
 	fprintf(fp, "# captured on    : %s", ctime(&stctime));
 
 	fprintf(fp, "# header version : %u\n", header->version);
-- 
2.21.1

