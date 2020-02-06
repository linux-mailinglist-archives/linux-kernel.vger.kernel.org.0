Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A44154C6D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 20:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBFTqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 14:46:54 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42694 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbgBFTqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:46:54 -0500
Received: by mail-il1-f196.google.com with SMTP id x2so6223758ila.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y+Qm2vuunUyIwT9FvbEtFr9J6rxqRNsvYMs4i9yZWHg=;
        b=vzy/d/95WWKu7PQDilCrAEJK/+BvYvrlT2fLOpZP6ixvZnvv2a4sXqwjMcXqyIgq9H
         EN9r/goqKuntaVTwMqDOGW/v6visAvmWs/nH3B2kj86dwwBwejEAzE8BMV0zbCC/fDMq
         WzePSNIQa3UtNwtLHdHNDK+ZW3zogJ2MFZl2gewBHH8v6czTPqdl06zFEIOGuypQqzna
         EIvN5c37/4OkK9P5qKqgMa+eAH8ZbCeO9dkeCHayol+DVcLPTpXyLjlsmd+pCfwD1dZK
         XIGD1UzUlidkvTuqtRkCAFubhYr7Ii+rEmULGQ+41K0nesS/AEyRBpqqPQu5P82GYGgZ
         mRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y+Qm2vuunUyIwT9FvbEtFr9J6rxqRNsvYMs4i9yZWHg=;
        b=ueGVArPR2MlKn3eDapOWs2hPWQHRZjpLSC/7hL8/no2KuDEU1ei2vfSurRBlbXEGKF
         VN80BVamsuzepVnRNKKIWDxFF7RyxjALyMw6pCL351shj4HtUw/jl2GvuSZ19sOD7LBI
         QJNLzeAWkZR/ScR5IfLAhBUwj9TMZbotlVtMJiF6ZcHpVmUgVE6NtKlnkOs/vKv/QyKn
         xsDS8lgpleetnx8v8iEn1Z+AsELlaOKvDXyVf/Ojy193fvGUA+sMd9u8KZHNRsoRaLGm
         EVDt0bVhdVKL0v0DXADXuDsGvZ2tyhEQWL2UYkaCU0HtSRKOieoVckL0JU/ZgwlWSStI
         n4hA==
X-Gm-Message-State: APjAAAWHMdrep/vg0qfuWv3PW8CqyoZdpK9Qu/Z0u1kTujNA5m/poSd1
        9usem2LmP/d+BRFgfE68gDAsHg==
X-Google-Smtp-Source: APXvYqzzT5Uf1j6WWUaNruAkal493BFlesJ6ootrwaINKDDVmguMA5dpYmg8FEKnhKslWtkKlTjDww==
X-Received: by 2002:a92:990b:: with SMTP id p11mr5538668ili.254.1581018412609;
        Thu, 06 Feb 2020 11:46:52 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b12sm255491iln.62.2020.02.06.11.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 11:46:52 -0800 (PST)
Subject: Re: [PATCH liburing v2 0/1] test: add epoll test case
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20200131142943.120459-1-sgarzare@redhat.com>
 <ebc2efdb-4e7f-0db9-ef04-c02aac0b08b1@kernel.dk>
 <CAGxU2F6qvW28=ULNUi-UHethus2bO6VXYX127HOcH_KPToZC-w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <57766a26-866b-3288-dc69-5104de3ac6b6@kernel.dk>
Date:   Thu, 6 Feb 2020 12:46:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAGxU2F6qvW28=ULNUi-UHethus2bO6VXYX127HOcH_KPToZC-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 10:33 AM, Stefano Garzarella wrote:
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 77f22c3da30f..2769451af89a 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -6301,7 +6301,7 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
>         if (READ_ONCE(ctx->rings->sq.tail) - ctx->cached_sq_head !=
>             ctx->rings->sq_ring_entries)
>                 mask |= EPOLLOUT | EPOLLWRNORM;
> -       if (READ_ONCE(ctx->rings->cq.head) != ctx->cached_cq_tail)
> +       if (!io_cqring_events(ctx, false))
>                 mask |= EPOLLIN | EPOLLRDNORM;
> 
>         return mask;

Are you going to send this as a proper patch? If so, I think you'll want
to remove the '!' negation for that check.

-- 
Jens Axboe

