Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5686BF1801
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 15:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfKFOKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 09:10:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38019 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfKFOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:10:04 -0500
Received: by mail-io1-f66.google.com with SMTP id u8so27106917iom.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 06:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3wrtEF/Rzlh75tZwEt9oiPqiKdXJjmpMQ9Y7AZzRq0Q=;
        b=drMejIE+n44EQB/7Y8f0aFSCwCUnxKnblRpdGjLXV9d/F0RagTG1Q/2EfJL91/9e71
         3buO3nJeh37HEJZDuQNuu2tOgGj9y/jAEcWJ63i7mK5myctJnWHq9Cuelez2yOBtXvkl
         RsdXm1PxJ6PanTxZR+kZQ5x49lx4jkMAd0AXg+t/tRc3dN6r7xrQQhq2nj7HcEhGzFKN
         eUm5FHQ8FE7ewHnRkjt8LpD35sb48jCaSlqKu3Ed9BD2SFT312otwLgVf5wzbyOLMGWh
         dGyJRDsWKYs0LxDrYydIoUbfQFyrrqti2CysKVWTuESSapkMBTyqdDJ4Zoy6ITJDE5P3
         Y1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3wrtEF/Rzlh75tZwEt9oiPqiKdXJjmpMQ9Y7AZzRq0Q=;
        b=MzjcvfeUfGv5GBUgLHg/lv5QDsq5IeI2apLE1RKK3s9x8QTkQxJU9OxOcfKLq/DuWd
         BxFDX1TDGg1J4aBmPWwrKYR0V7J3LkHFK+S2NdrNcO19znVSoHUe4MAdjxtK21lIw8TL
         HH6w+kjm6ahJ/mipvoV6cbvVmvI3vi4E475sIC9kZgoCegU7ELA/pL4GYPtuSZV8vP9o
         eY8ioIymgOBiK0+t9wzUHIUvzrTcWh1ENhgOn44UHqc+qhU6oixfa799VZy7CHsdky4w
         mDny7Xh5XAexXqE9zyPRIrlpCNVqvzLjtPOMeoVKyWW9h9UKmZjWPEuZaP4ys0a5JJ5j
         49Ng==
X-Gm-Message-State: APjAAAVRRa/Gm0pydN/zd9A6uEJCaCZI0FGyl4N7r0cOfM5UYP0dWM26
        GOsB5BkJqM9D6UWeXrla3ydH1TpbPgY=
X-Google-Smtp-Source: APXvYqzu6A1QOsFkaiXnwKhhauiHvp45yIxCn7YcXr9lkZvvYsm7nX83dqhE4BkhYs4Ixy7Te3y/oQ==
X-Received: by 2002:a6b:f306:: with SMTP id m6mr2378847ioh.172.1573049403353;
        Wed, 06 Nov 2019 06:10:03 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r17sm3544372ill.19.2019.11.06.06.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 06:10:02 -0800 (PST)
Subject: Re: [PATCH v2 0/2] cleanup of submission path
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572988512.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9456fb9c-956d-62da-807c-498d2885f968@kernel.dk>
Date:   Wed, 6 Nov 2019 07:10:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1572988512.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/19 2:22 PM, Pavel Begunkov wrote:
> A minor cleanup of io_submit_sqes() and io_ring_submit().
> 
> v2: rebased
>      move io_queue_link_head()
> 
> Pavel Begunkov (2):
>    io_uring: Merge io_submit_sqes and io_ring_submit
>    io_uring: io_queue_link*() right after submit
> 
>   fs/io_uring.c | 110 +++++++++++++-------------------------------------
>   1 file changed, 28 insertions(+), 82 deletions(-)

Applied this series, thanks Pavel.

-- 
Jens Axboe

