Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4450A10C99D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 14:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfK1Nko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 08:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfK1Nkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:40:40 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46ACE2176D;
        Thu, 28 Nov 2019 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948440;
        bh=mk6rvHktr9jb5/xki7FjACiw9opOwHR3MwXxtK7eNzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j93QfSXVR9myq53BEn/BFUAjhhuc1OdTifSouxGDKuYbJ2iJ17xcZYVAMARb2ep4d
         m+6B2JYmCSB356kt9tIYJumgHJhStpdx9qhyfbseN+zyP9Pg8GdBNvK6q0kAq1dEO6
         xdTboY0iOeks5pV19q9rpvyFZcoAFzIi3qab0Z6Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 02/22] perf map: Ditch leftover map__reloc_vmlinux() prototype
Date:   Thu, 28 Nov 2019 10:40:07 -0300
Message-Id: <20191128134027.23726-3-acme@kernel.org>
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

In 39b12f781271 ("perf tools: Make it possible to read object code from vmlinux")
the actual function was removed, but we forgot to remove the prototype,
fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-35yy50cgpcx8cjorluwd5j53@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 1f110b53b5f3..c0dffa9ecfe3 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -144,8 +144,6 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name);
 void map__fixup_start(struct map *map);
 void map__fixup_end(struct map *map);
 
-void map__reloc_vmlinux(struct map *map);
-
 int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
 				    u64 addr);
 
-- 
2.21.0

