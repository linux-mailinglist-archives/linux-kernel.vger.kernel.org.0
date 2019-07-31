Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA07C56A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbfGaOxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 10:53:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36080 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388075AbfGaOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:53:25 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so33283822iom.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zlcAXkKW8QVqrB0POXO1HOMAe1Y+4ab/2cQba0Zxxzc=;
        b=dHTL7S/edkTumLq61B3dgRSTYGv9sotAJDMUJepTiJ29to2FTPzeJyv09hKFMXSzVd
         KVPKvqqxnR/Oh93EXD/+aFdn2oJMNE728ofoODS4waMtHAjizmUISSWpa+PZSNsMK6NQ
         D4CDBalZTrgsHbDmKAYrktzLxkox+OFDWkabHXC0WMtzWNWuyZqFzjM9SZoMlUM6fHy3
         9gbAeeSYDTQl6aace1YXOpFKb0gJ082cn/p7wayzz/OmrcxO69KKCcvN0V7GBreuTHvJ
         Ds3VuIZk98nydQHyX418KEGGQp02TOtX8eDxYbChd7t564PMfRLKvw9ZmOo/KQMqaLLe
         FQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zlcAXkKW8QVqrB0POXO1HOMAe1Y+4ab/2cQba0Zxxzc=;
        b=XQvqY3yevhbrsDA8nVdNvJNa+vAQp1L3vsMc8XFBGBvIbBr/Cg7ZdKckyv4xBkwbPK
         1QXU7ENXMWHWGmt26D9cyAabjTJhAqlAwywmkHriioqSDcgGBcr8kuagUJjoY5diUK/G
         o6xdMepHtjtTriwmo3Vpj8k4rLVtou9oqDI1NOUmi+Ji8qtXd3LkXIvSj339zGTz7M9Q
         GDy+O4sxLnn58bjFXi1GxeNYEZYm/AXGS+NR5lr1dDDoT7HtpIJw5zU5KIybputOvXCr
         iS6aimzw0cTySBSom+Elvtwk7LkOpjwX/bnlTP53HFzrkbHM6XuxYoCzIcjZKzfkAjow
         Fngg==
X-Gm-Message-State: APjAAAU7IjNlkKyGtx0av3I3Nvw8GgQF9BTWoQqg35k3Fky8Ng9lxn9v
        GpITXo2YdutxRK52xeS+fracMGttuNI=
X-Google-Smtp-Source: APXvYqx+BXSVFPqAnw9J/ZjOuQ8bb3S7c7lnWx+PLlV1IxzY4n+cXUeefovmQctozHourMkeKSzzsA==
X-Received: by 2002:a5e:9e0a:: with SMTP id i10mr2803063ioq.44.1564584804230;
        Wed, 31 Jul 2019 07:53:24 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y18sm65072836iob.64.2019.07.31.07.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 07:53:23 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: floppy: take over maintainership
To:     efremov@linux.com, Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Will Deacon <will@kernel.org>,
        Greg KH <greg@kroah.com>,
        Alexander Popov <alex.popov@linux.com>, efremov@ispras.ru,
        linux-block@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20190712185523.7208-1-efremov@ispras.ru>
 <20190713080726.GA19611@1wt.eu>
 <ec0a6c5e-bdee-3c26-f5d2-31b883c0de5d@ispras.ru>
 <CAHk-=wi=fHuiQg1fMzqAP9cuykBQSN_feD=eALDwRPmw27UwEg@mail.gmail.com>
 <nycvar.YFH.7.76.1907172355020.5899@cbobk.fhfr.pm>
 <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <431bd981-d81a-d4dd-75fe-96a29f8f1065@kernel.dk>
Date:   Wed, 31 Jul 2019 08:53:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 8:47 AM, Denis Efremov wrote:
> Hi All,
> 
> On 18.07.2019 01:03, Jiri Kosina wrote:
>> On Wed, 17 Jul 2019, Linus Torvalds wrote:
>>
>>> I don't think we really have a floppy maintainer any more,
>>
>> Yeah, I basically volunteered myself to maintain it quite some time
>> ago back when I fixed the concurrency issues which exhibited itself
>> only with VM-emulated devices, and at the same time I still had the
>> physical 3.5" reader.
>>
>> The hardware doesn't work any more though. So I guess I should just
>> remove myself as a maintainer to reflect the reality and mark floppy.c
>> as Orphaned.
> 
> Well, without jokes about Thunderdome, I've got time, hardware and
> would like to maintain the floppy. Except the for recent fixes,
> I described floppy ioctls in syzkaller. I've already spent quite
> a lot of time with this code. Thus, if nobody minds

Great, can't see anyone objecting to doling out some floppy love.
Applied, thanks.

-- 
Jens Axboe

