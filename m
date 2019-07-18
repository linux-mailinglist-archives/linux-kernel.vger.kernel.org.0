Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EECE6D46C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 21:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391101AbfGRTJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 15:09:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfGRTJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:09:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJ9hG02124074
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:09:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJ9hG02124074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563476984;
        bh=To9WIY20quf06MwsFzLKBDzJpHII9kTOHnXwYc1Gj0U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ay7gO8rNSoCJxRNF6Sz0Kd6wObcRcGDz+HfRd5GaTch4703BDFz+ydH94X2uxZy4h
         Nw1OP8G/96hG1NASos/OaWBlpJsecK7Fy0BylR69XFJ4jZwdN93S2NqkP82Kyjtllp
         25uQymJYIkoTGImX95WZqSrXR8GG9A9KXXeIxoSUA6Ru+sJt+0II6mmDqUKlaZBSpr
         1Pd4gfuj+pzpZ9W9mTeviUDr6X1X9itoNOTL7jNCP16kpnHghSUMMb+0ZXqokNv7KF
         9YYGGf+1O2vVNTnN//jS8qnPskUx4ayRzA/OE35OKo9BVnekFPNBrBsIcCBCI1ekn4
         2OabhdQ+QbVdQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJ9ggV2124069;
        Thu, 18 Jul 2019 12:09:42 -0700
Date:   Thu, 18 Jul 2019 12:09:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-3901336ed9887b075531bffaeef7742ba614058b@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, hpa@zytor.com
Reply-To: peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
          jpoimboe@redhat.com, pbonzini@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <64a9b64d127e87b6920a97afde8e96ea76f6524e.1563413318.git.jpoimboe@redhat.com>
References: <64a9b64d127e87b6920a97afde8e96ea76f6524e.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] x86/kvm: Don't call kvm_spurious_fault() from
 .fixup
Git-Commit-ID: 3901336ed9887b075531bffaeef7742ba614058b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_48_96,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3901336ed9887b075531bffaeef7742ba614058b
Gitweb:     https://git.kernel.org/tip/3901336ed9887b075531bffaeef7742ba614058b
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:39 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:04 +0200

x86/kvm: Don't call kvm_spurious_fault() from .fixup

After making a change to improve objtool's sibling call detection, it
started showing the following warning:

  arch/x86/kvm/vmx/nested.o: warning: objtool: .fixup+0x15: sibling call from callable instruction with modified stack frame

The problem is the ____kvm_handle_fault_on_reboot() macro.  It does a
fake call by pushing a fake RIP and doing a jump.  That tricks the
unwinder into printing the function which triggered the exception,
rather than the .fixup code.

Instead of the hack to make it look like the original function made the
call, just change the macro so that the original function actually does
make the call.  This allows removal of the hack, and also makes objtool
happy.

I triggered a vmx instruction exception and verified that the stack
trace is still sane:

  kernel BUG at arch/x86/kvm/x86.c:358!
  invalid opcode: 0000 [#1] SMP PTI
  CPU: 28 PID: 4096 Comm: qemu-kvm Not tainted 5.2.0+ #16
  Hardware name: Lenovo THINKSYSTEM SD530 -[7X2106Z000]-/-[7X2106Z000]-, BIOS -[TEE113Z-1.00]- 07/17/2017
  RIP: 0010:kvm_spurious_fault+0x5/0x10
  Code: 00 00 00 00 00 8b 44 24 10 89 d2 45 89 c9 48 89 44 24 10 8b 44 24 08 48 89 44 24 08 e9 d4 40 22 00 0f 1f 40 00 0f 1f 44 00 00 <0f> 0b 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 55 49 89 fd 41
  RSP: 0018:ffffbf91c683bd00 EFLAGS: 00010246
  RAX: 000061f040000000 RBX: ffff9e159c77bba0 RCX: ffff9e15a5c87000
  RDX: 0000000665c87000 RSI: ffff9e15a5c87000 RDI: ffff9e159c77bba0
  RBP: 0000000000000000 R08: 0000000000000000 R09: ffff9e15a5c87000
  R10: 0000000000000000 R11: fffff8f2d99721c0 R12: ffff9e159c77bba0
  R13: ffffbf91c671d960 R14: ffff9e159c778000 R15: 0000000000000000
  FS:  00007fa341cbe700(0000) GS:ffff9e15b7400000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fdd38356804 CR3: 00000006759de003 CR4: 00000000007606e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
   loaded_vmcs_init+0x4f/0xe0
   alloc_loaded_vmcs+0x38/0xd0
   vmx_create_vcpu+0xf7/0x600
   kvm_vm_ioctl+0x5e9/0x980
   ? __switch_to_asm+0x40/0x70
   ? __switch_to_asm+0x34/0x70
   ? __switch_to_asm+0x40/0x70
   ? __switch_to_asm+0x34/0x70
   ? free_one_page+0x13f/0x4e0
   do_vfs_ioctl+0xa4/0x630
   ksys_ioctl+0x60/0x90
   __x64_sys_ioctl+0x16/0x20
   do_syscall_64+0x55/0x1c0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x7fa349b1ee5b

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/64a9b64d127e87b6920a97afde8e96ea76f6524e.1563413318.git.jpoimboe@redhat.com

---
 arch/x86/include/asm/kvm_host.h | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0cc5b611a113..8282b8d41209 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1496,25 +1496,29 @@ enum {
 #define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
 #define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
 
+asmlinkage void __noreturn kvm_spurious_fault(void);
+
 /*
  * Hardware virtualization extension instructions may fault if a
  * reboot turns off virtualization while processes are running.
- * Trap the fault and ignore the instruction if that happens.
+ * Usually after catching the fault we just panic; during reboot
+ * instead the instruction is ignored.
  */
-asmlinkage void kvm_spurious_fault(void);
-
-#define ____kvm_handle_fault_on_reboot(insn, cleanup_insn)	\
-	"666: " insn "\n\t" \
-	"668: \n\t"                           \
-	".pushsection .fixup, \"ax\" \n" \
-	"667: \n\t" \
-	cleanup_insn "\n\t"		      \
-	"cmpb $0, kvm_rebooting \n\t"	      \
-	"jne 668b \n\t"      		      \
-	__ASM_SIZE(push) " $666b \n\t"	      \
-	"jmp kvm_spurious_fault \n\t"	      \
-	".popsection \n\t" \
-	_ASM_EXTABLE(666b, 667b)
+#define ____kvm_handle_fault_on_reboot(insn, cleanup_insn)		\
+	"666: \n\t"							\
+	insn "\n\t"							\
+	"jmp	668f \n\t"						\
+	"667: \n\t"							\
+	"call	kvm_spurious_fault \n\t"				\
+	"668: \n\t"							\
+	".pushsection .fixup, \"ax\" \n\t"				\
+	"700: \n\t"							\
+	cleanup_insn "\n\t"						\
+	"cmpb	$0, kvm_rebooting\n\t"					\
+	"je	667b \n\t"						\
+	"jmp	668b \n\t"						\
+	".popsection \n\t"						\
+	_ASM_EXTABLE(666b, 700b)
 
 #define __kvm_handle_fault_on_reboot(insn)		\
 	____kvm_handle_fault_on_reboot(insn, "")
