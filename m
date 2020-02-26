Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E96516F6CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 06:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgBZFJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 00:09:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBZFJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=16jLXRFb0IZeEa6+N/G2JG9W3hVbNP5LpxYQtuzcMqI=; b=YCBvLCcrQQ5EEkpkh89tqhjfVu
        EjXzyCcZvM0T+3Ph2IwN+Cmoj4ckRd+ID/mfQZgl+tZREeFBNydSK7ru5VrK5G1JMJDUsez41dHFz
        f3dC+aoZVnVrWsAV3R/qyblhEjN3b3MM1P9x1W1x6OeAh/MFB5w9SZ6XoBYIqzLYuX/CIwpCfp22q
        wlvi2D5Zya8PH1k2DSbTV6U98YFtqBRFFC9LJlVcFHk6CDdhgZaj4PnrD5k0DwKmlnfqORiU9P0lj
        +4MjVJNCTQq1IePpr9sESMhJL1oU8yU1XuZXafJUlWYdPpS+Xk1ZcsvuKJ2UPPALCbAnFCkYWLPIg
        rQix+XMA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6owi-0001PD-Pj; Wed, 26 Feb 2020 05:09:20 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] locktorture.c: fix if-statement empty body warnings
Message-ID: <06d89556-777e-ba59-1d55-12f11cba9668@infradead.org>
Date:   Tue, 25 Feb 2020 21:09:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

When using -Wextra, gcc complains about torture_preempt_schedule()
when its definition is empty (i.e., when CONFIG_PREEMPTION is not
set/enabled).  Fix these warnings by adding an empty do-while block
for that macro when CONFIG_PREEMPTION is not set.
Fixes these build warnings:

../kernel/locking/locktorture.c:119:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:166:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:337:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:490:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:528:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../kernel/locking/locktorture.c:553:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

I have verified that there is no object code change (with gcc 7.5.0).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
---
 include/linux/torture.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200225.orig/include/linux/torture.h
+++ linux-next-20200225/include/linux/torture.h
@@ -89,7 +89,7 @@ void _torture_stop_kthread(char *m, stru
 #ifdef CONFIG_PREEMPTION
 #define torture_preempt_schedule() preempt_schedule()
 #else
-#define torture_preempt_schedule()
+#define torture_preempt_schedule()	do { } while (0)
 #endif
 
 #endif /* __LINUX_TORTURE_H */

