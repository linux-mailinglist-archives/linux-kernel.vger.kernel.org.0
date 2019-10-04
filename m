Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987DECBB32
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 15:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbfJDNFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 09:05:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33402 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbfJDNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:05:24 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so13434340ior.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=owB+0qIMoiD4khHlOx6XdkpZsBAmXun1zaiAh9/ru18=;
        b=ODuxhFr4Dd5XuPsWn8IgPf1Swa5PlcyIBmSDPW1rS8uMDmK/6S6dNDgHYKOKImNbFX
         61kuxlnGal/bij6RzNCjSbQFbV7/QKNvSqqeLrElxOT7W+JRcZVBfNiUJhVm4qVX1XQM
         BqU2ZwbWxD49TWAP4j/HpGiH7Ks63Gt+3VhDcv3kvOST28oYKVSHzYy8aYSviabTRuLo
         e7sAG++Cq+6kKv7+yzxac2hrYLZ/Lq2XCtM7rrO0wdZNLHsCD06cguZIijSs3D5OARk8
         7gH0j5AZi+fPyGfNifdjh4jFu9G325QH8+6J7smw/7vblWcTVsAIMTdURw/Ju/wU9pKv
         uy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=owB+0qIMoiD4khHlOx6XdkpZsBAmXun1zaiAh9/ru18=;
        b=bJ033QZ1o+SNcpnnNT/OvHn5VZmWe+e/pe1w41lDlQoabiYf4043HydDfGkgLMWL03
         oCmP2kns7GhwGjxjdiGw/8wibbctaIp/Px0iYm0tzSybqqSD4H+bek0dXhNRZVjmnmAH
         fqILR1XxuktsDLGAJ4jGa3N7+X1vQAdf8XDzfoXgAa6W9VkDAaKyRFRFU2ezks9gzh1k
         Mo3xwyswCPxCxj/5ozWyY+IzzSyeuThTYc5VeBciGYIEjL64pt1kDFBongc+pvsdhA1I
         kKb/pJtxBUzSMl1+LzzGgt0xiciMYGOQJdXK6Isqdwo1T+mFZeZGxNMQUZ5u6t8FtIN/
         sNwg==
X-Gm-Message-State: APjAAAXxB56dxc4mlaboXjGVWmtwdFFEkIwgF+6rd0kLEf41DkQTaJGl
        5ScaA5KGvEg8uqKXXBm/Q8o4jQ==
X-Google-Smtp-Source: APXvYqyKDvzAIIP552KZ9+y07//EEg/8qO3hqsy4XiD/90My4DhgNsPdBABRFOkw9vnr0KbsN/SlDw==
X-Received: by 2002:a6b:7102:: with SMTP id q2mr12090006iog.154.1570194323097;
        Fri, 04 Oct 2019 06:05:23 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w68sm3266361ili.59.2019.10.04.06.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:05:22 -0700 (PDT)
Subject: Re: [PATCH v2] io_uring: Fix reversed nonblock flag
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild test robot <lkp@intel.com>
References: <75be62996d115a3e2effa6753a6d803069131460.1570177340.git.asml.silence@gmail.com>
 <eecaf117de4894b595f300b9fb567825330b2d24.1570183599.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a18d7d7-323a-5903-2952-814954910ddd@kernel.dk>
Date:   Fri, 4 Oct 2019 07:05:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eecaf117de4894b595f300b9fb567825330b2d24.1570183599.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 4:07 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> io_queue_link_head() accepts @force_nonblock flag, but io_ring_submit()
> passes something opposite.
> 
> v2: fix build error by test robot: Rebase from custom tree
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>   fs/io_uring.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index c934f91c51e9..c909ea2b84e9 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2703,6 +2703,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
>   	struct io_kiocb *shadow_req = NULL;
>   	bool prev_was_link = false;
>   	int i, submit = 0;
> +	bool force_nonblock = true;
>   
>   	if (to_submit > IO_PLUG_THRESHOLD) {
>   		io_submit_state_start(&state, ctx, to_submit);
> @@ -2710,9 +2711,9 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
>   	}
>   
>   	for (i = 0; i < to_submit; i++) {
> -		bool force_nonblock = true;
>   		struct sqe_submit s;
>   
> +		force_nonblock = true;
>   		if (!io_get_sqring(ctx, &s))
>   			break;
>   
> @@ -2761,7 +2762,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
>   
>   	if (link)
>   		io_queue_link_head(ctx, link, &link->submit, shadow_req,
> -					block_for_last);
> +					force_nonblock);
>   	if (statep)
>   		io_submit_state_end(statep);

Shouldn't this just be:

   		io_queue_link_head(ctx, link, &link->submit, shadow_req,
 					!block_for_last);

We're outside the loop, so by definition at the end of what we need to
do. We don't need to factor in the fiddling of force_nonblock here,
it'll be false at this point anyway. Only exception is error handling,
if the caller asked for more than what was in the ring. Not a big
deal...

-- 
Jens Axboe

