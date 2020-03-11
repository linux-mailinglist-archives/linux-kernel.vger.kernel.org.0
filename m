Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACDB1812C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 09:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgCKITn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 04:19:43 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:8618 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKITn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:19:43 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5e689f0a48a-78125; Wed, 11 Mar 2020 16:19:24 +0800 (CST)
X-RM-TRANSID: 2eec5e689f0a48a-78125
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55e689f0bd5a-c5a41;
        Wed, 11 Mar 2020 16:19:23 +0800 (CST)
X-RM-TRANSID: 2ee55e689f0bd5a-c5a41
From:   tangbin <tangbin@cmss.chinamobile.com>
To:     christian.brauner@ubuntu.com
Cc:     oleg@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] pid:fix a return value in alloc_pid
Date:   Wed, 11 Mar 2020 16:19:16 +0800
Message-Id: <1583914756-45674-1-git-send-email-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I doing a make about linux-next in X86 right now,it prompts a 
warning about "‘retval’ may be used uninitialized in this function
[-Wmaybe-uninitialized]". So I found that undefined 'retval' initially
in alloc_pid(),so the return ERR_PTR(retval) was an uncertain value.
Kmem_cache_alloc() is for sapce,so it will return ERR_PTR(-ENOMEM) if 
unsuccessful.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 kernel/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index ff6cd67..f214094 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -177,7 +177,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 	pid = kmem_cache_alloc(ns->pid_cachep, GFP_KERNEL);
 	if (!pid)
-		return ERR_PTR(retval);
+		return ERR_PTR(-ENOMEM);
 
 	tmp = ns;
 	pid->level = ns->level;
-- 
2.7.4



