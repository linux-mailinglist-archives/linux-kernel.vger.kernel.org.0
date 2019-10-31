Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974D5EAD3B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 11:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfJaKNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 06:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbfJaKNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:13:13 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECF832086D;
        Thu, 31 Oct 2019 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572516791;
        bh=FpbMDfv8rJys/rg1TJkY++RodY4nxFvHJUJXHzff7kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCg078ifna1ZQnORalodJkXnTkUgBOMjWD0qxTpfti9/DfROrXVZAm9EgS0IHRGJY
         O+wbtjFiMeATly2PGRfDu4To26zZH5pX9UAQOIphbUMEYqipPrQKVs95xOD2t6OTSq
         3wmyPhYbmWM7+cmhkiND8aIKSLD6IORbXXb1oi5E=
Date:   Thu, 31 Oct 2019 11:13:06 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] module: avoid code duplication in
 include/linux/export.h
Message-ID: <20191031101306.GA2177@linux-8ccs>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-5-yamada.masahiro@socionext.com>
 <f2e28d6b-77c5-5fe2-0bc4-b24955de9954@rasmusvillemoes.dk>
 <20191029191925.GA19316@linux-8ccs>
 <a2e6bdc2-3d35-a3dc-13ef-1ce32f77ef17@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2e6bdc2-3d35-a3dc-13ef-1ce32f77ef17@rasmusvillemoes.dk>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Rasmus Villemoes [29/10/19 22:11 +0100]:
>On 29/10/2019 20.19, Jessica Yu wrote:
>> +++ Rasmus Villemoes [27/09/19 13:07 +0200]:
>>> On 27/09/2019 11.36, Masahiro Yamada wrote:
>>>>
>>>> A typical kernel configuration has 10K exported symbols, so it
>>>> increases 10KB in rough estimation.
>>>>
>>>> I did not come up with a good idea to refactor it without increasing
>>>> the code size.
>>>
>>> Can't we put the "aMS" flags on the __ksymtab_strings section? That
>>> would make the empty strings free, and would also deduplicate the
>>> USB_STORAGE string. And while almost per definition we don't have exact
>>> duplicates among the names of exported symbols, we might have both a foo
>>> and __foo, so that could save even more.
>>>
>>> I don't know if we have it already, but we'd need each arch to tell us
>>> what symbol to use for @ in @progbits (e.g. % for arm). It seems most
>>> are fine with @, so maybe a generic version could be
>>>
>>> #ifndef ARCH_SECTION_TYPE_CHAR
>>> #define ARCH_SECTION_TYPE_CHAR "@"
>>> #endif
>>>
>>> and then it would be
>>> section("__ksymtab_strings,\"aMS\","ARCH_SECTION_TYPE_CHAR"progbits,1")
>>
>> FWIW, I've just tinkered with this, and unfortunately the strings
>> don't get deduplicated for kernel modules :-(
>>
>> Apparently ld does not do the deduplication for SHF_MERGE|SHF_STRINGS
>> sections for relocatable files (ld -r), which kernel modules are. See:
>>
>>    https://sourceware.org/ml/binutils/2009-07/msg00291.html
>
>I know <https://patches-gcc.linaro.org/patch/5858/> :)

That is exactly what we need! :)

>> But, the strings do get deduplicated for vmlinux. Not sure if we can
>> find a workaround for modules or if the benefit is significant enough
>> if it only for vmlinux.
>
>I think it's definitely worth if, even if it "only" benefits vmlinux for
>now. And I still hope to revisit the --force-section-merge some day, but
>it's very far down my priority list.

Yeah, I think it's worth having too.

If you don't have any extra cycles at the moment, and it's far down
your priority list, do you mind if I take a look and maybe try to push
that patch of yours upstream again? I don't know how successful I'd
be, but now since it's especially relevant for namespaces, it's
definitely worth looking at again.

Thanks!

Jessica
