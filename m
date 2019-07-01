Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3581621F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 23:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfEQVRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 17:17:10 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:46355 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfEQVRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:17:10 -0400
Received: by mail-pf1-f177.google.com with SMTP id y11so4243105pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VfSQiZXDw9z5dZjFrjKTsYiGBGvOiJv1Tcdgk1Ayenw=;
        b=ZQgB8svULT7m4+ckNsrmDzuqhvjxHZ1KLASM6wK8qybKMMuf8tyQFKFF/qh8cfIPgC
         VAVycKs4s/8hNg6okfC2EAXU7FXf3ssdMfN+KPpaQM72/8YyV+s04X9OO7PBh1PDKJVa
         SihoYwqOKL4E2fL1WK4g4vlQrM/I0m2F3x1vHBBqcYaTtPCb/XPr8fJTsqnSBXwO+J9l
         BYDz7KUFsOV036aJB+tZYzpqlKr/GA4zci5ubzCh+kHwd0QRF4yqRi2ckgNmjCplzn71
         h7AD22WuoMrYzDN9/rzj2BBhWzSAdUumenJKXuHjRF2c4V561/irlMcjLTvuGro5tv1n
         yQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VfSQiZXDw9z5dZjFrjKTsYiGBGvOiJv1Tcdgk1Ayenw=;
        b=iQTZarLDVGapkfKMjtmbGd16ges8EsKbbJCeFmRtE5coyw3MSJM3AigfTUd1D8khmu
         cg/6kskLrc6/caAsaeLq0v15WHr+vYlgr/PespLJvdJBD8/VTPcYONxfQCfs5s5U8Mpv
         VBs+L+qzInGh+Tx1Y6rrXg2fgsj1ZBbX/VW/EotsoZtIVlMQo+sk7wYILQZlFfbKGxyo
         PNaRp9hPkVCW33in9Z0xcxw5VDYYs0djQ9dBvIMtCyraoWLazKDrdL3Gqh6NI3+AAttq
         +IEioR5KrqVS48PFBKT9DmHIm6Td9HO+g3s88aozUP5AiurODsDv70aHkOs6JI7aSxeu
         c/CA==
X-Gm-Message-State: APjAAAUDCnLYEwwLB+nIwn31Swc8ADqAc51SIPpTNDeN+qVb0wJ6BOrD
        p2CkjBSuHYkfc9D1eECBTVJbiyJED3K0ww==
X-Google-Smtp-Source: APXvYqxxPq8B0uWTBxjteNDiS1BP4g+8mhy1GplIdofmapADGYTuQgku8Axzh/smxiF171yIwBAh8w==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr59156393pgd.63.1558127829276;
        Fri, 17 May 2019 14:17:09 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 1sm10170104pfn.165.2019.05.17.14.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:17:08 -0700 (PDT)
Subject: Re: [PATCH] block: bio: use struct_size() in kmalloc()
To:     xiaolinkui <xiaolinkui@kylinos.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1558084350-25632-1-git-send-email-xiaolinkui@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e46a73e2-b04d-371b-f199-e789dbdbd9fc@kernel.dk>
Date:   Fri, 17 May 2019 15:17:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558084350-25632-1-git-send-email-xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/19 3:12 AM, xiaolinkui wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> instance = kmalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);

Applied, thanks.

-- 
Jens Axboe

