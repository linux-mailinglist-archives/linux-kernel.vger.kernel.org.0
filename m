Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AF560F7F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfGFIoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 04:44:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42199 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfGFIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 04:44:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x668hlA9351457
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 6 Jul 2019 01:43:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x668hlA9351457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562402628;
        bh=3e3bg69DEadrCh1Oa4RxROE8+viHlLBFLZHHmQ+MlY8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=laNct8PSNrL9723ae4YjOcG+5x25oOFV6Srj2xDyZPB1A0RNuuMT7NKAz4ctnO5Qc
         VJtfUhSxIJ+EKp+bwCqyUgxBMc2vDh4z/J8G+4EU+GNV0sZdZE6eXmEa4vfBvIYXlY
         cii3ICjm1mP/tHpFOCJNmTVCzJT2+XcOoNfNl297ODSaGJHZSGBGi9y/9cwkePwmBg
         +2/6XSUc5+ElS21Ufzl2gIm/UFhOv7WfzNpaVYtrMY41+IrysWSZd5i228H8krHkst
         kgZvpQC+sdQSCzMPnHOUTYzyz245WFJgFR/Ez5R4nsf2Ll4V/n/4WnT5ibkWjq1rw9
         UPujUxZ1XuCPQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x668hlhq351454;
        Sat, 6 Jul 2019 01:43:47 -0700
Date:   Sat, 6 Jul 2019 01:43:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zenghui Yu <tipbot@zytor.com>
Message-ID: <tip-3a1d24ca9573fbc74a3d32c972c333b161e0e9dc@git.kernel.org>
Cc:     mingo@kernel.org, yuzenghui@huawei.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, yuzenghui@huawei.com,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1562388072-23492-1-git-send-email-yuzenghui@huawei.com>
References: <1562388072-23492-1-git-send-email-yuzenghui@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] irq/irqdomain: Fix comment typo
Git-Commit-ID: 3a1d24ca9573fbc74a3d32c972c333b161e0e9dc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3a1d24ca9573fbc74a3d32c972c333b161e0e9dc
Gitweb:     https://git.kernel.org/tip/3a1d24ca9573fbc74a3d32c972c333b161e0e9dc
Author:     Zenghui Yu <yuzenghui@huawei.com>
AuthorDate: Sat, 6 Jul 2019 04:41:12 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 6 Jul 2019 10:40:20 +0200

irq/irqdomain: Fix comment typo

Fix typo in the comment on top of __irq_domain_add().

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1562388072-23492-1-git-send-email-yuzenghui@huawei.com

---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e7d17cc3a3d7..3078d0e48bba 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
  * @ops: domain callbacks
  * @host_data: Controller private data pointer
  *
- * Allocates and initialize and irq_domain structure.
+ * Allocates and initializes an irq_domain structure.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
