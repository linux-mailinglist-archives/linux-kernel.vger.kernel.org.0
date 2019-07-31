Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73EF57C319
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 15:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfGaNP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 09:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbfGaNP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:15:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713AB20693;
        Wed, 31 Jul 2019 13:15:57 +0000 (UTC)
Date:   Wed, 31 Jul 2019 09:15:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Use strlen/sizeof instead of hardcoded
 constants
Message-ID: <20190731091555.1d764ba1@gandalf.local.home>
In-Reply-To: <20190731123922.14056-1-geert+renesas@glider.be>
References: <20190731123922.14056-1-geert+renesas@glider.be>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 14:39:22 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Replace hardcoded string length or size constants by proper strlen() or
> sizeof() constructs.  As the strings are constant, gcc will reduce the
> lengths or sizes to constants again.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Assembler output before/after compared: no change in generated code.
> ---
>  include/linux/printk.h |  3 +--
>  kernel/printk/printk.c | 12 ++++++------
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index cefd374c47b1f88e..9a85d2eb6ff63460 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -77,8 +77,7 @@ static inline void console_verbose(void)
>  		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
>  }
>  
> -/* strlen("ratelimit") + 1 */
> -#define DEVKMSG_STR_MAX_SIZE 10
> +#define DEVKMSG_STR_MAX_SIZE sizeof("ratelimit")
>  extern char devkmsg_log_str[];
>  struct ctl_table;
>  
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1888f6a3b694cb88..e8f332f0ae3595e8 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -121,15 +121,15 @@ static int __control_devkmsg(char *str)
>  	if (!str)
>  		return -EINVAL;
>  
> -	if (!strncmp(str, "on", 2)) {
> +	if (!strncmp(str, "on", strlen("on"))) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_ON;
> -		return 2;
> -	} else if (!strncmp(str, "off", 3)) {
> +		return strlen("on");
> +	} else if (!strncmp(str, "off", strlen("off"))) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_OFF;
> -		return 3;
> -	} else if (!strncmp(str, "ratelimit", 9)) {
> +		return strlen("off");
> +	} else if (!strncmp(str, "ratelimit", strlen("ratelimit"))) {

Perhaps replacing all these with str_has_prefix() may be a better idea.

-- Steve

>  		devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
> -		return 9;
> +		return strlen("ratelimit");
>  	}
>  	return -EINVAL;
>  }

