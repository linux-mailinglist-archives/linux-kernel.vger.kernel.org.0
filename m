Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E6F8FDC6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 10:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfHPI0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 04:26:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:42700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfHPI0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:26:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB5B5AFDB;
        Fri, 16 Aug 2019 08:26:43 +0000 (UTC)
Date:   Fri, 16 Aug 2019 10:26:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jia He <justin.he@arm.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [PATCH 2/2] lib/test_printf: add test of null/invalid pointer
 dereference for dentry
Message-ID: <20190816082642.6xdrxnrnv42vq4um@pathway.suse.cz>
References: <20190809012457.56685-1-justin.he@arm.com>
 <20190809012457.56685-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809012457.56685-2-justin.he@arm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-08-09 09:24:57, Jia He wrote:
> This add some additional test cases of null/invalid pointer dereference
> for dentry and file (%pd and %pD)
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  lib/test_printf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 944eb50f3862..befedffeb476 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -455,6 +455,13 @@ dentry(void)
>  	test("foo", "%pd", &test_dentry[0]);
>  	test("foo", "%pd2", &test_dentry[0]);
>  
> +	/* test the null/invalid pointer case for dentry */
> +	test("(null)", "%pd", NULL);
> +	test("(efault)", "%pd", PTR_INVALID);
> +	/* test the null/invalid pointer case for file */

The two comments mention something that is obvious from the code.

I have pushed the patch as is and removed the comments in
a follow up patch [1]. Both are in printk.git, branch for-5.4.

> +	test("(null)", "%pD", NULL);
> +	test("(efault)", "%pD", PTR_INVALID);

Reference:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-5.4&id=8ebea6ea1a7ed5d67ecbb2a493c716a2a89c0be2

Best Regards,
Petr
