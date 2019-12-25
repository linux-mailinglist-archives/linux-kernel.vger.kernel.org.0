Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A9512A8DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 19:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLYS0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Dec 2019 13:26:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32907 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 13:26:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id c13so9657458pls.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 10:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cJYp9ftX998bOD2V8Vxk7qy7RjelI9Sr1IIEWlQTCXQ=;
        b=ky9gPXYeEpV+D3g7hOpEEvUPYTARCflLE+a5L1hDI3yIVTtN168Dcea1lIZf2xFI5R
         WK0UExCzY5Iay0lfVz9dRmMnYY4JMTRUrybskWcQ5UgQLlg+zNiHBRL9fTsgSt6hL2Tg
         ZZGaR2LaJFs0GVsNc10fSCvjpYZwxUc13UMu7lTubusA0o5/+ZDK/xGiNTdRvBc+sZ2V
         r8u2q/O8CF/UbNI2fSwTyl+AQhV8WNhuBJGusFjknPV8hN2kngHl3yodff5OS71xNGt4
         RflsCZcI4neH3y1guWJ9C/HgdOjly1EeDWZTasbJabNYZuhvLmVqA9sh+lm6esuhM2Kd
         w4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cJYp9ftX998bOD2V8Vxk7qy7RjelI9Sr1IIEWlQTCXQ=;
        b=bESCCAZq1uoGE+nV9rOfpu9xnyyut//7mjBNRs746RqVX/9+/ryLoM5ZkT0+uumfff
         NGNarMAXCeeQi3Dthd58ZZO1Ir0SJeKS5Nk9itXUahj2SoEiqOYsedmLt6YrMXdnSwMH
         8rLeYm5+6UzgAOj0AX0TF1uURcTemYkRMags4nKVFgjz3EcuguBO2MZY/df1xTrbg+d5
         a7eaqeMeCQqBGCWAztP4WZKK3PGaVJnxOe5WEDi1sOH2ufkZ9u8dfp94IkAHKnrT/dmP
         Z5lMVmInP8pNkxbnJADq/U/cKx8MOVM6EyGda/128TPdHgWRO7oVBUuzfytClvKrup31
         yM7Q==
X-Gm-Message-State: APjAAAXuEI0kUUbsMAwXEIQg915SHPBF99oWcGdvLyQKCCoqFxw3YWJD
        b+pcjvJGR6Vg9IjGFEtPlS0BeRhs9ZAJug==
X-Google-Smtp-Source: APXvYqzijgi1D01D1/dSwpZ9J8vTDYBdT1hbIGKMwddZwSbvzIQB32QEQRokAuC8+dyI74K6J6t4Ug==
X-Received: by 2002:a17:90a:ad48:: with SMTP id w8mr14422989pjv.19.1577298409752;
        Wed, 25 Dec 2019 10:26:49 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id i23sm12227476pfo.11.2019.12.25.10.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Dec 2019 10:26:49 -0800 (PST)
Subject: Re: [PATCH v2] libata: Fix retrieving of active qcs
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20191213080408.27032-1-s.hauer@pengutronix.de>
 <20191225181840.ooo6mw5rffghbmu2@pali>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad600bac-fd26-2d6b-85e6-372c072be9f5@kernel.dk>
Date:   Wed, 25 Dec 2019 11:26:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191225181840.ooo6mw5rffghbmu2@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/19 11:18 AM, Pali Rohár wrote:
> Hello Sascha!
> 
> On Friday 13 December 2019 09:04:08 Sascha Hauer wrote:
>> ata_qc_complete_multiple() is called with a mask of the still active
>> tags.
>>
>> mv_sata doesn't have this information directly and instead calculates
>> the still active tags from the started tags (ap->qc_active) and the
>> finished tags as (ap->qc_active ^ done_mask)
>>
>> Since 28361c40368 the hw_tag and tag are no longer the same and the
>> equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
>> initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
>> started and this will be in done_mask on completion. ap->qc_active ^
>> done_mask becomes 0x100000000 ^ 0x1 = 0x100000001 and thus tag 0 used as
>> the internal tag will never be reported as completed.
>>
>> This is fixed by introducing ata_qc_get_active() which returns the
>> active hardware tags and calling it where appropriate.
>>
>> This is tested on mv_sata, but sata_fsl and sata_nv suffer from the same
>> problem. There is another case in sata_nv that most likely needs fixing
>> as well, but this looks a little different, so I wasn't confident enough
>> to change that.
> 
> I can confirm that sata_nv.ko does not work in 4.18 (and new) kernel
> version correctly. More details are in email:
> 
> https://lore.kernel.org/linux-ide/20191225180824.bql2o5whougii4ch@pali/T/
> 
> I tried this patch and it fixed above problems with sata_nv.ko. It just
> needs small modification (see below).
> 
> So you can add my:
> 
> Tested-by: Pali Rohár <pali.rohar@gmail.com>
> 
> And I hope that patch would be backported to 4.18 and 4.19 stable
> branches soon as distributions kernels are broken for machines with
> these nvidia sata controllers.
> 
> Anyway, what is that another case in sata_nv which needs to be fixed
> too?

Thanks for testing, I've applied this for 5.5 and marked it for stable.

-- 
Jens Axboe

