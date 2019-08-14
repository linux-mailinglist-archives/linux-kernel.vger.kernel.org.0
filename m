Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37508D4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 15:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfHNNco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 09:32:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:47642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfHNNcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:32:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 253AFB04F;
        Wed, 14 Aug 2019 13:32:38 +0000 (UTC)
Subject: Re: [PATCH] regmap: fix writes to non incrementing registers
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, nandor.han@vaisala.com
References: <20190813212251.12316-1-ben.whitten@gmail.com>
 <20190814100115.GF4640@sirena.co.uk>
 <CAF3==iuZvCnmAg9hqs8ivHw0wHaUQEf8k9U8=KTekMMjdyyEKg@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <4ba5dd72-4a55-c383-0899-62109f10c020@suse.de>
Date:   Wed, 14 Aug 2019 15:32:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAF3==iuZvCnmAg9hqs8ivHw0wHaUQEf8k9U8=KTekMMjdyyEKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.08.19 um 15:09 schrieb Ben Whitten:
> On Wed, 14 Aug 2019 at 11:01, Mark Brown <broonie@kernel.org> wrote:
>>
>> On Tue, Aug 13, 2019 at 10:22:51PM +0100, Ben Whitten wrote:
>>
>>> @@ -1489,10 +1489,11 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
>>>       WARN_ON(!map->bus);
>>>
>>>       /* Check for unwritable registers before we start */
>>> -     for (i = 0; i < val_len / map->format.val_bytes; i++)
>>> -             if (!regmap_writeable(map,
>>> -                                  reg + regmap_get_offset(map, i)))
>>> -                     return -EINVAL;
>>> +     if (!regmap_writeable_noinc(map, reg))
>>> +             for (i = 0; i < val_len / map->format.val_bytes; i++)
>>> +                     if (!regmap_writeable(map,
>>> +                                          reg + regmap_get_offset(map, i)))
>>> +                             return -EINVAL;
>>
>> This feels like we're getting ourselves confused about nonincrementing
>> registers and probably have other breakage somewhere else - we're
>> already checking for nonincrementability in regmap_write_noinc(), and
>> here we're only checking if the first register in the block has that
>> property which might blow up on us if there's a register in the middle
>> of the block that is nonincrementable.  If we're going to check this
>> here I think we should check on every register, but this is
>> _raw_write_impl() which is part of the call path for implementing
>> regmap_noinc_write() so checking here will break the API purpose
>> designed for nonincrementing writes.
> 
> So it appeared that the last patch in this area for validating a register
> block [1] broke the regmap_noinc_write use case.

Then please add a Fixes: header to your commit message, so that it gets
backported to all affected upstream and downstream trees.

Thanks,
Andreas

> Because regmap_noinc_write calls _regmap_raw_write and in
> turn hits the _regmap_raw_write_impl, the val_len is the depth of the
> one register to write to and not a block of registers which is assumed
> by the previous check. By inserting a check that the first (and only)
> register is a noinc one allows me to start writing to my FIFO again.
> 
> I'm all for an alternative solution though if there is a cleaner approach.
> 
> Kind regards,
> Ben
> 
> [1] https://lore.kernel.org/patchwork/patch/1057184/
> 


-- 
SUSE Linux GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
