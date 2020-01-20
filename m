Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233C414345F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 00:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgATXIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 18:08:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATXIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 18:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EodYlEmpwWAl9DTdaczpMAO/Teu6D46q7CSzgtYCgVY=; b=PMMUAYFb2tDSWSgQuk+bIbmJj
        hZIa/MfnKK7Yl17lk5QDUd69m2UF5CLI0L1Ey4e+BsQpj76U3us2q1LSnh2I9UwpiBiZ0it1iBNKw
        nEIcSDV1HkzFOmnR1Vkr0iKkSxLfl9SCeTW2hOLH78ET45MaXlx2cIlwAa9UZc2Fz7xjqZjx713uZ
        iNuydb0EeCvUQNiYk0smRkU1J57E1iLj6YwI5H8PnK9yWQKMDZiEUUGGI3M9xixqD3nmNnrcSGJFz
        2ADqa0/Mzjp5N4hqMqxdJoD0pqZud/AumShJGuOGhdoKbxCig9Ddo0VShoIuGbbzgyTBxZb6iaibB
        lpNv6uDcg==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itg9Z-0003dI-6u; Mon, 20 Jan 2020 23:08:17 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] sched: fair.c: fix kernel-doc warning of @flags removal
Message-ID: <27d7d14f-aab3-ea45-9efc-2e8099bc758b@infradead.org>
Date:   Mon, 20 Jan 2020 15:08:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning in kernel/sched/fair.c, caused by a recent
function parameter removal:

../kernel/sched/fair.c:3526: warning: Excess function parameter 'flags' description in 'attach_entity_load_avg'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Ingo Molnar <mingo@redhat.com>
Cc:	Peter Zijlstra <peterz@infradead.org>
Cc:	Vincent Guittot <vincent.guittot@linaro.org> (SCHED_NORMAL)
Cc:	Dietmar Eggemann <dietmar.eggemann@arm.com> (SCHED_NORMAL)
---
 kernel/sched/fair.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20200120.orig/kernel/sched/fair.c
+++ linux-next-20200120/kernel/sched/fair.c
@@ -3516,7 +3516,6 @@ update_cfs_rq_load_avg(u64 now, struct c
  * attach_entity_load_avg - attach this entity to its cfs_rq load avg
  * @cfs_rq: cfs_rq to attach to
  * @se: sched_entity to attach
- * @flags: migration hints
  *
  * Must call update_cfs_rq_load_avg() before this, since we rely on
  * cfs_rq->avg.last_update_time being current.


