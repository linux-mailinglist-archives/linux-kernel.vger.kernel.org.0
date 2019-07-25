Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAAC74895
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 09:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbfGYH7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 03:59:32 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:32844 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388335AbfGYH7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:59:32 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x6P7wYiA029514;
        Thu, 25 Jul 2019 16:58:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x6P7wYiA029514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564041516;
        bh=1v752PISwpeCj8Aze3ypEj8GmNP9DdapaFZfYxvN23U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GlymzVHYvuyGwQJuCUCEJrk+fjkK8HJCfV0vUWk2Wgn915j1qvTHsTI4VsuzdA/vP
         0Wm+rDvAnG3vKTrHlp8AmpGCIZK43dpof5CwlklRuTjfJhjUyuei7DoTGRY6kgWZ9K
         0WmImWu965GxnJaAtu2QENN7jAY0TADAa+9Rgf6Js4KCWjxOx1WA/ivpO6hNsHgsSt
         /j3o4VxyX2FaDmr94JXVoF/NIk/bcTsAVIwbksiwbMuDAfO6D14rATGu49QlS/q4jW
         2YFQShesNpMXgy1B+/nrVbBhBrtlSI+20z30aQc/AHb/iYi0NxvXPzRDvpw8unTZ2u
         ivunlwdIvtxMw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 3/3] iomap: fix Invalid License ID
Date:   Thu, 25 Jul 2019 16:58:33 +0900
Message-Id: <20190725075833.3481-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725075833.3481-1-yamada.masahiro@socionext.com>
References: <20190725075833.3481-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detected by:

  $ ./scripts/spdxcheck.py
  fs/iomap/Makefile: 1:27 Invalid License ID: GPL-2.0-or-newer

Fixes: 1c230208f53d ("iomap: start moving code to fs/iomap/")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - New patch

 fs/iomap/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 2d165388d952..93cd11938bf5 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-or-newer
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (c) 2019 Oracle.
 # All Rights Reserved.
-- 
2.17.1

