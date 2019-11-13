Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5EFACF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 10:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKMJaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 04:30:14 -0500
Received: from relay.sw.ru ([185.231.240.75]:39206 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfKMJaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:30:13 -0500
Received: from finist_cl7.qa.sw.ru ([10.94.4.83] helo=finist-ce7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1iUoyF-00062s-7g; Wed, 13 Nov 2019 12:29:51 +0300
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Jessica Yu <jeyu@kernel.org>, Prarit Bhargava <prarit@redhat.com>,
        Barret Rhoden <brho@google.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, David Arcari <darcari@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 1/1] kernel/module.c: wakeup processes in module_wq on module unload
Date:   Wed, 13 Nov 2019 12:29:50 +0300
Message-Id: <20191113092950.15556-2-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20191113092950.15556-1-khorenko@virtuozzo.com>
References: <20191113092950.15556-1-khorenko@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the race between load and unload a kernel module.

sys_delete_module()
 try_stop_module()
  mod->state = _GOING
					add_unformed_module()
					 old = find_module_all()
					 (old->state == _GOING =>
					  wait_event_interruptible())

					 During pre-condition
					 finished_loading() rets 0
					 schedule()
					 (never gets waken up later)
 free_module()
  mod->state = _UNFORMED
   list_del_rcu(&mod->list)
   (dels mod from "modules" list)

return

The race above leads to modprobe hanging forever on loading
a module.

Error paths on loading module call wake_up_all(&module_wq) after
freeing module, so let's do the same on straight module unload.

Fixes: 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
for modules that have finished loading")

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 kernel/module.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index ff2d7359a418..cb09a5f37a5f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1033,6 +1033,8 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
 
 	free_module(mod);
+	/* someone could wait for the module in add_unformed_module() */
+	wake_up_all(&module_wq);
 	return 0;
 out:
 	mutex_unlock(&module_mutex);
-- 
2.15.1

