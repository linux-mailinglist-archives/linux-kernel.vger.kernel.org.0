Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88C9114257
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 15:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfLEOJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 09:09:59 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41559 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbfLEOJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:09:59 -0500
Received: by mail-il1-f193.google.com with SMTP id z90so3083491ilc.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 06:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NdRk0/WJY6q/NMtsungMXpX9nQb52EUzCZp5dxdBiDo=;
        b=s2a2GSfzBzKRVsd+y4on5r5AAqvHvkht2ps+r4RS1KKyGeBVN8Z1qlKDyUziyi3Zc6
         yWi9p9aDDyvVmDydac/apXnIR6wLQp9kVdSOBVNS5iVPCj4kXHoPV/ngMBUO/ZLO777X
         jwsvUMR29lHN5ATMpbKzK0E6rACPmzSnbGftP9d4Dq24+RqiRHs6gusv8y2h6PVQjn0G
         adNZbUX8kpKRnIt8RPYyE4dBcheAx8CAlQH16U+BZvIk0IcCeUdDw/l9FRBJaDZlOVg1
         p9ZAKiSGSXdObAu/1NIPuiNMTq5Ca1rr0x5jRS57Rk8WGym72d6zio+txaRLEOgsueSB
         0ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NdRk0/WJY6q/NMtsungMXpX9nQb52EUzCZp5dxdBiDo=;
        b=blmxK+jDjTlCIJq8xLQ7fKqkYn5QpuoAg+cYo855Tq6YLMmJOGMcKMIVY93TK4QDQ6
         4BHBBcIzgih6oenBR/jPHNudSeMwlJcbWqRYkE+1m9oFmEoJxKcZSG6CmfW1FYjrrNrV
         BCAWD3eFfPRW9H5AHfy0CnWK7OhDJ6W9aLZrQt4qmWwbvCYbhEy7RJ+GddLSmGPW7n6x
         lRm/KMdnPhAnH9Vje78DxuT6Bwuj6KeB9CRXyakOP9wWtVkk6ZD9TbDO3veIyIYIiFuL
         PP7FbIXsk1huW9+y58JJzZ0IpXcuXVZRvvpuYcFm5S4lj4MZrqVfY6/G+3Vrb8aRKFPf
         4BFQ==
X-Gm-Message-State: APjAAAU8uYIpXZ5nBkkf3akMfhDhXbqv92yZhrNguVVH/kl+dLDn+Bu+
        gYhcGaUnnLeH93JlR6acoG8+2Fg4A246IQ==
X-Google-Smtp-Source: APXvYqxka6pf9MNXTzfSzkKUdtu/jgSk3q+8bdm4H/e/EfMW/H5sh1ar7k3KBKI1kLw1wDMVkjBH0g==
X-Received: by 2002:a92:9107:: with SMTP id t7mr9019531ild.51.1575554998080;
        Thu, 05 Dec 2019 06:09:58 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s8sm2814777ilq.14.2019.12.05.06.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 06:09:57 -0800 (PST)
Subject: Re: [PATCH] io_uring: hook all linked requests via link_list
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <49ba20e17803a7caf1cb87792b36dd40b4a99806.1575551693.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d09eae06-b2e4-051e-359c-efff1ef957a7@kernel.dk>
Date:   Thu, 5 Dec 2019 07:09:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <49ba20e17803a7caf1cb87792b36dd40b4a99806.1575551693.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/19 6:16 AM, Pavel Begunkov wrote:
> Links are created by chaining requests through req->list with an
> exception that head uses req->link_list. (e.g. link_list->list->list)
> Because of that, io_req_link_next() needs complex splicing to advance.
> 
> Link them all through list_list. Also, it seems to be simpler and more
> consistent IMHO.

Agree, much easier to grok and verify. Applied, thanks.

-- 
Jens Axboe

