Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69E180F42
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 06:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgCKFHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 01:07:18 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:47984 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728214AbgCKFHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:07:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 76A3B18063C8E;
        Wed, 11 Mar 2020 05:07:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:967:969:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1543:1711:1730:1747:1777:1792:2196:2199:2393:2525:2560:2563:2682:2685:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3865:3866:3867:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6119:6261:7903:9025:9036:10004:10848:11026:11473:11657:11658:11914:12043:12296:12297:12438:12555:12679:12895:12986:13255:13894:14096:14181:14394:14721:21080:21433:21627:21811:21939:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: trade07_221c65ba4ee3b
X-Filterd-Recvd-Size: 4145
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:14 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 016/491] KERNEL VIRTUAL MACHINE FOR POWERPC (KVM/powerpc): Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:30 -0700
Message-Id: <37a5342c67e1b68b9ad06aca8da245b0ff409692.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kvm/book3s_32_mmu.c | 2 +-
 arch/powerpc/kvm/book3s_64_mmu.c | 2 +-
 arch/powerpc/kvm/book3s_pr.c     | 2 +-
 arch/powerpc/kvm/booke.c         | 6 +++---
 arch/powerpc/kvm/powerpc.c       | 1 -
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index f21e734..3fbd57 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -234,7 +234,7 @@ static int kvmppc_mmu_book3s_32_xlate_pte(struct kvm_vcpu *vcpu, gva_t eaddr,
 				case 2:
 				case 6:
 					pte->may_write = true;
-					/* fall through */
+					fallthrough;
 				case 3:
 				case 5:
 				case 7:
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 5991332..26b8b2 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -311,7 +311,7 @@ static int kvmppc_mmu_book3s_64_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	case 2:
 	case 6:
 		gpte->may_write = true;
-		/* fall through */
+		fallthrough;
 	case 3:
 	case 5:
 	case 7:
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 729a0f..7db3695 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -740,7 +740,7 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		    (vcpu->arch.hflags & BOOK3S_HFLAG_SPLIT_HACK) &&
 		    ((pte.raddr & SPLIT_HACK_MASK) == SPLIT_HACK_OFFS))
 			pte.raddr &= ~SPLIT_HACK_MASK;
-		/* fall through */
+		fallthrough;
 	case MSR_IR:
 		vcpu->arch.mmu.esid_to_vsid(vcpu, eaddr >> SID_SHIFT, &vsid);
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 7b27604..be47815 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -421,11 +421,11 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	case BOOKE_IRQPRIO_DATA_STORAGE:
 	case BOOKE_IRQPRIO_ALIGNMENT:
 		update_dear = true;
-		/* fall through */
+		fallthrough;
 	case BOOKE_IRQPRIO_INST_STORAGE:
 	case BOOKE_IRQPRIO_PROGRAM:
 		update_esr = true;
-		/* fall through */
+		fallthrough;
 	case BOOKE_IRQPRIO_ITLB_MISS:
 	case BOOKE_IRQPRIO_SYSCALL:
 	case BOOKE_IRQPRIO_FP_UNAVAIL:
@@ -459,7 +459,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	case BOOKE_IRQPRIO_DECREMENTER:
 	case BOOKE_IRQPRIO_FIT:
 		keep_irq = true;
-		/* fall through */
+		fallthrough;
 	case BOOKE_IRQPRIO_EXTERNAL:
 	case BOOKE_IRQPRIO_DBELL:
 		allowed = vcpu->arch.shared->msr & MSR_EE;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1af96fb5..c242a79 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -525,7 +525,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = 1;
 		break;
 	case KVM_CAP_PPC_GUEST_DEBUG_SSTEP:
-		/* fall through */
 	case KVM_CAP_PPC_PAIRED_SINGLES:
 	case KVM_CAP_PPC_OSI:
 	case KVM_CAP_PPC_GET_PVINFO:
-- 
2.24.0

