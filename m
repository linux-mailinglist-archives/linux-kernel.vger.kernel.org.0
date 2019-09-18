Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9020B5E04
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 09:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfIRH2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 03:28:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2293 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfIRH2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:28:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4A91B9F413254FC2720;
        Wed, 18 Sep 2019 15:28:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Sep 2019
 15:28:35 +0800
Subject: [PATCH] genirq: modify the comment for irq_desc
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <longman@redhat.com>,
        <dbueso@suse.de>, <julien.thierry.kdev@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <trivial@kernel.org>
References: <f31aba98-5abe-6719-1490-cb249cfe0f08@huawei.com>
Message-ID: <658460cf-493e-8afc-b9fd-364e5f158924@huawei.com>
Date:   Wed, 18 Sep 2019 15:28:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f31aba98-5abe-6719-1490-cb249cfe0f08@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 0c6f8a8b917a ("genirq: Remove compat code") deleted the @status
member of irq_desc, but forgot to update the comment.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 include/linux/irqdesc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index d6e2ab5..8f2820c 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -24,7 +24,7 @@
  * @handle_irq:		highlevel irq-events handler
  * @preflow_handler:	handler called before the flow handler (currently used by sparc)
  * @action:		the irq action chain
- * @status:		status information
+ * @status_use_accessors: status information
  * @core_internal_state__do_not_mess_with_it: core internal status information
  * @depth:		disable-depth, for nested irq_disable() calls
  * @wake_depth:		enable depth, for multiple irq_set_irq_wake() callers
-- 
1.8.3.1


