Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E896F17062B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 18:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBZRfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 12:35:05 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33258 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgBZRfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:35:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so1566859plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W0ORnmhkVOepGQNpJnxgqzW17jpKHirCqyJGUQC2QyA=;
        b=ijc5l2c1gKpMUhbpxqwqUqym5Ucu4whlkI/5Scz+IFKbThiygFjK4ZOT6c6VMMRbil
         4RjhIaNqqwL8SjTJ7XjtPgLewiTYh5zJqHq1B8Ovpp39iFNi7D6SFJETJ4DFgWtRZVzM
         aS2l6jL/6kN94aDrzdyGevV1WeJ0BuMk3S6vFoDPgCDgBHR49GnZEnF0ZClMoneIEqbX
         nxjkSomQ1kE7FTVuZPn4L8HqhcUjY3+WSXoo5K+0wu4HwfrXq+RzgHM64b0dHEjPxv02
         NFz/xK4gOISZDJK3wqPPgpOREA6fwc/WAoP4zwpu1YLzmJqoSP4e//C2HTzQuxVvVsDs
         EA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W0ORnmhkVOepGQNpJnxgqzW17jpKHirCqyJGUQC2QyA=;
        b=baMsy/JliCIX6x7c7DNGl+x22QEo4pj0AJp5C9wwqBJto8ROz279d0ZK4y0zT1NJ7B
         3Ows/J+0c7VlTCp57NhJQPuxEfxcioYnJ2Hfdu2FJmr7mI6XiA1sosgLkUhXS4NGX37/
         fSUk1PW6/1fcVu4Gb4sYboxgjHNOnVbYqCEB4GXp/rht2sPbS2vWOskNEquf3+okxmTK
         A4Abit+xOXWy28wwos2Uj1Hc5vHxrLNazY1CpfGxfmIxTnRsIVmPOFPQ67d5OdPVsj68
         EaKv+L6Yftvow0MS81rwoaFjPbT8vkg2Cvqu2HoQY6obr7/relLSB1TF3iskwyfFY9Ne
         bgWA==
X-Gm-Message-State: APjAAAUORa4/QkifCaajKd+j6BoREl/if1u2s85+0KVgoADr2+RXWBU8
        HErrB/kmKRRr3I0yAa7JhLF2iyW6eB+/0A==
X-Google-Smtp-Source: APXvYqxaSNdzyPXXWw7+ywNDTuXjozwt22BS/Ee83Ah9XJ5Js3PHigmunVGkZZaKRuMQ1YCX18GiDg==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr410020ply.68.1582738503463;
        Wed, 26 Feb 2020 09:35:03 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21d6::137a? ([2620:10d:c090:400::5:890])
        by smtp.gmail.com with ESMTPSA id 3sm3534168pjg.27.2020.02.26.09.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 09:35:02 -0800 (PST)
Subject: Re: [PATCH] blk-mq: Remove some unused function arguments
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1582719015-198980-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c245ec10-7c30-b0ce-6d1e-d23164b175a7@kernel.dk>
Date:   Wed, 26 Feb 2020 10:35:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582719015-198980-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/20 5:10 AM, John Garry wrote:
> The struct blk_mq_hw_ctx pointer argument in blk_mq_put_tag(),
> blk_mq_poll_nsecs(), and blk_mq_poll_hybrid_sleep() is unused, so remove
> it.
> 
> Overall obj code size shows a minor reduction, before:
>    text	   data	    bss	    dec	    hex	filename
>   27306	   1312	      0	  28618	   6fca	block/blk-mq.o
>    4303	    272	      0	   4575	   11df	block/blk-mq-tag.o
> 
> after:
>   27282	   1312	      0	  28594	   6fb2	block/blk-mq.o
>    4311	    272	      0	   4583	   11e7	block/blk-mq-tag.o

Applied, thanks.

-- 
Jens Axboe

