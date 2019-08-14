Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3EC8DD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfHNSmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbfHNSmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:42:54 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EE0216F4;
        Wed, 14 Aug 2019 18:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808173;
        bh=N5TpHcUTmlrhvV3UqolE4KL8/LV8os0UPPGPsPlAXVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPgcIAEZrHzs7WkmB3gb6ln9asfb7xQqsAP1CiS+Jy5iRliPyQdnpivwFEtizUHx/
         GOAJwzHlwgo1DUtvVqji+p10Mo3r4uvMvXxtfXhK8OpRLypN3Ba8koB6XhffnsFveL
         laxk9MKmTbaHcpN/LqGBfr0lJ3PbN51g9dTw8P0I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 07/28] perf top: Set display thread COMM to help with debugging
Date:   Wed, 14 Aug 2019 15:40:30 -0300
Message-Id: <20190814184051.3125-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we want to attach just to the thread that updates the display it
helps having its COMM stand out, so change it from the default "perf" to
"perf-top-UI".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5w0hmlk3zfvysxvpsh763k9w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1a4615a5f6c9..94e34853a238 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -601,6 +601,8 @@ static void *display_thread_tui(void *arg)
 	 */
 	unshare(CLONE_FS);
 
+	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
+
 	perf_top__sort_new_samples(top);
 
 	/*
@@ -651,6 +653,8 @@ static void *display_thread(void *arg)
 	 */
 	unshare(CLONE_FS);
 
+	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
+
 	display_setup_sig();
 	pthread__unblock_sigwinch();
 repeat:
-- 
2.21.0

