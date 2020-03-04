Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC75179072
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 13:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbgCDMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 07:33:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:44966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387776AbgCDMdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:33:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7AE1EB2BB;
        Wed,  4 Mar 2020 12:33:02 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] x86/unwind/orc: Do not skip the first frame unless explicitly asked for
Date:   Wed,  4 Mar 2020 13:32:59 +0100
Message-Id: <20200304123259.32199-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ORC unwinder can currently skip the first frame even if a user does not
ask for it. If both regs and first_frame parameters of unwind_start()
are set to NULL, state->sp and first_frame are later initialized to the
same value for an inactive task. Given there is "less than or equal to"
comparison used at the end of __unwind_start() for skipping stack frames,
the first frame is always skipped in this case.

Drop the equal part of the comparison and make it equivalent to the
frame pointer unwinder.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index e9cc182aa97e..8452518cc20a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -651,7 +651,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	/* Otherwise, skip ahead to the user-specified starting frame: */
 	while (!unwind_done(state) &&
 	       (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
-			state->sp <= (unsigned long)first_frame))
+			state->sp < (unsigned long)first_frame))
 		unwind_next_frame(state);
 
 	return;
-- 
2.25.1

