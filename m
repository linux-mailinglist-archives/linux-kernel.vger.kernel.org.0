Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD30A6C8D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 07:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfGRFnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 01:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfGRFnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:43:32 -0400
Received: from localhost.localdomain (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7AE02077C;
        Thu, 18 Jul 2019 05:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563428611;
        bh=gYp2Jk6FjA6u7NGwZZNab0rCjKuuYEFKcurXDzkIhwE=;
        h=From:To:Cc:Subject:Date:From;
        b=i8+x9a3I1RvHmXRr3SUKazCSVfaecwBSIoOOyiemH7yoHRKB3Xb9K823fNu85p0hu
         W2Gsyt7djBUsjiUTiu01xIg8L4NPOvUg38/WJf3Ygcm2XHoo14/A/WVFVah73KhZ2Z
         qU7k+O+JZNCsDbnvr2d/fZ7VB5kXkQHpBHLaw82I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
Subject: [PATCH 0/3] arm64: kprobes: Fix some bugs in arm64 kprobes 
Date:   Thu, 18 Jul 2019 14:43:26 +0900
Message-Id: <156342860634.8565.14804606041960884732.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the patches which fixes kprobe bugs on arm64.

Naresh reported that recently ftracetest crashes kernel, and I found
there are 3 different bugs around the crash.

- Kprobes on arm64 doesn't recover pstate.D mask even if probed
  context masks pstate.D. This causes a real kernel crash if a
  kprobe is nested.
- Some symbols which are called from blacklisted function, are not
  blacklisted.
- Debug exception handlers on arm64 is using rcu_read_lock(). This
  doesn't crashes kernel, but kicks suspicious RCU usage warning if
  we put kprobes on the function which is called in idle context.

This series includes fixes for above bugs.

Thank you,

---

Masami Hiramatsu (3):
      arm64: kprobes: Recover pstate.D in single-step exception handler
      arm64: unwind: Prohibit probing on return_address()
      arm64: debug: Remove rcu_read_lock from debug exception


 arch/arm64/kernel/debug-monitors.c |   14 ++++++++------
 arch/arm64/kernel/probes/kprobes.c |    9 ++++++---
 arch/arm64/kernel/return_address.c |    4 +++-
 arch/arm64/kernel/stacktrace.c     |    3 +++
 4 files changed, 20 insertions(+), 10 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
