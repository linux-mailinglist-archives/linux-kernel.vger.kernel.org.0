Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C72CED87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 02:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfD3AMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 20:12:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40963 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729104AbfD3AMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:12:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 83A8C21B03;
        Mon, 29 Apr 2019 20:12:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2019 20:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=h47RDnOLR3ulBCU/R
        /FMwsbaO8IAEzK5MvftA9Vw9lA=; b=lyvhOQj2gYuwzfZOz8UFTiCzc/3lN1GeX
        XpsIEv3yI+XV6rF3pMTYse14Hl+CRBBrKvjMBqSTAiGJoPtaru6EaJVwrx6UYCqW
        dDf9ScH8rRU+YrClWT0nh4XzuYKugya2oYZgQD9z9XFEd7A69r6uJJRLaUIT/td6
        XGyj4kwU51Cs854S63LLCPmNEhA0pMCodj0cSPe7Nh6FD2mcEC9ZpCST1teT15R+
        yiDhnkw+MbkQfVuQfQBJMVaU5VUIgHTgT5dhUHyIdIZETLxZCx9gpEtaZEPXDo8a
        LTrhV8sSlgoUhTIpRwWtEogwrWEZXRMNC1tdorUgO91OnYYbiZKrw==
X-ME-Sender: <xms:85LHXLx39Z3GyDKDT6-2DmtMrSPU_uUEVv1cvH7Oqm9a7OTuZlFasQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvuddrgeegrddvfedtrddukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:85LHXHkQVd5Q4FKRRpkJJuR9S0bHonsU4oog9FqkvbprMYh7XE3bWQ>
    <xmx:85LHXAO884V_CdiQrYOr0Zzp_ZB_dq0Wx9jD9ijLLC7LXRpGOnFZrg>
    <xmx:85LHXAtXwI8ukD1wLyItQ_2Yk19FYK5sbP0_pX78hL5YM3YrWbMhdQ>
    <xmx:9JLHXPZrjiqs23l5GmJ3DOIq3Uq6PROfcU3fKV9otMaG3B0Z_kdYpQ>
Received: from eros.localdomain (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 30783103CD;
        Mon, 29 Apr 2019 20:12:32 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/cpufreq: Fix kobject memleak
Date:   Tue, 30 Apr 2019 10:11:44 +1000
Message-Id: <20190430001144.24890-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently error return from kobject_init_and_add() is not followed by a
call to kobject_put().  This means there is a memory leak.

Add call to kobject_put() in error path of kobject_init_and_add().
---
 kernel/sched/cpufreq_schedutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5c41ea367422..3638d2377e3c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -771,6 +771,7 @@ static int sugov_init(struct cpufreq_policy *policy)
 	return 0;
 
 fail:
+	kobject_put(&tunables->attr_set.kobj);
 	policy->governor_data = NULL;
 	sugov_tunables_free(tunables);
 
-- 
2.21.0

