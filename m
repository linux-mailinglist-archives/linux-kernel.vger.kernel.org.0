Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7075612627E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 13:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLSMpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 07:45:35 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55160 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfLSMpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:45:35 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep17so2470034pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 04:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z/xYSl6zQKjABLBTONR1NAB8T0yFBm0l2LQ2eaQw2EE=;
        b=RP155P0qGjBkRG3bhkvHndHmrwp9Llla3wDhunWiTYVqDWJ1dEbVLWz8ii9l25yKDv
         MS4sgKHJcS78zL6L8R05uLrSHADSi8OeAcHnMn892flYwp8w8k817RwuHKfKyqWYzljU
         ifZbRTmhZRxvPpZ/qGYBHAR61cmoo+tc1qFFHcUacUc7eYKZY7tvFaxhy5lbHCeXZ0PP
         zy/FgjeBx3g9wUxuLFz7wtZKqvIctzSFR513epcayjAenYhJCg7gNhJXYH6WRzj1lKVH
         nnvOymZxdX4KhPRioI/3lXC0NOyc/ehWDwI41Jm8wtnBdmYokvvi0yNO5kHaSyYmYlfU
         6SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z/xYSl6zQKjABLBTONR1NAB8T0yFBm0l2LQ2eaQw2EE=;
        b=sb/SFknf34+8c1uAdRHtrtnWQ2h3rgxDaGIMNHr4vRLg5SVL+neDQGJUV+l/DM9cyG
         CTTByTV6FdVGi9q0aKM2H0jMWoKqi63MtKtT/Hn3rl5Wwk+qfy0SHtSZlvJVqKaf+5aV
         H9/GEwY4bSPXu5bVO07p/XHE1zWqsFvUFnwF1ZXBLnJGR52zvhM9x7mniW1N3S/UV1ue
         H5jGyIz5+b16UFOcwEjm2noaEqR3z68eDD5GaMQunjekcJYG+HJh2IANDg3MZrLrbFXG
         mFy0Kt+f+AKD12wHM0J4eSDhYj8ufazHqVAFOT7VLZF9TYPASIYbKdy0N+iHETGehNnx
         VHTA==
X-Gm-Message-State: APjAAAWbsMxrFgXLYBBpf7iOwz2Trae4nz+zHRb4jFT+shGo8BF6/+BF
        VtSX/wMF3nsO1NiITu9X+EErIBMW1XJZ3A==
X-Google-Smtp-Source: APXvYqy6HTR64BHbjBbMtSNTgHsPQfIuOLG3t31OX3o/0XEEirytJKmtxMG+dB64dUKLh5yc1ScyOg==
X-Received: by 2002:a17:90a:1ae9:: with SMTP id p96mr9640448pjp.8.1576759534340;
        Thu, 19 Dec 2019 04:45:34 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id s15sm7451809pgq.4.2019.12.19.04.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 04:45:33 -0800 (PST)
Subject: Re: [PATCH] block: fix memleak when __blk_rq_map_user_iov() is failed
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576658644-88101-1-git-send-email-yangyingliang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4e2e03e4-b5ed-e16a-e7a0-0900afb23042@kernel.dk>
Date:   Thu, 19 Dec 2019 05:45:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576658644-88101-1-git-send-email-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/19 1:44 AM, Yang Yingliang wrote:
> When I doing fuzzy test, get the memleak report:
> 
> BUG: memory leak
> unreferenced object 0xffff88837af80000 (size 4096):
>   comm "memleak", pid 3557, jiffies 4294817681 (age 112.499s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     20 00 00 00 10 01 00 00 00 00 00 00 01 00 00 00   ...............
>   backtrace:
>     [<000000001c894df8>] bio_alloc_bioset+0x393/0x590
>     [<000000008b139a3c>] bio_copy_user_iov+0x300/0xcd0
>     [<00000000a998bd8c>] blk_rq_map_user_iov+0x2f1/0x5f0
>     [<000000005ceb7f05>] blk_rq_map_user+0xf2/0x160
>     [<000000006454da92>] sg_common_write.isra.21+0x1094/0x1870
>     [<00000000064bb208>] sg_write.part.25+0x5d9/0x950
>     [<000000004fc670f6>] sg_write+0x5f/0x8c
>     [<00000000b0d05c7b>] __vfs_write+0x7c/0x100
>     [<000000008e177714>] vfs_write+0x1c3/0x500
>     [<0000000087d23f34>] ksys_write+0xf9/0x200
>     [<000000002c8dbc9d>] do_syscall_64+0x9f/0x4f0
>     [<00000000678d8e9a>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> If __blk_rq_map_user_iov() is failed in blk_rq_map_user_iov(),
> the bio(s) which is allocated before this failing will leak. The
> refcount of the bio(s) is init to 1 and increased to 2 by calling
> bio_get(), but __blk_rq_unmap_user() only decrease it to 1, so
> the bio cannot be freed. Fix it by calling blk_rq_unmap_user().

Applied, thanks.

-- 
Jens Axboe

