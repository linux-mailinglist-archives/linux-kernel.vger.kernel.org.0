Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9536F2BC31
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 00:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfE0WlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 18:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbfE0WlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:41:06 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7467320859;
        Mon, 27 May 2019 22:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996866;
        bh=mfVl03+JldGddTH7mZZrjqAYZtBlRBS/GAL/B9LjS00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5oC2N3KsSaHRUhSeXdGFTJZTe0uWL/wvA1YAi8zOb2oLKHa3R+SYmK1HXIvtzx5I
         NIm9ZkajFGKQbLhwepf+sDopivzaFcWPp8izNHjnWWV/S09u5IwQrg16tyT5N6tY6v
         0CITSoUfE0GLruaNy5KDq/+WGclhZrIPEfR3tNE0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 42/44] perf version: Append 12 git SHA chars to the version string
Date:   Mon, 27 May 2019 19:37:28 -0300
Message-Id: <20190527223730.11474-43-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Bumping it from just 4:

Before:

  $ perf -v
  perf version 5.2.rc1.g80978f
  $

After:

  $ perf -v
  perf version 5.2.rc1.g80978fc864c5
  $

Requested-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p4yun2nxlo7eeeohyx5v4kw7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/PERF-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
index 3802cee5e188..59241ff342be 100755
--- a/tools/perf/util/PERF-VERSION-GEN
+++ b/tools/perf/util/PERF-VERSION-GEN
@@ -19,7 +19,7 @@ TAG=
 if test -d ../../.git -o -f ../../.git
 then
 	TAG=$(git describe --abbrev=0 --match "v[0-9].[0-9]*" 2>/dev/null )
-	CID=$(git log -1 --abbrev=4 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
+	CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
 elif test -f ../../PERF-VERSION-FILE
 then
 	TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
-- 
2.20.1

