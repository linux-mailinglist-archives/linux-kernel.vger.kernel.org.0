Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBBFE1207D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 15:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfLPOCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 09:02:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40646 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfLPOCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:02:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so6803691wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 06:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PPVkKUPHdQuhDbyrhJPZArVtxKIO++dpqLMyX5OYaQg=;
        b=I7oQ9HXSdnGWNLNtUHMqSL3eMhHW3n4yFEm5bbZiQRw/+xf+bdqlk2WRtCkpcumJOg
         +1AVSnw3fgx7LEIxcKi0u3Zk7UdrjQH3clVHvrm0aW4R0sWkosutS8COAESUlZ/380JJ
         43FEhCJ8io1SNvy7TZCUwebAd9SKerw7nh5aP3pmLVMmH1CM4xXnqkgOBqQshINoEC1N
         0puoGvw6KjJQyXLStjVRMJJxExSTXfWHQ5E5BA9GgenPXzqGTx+tIrgaruWt9wvQ8/0G
         J6bmsfmasodsqk9yYGuReF5y+SrRMAtZWbvSubCfeG9RzmNUEBasyj297SJRWmOCGmB1
         7IHw==
X-Gm-Message-State: APjAAAVJZXeoJzhHjwCf9dm+8vihnlY+OAjmTMWEGdQKQ2MqyJLzEdZd
        M7IgtlDKHFTQqofgbRkOYSg=
X-Google-Smtp-Source: APXvYqxqJLUTD5JRPD7XF6g976GK7Ro9fMcZnkhdiXEiTCJLlmII8WZQf57vEbIG+6XkGYWb9IuhkA==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr28849561wmj.11.1576504940945;
        Mon, 16 Dec 2019 06:02:20 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id w17sm21668962wrt.89.2019.12.16.06.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 06:02:20 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:02:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] workqueue: fix detecting reentrance
Message-ID: <20191216140219.GD6444@dhcp22.suse.cz>
References: <20191212091548.21668-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212091548.21668-1-hdanton@sina.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc maintainers.

On Thu 12-12-19 17:15:48, Hillf Danton wrote:
> 
> If we can find a valid worker that is serving the specified work at
> the moment then the worker itself is enough to ensure reentrance and
> workqueue doesn't matter here because it is permitted for a work to
> requeue itself either on different cpu or numa node or even on another
> workqueue.

I do not follow what is the actual problem you are trying to fix here.

> Fixes: c9178087acd7 ("workqueue: perform non-reentrancy test when queueing to unbound workqueues too")
> Fixes: 18aa9effad4a ("workqueue: implement WQ_NON_REENTRANT")
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- f/kernel/workqueue.c
> +++ g/kernel/workqueue.c
> @@ -1433,7 +1433,7 @@ retry:
>  
>  		worker = find_worker_executing_work(last_pool, work);
>  
> -		if (worker && worker->current_pwq->wq == wq) {
> +		if (worker) {
>  			pwq = worker->current_pwq;
>  		} else {
>  			/* meh... not running there, queue here */
> 

-- 
Michal Hocko
SUSE Labs
