Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1815C34A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 16:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbgBMPjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 10:39:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729624AbgBMP2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:54 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 644AD206DB;
        Thu, 13 Feb 2020 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607734;
        bh=WuqV254a5onX5HPGKhHxntSjp5QurUQnAHBFMgCKLuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygsCihCbkLz1PVYtkNSm6NfYC+lyeG5cc7jGFCt7XUfKe+ssFbwANlTNw7yIOtQnB
         o6RDa5Gh/WMYoaESxIX6PQoZcZkbZs/ggsFe3PZwj2Ba934/zpeXkb6KD40/fF2zr/
         cg84y350fw6C5f93Jbku+gHVxdBwYarXF2nQXNfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gavin Shan <gshan@redhat.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 5.5 085/120] KVM: arm/arm64: Fix young bit from mmu notifier
Date:   Thu, 13 Feb 2020 07:21:21 -0800
Message-Id: <20200213151929.930520608@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gavin Shan <gshan@redhat.com>

commit cf2d23e0bac9f6b5cd1cba8898f5f05ead40e530 upstream.

kvm_test_age_hva() is called upon mmu_notifier_test_young(), but wrong
address range has been passed to handle_hva_to_gpa(). With the wrong
address range, no young bits will be checked in handle_hva_to_gpa().
It means zero is always returned from mmu_notifier_test_young().

This fixes the issue by passing correct address range to the underly
function handle_hva_to_gpa(), so that the hardware young (access) bit
will be visited.

Fixes: 35307b9a5f7e ("arm/arm64: KVM: Implement Stage-2 page aging")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200121055659.19560-1-gshan@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/mmu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -2147,7 +2147,8 @@ int kvm_test_age_hva(struct kvm *kvm, un
 	if (!kvm->arch.pgd)
 		return 0;
 	trace_kvm_test_age_hva(hva);
-	return handle_hva_to_gpa(kvm, hva, hva, kvm_test_age_hva_handler, NULL);
+	return handle_hva_to_gpa(kvm, hva, hva + PAGE_SIZE,
+				 kvm_test_age_hva_handler, NULL);
 }
 
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu)


