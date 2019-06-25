Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C985248F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfFYH25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 03:28:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfFYH24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:28:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P7S3973508765
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 00:28:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P7S3973508765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561447684;
        bh=DKnktSBBWht+QETywtp4eZvOxuNjdPNQATPDbmCp6xQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WKw5jlJGHI4i5yC3AHTxtB5yVFaYo5afDiJPoOgn0fIJamqbSVEHUE1s4LHrcqRRF
         2NGb0BJAOVsmbmvNVdMdQiNpAw22/NKMWT3ZZ93LHVXg99aDlwvazSDfSphdjzxoD5
         pLVJDxgB+eNLx8eaA5IFH402Ncx94LbrfvBniO5rK3ADJyb7IF/KJWZDyg18hptX/M
         WAN3ZusTR0mupym9h2WpfcpVvT2wwJKjqTWNuXw/yTrBtVyQjLxOao8tyaGaa8oA1U
         klXJKxpgj/pzNfHVaeNGJqEFXTuLwITYUhAk9lrKWXsE1hn+kG98aHO3pWD0qDE/CE
         OgaDhcfiPLVdA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P7S3vK3508762;
        Tue, 25 Jun 2019 00:28:03 -0700
Date:   Tue, 25 Jun 2019 00:28:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-bf10c97adbd0dc8fa65c35d5b0c0dc281a68ac8e@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        namit@vmware.com, hulkci@huawei.com, yuehaibing@huawei.com,
        bristot@redhat.com, bp@alien8.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: yuehaibing@huawei.com, bp@alien8.de, mingo@kernel.org,
          bristot@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          tglx@linutronix.de, peterz@infradead.org, hulkci@huawei.com,
          namit@vmware.com
In-Reply-To: <20190625034548.26392-1-yuehaibing@huawei.com>
References: <20190625034548.26392-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] x86/jump_label: Make tp_vec_nr static
Git-Commit-ID: bf10c97adbd0dc8fa65c35d5b0c0dc281a68ac8e
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

Commit-ID:  bf10c97adbd0dc8fa65c35d5b0c0dc281a68ac8e
Gitweb:     https://git.kernel.org/tip/bf10c97adbd0dc8fa65c35d5b0c0dc281a68ac8e
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Tue, 25 Jun 2019 11:45:48 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 25 Jun 2019 09:22:14 +0200

x86/jump_label: Make tp_vec_nr static

Fix sparse warning:

arch/x86/kernel/jump_label.c:106:5: warning:
 symbol 'tp_vec_nr' was not declared. Should it be static?

It's only used in jump_label.c, so make it static.

Fixes: ba54f0c3f7c4 ("x86/jump_label: Batch jump label updates")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <bp@alien8.de>
Cc: <hpa@zytor.com>
Cc: <peterz@infradead.org>
Cc: <bristot@redhat.com>
Cc: <namit@vmware.com>
Link: https://lkml.kernel.org/r/20190625034548.26392-1-yuehaibing@huawei.com

---
 arch/x86/kernel/jump_label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index ea13808bf6da..044053235302 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -103,7 +103,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
 
 #define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
 static struct text_poke_loc tp_vec[TP_VEC_MAX];
-int tp_vec_nr = 0;
+static int tp_vec_nr;
 
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
