Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5169D1165CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 05:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfLIE1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 23:27:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLIE1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g9bbRP19mv05O0IJy6jast55JsBd8ATFRNON9aYZJgg=; b=ZQ9gVd6cW3cbT2VbVcxdm0Vk6
        /fElAFBSSaOqvpgEowyB0D426oJv+So8Rf0BBTSwPrrj3obDpXLrDiWGt3MTliWY/izSIwR4rDB8K
        U1htGk/oDZh+iNoKAhNcVjbDobOypBLbJiBEcfXpYv1+j7S/XcEA8KQK0s35QK5RQ7kZmLIBS7/ZC
        Z6WeAjkDLOv8REKcEmVle69QpSgpodm1c6QVnvM0hazEFpkc6PtKh7lD088AL2YNiaEYKIvBrnV4P
        6E3hykFtXTgnK0q9GhuORR6/AYtK6xALewwMp7G1C0QCXkU2ZIR5BX7kYPejQceBvFUEQuNXoyyrj
        eBkSKO7tA==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieAdO-0000ie-NW; Mon, 09 Dec 2019 04:26:58 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] futex: fix kernel-doc notation warning
Message-ID: <223be78c-f3c8-52df-836d-c5fb8e7907e9@infradead.org>
Date:   Sun, 8 Dec 2019 20:26:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a kernel-doc warning in kernel/futex.c by adding notation
for @ret.

../kernel/futex.c:1187: warning: Function parameter or member 'ret' not described in 'wait_for_owner_exiting'

Fixes: 3ef240eaff36 ("futex: Prevent exit livelock")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
---
 kernel/futex.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20191209.orig/kernel/futex.c
+++ linux-next-20191209/kernel/futex.c
@@ -1178,6 +1178,7 @@ out_error:
 
 /**
  * wait_for_owner_exiting - Block until the owner has exited
+ * @ret: owner's current futex lock status
  * @exiting:	Pointer to the exiting task
  *
  * Caller must hold a refcount on @exiting.


