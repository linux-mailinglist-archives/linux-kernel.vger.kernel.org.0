Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAD46C458
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 03:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbfGRBhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 21:37:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731985AbfGRBhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:37:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95051300CB05;
        Thu, 18 Jul 2019 01:37:12 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-211.rdu2.redhat.com [10.10.122.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F08D5D9CC;
        Thu, 18 Jul 2019 01:37:11 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 03/22] x86/kvm: Replace vmx_vmenter()'s call to kvm_spurious_fault() with UD2
Date:   Wed, 17 Jul 2019 20:36:38 -0500
Message-Id: <9fc2216c9dc972f95bb65ce2966a682c6bda1cb0.1563413318.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563413318.git.jpoimboe@redhat.com>
References: <cover.1563413318.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 18 Jul 2019 01:37:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool reports the following:

  arch/x86/kvm/vmx/vmenter.o: warning: objtool: vmx_vmenter()+0x14: call without frame pointer save/setup

But frame pointers are necessarily broken anyway, because
__vmx_vcpu_run() clobbers RBP with the guest's value before calling
vmx_vmenter().  So calling without a frame pointer doesn't make things
any worse.

Make objtool happy by changing the call to a UD2.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
v2: ud2 instead of kvm_spurious_fault() [Paolo]

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
---
 arch/x86/kvm/vmx/vmenter.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index d4cb1945b2e3..4010d519eb8c 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -54,9 +54,9 @@ ENTRY(vmx_vmenter)
 	ret
 
 3:	cmpb $0, kvm_rebooting
-	jne 4f
-	call kvm_spurious_fault
-4:	ret
+	je 4f
+	ret
+4:	ud2
 
 	.pushsection .fixup, "ax"
 5:	jmp 3b
-- 
2.20.1

