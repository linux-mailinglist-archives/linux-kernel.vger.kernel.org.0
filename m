Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2A786ADF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 21:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404602AbfHHTxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 15:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404493AbfHHTxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:21 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4071D218BA;
        Thu,  8 Aug 2019 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565294001;
        bh=uzqc82uL7ogPgfU3mLq02OpcxdL1zrJ3Wa79m/7CGeM=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=bU4bv4chKeLbwypjLEWS5KvWXiBncOS7Dn7FvnirNJUp8mXqoxpKoHGvp1MK/sM4r
         vevO0TAAFPf2b+d7XWAJT3PtGAVjoDl4ym+7f7BXmWNYiQHd4fzBFRagIFp0rd76Aq
         lDxAfy2yDe4OsuvhtGP+MsdMmbiJfMQfTh4aDHbI=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 12/19] Revert "futex: Ensure lock/unlock symetry versus pi_lock and hash bucket lock"
Date:   Thu,  8 Aug 2019 14:52:40 -0500
Message-Id: <0b6569b5ad6a4b31289a9f62f40f86a67a151115.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 6a773b70cf105b46298ed3b44e77c102ce31d9ec ]

Drop the RT fixup, the futex code will be changed to avoid the need for
the workaround.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/futex.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index ad0abb0e339f..07b148ad703a 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -936,9 +936,7 @@ void exit_pi_state_list(struct task_struct *curr)
 		if (head->next != next) {
 			/* retain curr->pi_lock for the loop invariant */
 			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
-			raw_spin_unlock_irq(&curr->pi_lock);
 			spin_unlock(&hb->lock);
-			raw_spin_lock_irq(&curr->pi_lock);
 			put_pi_state(pi_state);
 			continue;
 		}
-- 
2.14.1

