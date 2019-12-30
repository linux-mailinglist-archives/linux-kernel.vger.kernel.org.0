Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AAB12D4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 23:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfL3WCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 17:02:33 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42476 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3WCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 17:02:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so47869623otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 14:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GCvwk3ABtwdjqvG1uWUdW6LjUhV+jArcCKnO+jIkeHI=;
        b=KJDV0WG3wMa8o9uizk2psQr+rEg4Ky+Sq1BQ1K0IhSA9zCssdnHtQfS/VJc8n14n9u
         gcbEBXgXPmF6D67nIcjg24ycKxfA/va/go5ywBySYDAeZxYmmWgMlNv68t+dncdrPFGj
         sJJ2wOmxVxT44O0A3rlMCBaYkp4DAGBZMX7oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GCvwk3ABtwdjqvG1uWUdW6LjUhV+jArcCKnO+jIkeHI=;
        b=ibSwlAn1j1kBhFMzP0LpSG7tzaY1ZydKF6v09R6nZqQWIvt5WxlNTmmWM1HtRpA7Sm
         EB5Iw6tWt49n5XMA36KqBOMMKrB7TLNh+fDenCO89YbvymS604oqGWYjzW6qjI6UrEkt
         bnnWoAOOHgZOnIrUGfJlTqTuLWqOi+C+OIqmS88u0JQQlGxqHmuP8A8j6lzt9RyRnfmg
         7APW12JkfSvXV7ydpo8wujhor6UOyDZOgHGAqdFASWunad3Niax7l0eLTvWZgylUAZZL
         1ISMtfcd4cuLMXLuz4+KIWGGA1zJ2pZJ9tc+Sd1PmdEdftdJl04EJPuC/3iUzDalctgc
         TCvQ==
X-Gm-Message-State: APjAAAUM8E+V/nUrnF/YVhxr1hCAImDTa5Pfun0Jkd/R/6YK6Tjd0NC1
        05tJ0Y9UGNVFdYBoO6STfZo0Fw==
X-Google-Smtp-Source: APXvYqyuYH9hz2+g2LLkII1/dtCC2qoc/sgWx1FYD3X0a6qYEktyc1SCWh9/egs5+6Cv10HajbFEyQ==
X-Received: by 2002:a05:6830:1257:: with SMTP id s23mr76895275otp.241.1577743352313;
        Mon, 30 Dec 2019 14:02:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 15sm13674755oin.5.2019.12.30.14.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 14:02:31 -0800 (PST)
Date:   Mon, 30 Dec 2019 14:02:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH] samples/seccomp: Zero out datastructures based on
 seccomp_notif_sizes
Message-ID: <201912301402.EF4C0F72E@keescook>
References: <20191230203503.4925-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230203503.4925-1-sargun@sargun.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 12:35:03PM -0800, Sargun Dhillon wrote:
> The sizes by which seccomp_notif and seccomp_notif_resp are allocated are
> based on the SECCOMP_GET_NOTIF_SIZES ioctl. This allows for graceful
> extension of these datastructures. If userspace zeroes out the
> datastructure based on its version, and it is lagging behind the kernel's
> version, it will end up sending trailing garbage. On the other hand,
> if it is ahead of the kernel version, it will write extra zero space,
> and potentially cause corruption.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Suggested-by: Tycho Andersen <tycho@tycho.ws>
> Cc: Kees Cook <keescook@chromium.org>

Ah, cool. I've rearranged things and split the other patch's samples
changes into this one, etc etc :)

Thanks!

-Kees

> ---
>  samples/seccomp/user-trap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
> index 3e31ec0cf4a5..20291ec6489f 100644
> --- a/samples/seccomp/user-trap.c
> +++ b/samples/seccomp/user-trap.c
> @@ -302,10 +302,10 @@ int main(void)
>  		resp = malloc(sizes.seccomp_notif_resp);
>  		if (!resp)
>  			goto out_req;
> -		memset(resp, 0, sizeof(*resp));
> +		memset(resp, 0, sizes.seccomp_notif_resp);
>  
>  		while (1) {
> -			memset(req, 0, sizeof(*req));
> +			memset(req, 0, sizes.seccomp_notif);
>  			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
>  				perror("ioctl recv");
>  				goto out_resp;
> -- 
> 2.20.1
> 

-- 
Kees Cook
