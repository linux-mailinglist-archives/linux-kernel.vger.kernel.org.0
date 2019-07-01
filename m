Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB12CE4D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 16:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfD2Oe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 10:34:26 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:27271 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2Oe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:34:26 -0400
Received: from grover.flets-west.jp (softbank126125154137.bbtec.net [126.125.154.137]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x3TEXjjC012152;
        Mon, 29 Apr 2019 23:33:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x3TEXjjC012152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556548426;
        bh=cDqhU/A9vJe3r9Ss7WsLxReyOUJCpxBYz1D7OJq2QZM=;
        h=From:To:Cc:Subject:Date:From;
        b=syq03RArj/bHdyU2TkPL22nwUZhjgdGLAMz9o/HKs/MwA11sUi9sQ2wKHHeHps9sC
         KsL2JoXeFd1tNPBInLQinw+QFbJccD7YeWsHutBpkw5+yPhJP8ibqtvsQB55O1k3Nx
         6HDC4OKdqvS8KAwa2pLBTMrOuRf9ujnTVN0dl7NZBn8B/QTti7tkBtyDfyh0N+6V2M
         LNkIApe36IAJOk+v/pNOxpG7v4r1xFkTXFOxFE9lQoEGA8laIqSVKj6AThlBTyRnRW
         28BV/nH/gIFYerUAYZLHUUDlCF1rrH23yF0XTvWHUJRS6ciTVTciymXGZh85bgjGNc
         fmefgiB+OfznA==
X-Nifty-SrcIP: [126.125.154.137]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: exclude vmlinux.scr from .gitignore pattern
Date:   Mon, 29 Apr 2019 23:33:11 +0900
Message-Id: <1556548391-14520-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/sh/boot/.gitignore has the pattern "vmlinux*"; this is effective
not only for the current directory, but also for any sub-directories.

So, the following files are also considered to be ignored:

  arch/sh/boot/compressed/vmlinux.scr
  arch/sh/boot/romimage/vmlinux.scr

They are obviously version-controlled, so should be excluded from the
.gitignore pattern.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sh/boot/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boot/.gitignore b/arch/sh/boot/.gitignore
index 541087d..f50fdd9 100644
--- a/arch/sh/boot/.gitignore
+++ b/arch/sh/boot/.gitignore
@@ -1,3 +1,4 @@
 zImage
 vmlinux*
 uImage*
+!vmlinux.scr
-- 
2.7.4

