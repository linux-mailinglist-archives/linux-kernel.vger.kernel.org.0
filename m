Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9815C207
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 19:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfGARd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 13:33:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfGARd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:33:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hi0Be-0005Or-7t; Mon, 01 Jul 2019 19:33:54 +0200
Date:   Mon, 1 Jul 2019 19:33:54 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH] x86/ldt: Initialize the context lock for init_mm
Message-ID: <20190701173354.2pe62hhliok2afea@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mutex mm->context->lock for init_mm is not initialized for init_mm.
This wasn't a problem because it remained unused. This changed however
since commit
	4fc19708b165c ("x86/alternatives: Initialize temporary mm for patching")

Initialize the mutex for init_mm.

Fixes: 4fc19708b165c ("x86/alternatives: Initialize temporary mm for patching")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

The rwsem `ldt_usr_sem' is also not initialized for init_mm. No idea if
we want this.

 arch/x86/include/asm/mmu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5ff3e8af2c205..e78c7db878018 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -59,6 +59,7 @@ typedef struct {
 #define INIT_MM_CONTEXT(mm)						\
 	.context = {							\
 		.ctx_id = 1,						\
+		.lock = __MUTEX_INITIALIZER(mm.context.lock),		\
 	}
 
 void leave_mm(int cpu);
-- 
2.20.1

