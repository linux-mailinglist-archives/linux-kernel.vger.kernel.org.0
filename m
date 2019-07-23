Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F832715A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 12:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbfGWKCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 06:02:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41483 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbfGWKCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:02:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so43420925ota.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=casparzhang-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=30UXoZPM+9RE8an6O7xxTToknZxq9ZoH5S52VkZVUZY=;
        b=C34havDI1qpeD/ZbDajYiieBd3DQOuEyEZEm9XmYNVpHFkHU0xEGyOyTeTRn1glKGu
         L0w5sgjbRZUXHzM2tAO+Xud81v/YfKGyHGMfdsvnIdYcy1o3634QYl1MEtA/dospRrPs
         CUA18mjO4f6mrVUW/5XCy46Z6j2OA6wqA54s+X9ytuwN7cdVjEB/Qro1JnxG38nUkgrU
         l1kehUwaz2eM5uU2sKPtS29DgVvaiyZp/S33ee7fOZ5L/pCSVwOVwOH4VL/hzXjCYB/W
         4qkExEWmA5Q9U2xOAuNUxHzMdhfWZUJFhOrC/j3oWXszWZbBlbFMcBaCS7Q0Oj3QyFJI
         aFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=30UXoZPM+9RE8an6O7xxTToknZxq9ZoH5S52VkZVUZY=;
        b=hmj9cCE5ELLHSlwXkFLLf/5VY5ktGNKcU+3XA8nFoTxsDaOGHTMdiW6bVv22+opooI
         eEELnhqJ6qbYch8moBJwPhLsXENLeQKqVStyJVh7YZD1stKPiJc35Q7pdehPdQcwjkdf
         eAY5otlj4pEG6BuYZ6zNg1KrmUwr1pDhpdsJdx3Vk9B3039ZknHppBA7f+9FyFbiYX+z
         cHVWQhlc67jpPyXhN9OW9ZbS6BjeSqbllzRLy3uGvMDo666qrf5Tt/ObiW1x0DX26AVZ
         UoJ3JXEL4aZHCn0oOtRjeB4vAopAFQmW69xVwPLBG3h1UbKfjAmhoyHOMhe+wTd3PTm+
         ET3w==
X-Gm-Message-State: APjAAAWFo028At1f8KOiI+KskqsSzl8bTkWIio4SXismkHAZqBGGkz7P
        qFp6X1EZduunpFGV9+7kL3SnaYzvbGk=
X-Google-Smtp-Source: APXvYqzxufKEXHQJFf9Zix4DWVvcjwlo4dsXaNVQdUuvIwurDnDzszSzb4mGi34w6ZGACrPcGn4gaA==
X-Received: by 2002:a9d:4809:: with SMTP id c9mr21699259otf.199.1563876135310;
        Tue, 23 Jul 2019 03:02:15 -0700 (PDT)
Received: from casparzhang.com ([240e:390:e6f:dc80:cdd6:529c:3a94:95d7])
        by smtp.gmail.com with ESMTPSA id w139sm15235606oiw.0.2019.07.23.03.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 03:02:13 -0700 (PDT)
Date:   Tue, 23 Jul 2019 18:02:09 +0800
From:   Caspar Zhang <caspar@casparzhang.com>
To:     Jason Xing <kerneljasonxing@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, dennis@kernel.org, axboe@kernel.dk,
        lizefan@huawei.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        caspar@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] psi: get poll_work to run when calling poll syscall next
 time
Message-ID: <20190723100209.GA78446@casparzhang.com>
References: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 02:45:39PM +0800, Jason Xing wrote:
> Only when calling the poll syscall the first time can user
> receive POLLPRI correctly. After that, user always fails to
> acquire the event signal.
>
> Reproduce case:
> 1. Get the monitor code in Documentation/accounting/psi.txt
> 2. Run it, and wait for the event triggered.
> 3. Kill and restart the process.
>
> If the user doesn't kill the monitor process, it seems the
> poll_work works fine. After killing and restarting the monitor,
> the poll_work in kernel will never run again due to the wrong
> value of poll_scheduled. Therefore, we should reset the value
> as group_init() does after the last trigger is destroyed.
>
> Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>

Reviewed-by: Caspar Zhang <caspar@linux.alibaba.com>

> ---
>  kernel/sched/psi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7acc632..66f4385 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1133,6 +1133,12 @@ static void psi_trigger_destroy(struct kref *ref)
>  	if (kworker_to_destroy) {
>  		kthread_cancel_delayed_work_sync(&group->poll_work);
>  		kthread_destroy_worker(kworker_to_destroy);
> +		/*
> +		 * The poll_work should have the chance to be put into the
> +		 * kthread queue when calling poll syscall next time. So
> +		 * reset poll_scheduled to zero as group_init() does
> +		 */
> +		atomic_set(&group->poll_scheduled, 0);
>  	}
>  	kfree(t);
>  }
> --
> 1.8.3.1
>

--
        Thanks,
        Caspar
