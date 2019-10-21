Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4639DEE10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 15:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfJUNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 09:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729743AbfJUNlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26AC42053B;
        Mon, 21 Oct 2019 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665299;
        bh=oHUY9ohOod0xt4F7F1gde1O9xHZIQP1eY0A6fuFzdvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDaJ4kMPjNtBeBOAGLbSltYuOpFV3cXm53ju+Oxg3nsLDbVvkXT+fUxZLDPziNwAj
         fmSV1DRfbld0nY1KUy2zsUtLqvhXYQvJE69SFsflL1zmitLFbqKfWkx+CGDLgqEvHP
         eE+bkD1LpPFtzLaqlBWyyaOEGTkNe75r4QvA8FD0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 54/57] libbeauty: Make the mmap_flags strarray visible outside of its beautifier
Date:   Mon, 21 Oct 2019 10:38:31 -0300
Message-Id: <20191021133834.25998-55-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can later use it with the strarray__strtoul_flags() routine
that will be soon introduced.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vldj3ch8su6i20to5eq31e8x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 859a8a9db2c6..9fa771a90d79 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -33,11 +33,11 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 
 #define SCA_MMAP_PROT syscall_arg__scnprintf_mmap_prot
 
-static size_t mmap__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
-{
 #include "trace/beauty/generated/mmap_flags_array.c"
        static DEFINE_STRARRAY(mmap_flags, "MAP_");
 
+static size_t mmap__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
+{
        return strarray__scnprintf_flags(&strarray__mmap_flags, bf, size, show_prefix, flags);
 }
 
-- 
2.21.0

