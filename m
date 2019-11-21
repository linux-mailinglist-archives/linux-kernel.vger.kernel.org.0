Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4631059B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 19:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfKUSha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 13:37:30 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40360 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfKUSh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:37:29 -0500
Received: by mail-il1-f193.google.com with SMTP id v17so412843ilg.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=faq1HCiwAUKpn9KibrFveIIN8Gq95mpKVvXAdv0gtDk=;
        b=EJjPbSz0Y6tDOEGVI+1jJ8atWnfgVSawkkT8eN6V6cCPix2Oo1Ul5auUyUzMkYlDoK
         3qNVcfI7jBdMccdBn/qZtJ6b635qSK6GyU075QBm/DiZL+E8zm9p4ZUKRL1MoOZVUo9N
         hoLYwkn2XLv87sQlikDmsBXss5UhTiaeuDHLmSWYC9JxUub0lmUUW2xZVXJnpyOXNaGw
         y82WJV8Pyc4iflpx/NYF12hA4nSerOKHfUJ23hnfkFrUUUVENyO4lqlRhEgEEDYvonHB
         7Ro2z4dGPGwjzFmYorVFleDJuov531ZDGun6BqLfvQZGB8jgtd1IecdJaPKyCHOmApK5
         PRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=faq1HCiwAUKpn9KibrFveIIN8Gq95mpKVvXAdv0gtDk=;
        b=Xk0eWVXJdvF160xXbqGcgB19NjlAcQ3vXAc7mKI4tCdtGRnBbQIJGw5UxP/SW1IE4b
         G2wT/bC3EIj/dGBN3kW7fvJtRnyz/H2ceANbK0O7Mcco8R471nVzRDmEfZFpfNcVwSis
         aGdOje0OQ/uuAGgAAH62lX4jld1fB3bJsaFUN2j46spOBHiyCo1iWSV/ZIa5IeniIvgw
         VJZsjvjdR3gAanbP7zeVLKZv9JoGnEA9M3Fxr3SO0joydK/GR4CDvkPh33hGbT0wBAgC
         7cVrdkZ2Tn+PGpZwg6/oGGeEUllmS+WLsb/u+lmucZrcPO0H3dEQ4VHJgwA4yPalr2t4
         gX6A==
X-Gm-Message-State: APjAAAVin7cRjCgaIQF6DB22LrK3XvVvx7u1DFW4tbL11+ZAJFfFOJg3
        nBUQgnGkepOQodpFnMY7/6jPb0X1M5y2ng==
X-Google-Smtp-Source: APXvYqwleGilbYtjejG0htBS2Id79yaqhJ2aVAJKwRv51I6HzmumqzuaenMu1RY8209HZRrCTLCAsA==
X-Received: by 2002:a92:b686:: with SMTP id m6mr11013166ill.35.1574361446126;
        Thu, 21 Nov 2019 10:37:26 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s11sm1518746ilh.54.2019.11.21.10.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 10:37:25 -0800 (PST)
Subject: Re: [PATCH] nbd: prevent memory leak
To:     Josef Bacik <josef@toxicpanda.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20190923200959.29643-1-navid.emamdoost@gmail.com>
 <20191121183017.h3qkpib5re27ty3b@MacBook-Pro-91.local>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae75694c-02a5-6f7f-c812-1350512490da@kernel.dk>
Date:   Thu, 21 Nov 2019 11:37:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121183017.h3qkpib5re27ty3b@MacBook-Pro-91.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/19 11:30 AM, Josef Bacik wrote:
> On Mon, Sep 23, 2019 at 03:09:58PM -0500, Navid Emamdoost wrote:
>> In nbd_add_socket when krealloc succeeds, if nsock's allocation fail the
>> reallocted memory is leak. The correct behaviour should be assigning the
>> reallocted memory to config->socks right after success.
>>
>> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>> ---
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Now applied, thanks.

-- 
Jens Axboe

