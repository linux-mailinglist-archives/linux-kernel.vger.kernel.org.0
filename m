Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D0315B59E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 01:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgBMADV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 19:03:21 -0500
Received: from ishtar.tlinx.org ([173.164.175.65]:53526 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBMADU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:03:20 -0500
X-Greylist: delayed 1819 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 19:03:20 EST
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id 01CNWvUV014523;
        Wed, 12 Feb 2020 15:33:00 -0800
Message-ID: <5E448B29.1080705@tlinx.org>
Date:   Wed, 12 Feb 2020 15:32:57 -0800
From:   L Walsh <cifs@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Steve French <smfrench@gmail.com>
CC:     CIFS <linux-cifs@vger.kernel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CIFS][PATCH] Add SMB3/Win10-only  Change Notify
References: <CAH2r5mtQRVX3_-_sVjvigRSv2LpSoUBQo7YeY5v0nXm7BGaDig@mail.gmail.com> <5E413F22.3070101@tlinx.org> <CAH2r5mst9FjdPrBQdjt1HGkf73VoNzDUxPSEQNZwyi=9W9XGhA@mail.gmail.com>
In-Reply-To: <CAH2r5mst9FjdPrBQdjt1HGkf73VoNzDUxPSEQNZwyi=9W9XGhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/02/10 06:30, Steve French wrote:
>
>>     By calling it a SMB3 feature, does that mean you are removing
>> it from SMB2?
>>     
>
> That is a good question.  I should have made more clear that although
> many servers support Change Notify prior to SMB3 dialect, we chose
> to implement it in SMB3 (late 2012 and later dialect) to minimize testing
> risks and since we want to encourage users to use SMB3 or later (or
> at least SMB2.1 or later since security is significantly better for later
> dialects than for SMB1 and even SMB2)
>   
----
    SMB2.1 would be fine for my purposes, I find it a bit odd though that
my linux server running these changes won't be as capable of detecting
directory changes as an outdated Win7 machine. 

    There are many below-SMB3 speaking devices out in the world right now. 
Probably many below 2.1. 

    You say you want to "encourage users to use SMB3 or later (or at least
SMB2.1)", how does adding SMB3-only support allow users to use SMB2.1?
Say your encouragement of users is taken to heart, and they want to use 
SMB3.
How would those users upgrade the dialect of SMB used in their
machine or device?  I don't know of any easy way to upgrade existing 
devices -
even existing OS's, if a user ran Win7, how would they upgrade the CIFS
drivers to 3.0?

    If it is not possible to upgrade existing devices, then wouldn't that
encouragement boil down to junking the device and buying a new one?
> Change Notify is available in all dialects (SMB2, SMB2.1, SMB3, SMB3.1.1)
> for many servers but for the client we just implemented it for SMB3 and later.
>   
    Doesn't that mean that the linux client won't be able to access 
existing
NAS servers or Win-Client machine running anything other than Win10?  Does
the current version of samba provide full SMB3 support?  If not, doesn't 
that
imply that the client for CIFS won't be able to access or use these features
from another linux server?
> If you have a server that you want to support that requires
> SMB2 or SMB2.1 mounts, I wouldn't mind a patch to add notify support
> for those older dialects but I would like to encourage use of SMB3 or later (or
> at least SMB2.1 or later) where possible.
>   
    Again, how does implementing SMB3-only, only support SMB2.1 or later?

    If you feel it would be trivial to add such a patch, wouldn't you be in
the position of, probably, having the most knowledge about the subject 
and be
likely to do the best job without breaking anything else?  Certainly doesn't
mean someone else couldn't but seems riskier than offering a Linux 
client that
would be able to access the widest range of existing devices and 
computers from
the start.

Thanks!
Linda







