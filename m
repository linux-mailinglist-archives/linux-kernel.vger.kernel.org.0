Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3710EC4E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 15:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKAOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 10:43:06 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45874 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfKAOnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:43:05 -0400
Received: by mail-il1-f194.google.com with SMTP id b12so8843183ilf.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 07:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pOsu2AcG2YG+DGQYkcK4IHDj0JhN9eSDbjkqK9jcdeU=;
        b=by+aCiRbys++Hk7pZDZPyBKkx18BYYSC1DSo4Jvg0Y7Fw4nrTh42bNjln5w3wVp49S
         6TFbd/JAY0l5wsaIoyBB7/+tjbY1DO2Z2Stwj31eHK5Fq+SgOUtpGZavHSW6z1aFuRyv
         ky6qkBzmoN1F4xzhrekVLEUhwDFL19eoRbF7tzDD69FdBf2I9aq21ygAGFx9Ny+sxh3/
         lENK43cv6xhuOk9n6XDje23lyxLdO4G3FVNVH/VoMD3yWRLFrPeVKf/K6VxC21VrNOvK
         AwvWCSmLK6Krn+lHP+o9blGyQpqpqvM+FKGywyImb6hazbo3naiQZNZFDhcImgqITbHU
         5Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOsu2AcG2YG+DGQYkcK4IHDj0JhN9eSDbjkqK9jcdeU=;
        b=mKMXV9IZp/khiSkWq5s/xBgdtVnZVBJnPMpkmJbhwaCubB0L3LNDXU6fW16fa+m8O6
         /brjY2KJaIFM5TKNTmSTYNAD0WmTTTCJEudMgenotCa/EdHpYAU7BuuA+RHY4mFO4aZ3
         Ocu7T3NZ4Yyg/6vsNWnP7WZyRC+1BOzSWtdzIQhVxJO0rU1tBJ2/sXYQvToLSTsE2Woe
         130RJNmnnKCj/qe/0TfpgbJxzQDc6ubmPyBERYXe6UraTbr7KUNa0AtgjRdU9ik4P9Ab
         HCxK0AEU+cZ3h2aKD7buy63bpzJiwSbz7X3a7YglUv3K0+SF4wM3SbrE4Dhk+MVhvT42
         trhw==
X-Gm-Message-State: APjAAAWFS8reb3SGwNHP/buQt8Fpr/NQcDQB8RasBA/c8Iygqn7pul0x
        +Y1x7dybkWieNiqwsiGOqzt9gvrHAeYLJQ==
X-Google-Smtp-Source: APXvYqxgmEpiVeLF3XJCoR505jhuWbx/CW7TxVDFN3I3miphrKm6TiRF71WtKd6tpywv2xpw6YwQrw==
X-Received: by 2002:a05:6e02:546:: with SMTP id i6mr12379669ils.54.1572619384454;
        Fri, 01 Nov 2019 07:43:04 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n28sm985343ili.70.2019.11.01.07.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 07:43:03 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Make blk_mq_run_hw_queue() return void
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1572368370-139412-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <411ad78b-ba8c-cbee-f4f4-19a626cbfc0f@kernel.dk>
Date:   Fri, 1 Nov 2019 08:43:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572368370-139412-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/19 10:59 AM, John Garry wrote:
> Since commit 97889f9ac24f ("blk-mq: remove synchronize_rcu() from
> blk_mq_del_queue_tag_set()"), the return value of blk_mq_run_hw_queue()
> is never checked, so make it return void, which very marginally simplifies
> the code.

Applied, thanks.

-- 
Jens Axboe

