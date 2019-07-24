Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427A272729
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 07:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfGXFIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 01:08:48 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:56680 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfGXFIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:08:48 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d09 with ME
        id gV8l200024n7eLC03V8lCw; Wed, 24 Jul 2019 07:08:46 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Jul 2019 07:08:46 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bsingharora@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] taskstats: Fix a typo - taskstsats --> taskstats
Date:   Wed, 24 Jul 2019 07:07:51 +0200
Message-Id: <20190724050751.30170-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an extra 's' in 'taskstsats', remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 kernel/taskstats.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 13a0f2e6ebc2..30578b139d16 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -163,7 +163,7 @@ static void fill_stats(struct user_namespace *user_ns,
 	memset(stats, 0, sizeof(*stats));
 	/*
 	 * Each accounting subsystem adds calls to its functions to
-	 * fill in relevant parts of struct taskstsats as follows
+	 * fill in relevant parts of struct taskstats as follows
 	 *
 	 *	per-task-foo(stats, tsk);
 	 */
@@ -222,7 +222,7 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 			continue;
 		/*
 		 * Accounting subsystem can call its functions here to
-		 * fill in relevant parts of struct taskstsats as follows
+		 * fill in relevant parts of struct taskstats as follows
 		 *
 		 *	per-task-foo(stats, tsk);
 		 */
-- 
2.20.1

