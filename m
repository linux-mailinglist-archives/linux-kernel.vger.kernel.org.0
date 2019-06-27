Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36C957AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 06:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfF0EpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 00:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0EpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:45:12 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B4421726;
        Thu, 27 Jun 2019 04:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561610711;
        bh=I8RajpbaAK+4wyrZn0EPAIrA0weDhNAvvH0B13QKyUA=;
        h=From:To:Cc:Subject:Date:From;
        b=wfhQDHKUvjUML7fCCCmdSXt+UDqj9FwwR1gZVAW3p+8nvTsUklt0aecCbDXfRI4Ry
         kVjXeo3pFcraqZnYFumADELrOC3R0s6a+MYAg5i9G6Y3N8syJmM9fPacvJK8BD0jlH
         BkwLFIgQ2bksfLaItLrxhyvXWbK9BTTzC+/7uxE0=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 0/8] vsyscall xonly mode
Date:   Wed, 26 Jun 2019 21:45:01 -0700
Message-Id: <cover.1561610354.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

This adds a new "xonly" mode for vsyscalls and makes it the default.
xonly is a bit more secure -- Kees knows about an exploit that relied on
read access to the vsyscall page.  It's also nicer from a paging
perspective, as it doesn't require user access to any of the kernel
address space as far as the CPU is concerned.  This would, for example,
allow a much simpler implementation of per-process vsyscall disabling.

I will follow up with two non-x86 changes that are related but have
no dependencies.

Changes from v1:
 - Minor cleanups (Kees)
 - Add a searchable message when a vsyscall read is denied (Kees)
 - The test case is vastly improved
 - Get rid of the extra gate vma object
 - Add the __ro_after_init patch

Andy Lutomirski (8):
  x86/vsyscall: Remove the vsyscall=native documentation
  x86/vsyscall: Add a new vsyscall=xonly mode
  x86/vsyscall: Show something useful on a read fault
  x86/vsyscall: Document odd SIGSEGV error code for vsyscalls
  selftests/x86/vsyscall: Verify that vsyscall=none blocks execution
  x86/vsyscall: Change the default vsyscall mode to xonly
  x86/vsyscall: Add __ro_after_init to global variables
  selftests/x86: Add a test for process_vm_readv() on the vsyscall page

 .../admin-guide/kernel-parameters.txt         |  11 +-
 arch/x86/Kconfig                              |  35 +++--
 arch/x86/entry/vsyscall/vsyscall_64.c         |  37 +++++-
 arch/x86/include/asm/vsyscall.h               |   6 +-
 arch/x86/mm/fault.c                           |  18 ++-
 tools/testing/selftests/x86/test_vsyscall.c   | 120 ++++++++++++++----
 6 files changed, 174 insertions(+), 53 deletions(-)

-- 
2.21.0

