Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A015F671
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 20:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbgBNTJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 14:09:54 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43130 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbgBNTJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:09:54 -0500
Received: by mail-io1-f67.google.com with SMTP id n21so11671819ioo.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3nQft3zNgFt5uQU8oAfUWTsZHLYmMf56s+RYaheimZE=;
        b=MyO7QGdH+798UZjnAMYOkuj8AFhvD2grF/mlXVN0vybPurAJxYZ3oL+IKZCAWZdcy+
         6FvlmOcxSEeyW8GYOiu92uMLIpGO5GXj3ROj/POgPywHF+Dt2fQxlx1GIav6E7x8zu1c
         CTgCm8fggVi5/kFqoAyeAhSdRpnkaQluMrEathIPxVTtnDPqtth+G/BB5JjQt+WUNXJ9
         jTURq56vwZzGFlpQN6IhytUiG3E2ru0w7HUvwsQRSSwxhzmPCj1Kew74eBYQZNib9FRM
         aCVMOfr4k5v9e+J+g08mdNKZWQHugVJLIgsInifA26Ph3dd5Xl2RBoil6Z1ALotLGyjj
         NqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3nQft3zNgFt5uQU8oAfUWTsZHLYmMf56s+RYaheimZE=;
        b=KKj80IWeMBPCqf3/bAyn8TRPPh/hUJIIksUvp0OqaBrcxjMicdVY8J+1wjVdSJLulo
         GLXJN+rJ/ajnOEE9kHnlyb00W+3ufymSfsMop0blVt3k8gRzSIzykzFiY8KxCf1BruTq
         4J+EimYoBaeqUzFpHueb/LnC3XdimNqtT7Miqiiz/0Xcv9OQ2IGN07c8m28iyhhBmdod
         JeVRlTKwCttr32jrvXy9LElrhLTkeoLJ+K81L5HCgagTtp461PE16VwjdlnmP1EdJIj1
         GTDiovi4yMg2Nb3Y75RK36QBcU6BytXT+vhNQRjTpWnWMYXWYGIDilbtviVLTjbOtyrO
         vEMw==
X-Gm-Message-State: APjAAAUJMjkPEWwDVMbOA/sXtazIIkJtCcPjCXoMuCWbSZtvZxJV2dzD
        IViBmz+X39KTc4B8PJzf9ulcCA==
X-Google-Smtp-Source: APXvYqxw24vmx09MidR6SM+oAC5IbyGhplcGKEG/Y6qBp3Q33Biv24Xoj209dgWP5oW04FL2GGkyzA==
X-Received: by 2002:a02:cab0:: with SMTP id e16mr3903013jap.6.1581707393584;
        Fri, 14 Feb 2020 11:09:53 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z21sm1692252ioj.21.2020.02.14.11.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 11:09:53 -0800 (PST)
Subject: Re: [PATCH v5 1/7] mm: pass task and mm to do_madvise
To:     Minchan Kim <minchan@kernel.org>
Cc:     Jann Horn <jannh@google.com>, io-uring <io-uring@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
References: <20200214170520.160271-1-minchan@kernel.org>
 <20200214170520.160271-2-minchan@kernel.org>
 <CAG48ez3S5+EasZ1ZWcMQYZQQ5zJOBtY-_C7oz6DMfG4Gcyig1g@mail.gmail.com>
 <68044a15-6a31-e432-3105-f2f1af9f4b74@kernel.dk>
 <20200214184514.GA165785@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <93aadcc6-3ef5-4ea0-be6b-23c06862002e@kernel.dk>
Date:   Fri, 14 Feb 2020 12:09:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214184514.GA165785@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 11:45 AM, Minchan Kim wrote:
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 63beda9bafc5..1c7e9cd6c8ce 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2736,7 +2736,7 @@ static int io_madvise(struct io_kiocb *req, struct io_kiocb **nxt,
>  	if (force_nonblock)
>  		return -EAGAIN;
>  
> -	ret = do_madvise(ma->addr, ma->len, ma->advice);
> +	ret = do_madvise(NULL, current->mm, ma->addr, ma->len, ma->advice);
>  	if (ret < 0)
>  		req_set_fail_links(req);
>  	io_cqring_add_event(req, ret);

I think we want to use req->work.mm here - it'll be the same as
current->mm at this point, but it makes it clear that we're using a
grabbed mm.

-- 
Jens Axboe

