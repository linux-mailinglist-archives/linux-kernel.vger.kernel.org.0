Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F1819A1F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 00:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbgCaWc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 18:32:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62014 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:32:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EB225E923;
        Tue, 31 Mar 2020 18:32:23 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=ij8E2mP4qn59
        jj81vTeQK6B7GHM=; b=dXRKPE5N4m7oXAcItLUINV5/aqGBbNL9+oXl1FMODExK
        j4cC6UHcXb9i2bFG2Sj19JpkR8aHIlskVH0wbLizueh/UA64CfMqz9tIqDyVIXZN
        Hr2EHeGpohsN493+2FHsCl9lnoAhc5t9IH7YCeUuG6+ZvUhUF6T7d+PTR92jg1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ikshDs
        vqIHah/bWJ1uWaMmIWWdFR8pcP3B3w20KKbAT8SH3CEdNn9T6xX5ZNW1+Q/Dndwm
        x1WY/CAv5Z66KQeIJpGdYxSAdCBxqFur9tboO1FiGDVoX38mEJI1kIMNZOCoBSML
        Hih51i3nhK/SX3fkHxvHMtxwhgxF4+qgTj/ps=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 955CA5E922;
        Tue, 31 Mar 2020 18:32:23 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
Received: from [192.168.0.8] (unknown [76.183.130.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64C775E921;
        Tue, 31 Mar 2020 18:32:17 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Joe Perches <joe@perches.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
 <dc53b8704ec674cba636b41d7f55bf507a7bd7aa.camel@perches.com>
 <123d3606-cebf-4261-4b04-7d53d1fcdb07@prevas.dk>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <7acde2e5-60dd-f384-fda7-1d018608f8e7@pobox.com>
Date:   Tue, 31 Mar 2020 17:30:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <123d3606-cebf-4261-4b04-7d53d1fcdb07@prevas.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: 7D88B43C-739F-11EA-BD69-C28CBED8090B-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/20 1:56 PM, Rasmus Villemoes wrote:
> On 31/03/2020 20.20, Joe Perches wrote:
>> On Tue, 2020-03-31 at 13:26 +0200, Vegard Nossum wrote:
>>>  #define compiletime_assert(condition, msg) \
>>> -	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__=
)
>>> +	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTE=
R__)
>> This might be better using something like __LINE__ ## _ ## __COUNTER__
>>
>> as line # is somewhat useful to identify the specific assert in a file=
.
>>
> Eh, if the assert fires, doesn't the compiler's diagnostics already
> contain all kinds of location information?
>
> Rasmus

Yes, the diagnostic contains the file name and line in a far more useful
format that every IDE knows how to read.=C2=A0 __LINE__ is only used for
uniqueness and was chosen when __COUNTER__ (introduced in gcc 4.3) was
still somewhat new.

Daniel
