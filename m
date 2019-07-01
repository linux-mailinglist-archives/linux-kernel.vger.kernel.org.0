Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4AB3657A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfFEUa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 16:30:27 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:58289 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEUa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:30:27 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hYcY5-0007fD-46 from George_Davis@mentor.com ; Wed, 05 Jun 2019 13:30:17 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 5 Jun
 2019 13:30:14 -0700
From:   "George G. Davis" <george_davis@mentor.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Jiri Kosina <trivial@kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "George G. Davis" <george_davis@mentor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ARM64: trivial: s/TIF_SECOMP/TIF_SECCOMP/ comment typo fix
Date:   Wed, 5 Jun 2019 16:30:09 -0400
Message-ID: <1559766612-12178-1-git-send-email-george_davis@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a s/TIF_SECOMP/TIF_SECCOMP/ comment typo

Cc: Jiri Kosina <trivial@kernel.org>
Signed-off-by: George G. Davis <george_davis@mentor.com>
---
 arch/arm64/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index eb3ef73e07cf..f1d032be628a 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -75,7 +75,7 @@ void arch_release_task_struct(struct task_struct *tsk);
  *  TIF_SYSCALL_TRACE	- syscall trace active
  *  TIF_SYSCALL_TRACEPOINT - syscall tracepoint for ftrace
  *  TIF_SYSCALL_AUDIT	- syscall auditing
- *  TIF_SECOMP		- syscall secure computing
+ *  TIF_SECCOMP		- syscall secure computing
  *  TIF_SIGPENDING	- signal pending
  *  TIF_NEED_RESCHED	- rescheduling necessary
  *  TIF_NOTIFY_RESUME	- callback before returning to user
-- 
2.7.4

