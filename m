Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E2C177BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 17:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgCCQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 11:16:10 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49564 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729680AbgCCQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:16:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TrZg1ZS_1583252154;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TrZg1ZS_1583252154)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Mar 2020 00:16:06 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [PATCH v2 0/1] mm: fix interrupt disabled long time inside
Date:   Wed,  4 Mar 2020 00:15:50 +0800
Message-Id: <20200303161551.132263-1-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew and Kirill,

Sorry for late!
It's a shame that I misunderstood your mails.

@Kirill
I'm very sorry for misunderstood before!
Now, I got your points. Yes, the v1 patch is buggy in preemption case.
I also tried your suggestion, it's works!

Please help to review the new patch again.

Thanks very much for you kindly guidance!

Shile

Changelog:
v1:
https://lore.kernel.org/lkml/20200110082510.172517-1-shile.zhang@linux.alibaba.com/

Shile Zhang (1):
  mm: fix interrupt disabled long time inside deferred_init_memmap()

 mm/page_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.24.0.rc2

