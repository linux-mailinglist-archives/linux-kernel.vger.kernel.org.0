Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC6E2DE96
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfE2NjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2NjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:39:08 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48350222F9;
        Wed, 29 May 2019 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137148;
        bh=hPObr9/Cm2ba7NydJ1YG8PV/LYy6qblEkhksufyDhVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcAOoFF92AyeU4l0g46ImKDhuLtiADok1RRk8L+35fwIX998rNFJvWgAZG6LIX+bx
         o7FneZbE0uK7pmgslj0OCW6I42GFGzIW7GEHMdNuSHK3ayUNTd9MDdcKbPSyG70nXh
         bOyal1HJtt3okT4kUP0390ugqUwmq50U6DNIWzFo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 35/41] perf scripts python: exported-sql-viewer.py: Change python2 to python
Date:   Wed, 29 May 2019 10:35:59 -0300
Message-Id: <20190529133605.21118-36-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Now that there is also support for python3, there is no need to specify
python2 explicitly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index affed7d149be..9ff92a130655 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python2
+#!/usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0
 # exported-sql-viewer.py: view data from sql database
 # Copyright (c) 2014-2018, Intel Corporation.
-- 
2.20.1

