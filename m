Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9F6182423
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 22:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgCKVpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 17:45:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44527 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgCKVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:45:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so1708561plo.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uN1amOH5ZU5RT92sA61UloyUkxnxKCdtIJfyk4RzGY8=;
        b=KfPWVzHOvplm4aMeyKxQGHaE4kkrJqpFPCJQJRlKEZ8nqcZ36dfbDASxWD+9ZYSwf3
         G+yYqjTq7URoOiqgVXn9gbYPSo4QYw2ZjHwldmiRqFLDR8srM57PiCcn6dNx4BkIuFwv
         28FOivlX9pYy6fzhz6+udQIv6YVqyiNncE74PdCOSelZ8PxIdweX9uN6TrAAkO86obZE
         mVkfhtgemtAUTMp8BtV9L2huvca0Ld6ml8UQPzQLz4jsAZMjg9t0DibzEAtYY2iJ+Kf2
         1tqgQS1rM5xq+ixnbRKvCx8IhexYPjmPBAuwZVq1WMhnr0KxsZiQbb9ZJF8NSVebUYLQ
         5ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uN1amOH5ZU5RT92sA61UloyUkxnxKCdtIJfyk4RzGY8=;
        b=tblH/jMSnIdGezgUeTdSzHcQvGOTzkQfdC/Nc5F1WtDjsdSbqv65ay5QwAcAS8NWSo
         bo1AL6lsN9w4d8Flhku7M8Po2Y+Z5nkuoGPGCD4Lmsimd7jGT/e383eqBlwP/o5EoTVC
         oyKdHHcLKe0iYiAkGdIIMiubo7jFzQjoz80EzF0qUV5/sOyScG7bFkpDBHJbILOYN5yq
         ACY6Y28dFD73DtdRVhhK3l4es8554uWyGOFYFKp9qfDRl9JNiQmHm6N82kshQ15ARPgA
         9+Xbi075OhNjHKkMA2J/iVqFkN72s3qS39OILD4RT/e8xNtRZdbFqHj0k1ZnrZh82GLZ
         XOEw==
X-Gm-Message-State: ANhLgQ3ezkFEDhoNz81DKATnZtlhGyWLQzroVX53Aa6U/gSBt/VObVIR
        TVwWWKB7nGZpegIVsgZCKK39eg==
X-Google-Smtp-Source: ADFU+vt4rfokOL/oJaLw4dSeLhyEOzJbqm/GUHgNbwUXS8INzMYJiSGput+Rwtg/T3NvKl0tKxjRgg==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr4525944plo.98.1583963106709;
        Wed, 11 Mar 2020 14:45:06 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r24sm27165674pfg.61.2020.03.11.14.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:45:06 -0700 (PDT)
Date:   Wed, 11 Mar 2020 15:45:04 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@linaro.org,
        fabien.dessenne@st.com, s-anna@ti.com
Subject: Re: [RFC 1/2] remoteproc: sysfs: authorize rproc shutdown when rproc
 is crashed
Message-ID: <20200311214504.GA32471@xps15>
References: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
 <1583924072-20648-2-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583924072-20648-2-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On Wed, Mar 11, 2020 at 11:54:31AM +0100, Loic Pallardy wrote:
> When remoteproc recovery is disabled and rproc crashed, user space
> client has no way to reboot co-processor except by a complete platform
> reboot.
> Indeed rproc_shutdown() is called by sysfs state_store() only is rproc
> state is RPROC_RUNNING.
> 
> This patch offers the possibility to shutdown the co-processor if
> it is in RPROC_CRASHED state and so to restart properly co-processor
> from sysfs interface.

And it is not possible to use the debugfs interface [1] to restart the MCU?

[1]. https://elixir.bootlin.com/linux/v5.6-rc2/source/drivers/remoteproc/remoteproc_debugfs.c#L147


> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c  | 2 +-
>  drivers/remoteproc/remoteproc_sysfs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 097f33e4f1f3..7ac87a75cd1b 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1812,7 +1812,7 @@ void rproc_shutdown(struct rproc *rproc)
>  	if (!atomic_dec_and_test(&rproc->power))
>  		goto out;
>  
> -	ret = rproc_stop(rproc, false);
> +	ret = rproc_stop(rproc, rproc->state == RPROC_CRASHED);
>  	if (ret) {
>  		atomic_inc(&rproc->power);
>  		goto out;
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 7f8536b73295..1029458a4678 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -101,7 +101,7 @@ static ssize_t state_store(struct device *dev,
>  		if (ret)
>  			dev_err(&rproc->dev, "Boot failed: %d\n", ret);
>  	} else if (sysfs_streq(buf, "stop")) {
> -		if (rproc->state != RPROC_RUNNING)
> +		if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_CRASHED)
>  			return -EINVAL;
>  
>  		rproc_shutdown(rproc);
> -- 
> 2.7.4
> 
