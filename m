Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6930810DC42
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 04:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfK3Dbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 22:31:44 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42428 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfK3Dbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 22:31:44 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3F144FF97D9E9D257E9E;
        Sat, 30 Nov 2019 11:31:41 +0800 (CST)
Received: from linux-XCyijm.huawei.com (10.175.104.212) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Sat, 30 Nov 2019 11:31:32 +0800
From:   Heyi Guo <guoheyi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jiri Kosina <trivial@kernel.org>
Subject: [PATCH] trivial: kvm/arm: merge cases to reduce code lines
Date:   Sat, 30 Nov 2019 11:30:29 +0800
Message-ID: <20191130033029.61059-1-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems a little confusing for KVM_CAP_ARM_SET_DEVICE_ADDR to have a
separate branch while it doesn't have any difference with the above
cases.  So we merge it to the above cases, which can also save 2 lines.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Jiri Kosina <trivial@kernel.org>
---
 virt/kvm/arm/arm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 86c6aa1cb58e..6f94080969d1 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -197,8 +197,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IMMEDIATE_EXIT:
 	case KVM_CAP_VCPU_EVENTS:
 	case KVM_CAP_ARM_IRQ_LINE_LAYOUT_2:
-		r = 1;
-		break;
 	case KVM_CAP_ARM_SET_DEVICE_ADDR:
 		r = 1;
 		break;
-- 
2.19.1

