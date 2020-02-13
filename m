Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903AF15BB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 10:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgBMJIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 04:08:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35568 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:08:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id y73so2765774pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iZ4ALMIQ3+TkLwExvTpCpZXbkNrLF9yBShKjZ2USbmI=;
        b=VjrhEKjg/eQQL39kqbYW4sTUO7Dkc4Lwr+Txc2E6nE9o78H+RPowJ5/THyptvadMzN
         hLmpo02dDGTpF6sjQQJCR2DbqfEUaBtJFqewYeZ3bOzekqvoa8svO7s4rAaeyosodBNM
         oA9Mdq6PTJdrAlcBdB1RVTAyyN84Z/zRhOv8UAQcIIYYQxhdAAz7/fyYYd+KCF6/erkP
         aGxry2onFhnMIN50g04l8s9InEvOyUGkLkBjg5nlXl/9eSq4LnmogJC9hkwR33KFDyB3
         8tuhDKc4Ar5YYgl/hvbYN+sgB1JNdWqsitexCsumRFuDSPkNs2LHsSTNqGhrtEvalu4v
         SlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iZ4ALMIQ3+TkLwExvTpCpZXbkNrLF9yBShKjZ2USbmI=;
        b=jcbvGZyWRT6aV9o3xofKDjJJ/3OIiD4GcjVYyqGdW8Jco7MnHBze9pqU9xuiisVL3z
         7SAzaOShpUtrb7zfa6e5UzPM1OJgINzyCTybBe5aSIdzijP/pQt1xuHFzVXk0Aypidfs
         6LazzYiyqasgK5VSk/W/QQsUcxHb8/cBBbUax9SXF+KANBGj+RlCYtoTAmqmTm1mdZlK
         mQp1Rs+2y4RVnIGthqDyaoz6hfF6ENXxPUe8V0f13pFRMVsUKtCHXV6wJFce5bpmFx3p
         LnPrBb96gCNfthwb5m3AhJaXDvac1EPlv+xR1PQ9P+9hQ0TgOLDplrKtF4aaw3LSzn1r
         RplQ==
X-Gm-Message-State: APjAAAUMXcbT84fdegAYHnr0IVNSXAvkjFpf5JqBD+i+AZVccc/Wsbz3
        I1h5zR+k70JVVMS4AISgXOc=
X-Google-Smtp-Source: APXvYqzHEVTHskgrdP+FV0zdgL5k5qeBTwi8pTz/gKF/KF6N5daLmf/6qact8sPmkxlTbcKlT6X8vg==
X-Received: by 2002:a62:1a97:: with SMTP id a145mr16870284pfa.244.1581584880034;
        Thu, 13 Feb 2020 01:08:00 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id k1sm2259597pfg.66.2020.02.13.01.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:07:58 -0800 (PST)
Date:   Thu, 13 Feb 2020 18:07:57 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: use the lockless ringbuffer
Message-ID: <20200213090757.GA36551@google.com>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128161948.8524-3-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/28 17:25), John Ogness wrote:
[..]
> -	while (user->seq == log_next_seq) {
> +	if (!prb_read_valid(prb, user->seq, r)) {
>  		if (file->f_flags & O_NONBLOCK) {
>  			ret = -EAGAIN;
>  			logbuf_unlock_irq();
> @@ -890,30 +758,26 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>  
>  		logbuf_unlock_irq();
>  		ret = wait_event_interruptible(log_wait,
> -					       user->seq != log_next_seq);
> +					prb_read_valid(prb, user->seq, r));
>  		if (ret)
>  			goto out;
>  		logbuf_lock_irq();
>  	}
>  
> -	if (user->seq < log_first_seq) {
> -		/* our last seen message is gone, return error and reset */
> -		user->idx = log_first_idx;
> -		user->seq = log_first_seq;
> +	if (user->seq < r->info->seq) {
> +		/* the expected message is gone, return error and reset */
> +		user->seq = r->info->seq;
>  		ret = -EPIPE;
>  		logbuf_unlock_irq();
>  		goto out;
>  	}

Sorry, why doesn't this do something like

	if (user->seq < prb_first_seq(prb)) {
		/* the expected message is gone, return error and reset */
		user->seq = prb_first_seq(prb);
		ret = -EPIPE;
		...
	}

?

	-ss
