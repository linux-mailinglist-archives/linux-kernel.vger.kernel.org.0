Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBC08CFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfHNJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 05:46:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42568 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbfHNJqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:46:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467l8z42V2z9v0Ff;
        Wed, 14 Aug 2019 11:46:43 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Bz43zrqY; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id duYmpjDDdGb3; Wed, 14 Aug 2019 11:46:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467l8z2ylKz9v0Fd;
        Wed, 14 Aug 2019 11:46:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565776003; bh=BrHb6kuTC/Mg9gOVpCVXDn+9cEW6zECD+XrYrLBGZrw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bz43zrqY6DkHgepmrZy8IMGoI34HYy7ngYk/QDdrVa/3/cNyEfkk+dUlEujLzqUKf
         65mt+1P9h2PsIv2PPQQoyXcW5E5hkentK4YunvZzNJ71IUqFnu4S83t/SOnKl4bYub
         Z8I/IiFZHGpk019jmVlId2/HuMYNjwcbVZbJnHwE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 950A68B7A3;
        Wed, 14 Aug 2019 11:46:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vROh-KTZERmY; Wed, 14 Aug 2019 11:46:44 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 94A1C8B761;
        Wed, 14 Aug 2019 11:46:43 +0200 (CEST)
Subject: Re: [PATCH 1/2] powerpc: rewrite LOAD_REG_IMMEDIATE() as an
 intelligent macro
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        segher@kernel.crashing.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <61d2a0b6f0c89b1ee546851ce9b6bd345e5ec968.1565690241.git.christophe.leroy@c-s.fr>
 <20190814020803.it7i7mjxyruu4vy3@oak.ozlabs.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3d4e757f-84cd-7a48-0b5a-d39c44ea33ea@c-s.fr>
Date:   Wed, 14 Aug 2019 11:46:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814020803.it7i7mjxyruu4vy3@oak.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/08/2019 à 04:08, Paul Mackerras a écrit :
> On Tue, Aug 13, 2019 at 09:59:35AM +0000, Christophe Leroy wrote:
> 
> [snip]
> 
>> +.macro __LOAD_REG_IMMEDIATE r, x
>> +	.if \x & ~0xffffffff != 0
>> +		__LOAD_REG_IMMEDIATE_32 \r, (\x) >> 32
>> +		rldicr	\r, \r, 32, 31
>> +		.if (\x) & 0xffff0000 != 0
>> +			oris \r, \r, (\x)@__AS_ATHIGH
>> +		.endif
>> +		.if (\x) & 0xffff != 0
>> +			oris \r, \r, (\x)@l
>> +		.endif
>> +	.else
>> +		__LOAD_REG_IMMEDIATE_32 \r, \x
>> +	.endif
>> +.endm
> 
> Doesn't this force all negative constants, even small ones, to use
> the long sequence?  For example, __LOAD_REG_IMMEDIATE r3, -1 will
> generate (as far as I can see):
> 
> 	li	r3, -1
> 	rldicr	r3, r3, 32, 31
> 	oris	r3, r3, 0xffff
> 	ori	r3, r3, 0xffff
> 
> which seems suboptimal.

Ah yes, thanks. And it is also buggy when \x is over 0x80000000 because 
lis is a signed ops

I'll send v2

Christophe
