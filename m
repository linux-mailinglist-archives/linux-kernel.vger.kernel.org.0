Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F509358A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 10:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfFEIgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 04:36:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfFEIgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:36:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D65E830860BD;
        Wed,  5 Jun 2019 08:36:00 +0000 (UTC)
Received: from [10.43.17.112] (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFD045F7C2;
        Wed,  5 Jun 2019 08:35:50 +0000 (UTC)
Subject: Re: [dm-devel] [PATCH v12] dm: add support to directly boot to a
 mapped device
To:     Stephen Boyd <swboyd@chromium.org>,
        Helen Koike <helen.koike@collabora.com>, dm-devel@redhat.com
Cc:     wad@chromium.org, keescook@chromium.org, snitzer@redhat.com,
        linux-doc@vger.kernel.org, richard.weinberger@gmail.com,
        linux-kernel@vger.kernel.org, linux-lvm@redhat.com,
        enric.balletbo@collabora.com, kernel@collabora.com, agk@redhat.com
References: <20190221203334.24504-1-helen.koike@collabora.com>
 <5cf5a724.1c69fb81.1e8f0.08fb@mx.google.com>
 <d6b4fb26-9a1b-0acd-ce4a-e48322a17e7d@collabora.com>
 <5cf6c7e6.1c69fb81.e1551.8ac4@mx.google.com>
From:   Zdenek Kabelac <zkabelac@redhat.com>
Organization: Red Hat
Message-ID: <c5eae05c-f209-8578-f7fd-cd2feabb309c@redhat.com>
Date:   Wed, 5 Jun 2019 10:35:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5cf6c7e6.1c69fb81.e1551.8ac4@mx.google.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 05 Jun 2019 08:36:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 04. 06. 19 v 21:35 Stephen Boyd napsal(a):
> Quoting Helen Koike (2019-06-04 10:38:59)
>> On 6/3/19 8:02 PM, Stephen Boyd wrote:
>>>
>>> I'm trying to boot a mainline linux kernel on a chromeos device with dm
>>> verity and a USB stick but it's not working for me even with this patch.
>>> I've had to hack around two problems:
>>>
>>>   1) rootwait isn't considered
>>>
>>>   2) verity doesn't seem to accept UUID for <hash_dev> or <dev>
>>>
>>> For the first problem, it happens every boot for me because I'm trying
>>> to boot off of a USB stick and it's behind a hub that takes a few
>>> seconds to enumerate. If I hack up the code to call dm_init_init() after
>>> the 'rootdelay' cmdline parameter is used then I can make this work. It
>>> would be much nicer if the whole mechanism didn't use a late initcall
>>> though. If it used a hook from prepare_namespace() and then looped
>>> waiting for devices to create when rootwait was specified it would work.
>>
>> The patch was implemented with late initcall partially to be contained
>> in drivers/md/*, but to support rootwait, adding a hook from
>> prepare_namespace seems the way to go indeed.
> 
> Alright, great.
> 
>>
>>>
>>> The second problem is that in chromeos we have the bootloader fill out
>>> the UUID of the kernel partition (%U) and then we have another parameter
>>> that indicates the offset from that kernel partition to add to the
>>> kernel partition (typically 1, i.e. PARTNROFF=1) to find the root
>>> filesystem partition. The way verity seems to work here is that we need
>>> to specify a path like /dev/sda3 or the major:minor number of the device


Hi

As not a direct dm developer - isn't this going a bit too far ? -
This way you will need to soon move halve of the userspace functionality into 
kernel space.

IMHO would be way more progressive to start using initramdisk and let 
userspace resolve all the issue.

Clearly once you start to wait for some 'devices' to appear - then you will 
need to way for CORRECT device as well - since sda,sdb... goes in random 
order, so you would need to parse disk headers and so on.

What you are effectively doing at this moment is you are shifting/ballooning 
'ramdisk' code into kernel image - just to be named a kernel.

So why it is so big deal to start to use ramdisk on ChromeOS?
That would have solved most of problems you have or you will have instantly.

Regards

Zdenek
