Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2633BD591
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 01:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442113AbfIXXtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 19:49:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35652 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388576AbfIXXtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:49:13 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1iCuYQ-00018W-9p; Wed, 25 Sep 2019 01:49:10 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     <zhe.he@windriver.com>
Cc:     <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RT] printk: devkmsg: read: Return EPIPE when the first message user-space wants has gone
References: <20190924072639.25986-1-zhe.he@windriver.com>
Date:   Wed, 25 Sep 2019 01:49:08 +0200
In-Reply-To: <20190924072639.25986-1-zhe.he@windriver.com> (zhe he's message
        of "Tue, 24 Sep 2019 15:26:39 +0800")
Message-ID: <8736gls1aj.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-24, <zhe.he@windriver.com> wrote:
> From: He Zhe <zhe.he@windriver.com>
>
> When user-space wants to read the first message, that is when user->seq
> is 0, and that message has gone, it currently automatically resets
> user->seq to current first seq. This mis-aligns with mainline kernel.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/dev-kmsg#n39
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/printk/printk.c#n899
>
> We should inform user-space that what it wants has gone by returning EPIPE
> in such scenario.
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>

Signed-off-by: John Ogness <john.ogness@linutronix.de>

> ---
>  kernel/printk/printk.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e3fa33f2e23c..58c545a528b3 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -703,14 +703,10 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>  		goto out;
>  	}
>  
> -	if (user->seq == 0) {
> -		user->seq = seq;
> -	} else {
> -		user->seq++;
> -		if (user->seq < seq) {
> -			ret = -EPIPE;
> -			goto restore_out;
> -		}
> +	user->seq++;
> +	if (user->seq < seq) {
> +		ret = -EPIPE;
> +		goto restore_out;
>  	}
>  
>  	msg = (struct printk_log *)&user->msgbuf[0];
