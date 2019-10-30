Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D0CE9515
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 03:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfJ3Cvv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Oct 2019 22:51:51 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:6708 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfJ3Cvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 22:51:50 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id CF8FBEED7FEA4ED64C6A;
        Wed, 30 Oct 2019 10:51:48 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x9U2pZDb074519;
        Wed, 30 Oct 2019 10:51:35 +0800 (GMT-8)
        (envelope-from zhong.shiqi@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019103010515442-192490 ;
          Wed, 30 Oct 2019 10:51:54 +0800 
From:   zhongshiqi <zhong.shiqi@zte.com.cn>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn,
        zhongshiqi <zhong.shiqi@zte.com.cn>
Subject: [PATCH v5] coccicheck: Support search for SmPL scripts within selected directory hierarchy
Date:   Wed, 30 Oct 2019 10:54:30 +0800
Message-Id: <1572404070-41580-1-git-send-email-zhong.shiqi@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-10-30 10:51:54,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-30 10:51:38
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl2.zte.com.cn x9U2pZDb074519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*Allow defining the environment variable “COCCI” as a directory to search
SmPL scripts.

*Start a corresponding file determination if it contains an acceptable
path.

Signed-off-by: zhongshiqi <zhong.shiqi@zte.com.cn>
---
Changes in v5:
	1:rewrite change description as an enumeration

Changes in v4:
	1:rewrite change description in another wording

Changes in v3:
	1:rewrite change description
	2:fix patch subject
	3:modify commit log

Changes in v2:
	1.fix patch subject according to the reply by Markus
	<Markus.Elfring@web.de>
	2.change description in “imperative mood”
 
 scripts/coccicheck | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328..a1c4197 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -257,6 +257,10 @@ if [ "$COCCI" = "" ] ; then
     for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
 	coccinelle $f
     done
+elif [ -d "$COCCI" ] ; then
+    for f in `find $COCCI/ -name '*.cocci' -type f | sort`; do
+	coccinelle $f
+    done
 else
     coccinelle $COCCI
 fi
-- 
2.9.5

