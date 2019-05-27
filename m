Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90D42BC00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 00:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfE0Whs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 18:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfE0Whr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:37:47 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D5F8208C3;
        Mon, 27 May 2019 22:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996667;
        bh=i5pHeQJ7ppT3kwKYAu+b8dnrhSm99cbuXjzq8mQ059I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y6kr6cw633jgEqC4SFq2g/bwtkBXmGNLGt0pa2epnWdRCxEdk7Ir/NP3CL4R55XiA
         NuptefQD80IwY0bazavH2wZyu6NffE4PvohivvyNPCpvjIMomCIR2pKyL+yciSqvv0
         CBKH3kjbjFOwsSvjf77psM/SkjnQENsOMnAMzcvc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/44] perf-with-kcore.sh: Always allow fix_buildid_cache_permissions
Date:   Mon, 27 May 2019 19:36:47 -0300
Message-Id: <20190527223730.11474-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The user's buildid cache may contain entries added by root even if root
has its own home directory (e.g. by using perfconfig to specify the same
buildid dir), so remove that validation.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf-with-kcore.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/perf-with-kcore.sh b/tools/perf/perf-with-kcore.sh
index 7e47a7cbc195..2ad2fffdb209 100644
--- a/tools/perf/perf-with-kcore.sh
+++ b/tools/perf/perf-with-kcore.sh
@@ -111,11 +111,6 @@ fix_buildid_cache_permissions()
 
 	USER_HOME=$(bash <<< "echo ~$SUDO_USER")
 
-	if [ "$HOME" != "$USER_HOME" ] ; then
-		echo "Fix unnecessary because root has a home: $HOME" >&2
-		exit 1
-	fi
-
 	echo "Fixing buildid cache permissions"
 
 	find "$USER_HOME/.debug" -xdev -type d          ! -user "$SUDO_USER" -ls -exec chown    "$SUDO_USER" \{\} \;
-- 
2.20.1

