Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2AD10B124
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 15:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfK0OXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 09:23:50 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37221 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0OXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:23:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so17323539lfp.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 06:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQAc09iOSs+OUg5bzPj2H1rBE2GvXaGtHzNxY2vVFm8=;
        b=NVsRjIUcwILPd1tnDv3S17qPH2Rc8pdEr06OlwognC5L1wYvuuWE2VmFAVum6Qb1sC
         lmVgIpOLWlVMCndd202EatqCqX9bWwKuQpuknmnYAvNBZuRM0nfXZWN+zzgPxEDxXtNP
         jo3HcmJ7bYOf3vgkcdZcmnDKCfYRUit71JHPUh0YjkuskgVPvkpJtC7gGesDIl5k/ASd
         TnVlq3uYhRek3JP6dVNkz96AweylBNW4uXW04xnsmUiSETC69B8fHHkaoIdGKO35hm8Y
         2kalCjn+HqYa1IEXmMSEhDzdLjntmK6J3oLzeaoyaS1e+VSazkpj5LuLvCDr9RKRbaqp
         qWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQAc09iOSs+OUg5bzPj2H1rBE2GvXaGtHzNxY2vVFm8=;
        b=qXh6BhVT/tKtT3ru67dV7ezgW+b2aOyZD5A1WjRb22WnXIl9hSEZ+64FEJb4EMYe0p
         4fZG1vxya98L1bntcoRcFoEyZ13NRBWYo3yITVpCUWgaJo6NIvLk5GDa9Kmix64eLuPa
         uXXWxZn8ooZ9QeENodt4bYX1PxK9qBobgN6vz0oGNKhQgdTZIzF5dE+sADewmzCA7eLi
         CJm8JfuIbVmJ6BZ0aiAgDAsYNmH1swi9cEk12Z+7RCdVLF8RKmY8kM8NNw1tyVvDXNzc
         A2RvMyWvjqtsm3861U84ZPqISdouKx2YDGvN3t4I3//K/HkCjwLRLxM5HGuu0r2/f+p+
         7iSw==
X-Gm-Message-State: APjAAAWmn6tkyQTEnBoBTrvBSYy3loSVQdQOL8Y84/J8+trgWjDr92O7
        EyIkaGerOjHvO7llRxvh/6VH2vtk
X-Google-Smtp-Source: APXvYqzhLx4HT6/iHXYY/lRbgzvswtQ8BpAwyny4yrxeVKhWIvSHhwsbr3b6fJNLMHfbnSj4C4QlJQ==
X-Received: by 2002:ac2:4c82:: with SMTP id d2mr15617326lfl.62.1574864626598;
        Wed, 27 Nov 2019 06:23:46 -0800 (PST)
Received: from seldlx21914.corpusers.net ([37.139.156.40])
        by smtp.gmail.com with ESMTPSA id t8sm6975946lfl.51.2019.11.27.06.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 06:23:46 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:23:45 +0100
From:   Vitaly Wool <vitalywool@gmail.com>
To:     <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] z3fold: protect handle reads
Message-Id: <20191127152345.8059852f60947686674d726d@gmail.com>
In-Reply-To: <20191127152012.17a4b35f9e7f6e50f9aaca9c@gmail.com>
References: <20191127152012.17a4b35f9e7f6e50f9aaca9c@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to make sure slots are protected on reading a handle. Since
handles are modified by free_handle() which only takes slot rwlock,
that lock should be used when handles are read.

Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
---
 mm/z3fold.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index f2a75418e248..43754d8ebce8 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -486,8 +486,12 @@ static unsigned long encode_handle(struct z3fold_header *zhdr, enum buddy bud)
 /* only for LAST bud, returns zero otherwise */
 static unsigned short handle_to_chunks(unsigned long handle)
 {
-	unsigned long addr = *(unsigned long *)handle;
+	struct z3fold_buddy_slots *slots = handle_to_slots(handle);
+	unsigned long addr;
 
+	read_lock(&slots->lock);
+	addr = *(unsigned long *)handle;
+	read_unlock(&slots->lock);
 	return (addr & ~PAGE_MASK) >> BUDDY_SHIFT;
 }
 
@@ -499,10 +503,13 @@ static unsigned short handle_to_chunks(unsigned long handle)
 static enum buddy handle_to_buddy(unsigned long handle)
 {
 	struct z3fold_header *zhdr;
+	struct z3fold_buddy_slots *slots = handle_to_slots(handle);
 	unsigned long addr;
 
+	read_lock(&slots->lock);
 	WARN_ON(handle & (1 << PAGE_HEADLESS));
 	addr = *(unsigned long *)handle;
+	read_unlock(&slots->lock);
 	zhdr = (struct z3fold_header *)(addr & PAGE_MASK);
 	return (addr - zhdr->first_num) & BUDDY_MASK;
 }
-- 
2.17.1
