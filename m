Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6B12B5E9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 17:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfL0QgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Dec 2019 11:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0QgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 11:36:20 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F2B1208C4;
        Fri, 27 Dec 2019 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577464579;
        bh=saOyowJ7uyY9gUuA6lkNUqoCxJUMqAWkV+VrH02LNAw=;
        h=From:To:Cc:Subject:Date:From;
        b=Wa3bfY+Gsu9wIHH2naA7mjTeUGL36HKsu1ayiq7zYYeHa9GBX7+y4ADhJAoxCSK1T
         YtZ/+r2PlMhx/578rf84OpGHQ4kNTcpe+CF1QrGHvfyhboLqu2r2rpyLQxCLuVhQBy
         T4GnwdqEv3J94Zch5nJUpHwGkXinrA2pw4qjTOZ0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 0/2] x86/context-tracking: Remove last remaining calls to exception_enter/exception_exit()
Date:   Fri, 27 Dec 2019 17:36:10 +0100
Message-Id: <20191227163612.10039-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the cleanups from Andy Lutomirski over the years, those calls
can now be removed. This will allow for nice things in the future for
x86 support on full nohz:

* Remove TIF_NOHZ and use a per-cpu switch to enable, disable context
  tracking.

* Avoid context tracking on housekeepers.

* Dynamically enable/disable context tracking on CPU on runtime and
  therefore allow runtime enable/disable of nohz_full

* Make nohz_full a property of cpuset.

Frederic Weisbecker (2):
  x86/context-tracking: Remove exception_enter/exit() from
    do_page_fault()
  x86/context-tracking: Remove exception_enter/exit() from
    KVM_PV_REASON_PAGE_NOT_PRESENT async page fault

 arch/x86/kernel/kvm.c |  4 ----
 arch/x86/mm/fault.c   | 39 ++++++++++++---------------------------
 2 files changed, 12 insertions(+), 31 deletions(-)

-- 
2.23.0

