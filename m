Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0CF180F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 06:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgCKFHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 01:07:05 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:42644 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727184AbgCKFGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:06:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CBEC2181D3028;
        Wed, 11 Mar 2020 05:06:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:69:355:379:541:800:960:967:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1535:1605:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3865:3866:3867:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4049:4118:4321:5007:6261:9025:9038:10004:10848:11026:11473:11657:11658:11914:12043:12048:12296:12297:12438:12555:12679:12683:12895:12986:13255:13894:14110:14394:21080:21433:21451:21627:21811:21939:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bread73_1f0bc20945b1e
X-Filterd-Recvd-Size: 7226
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:06:53 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next 007/491] KERNEL VIRTUAL MACHINE FOR ARM/ARM64 (KVM/arm, KVM/arm64): Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:21 -0700
Message-Id: <af51bd879a723c790ffed82b81bc30e207001153.1583896348.git.joe@perches.com>
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
 arch/arm64/kvm/handle_exit.c  |  2 +-
 arch/arm64/kvm/hyp/debug-sr.c | 60 +++++++++++++++++------------------
 virt/kvm/arm/hyp/vgic-v3-sr.c | 16 +++++-----
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index aacfc5..b14d6a 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -128,7 +128,7 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	switch (ESR_ELx_EC(hsr)) {
 	case ESR_ELx_EC_WATCHPT_LOW:
 		run->debug.arch.far = vcpu->arch.fault.far_el2;
-		/* fall through */
+		fallthrough;
 	case ESR_ELx_EC_SOFTSTP_LOW:
 	case ESR_ELx_EC_BREAKPT_LOW:
 	case ESR_ELx_EC_BKPT32:
diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
index 0fc987..b074d3 100644
--- a/arch/arm64/kvm/hyp/debug-sr.c
+++ b/arch/arm64/kvm/hyp/debug-sr.c
@@ -18,70 +18,70 @@
 #define save_debug(ptr,reg,nr)						\
 	switch (nr) {							\
 	case 15:	ptr[15] = read_debug(reg, 15);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 14:	ptr[14] = read_debug(reg, 14);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 13:	ptr[13] = read_debug(reg, 13);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 12:	ptr[12] = read_debug(reg, 12);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 11:	ptr[11] = read_debug(reg, 11);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 10:	ptr[10] = read_debug(reg, 10);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 9:		ptr[9] = read_debug(reg, 9);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 8:		ptr[8] = read_debug(reg, 8);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 7:		ptr[7] = read_debug(reg, 7);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 6:		ptr[6] = read_debug(reg, 6);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 5:		ptr[5] = read_debug(reg, 5);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 4:		ptr[4] = read_debug(reg, 4);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 3:		ptr[3] = read_debug(reg, 3);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 2:		ptr[2] = read_debug(reg, 2);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 1:		ptr[1] = read_debug(reg, 1);			\
-			/* Fall through */				\
+			fallthrough;					\
 	default:	ptr[0] = read_debug(reg, 0);			\
 	}
 
 #define restore_debug(ptr,reg,nr)					\
 	switch (nr) {							\
 	case 15:	write_debug(ptr[15], reg, 15);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 14:	write_debug(ptr[14], reg, 14);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 13:	write_debug(ptr[13], reg, 13);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 12:	write_debug(ptr[12], reg, 12);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 11:	write_debug(ptr[11], reg, 11);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 10:	write_debug(ptr[10], reg, 10);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 9:		write_debug(ptr[9], reg, 9);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 8:		write_debug(ptr[8], reg, 8);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 7:		write_debug(ptr[7], reg, 7);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 6:		write_debug(ptr[6], reg, 6);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 5:		write_debug(ptr[5], reg, 5);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 4:		write_debug(ptr[4], reg, 4);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 3:		write_debug(ptr[3], reg, 3);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 2:		write_debug(ptr[2], reg, 2);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 1:		write_debug(ptr[1], reg, 1);			\
-			/* Fall through */				\
+			fallthrough;					\
 	default:	write_debug(ptr[0], reg, 0);			\
 	}
 
diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index ccf1fde..93331f2 100644
--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -349,10 +349,10 @@ void __hyp_text __vgic_v3_save_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		cpu_if->vgic_ap0r[3] = __vgic_v3_read_ap0rn(3);
 		cpu_if->vgic_ap0r[2] = __vgic_v3_read_ap0rn(2);
-		/* Fall through */
+		fallthrough;
 	case 6:
 		cpu_if->vgic_ap0r[1] = __vgic_v3_read_ap0rn(1);
-		/* Fall through */
+		fallthrough;
 	default:
 		cpu_if->vgic_ap0r[0] = __vgic_v3_read_ap0rn(0);
 	}
@@ -361,10 +361,10 @@ void __hyp_text __vgic_v3_save_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		cpu_if->vgic_ap1r[3] = __vgic_v3_read_ap1rn(3);
 		cpu_if->vgic_ap1r[2] = __vgic_v3_read_ap1rn(2);
-		/* Fall through */
+		fallthrough;
 	case 6:
 		cpu_if->vgic_ap1r[1] = __vgic_v3_read_ap1rn(1);
-		/* Fall through */
+		fallthrough;
 	default:
 		cpu_if->vgic_ap1r[0] = __vgic_v3_read_ap1rn(0);
 	}
@@ -386,10 +386,10 @@ void __hyp_text __vgic_v3_restore_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[3], 3);
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[2], 2);
-		/* Fall through */
+		fallthrough;
 	case 6:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[1], 1);
-		/* Fall through */
+		fallthrough;
 	default:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[0], 0);
 	}
@@ -398,10 +398,10 @@ void __hyp_text __vgic_v3_restore_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[3], 3);
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[2], 2);
-		/* Fall through */
+		fallthrough;
 	case 6:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[1], 1);
-		/* Fall through */
+		fallthrough;
 	default:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[0], 0);
 	}
-- 
2.24.0

