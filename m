Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68AC87F4C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 12:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391709AbfHBKKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 06:10:07 -0400
Received: from foss.arm.com ([217.140.110.172]:48812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfHBKKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:10:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A1FA344;
        Fri,  2 Aug 2019 03:10:06 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 107B73F71F;
        Fri,  2 Aug 2019 03:10:04 -0700 (PDT)
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH 0/6] Rework REFCOUNT_FULL using atomic_fetch_* operations
Date:   Fri,  2 Aug 2019 11:09:54 +0100
Message-Id: <20190802101000.12958-1-will@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series reworks the generic REFCOUNT_FULL implementation using
atomic_fetch_* operations so that the performance impact of the cmpxchg()
loops is mitigated for common refcount operations. The algorithm was
heavily inspired by Ard's assembly implementation for arm64:

  http://lkml.kernel.org/r/20190619105431.2630-1-ard.biesheuvel@linaro.org

but I figured we could achieve something similar using atomics in generic
code.

Although the revised implementation passes all of the lkdtm REFCOUNT
tests, there is a race condition introduced by the deferred saturation
whereby if INT_MIN + 2 tasks take a reference on a refcount at
REFCOUNT_MAX and are each preempted between detecting overflow and
writing the saturated value without being rescheduled, then another task
may end up erroneously freeing the object when it drops the refcount and
sees zero. It doesn't feel like a particularly realistic case to me, but
I thought I should mention it in case somebody else knows better.

Will

Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Jan Glauber <jglauber@marvell.com>

--->8

Will Deacon (6):
  lib/refcount: Define constants for saturation and max refcount values
  lib/refcount: Ensure integer operands are treated as signed
  lib/refcount: Remove unused refcount_*_checked() variants
  lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
  lib/refcount: Improve performance of generic REFCOUNT_FULL code
  lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions

 drivers/misc/lkdtm/refcount.c |   8 --
 include/linux/refcount.h      | 236 +++++++++++++++++++++++++++++++++++++----
 lib/refcount.c                | 238 +-----------------------------------------
 3 files changed, 219 insertions(+), 263 deletions(-)

-- 
2.11.0

