Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84739192B58
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 15:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCYOlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 10:41:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34689 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCYOlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:41:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id 23so1148924pfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XCINa/bqSDUlqZD8AeDZCCs9KQApmzJ+EcZpMaMnQiE=;
        b=1y4th5zBJLAPdinDNsQAcPCnP07KOhdoUwWMiLuJy3AnWXSs87PyhBJVRJOWhdDEwM
         VI8UIkGRgodl0kURsdq28TpG4tvJiZYoUpX3sbQ13F2cWFaiMA9zpRByORW/kD3lQmd5
         HCND+yoyVa6cGABwLtFEZ7Xge6/BR6sPuLuV+9r3uHLOJ21imyaxvuqROpeDze2k1GYW
         7XpnLfSi35tZsLpWrqOIbwMeg4VdaeQBkEB2V7HMGkGYiYFfb2S4IAsm4eb6Aw8kj4go
         2n8voRavhgEMowTT4yKTn1nx0TfBmnPNWliyhA9S4UtZBN24HqzMkUalaevIzeIlqLCY
         kp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XCINa/bqSDUlqZD8AeDZCCs9KQApmzJ+EcZpMaMnQiE=;
        b=WN6xOum6E9ykJ0p1NJD+gFtP60K0B61OHtpaYtMKlS1p6wttYyteCDMQa8iApIxW1V
         yyH5PAmKmMFMb+XnqHn0M2sGwdqxU8CZZogkO1wQ5Z6QiQvA757bqMRar7EHx0c9/Yo+
         GR7EdyEjQW2kGKH+QX183S8L5yYTT88YzQe4kcZ63aRcWwe/2I0TrN2IWgmYSoZMWkcG
         jEPpS8T2rguI4jTAwYlbDDaRKIGEZlyXD6DgGF1jp6H2rb7qT2sYtwqANV+NAWgo/lqO
         He36nuBiKenpdDpL5EDCtJbftUw8K0X9mSsD6bBQv+z62wGC1utpHOaI6nm0JIZjGoqo
         lbiA==
X-Gm-Message-State: ANhLgQ3qSzog989vWOw+DgxNUsMxEbimmE9UqLGpd1lAs9/qSUC4vmkT
        fm4Z2xmdeV3MfT9WjhGvlUQDIA==
X-Google-Smtp-Source: ADFU+vsylQYqAZKy5Es0twsf9ymu9IpbEgQlJ6+DrsNkH7/GdDMgZpHpjf4lMyTBpW2WLfcpVjSULQ==
X-Received: by 2002:a63:2948:: with SMTP id p69mr3644131pgp.238.1585147312228;
        Wed, 25 Mar 2020 07:41:52 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id d3sm18690858pfq.126.2020.03.25.07.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:41:51 -0700 (PDT)
Subject: Re: [PATCH liburing] Add test/splice to .gitignore
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20200325083321.16826-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d2c5888d-0acc-248f-833d-b60f9960a37c@kernel.dk>
Date:   Wed, 25 Mar 2020 08:41:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325083321.16826-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 2:33 AM, Stefano Garzarella wrote:
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 9f85a5f..db163b4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -74,6 +74,7 @@
>  /test/shared-wq
>  /test/short-read
>  /test/socket-rw
> +/test/splice
>  /test/sq-full
>  /test/sq-poll-kthread
>  /test/sq-space_left

Applied, thanks.

-- 
Jens Axboe

