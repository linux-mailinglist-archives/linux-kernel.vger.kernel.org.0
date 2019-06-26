Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66145737F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 23:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfFZVUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 17:20:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51399 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZVUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:20:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so3560709wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0DtFqszsr3qJYqKdyDfqtNM2KkK1DcaCWoxZcO7W0sI=;
        b=dvYr6HuZFPqose6JEl5JScrwn2WfYFDWGYGVKHTBf0StaVq86QFFjFB1pVno2syJhU
         tOeyX8aGu1TM9h3MNaP4xZ6NcNZBm7Ap0inzYVlrex7Tjqd3C8BuPu+ENsZ+Wq8ajyVq
         n+5iA1bxvfGLfcnp6f6JMY/+9HkUjo7NXmXBN/4SGiJx8dehB9e9hKps36omIaY/alyW
         q4Tg2TG5ILXGn5CJbYn5fA9JqK0DirENheLbzBGC+51FANRAvxQQMZ4jZ4Z//z0TbsjS
         LNEDGtPhwg2Ep+N8f0RT+eveeBruifCQJTuJzPNGCTNXJzJvQZHBzHfXmAHzOWVmrCYr
         +TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0DtFqszsr3qJYqKdyDfqtNM2KkK1DcaCWoxZcO7W0sI=;
        b=h2yF9UVfY1zYSu5rJVrUuI4XRJJ4gEM4GZJN8bLpHtge2hK/RIY4FdpS1LU/AwaFdn
         Tmrtz1OqBXWFKQyLQ9PCdJ5l5pZSVSSb2Bfh1rid9AfhXfk49B4AW+uZzlhrcXjVeu99
         5GP9huWP5bLT9TxIomPKDP9t/qC6tRiusCHIztginM1L56dbUbyorN6qUhyfftSl1qlf
         MY7sq81f/2kMEWblEqqWg+GydAUT2QfIN2UwACg23XB8Mxd0msPtXJwTHd4V4KP/Yyr/
         0vc7QAO04ZjZPLIdDi9B565gIo5V2MIwiFPxrC8/fWMEepHts/Qzbwhw1QSPnHSx39lJ
         ytrg==
X-Gm-Message-State: APjAAAX63VhtGILGpKDo0va8s4BbPyLxv75amjZP3bQeXN8Joxf6Jf4Q
        QF3+INq8kLZRu86yfqUxJGQ=
X-Google-Smtp-Source: APXvYqyuvOaPAPzC1vcGqF5fygDlBPVn5tHNksOdZJf7VQhfOe3P/OPsxR6s71nPVBliZC8WGDAy9Q==
X-Received: by 2002:a1c:4b1a:: with SMTP id y26mr577121wma.105.1561584017187;
        Wed, 26 Jun 2019 14:20:17 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m24sm434823wmi.39.2019.06.26.14.20.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 14:20:16 -0700 (PDT)
Date:   Wed, 26 Jun 2019 23:20:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: Re: [patch 24/29] x86/hpet: Use cached info instead of extra flags
Message-ID: <20190626212014.GC101255@gmail.com>
References: <20190623132340.463097504@linutronix.de>
 <20190623132436.277510163@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623132436.277510163@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Now that HPET clockevent support is integrated into the channel data, reuse
> the cached boot configuration instead of copying the same information into
> a flags field.
> 
> This also allows to consolidate the reservation code into one place, which
> can now solely depend on the mode information.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/hpet.c |   76 ++++++++++++++-----------------------------------
>  1 file changed, 23 insertions(+), 53 deletions(-)
> 
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -25,8 +25,8 @@ struct hpet_channel {
>  	unsigned int			num;
>  	unsigned int			cpu;
>  	unsigned int			irq;
> +	unsigned int			inuse;
>  	enum hpet_mode			mode;
> -	unsigned int			flags;
>  	unsigned int			boot_cfg;
>  	char				name[10];

Let's fight entropy name by name and s/inuse/in_use ?

Because in_use is closer to harmony:

 dagon:~/tip> git grep -w in_use | wc -l
 518
 dagon:~/tip> git grep -w inuse | wc -l
 318

and also easier to read.

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
