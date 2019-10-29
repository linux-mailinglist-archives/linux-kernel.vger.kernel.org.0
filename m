Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A036E8203
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 08:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfJ2HUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 03:20:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728032AbfJ2HUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:20:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 369BCB063877C594D3FB;
        Tue, 29 Oct 2019 15:20:22 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 29 Oct 2019 15:20:15 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <maz@kernel.org>, <eric.auger@redhat.com>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 0/3] KVM: arm/arm64: vgic: Some cleanups and fixes
Date:   Tue, 29 Oct 2019 15:19:16 +0800
Message-ID: <20191029071919.177-1-yuzenghui@huawei.com>
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

Hi KVM/ARM maintainers,

This series contains three cleanups (fixes) I've collected when looking
through the vgic code. Please consider taking them if you're happy with
them.

Thanks!

Zenghui Yu (3):
  KVM: arm/arm64: vgic: Remove the declaration of
    kvm_send_userspace_msi()
  KVM: arm/arm64: vgic: Fix some comments typo
  KVM: arm/arm64: vgic: Don't rely on the wrong pending table

 include/kvm/arm_vgic.h      | 4 +---
 virt/kvm/arm/vgic/vgic-v3.c | 8 ++++----
 virt/kvm/arm/vgic/vgic-v4.c | 2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.19.1


