Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E70E8157D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 15:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgBJOWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 09:22:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:44120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgBJOWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:22:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22E49B1E1;
        Mon, 10 Feb 2020 14:21:56 +0000 (UTC)
Date:   Mon, 10 Feb 2020 15:21:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1] MAINTAINERS: Sort entries in database for VSPRINTF
Message-ID: <20200210142154.x2azckvduvh3xuea@pathway.suse.cz>
References: <20200128143425.47283-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128143425.47283-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue 2020-01-28 16:34:25, Andy Shevchenko wrote:
> Run parse-maintainers.pl and choose VSPRINTF record. Fix it accordingly.

Does this produce any visible error or warning anywhere, please?

checkpatch.pl does not warn about it.

Also the order does not look defined in the file. When I run
parse-maintainers.pl on the entire MAINTAINERS file:

 MAINTAINERS | 5584 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------
 1 file changed, 2787 insertions(+), 2797 deletions(-)

The file has 18545 lines. It means that huge amount of entries
do not follow the order.

Best Regards,
Petr

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 211043d91cd0..4791757ba1ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17932,11 +17932,11 @@ M:	Steven Rostedt <rostedt@goodmis.org>
>  M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git
>  S:	Maintained
> -F:	lib/vsprintf.c
> -F:	lib/test_printf.c
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git
>  F:	Documentation/core-api/printk-formats.rst
> +F:	lib/test_printf.c
> +F:	lib/vsprintf.c
>  
>  VT1211 HARDWARE MONITOR DRIVER
>  M:	Juerg Haefliger <juergh@gmail.com>
> -- 
> 2.24.1
