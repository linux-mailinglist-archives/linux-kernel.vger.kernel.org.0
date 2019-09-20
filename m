Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B36B8AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 08:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437446AbfITGJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 02:09:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437368AbfITGJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:09:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F3ABCBA39476FF07B2C1;
        Fri, 20 Sep 2019 14:09:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:09:14 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>
Subject: [PATCH 32/32] checkpatch: Drop pr_warning check
Date:   Fri, 20 Sep 2019 14:25:44 +0800
Message-ID: <20190920062544.180997-33-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, all pr_warning are removed, delete pr_warning check in
checkpatch.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 scripts/checkpatch.pl | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..56d710274a15 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4098,15 +4098,6 @@ sub process {
 			     "Prefer [subsystem eg: netdev]_$level2([subsystem]dev, ... then dev_$level2(dev, ... then pr_$level(...  to printk(KERN_$orig ...\n" . $herecurr);
 		}
 
-		if ($line =~ /\bpr_warning\s*\(/) {
-			if (WARN("PREFER_PR_LEVEL",
-				 "Prefer pr_warn(... to pr_warning(...\n" . $herecurr) &&
-			    $fix) {
-				$fixed[$fixlinenr] =~
-				    s/\bpr_warning\b/pr_warn/;
-			}
-		}
-
 		if ($line =~ /\bdev_printk\s*\(\s*KERN_([A-Z]+)/) {
 			my $orig = $1;
 			my $level = lc($orig);
-- 
2.20.1

