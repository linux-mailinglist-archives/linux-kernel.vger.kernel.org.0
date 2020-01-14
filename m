Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF6E13A842
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 12:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgANLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 06:22:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgANLWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:22:42 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DE3A7121F63BD1BB6E66;
        Tue, 14 Jan 2020 19:22:39 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 14 Jan 2020 19:22:32 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <maz@kernel.org>
CC:     <andre.przywara@arm.com>, <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2] KVM: arm/arm64: vgic-its: Properly check the unmapped coll in DISCARD handler
Date:   Tue, 14 Jan 2020 19:22:12 +0800
Message-ID: <20200114112212.1411-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discard is supposed to fail if the collection is not mapped to any
target redistributor. We currently check if the collection is mapped
by "ite->collection" but this is incomplete (e.g., mapping a LPI to
an unmapped collection also results in a non NULL ite->collection).
What actually needs to be checked is its_is_collection_mapped(), let's
turn to it.

Also take this chance to remove an extra blank line.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

v1->v2:
 - Rewrite the commit message with Eric's suggestion,
   the original one is not so good...
 - Add Eric's R-b

 virt/kvm/arm/vgic/vgic-its.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 17920d1b350a..d53d34a33e35 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -839,9 +839,8 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 	u32 event_id = its_cmd_get_id(its_cmd);
 	struct its_ite *ite;
 
-
 	ite = find_ite(its, device_id, event_id);
-	if (ite && ite->collection) {
+	if (ite && its_is_collection_mapped(ite->collection)) {
 		/*
 		 * Though the spec talks about removing the pending state, we
 		 * don't bother here since we clear the ITTE anyway and the
-- 
2.19.1


