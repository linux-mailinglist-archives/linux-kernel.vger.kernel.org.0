Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651FCF37C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 20:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfKGTBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 14:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfKGTBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:01:20 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C9721D7B;
        Thu,  7 Nov 2019 19:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153280;
        bh=2JZHOoP9H0lcKnjrmlUQPDmqlsNuw+O77jPuqCd6DCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2AcMloVYre2RZiJ73gyHd497qErU9OpJ7kUcS2rpjSHF68oZ3Z2XMumXh1Mz0BkX8
         D8BQY1UPNy4xMOn3c+ChhraQ9KAalhYhMwbVNYBO+YqgASkYWQQN9ikCpll3rcpF6e
         ipaEGNLrHwc2o//PaQZIOLVhBK/olkBt1pkFgWMs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 07/63] perf llvm: Make .o saving a debug message, not an info one
Date:   Thu,  7 Nov 2019 15:59:15 -0300
Message-Id: <20191107190011.23924-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its a bit annoying to have that message, better make it a debug one.

I.e. now this message will only appear when using '-v':

  [root@quaco tracebuffer]# trace -e bristot.c
  LLVM: dumping bristot.o
  ^C[root@quaco tracebuffer]#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-o7jd4i7s66kosec5torubqps@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 8b14e4a7f1dc..eae47c2509eb 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -418,10 +418,9 @@ void llvm__dump_obj(const char *path, void *obj_buf, size_t size)
 		goto out;
 	}
 
-	pr_info("LLVM: dumping %s\n", obj_path);
+	pr_debug("LLVM: dumping %s\n", obj_path);
 	if (fwrite(obj_buf, size, 1, fp) != 1)
-		pr_warning("WARNING: failed to write to file '%s': %s, skip object dumping\n",
-			   obj_path, strerror(errno));
+		pr_debug("WARNING: failed to write to file '%s': %s, skip object dumping\n", obj_path, strerror(errno));
 	fclose(fp);
 out:
 	free(obj_path);
-- 
2.21.0

