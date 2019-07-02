Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A045C7EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 05:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfGBDnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 23:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfGBDnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:43:24 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85A882146F;
        Tue,  2 Jul 2019 03:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562039003;
        bh=GI6ro7Nu3o6bB6TVX0IWB7UAbyym6bHooL49aoT6EtA=;
        h=From:To:Cc:Subject:Date:From;
        b=wkvH+CXlwlOD04eYycPV3k5MMeoKcqFQ5CtPEtWzGTpskEJjg9CZAtpS6Nlqroi0f
         XQMCCg+EXhmUJpbO2xrid/4PhQsP4zoVGpk2c2lIK7uSuo8m+rF91YURfDWMcUEpka
         +5yqv58mNvpLPIU3vOOe71OP8dKCs7Adl7KUEsds=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/3] FSGSBASE fix, test, and a semi-related cleanup
Date:   Mon,  1 Jul 2019 20:43:18 -0700
Message-Id: <cover.1562035429.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In -tip, if FSGSBASE and PTI are on, the kernel crashes if SYSENTER
happens with TF set.  It also crashes under if a non-NMI paranoid
entry happens for any other reason from kernel mode with user GSBASE
and user CR3, e.g. due to MOV SS shenanigans.

This series fixes the bug.  It also adds another test to make sure
we exercise SYSENTER with TF set regardless of what vendor's CPU
we're on, although the test isn't needed to detect the bug: the
single_step_syscall_32 and mov_ss_trap_* tests also trigger it.  And
it compiles ignore_sysret out on IA32_EMULATION kernels -- I wasted
a couple minutes while debugging this wondering whether I was
accidentally triggering ignore_sysret.

Andy Lutomirski (3):
  selftests/x86: Test SYSCALL and SYSENTER manually with TF set
  x86/entry/64: Don't compile ignore_sysret if 32-bit emulation is
    enabled
  x86/entry/64: Fix and clean up paranoid_exit

 arch/x86/entry/entry_64.S                     |  39 +++---
 tools/testing/selftests/x86/Makefile          |   5 +-
 .../testing/selftests/x86/syscall_arg_fault.c | 112 +++++++++++++++++-
 3 files changed, 133 insertions(+), 23 deletions(-)

-- 
2.21.0

