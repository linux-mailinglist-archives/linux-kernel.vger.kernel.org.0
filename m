Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD814123B03
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 00:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfLQXnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 18:43:02 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37661 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLQXnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 18:43:01 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so89563pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 15:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tHmNU07IcGRBf3kW7420AEAyNNkvnhcQSgIuqJOcv00=;
        b=zsV2xawrWlDsePcpPDiu23b85PAqEZogHMIfzb9ZmGgVUnDZCDRJpzJJsmvJ0vsHQi
         VEPCVHrKoxwPQiIMSWNUoIa8rQyiLdEVJbea+vtpjVb3r0p7wXi8hEVnsCAwoUj/qflt
         1RZYtfJZYmM4fG/1AliI2+J8qkKpsMQEAWIw7iqaD1WmzkQIIKmVX0SWhEC+oUN3+x9v
         8dBlqfBmaawTmfBO3cN+/8FWKKy57hi5blT+xuyHSZf/PlBbUQhQmi/SNlAyzQaPLZDU
         E5PIicnCUaepxK5pShrWpPLdF8dCh7q4BctuJmbkgTdT+BJmWAp+rJRJFvRdt0tN/vsw
         cXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tHmNU07IcGRBf3kW7420AEAyNNkvnhcQSgIuqJOcv00=;
        b=pGzErUXsVAVjqVsPm2+gLD0XRZ040YcxUDR5wmApjT0bqCQZ7mlyKr6gQAgOtNcQTj
         iRd0NV5wmAUELFITfOekHi1o9lOT8S9kSnEyE1VVVjPqaBQHrqxY8bRFF9MR4aS7nnZB
         T9i12kvakeU1TGhBbOFEeajnV29iG6yhMiYP5cJNIdUgmPTn8npRDkyM4u1cY77IuS9w
         BarYDYQ48GjHT/66xqsr8X4HEBCnLLbjPmMcPLot00biLNhAxWwcZ/1KE0Zz/DC0xmyG
         HK13GNSZwldRoqT77cDerPHY3B5B2/+LvjbzTCVM/L6c9OFrrxeptF7hjJ4wAGKuIEXL
         yAQg==
X-Gm-Message-State: APjAAAX7SsCMp2sDI5v9qPA56q+E8o6kLgQO6piwEAiZWWZW9Rx6K4P9
        iWSElmm8HNqV+x+AnHgrYcz9Ydv8KBU=
X-Google-Smtp-Source: APXvYqz6VOb6mNZEJr8x7r1M1I9GIrmI9pZWmIw4LTi28DeTYqyeRh+cjuTn41Swp2XEdFCTKwumRg==
X-Received: by 2002:a17:902:b690:: with SMTP id c16mr763115pls.72.1576626181072;
        Tue, 17 Dec 2019 15:43:01 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::13f4? ([2620:10d:c090:180::6446])
        by smtp.gmail.com with ESMTPSA id g25sm141541pfo.110.2019.12.17.15.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 15:43:00 -0800 (PST)
Subject: Re: [PATCH 1/2] pcpu_ref: add percpu_ref_tryget_many()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <cover.1576621553.git.asml.silence@gmail.com>
 <c430d1a603f9ffe01661fc1b3bad6e3101a8b855.1576621553.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe13d615-0fae-23e3-f133-49b727973d14@kernel.dk>
Date:   Tue, 17 Dec 2019 16:42:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c430d1a603f9ffe01661fc1b3bad6e3101a8b855.1576621553.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Tejun on this one. Looks fine to me, and matches the put path.


On 12/17/19 3:28 PM, Pavel Begunkov wrote:
> Add percpu_ref_tryget_many(), which works the same way as
> percpu_ref_tryget(), but grabs specified number of refs.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/linux/percpu-refcount.h | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index 390031e816dc..19079b62ce31 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -210,15 +210,17 @@ static inline void percpu_ref_get(struct percpu_ref *ref)
>  }
>  
>  /**
> - * percpu_ref_tryget - try to increment a percpu refcount
> + * percpu_ref_tryget_many - try to increment a percpu refcount
>   * @ref: percpu_ref to try-get
> + * @nr: number of references to get
>   *
>   * Increment a percpu refcount unless its count already reached zero.
>   * Returns %true on success; %false on failure.
>   *
>   * This function is safe to call as long as @ref is between init and exit.
>   */
> -static inline bool percpu_ref_tryget(struct percpu_ref *ref)
> +static inline bool percpu_ref_tryget_many(struct percpu_ref *ref,
> +					  unsigned long nr)
>  {
>  	unsigned long __percpu *percpu_count;
>  	bool ret;
> @@ -226,10 +228,10 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>  	rcu_read_lock();
>  
>  	if (__ref_is_percpu(ref, &percpu_count)) {
> -		this_cpu_inc(*percpu_count);
> +		this_cpu_add(*percpu_count, nr);
>  		ret = true;
>  	} else {
> -		ret = atomic_long_inc_not_zero(&ref->count);
> +		ret = atomic_long_add_unless(&ref->count, nr, 0);
>  	}
>  
>  	rcu_read_unlock();
> @@ -237,6 +239,20 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>  	return ret;
>  }
>  
> +/**
> + * percpu_ref_tryget - try to increment a percpu refcount
> + * @ref: percpu_ref to try-get
> + *
> + * Increment a percpu refcount unless its count already reached zero.
> + * Returns %true on success; %false on failure.
> + *
> + * This function is safe to call as long as @ref is between init and exit.
> + */
> +static inline bool percpu_ref_tryget(struct percpu_ref *ref)
> +{
> +	return percpu_ref_tryget_many(ref, 1);
> +}
> +
>  /**
>   * percpu_ref_tryget_live - try to increment a live percpu refcount
>   * @ref: percpu_ref to try-get
> 


-- 
Jens Axboe

