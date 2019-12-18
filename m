Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99601248CF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 14:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLRN57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 08:57:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39011 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLRN57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:57:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so1883484wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pCsuWU4HWowCBBiSnSWMn5G6gwMjvZ2EZc/rIekVAJM=;
        b=hrSoTXs+zBqmdGjqZRPkRGiKMLYftNQG8aKgaHR+rtvkjU3jy22P9e6croup5zJ3zS
         FZrpgYYYmVmIHMpq5CpUsbNGz3Xjiqm3cbPLyzmOcDerS6FcYNv8UNYs4hIHd/hNVnh6
         8NPschMM19LAsHoi9Sbr9uIq8Ej+7F7ARWQnQEUWcnkGReaT7Q798HcTtV39f5G4fpaw
         6QmRke/mySd4+Uvr7YguRLBCp1sC8lZ2Ey2n4FUleez9VmRj3WpoAgJqPpc/SC1/MEe8
         1xhBFKwBQxsXr2UQni26kxHvtDfcEYyFH95jr04ulWdQjIfUB9oIdlGS/pQ2bX/s7olp
         0RZw==
X-Gm-Message-State: APjAAAXcQptL0iDP8gbB5aUm849vo6nZ2MaZ0rKJ0c2HVnv5v0+Y65m5
        0ber1OXCtN11RPXRzTuFR3mqtZn3
X-Google-Smtp-Source: APXvYqw3ofxfP1JoJp+brrKHwVfq8aEOnoOXYziPzSeicR3YmkDvybmUbu5EXKRypu0PMwfcYr0j8Q==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr3398387wml.103.1576677477413;
        Wed, 18 Dec 2019 05:57:57 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z3sm2572944wrs.94.2019.12.18.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:57:56 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:57:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] workqueue: dexpose worker
Message-ID: <20191218135755.GC28111@dhcp22.suse.cz>
References: <20191218035945.16180-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218035945.16180-1-hdanton@sina.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You probably wanted to Cc maintainers.

On Wed 18-12-19 11:59:45, Hillf Danton wrote:
> 
> It does not make much sense to expose worker, workqueue's internal
> object, to outsiders, and whatever field inside worker as well.
> Nor does worker pool rather than workqueue and work.

But I have to say that this doesn't really make much sense to me.
What is the problem you are trying to solve?

current_is_executing is a really ambiguous name without any relation to
WQ. Also this seems like a pointless code churn to me. Anyway for
maintainers to judge.

> 
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/kernel/workqueue_internal.h
> +++ b/kernel/workqueue_internal.h
> @@ -69,6 +69,13 @@ static inline struct worker *current_wq_
>  	return NULL;
>  }
>  
> +static inline bool current_is_executing(work_func_t func)
> +{
> +	struct worker *worker = current_wq_worker();
> +
> +	return worker && worker->current_func == func;
> +}
> +
>  /*
>   * Scheduler hooks for concurrency managed workqueue.  Only to be used from
>   * sched/ and workqueue.c.
> --- a/kernel/async.c
> +++ b/kernel/async.c
> @@ -327,8 +327,6 @@ EXPORT_SYMBOL_GPL(async_synchronize_cook
>   */
>  bool current_is_async(void)
>  {
> -	struct worker *worker = current_wq_worker();
> -
> -	return worker && worker->current_func == async_run_entry_fn;
> +	return current_is_executing(async_run_entry_fn);
>  }
>  EXPORT_SYMBOL_GPL(current_is_async);
> 

-- 
Michal Hocko
SUSE Labs
