Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80D6130662
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 08:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgAEHCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 02:02:09 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:34890 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAEHCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:02:09 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 00570Vd5025147;
        Sun, 5 Jan 2020 16:00:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 00570Vd5025147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578207632;
        bh=aQWA9Wh+CP+a7XG9Z34xhxqGyAotNfwR+iGU1r9t/jE=;
        h=From:To:Cc:Subject:Date:From;
        b=wSbSvN2j+w1+6m9KA5SJxkopWYj2dDvR+iI9lH5mdREdTUiQrswh5Y7n8Whgnr7q1
         +64XQTbV7gVU29uijD8KklSBlxdWEZLBub4dykx2ymdILxg2Sv7E5BXjHCyl0t3jJ9
         jzs5B9SDzb2+aDrTeZ9R700Vd3lnbGfQPztn6OmESEhs535UjTAxN1P6DeP2lLX3iN
         P3jfnacjqtomoQWVKspINuWYdsjGyPsMJLBh6hpCtTFB1KRhpv5Au0OqU9FXLGn9Xg
         t/avrQUxR4mtxXeWgfNAY3Jun0BI+g2lKs8Kw8wKU4Fe7XJCWat0A3OcaN78CS80uM
         6HCBKnu/E88ZQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: remove unneeded header include path in fs/ocfs2/Makefile
Date:   Sun,  5 Jan 2020 16:00:23 +0900
Message-Id: <20200105070023.27806-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can build fs/ocfs2 without this.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 fs/ocfs2/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ocfs2/Makefile b/fs/ocfs2/Makefile
index cc9b32b9db7c..46381d9dd890 100644
--- a/fs/ocfs2/Makefile
+++ b/fs/ocfs2/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -I$(src)
 
 obj-$(CONFIG_OCFS2_FS) += 	\
 	ocfs2.o			\
-- 
2.17.1

