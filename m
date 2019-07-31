Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8777C699
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 17:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfGaPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 11:31:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41638 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfGaPbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:31:10 -0400
Received: by mail-io1-f65.google.com with SMTP id j5so133048424ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NhDp9pB52pEJ9oRSh1f9rOMY2HRPDd+xxEBM3tyomOA=;
        b=KiEwryaotyWrJjNgeSpDaJXe1nW/Kc3GwwMNMx04fKoGaN9GQjSX5+Kkm3KXxhaYpE
         ygjDhFMPIVMGhBpr+7Xe0o0x0ut78ghCFj/Sb1+Z5+PUhR2l10jY/jQU1n/4bsP6cVEf
         2vKxLtbMLXK6WZWHSBacQe2wGDOM9nhDVekIdZqvvxXOyBb7Yewuw07ZieaTv6OfLrqP
         gTiQZBGS/Oj5NbArVgHD2Wqvz46vGEvmWlUi8wB1E0+MtkxShFQXsJ0WbKG+WvH0jZad
         eDETGaRcbelhCY3YPbD59ynmcQgORQbhBf16FgTzNjGZpxowTbgC6T8piKFAbe2fWmrk
         dprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NhDp9pB52pEJ9oRSh1f9rOMY2HRPDd+xxEBM3tyomOA=;
        b=G0DmyXP4Eic6PZc9wrddCWZxknxrghfd446KepbdU+4OntleFlDmK8nfYT1UXp64yR
         4qjFWYhRZbeeJbvxhkoictri0c6Jctbxp2dbzXbMkww/nX1N7uVR1zheNb+I6164JXt3
         HrLRLpSdbaN/tnfBa5glSUe3OzZnh/eAmBM2juaEQBoB7KHs42eD4jaN2TufBLoxL++5
         8hy6xMapDpCjJ5Vy18vGT5BB8/mW4RwduWgTgv8KEahAqNeHnBKtVlusODonL3yJVVS8
         xcn9AxZK7KEiKPwBgxJNefBSXMILeJI3Voo+4OHt0+Q4OunlDUAcUA+mH9wDzOFHLqdF
         osEA==
X-Gm-Message-State: APjAAAVn7RlnmdX5ENcQ7gf+WvN3QKcjvnXxGx/+qlhxrATuoV3B24pG
        u5+iYU5AVdJMwah8H8q5NjwZWoY61SA=
X-Google-Smtp-Source: APXvYqwGXXjJXjEsoxOuddpeliVA63sBvMHhTn1ZCrzLO5mUN9Bt6IhneaHjxuTusUpX/lvztpwbIw==
X-Received: by 2002:a5e:9b05:: with SMTP id j5mr50822005iok.75.1564587068518;
        Wed, 31 Jul 2019 08:31:08 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l2sm48642691ioh.20.2019.07.31.08.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:31:07 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: floppy: take over maintainership
To:     Will Deacon <will@kernel.org>
Cc:     efremov@linux.com, Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, Greg KH <greg@kroah.com>,
        Alexander Popov <alex.popov@linux.com>, efremov@ispras.ru,
        linux-block@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20190712185523.7208-1-efremov@ispras.ru>
 <20190713080726.GA19611@1wt.eu>
 <ec0a6c5e-bdee-3c26-f5d2-31b883c0de5d@ispras.ru>
 <CAHk-=wi=fHuiQg1fMzqAP9cuykBQSN_feD=eALDwRPmw27UwEg@mail.gmail.com>
 <nycvar.YFH.7.76.1907172355020.5899@cbobk.fhfr.pm>
 <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
 <431bd981-d81a-d4dd-75fe-96a29f8f1065@kernel.dk>
 <20190731152220.xgif4fwyqybb37pp@willie-the-truck>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e98a4fdd-530b-28e0-f8a3-cc8fb1b95320@kernel.dk>
Date:   Wed, 31 Jul 2019 09:31:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731152220.xgif4fwyqybb37pp@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 9:22 AM, Will Deacon wrote:
> On Wed, Jul 31, 2019 at 08:53:22AM -0600, Jens Axboe wrote:
>> On 7/31/19 8:47 AM, Denis Efremov wrote:
>>> Hi All,
>>>
>>> On 18.07.2019 01:03, Jiri Kosina wrote:
>>>> On Wed, 17 Jul 2019, Linus Torvalds wrote:
>>>>
>>>>> I don't think we really have a floppy maintainer any more,
>>>>
>>>> Yeah, I basically volunteered myself to maintain it quite some time
>>>> ago back when I fixed the concurrency issues which exhibited itself
>>>> only with VM-emulated devices, and at the same time I still had the
>>>> physical 3.5" reader.
>>>>
>>>> The hardware doesn't work any more though. So I guess I should just
>>>> remove myself as a maintainer to reflect the reality and mark floppy.c
>>>> as Orphaned.
>>>
>>> Well, without jokes about Thunderdome, I've got time, hardware and
>>> would like to maintain the floppy. Except the for recent fixes,
>>> I described floppy ioctls in syzkaller. I've already spent quite
>>> a lot of time with this code. Thus, if nobody minds
>>
>> Great, can't see anyone objecting to doling out some floppy love.
> 
> Whatever that involves, I don't like the sound of it.

Floppy love? It's not that hard.

This is where we need GIFs in kernel communication...

> Here's a belated Ack if you can add it:
> 
> Acked-by: Will Deacon <will@kernel.org>

Added, thanks.

-- 
Jens Axboe

