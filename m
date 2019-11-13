Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC5FA061
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 02:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKMBlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 20:41:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6647 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfKMBlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:41:46 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 54C90FF4F34A2FEC17B5;
        Wed, 13 Nov 2019 09:41:27 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 09:41:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <maz@kernel.org>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <steven.price@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] KVM: arm: remove duplicate include
Date:   Wed, 13 Nov 2019 09:40:45 +0800
Message-ID: <20191113014045.15276-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 virt/kvm/arm/arm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 12e0280..d910a03 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -20,8 +20,6 @@
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
 #include <trace/events/kvm.h>
-#include <kvm/arm_pmu.h>
-#include <kvm/arm_psci.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
-- 
2.7.4


