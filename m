Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D297A343
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 10:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfG3Imq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 04:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfG3Imq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:42:46 -0400
Received: from linux-8ccs (unknown [92.117.234.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA68206A2;
        Tue, 30 Jul 2019 08:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564476165;
        bh=YK2IrKjOsWEiencRzwtkuliQzDg5iArYwQoLPINIRA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhAE4XiAR0lxtgqgtoYxN5SYyXm0adhMlJdrSkEJ6XXgah/SpUVb5UExJLe5pTPCr
         cbJXtlcPxXvaWI/EQk7jDxsMsploMkUqXkVi9o7f4RTfWKOUGQsDFjixpUghXXo1nZ
         6mvX52uc1uXN9atQc5ejGExZkxF+9GEt7h4ESHMM=
Date:   Tue, 30 Jul 2019 10:42:39 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jian Cheng <cj.chengjian@huawei.com>,
        Nadav Amit <namit@vmware.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>, Martin Kaiser <lists@kaiser.cx>
Subject: Re: [PATCH] modules: always page-align module section allocations
Message-ID: <20190730084239.GA19748@linux-8ccs>
References: <20190724150156.28526-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190724150156.28526-1-jeyu@kernel.org>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jessica Yu [24/07/19 17:01 +0200]:
>Some arches (e.g., arm64, x86) have moved towards non-executable
>module_alloc() allocations for security hardening reasons. That means
>that the module loader will need to set the text section of a module to
>executable, regardless of whether or not CONFIG_STRICT_MODULE_RWX is set.
>
>When CONFIG_STRICT_MODULE_RWX=y, module section allocations are always
>page-aligned to handle memory rwx permissions. On some arches with
>CONFIG_STRICT_MODULE_RWX=n however, when setting the module text to
>executable, the BUG_ON() in frob_text() gets triggered since module
>section allocations are not page-aligned when CONFIG_STRICT_MODULE_RWX=n.
>Since the set_memory_* API works with pages, and since we need to call
>set_memory_x() regardless of whether CONFIG_STRICT_MODULE_RWX is set, we
>might as well page-align all module section allocations for ease of
>managing rwx permissions of module sections (text, rodata, etc).
>
>Fixes: 2eef1399a866 ("modules: fix BUG when load module with rodata=n")
>Reported-by: Martin Kaiser <lists@kaiser.cx>
>Reported-by: Bartosz Golaszewski <brgl@bgdev.pl>
>Tested-by: David Lechner <david@lechnology.com>
>Tested-by: Martin Kaiser <martin@kaiser.cx>
>Signed-off-by: Jessica Yu <jeyu@kernel.org>

Applied, thanks everyone for testing.

> kernel/module.c | 7 +------
> 1 file changed, 1 insertion(+), 6 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 5933395af9a0..cd8df516666d 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -64,14 +64,9 @@
>
> /*
>  * Modules' sections will be aligned on page boundaries
>- * to ensure complete separation of code and data, but
>- * only when CONFIG_STRICT_MODULE_RWX=y
>+ * to ensure complete separation of code and data
>  */
>-#ifdef CONFIG_STRICT_MODULE_RWX
> # define debug_align(X) ALIGN(X, PAGE_SIZE)
>-#else
>-# define debug_align(X) (X)
>-#endif
>
> /* If this is set, the section belongs in the init part of the module */
> #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
>-- 
>2.16.4
>
