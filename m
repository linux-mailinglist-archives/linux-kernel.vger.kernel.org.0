Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92D610C99C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 14:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK1Nko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 08:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbfK1Nko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:40:44 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02920217D6;
        Thu, 28 Nov 2019 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948443;
        bh=9shmp8VvJhPk3FNT3odx32MMDitjH1qQ0HRVeh3OUgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jsfvcm5vWozw4Yjye6QIWjcomxG6vMlcDKgzMIn4ivOofJlvSkETRPV8zO+VmX3t
         qCJGS5BxxG9bGkjNJ55Use8TNbCSPy8DJqDdCvggQiRBmeMn4qZVadWukBAKbPYLUY
         dFM5qqiO7iKA/g7w5ZH1nTCZysCoZ+736YbFsVfg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 03/22] perf map: Remove needless struct forward declarations
Date:   Thu, 28 Nov 2019 10:40:08 -0300
Message-Id: <20191128134027.23726-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

At some point we may have needed that, not anymore.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hnao13231bsl7xml5wn8h4iu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index c0dffa9ecfe3..aafaea22737c 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -12,11 +12,8 @@
 #include <linux/types.h>
 
 struct dso;
-struct ip_callchain;
-struct ref_reloc_sym;
 struct map_groups;
 struct machine;
-struct evsel;
 
 struct map {
 	union {
-- 
2.21.0

