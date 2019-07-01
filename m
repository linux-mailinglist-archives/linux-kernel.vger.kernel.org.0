Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1782188EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 13:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEIL17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 07:27:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28430 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfEIL17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:27:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 450B0X4Z0Xz9v114;
        Thu,  9 May 2019 13:27:56 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=SY9KuSHm; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YU_cHU7ABhH9; Thu,  9 May 2019 13:27:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 450B0X3SDxz9v10f;
        Thu,  9 May 2019 13:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557401276; bh=te5Ea9Nu7fIuisOgqijviIon2+QUqVw422cO21j19e8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SY9KuSHmnrVh2Yoqk8T/eCt5yHV5/NpWi6CRNnujTHOhKVF3ddsxyof+YRlucevjn
         mr1IY0uPe088P/n1iLq5V2QRJNuJEKH+pB3Tlgi5VPekRTQxWYuE9ncek1jbTFYkQN
         pjBh+r7J8axOCTugpg+JoO8Bz7BmjLyEbLqTcTE0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C265E8B913;
        Thu,  9 May 2019 13:27:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OYNhdwwfftva; Thu,  9 May 2019 13:27:57 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5555E8B90D;
        Thu,  9 May 2019 13:27:57 +0200 (CEST)
Subject: Re: [PATCH] powerpc/ftrace: Enable C Version of recordmcount
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <4464516c0b6835b42acc65e088b6d7f88fe886f2.1557235811.git.christophe.leroy@c-s.fr>
 <87ef59wz8n.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1a731776-2b9f-ae62-c858-cfd22923f03a@c-s.fr>
Date:   Thu, 9 May 2019 13:27:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ef59wz8n.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/05/2019 à 02:45, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Selects HAVE_C_RECORDMCOUNT to use the C version of the recordmcount
>> intead of the old Perl Version of recordmcount.
>>
>> This should improve build time. It also seems like the old Perl Version
>> misses some calls to _mcount that the C version finds.
> 
> That would make this a bug fix possibly for stable even.
> 
> Any more details on what the difference is, is it just some random
> subset of functions or some pattern?

I have not been able to identify any pattern. Will add a few details in 
the 'issue' on github.

Christophe

> 
> cheers
> 
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 2711aac24621..d87de4f9da61 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -180,6 +180,7 @@ config PPC
>>   	select HAVE_ARCH_NVRAM_OPS
>>   	select HAVE_ARCH_SECCOMP_FILTER
>>   	select HAVE_ARCH_TRACEHOOK
>> +	select HAVE_C_RECORDMCOUNT
>>   	select HAVE_CBPF_JIT			if !PPC64
>>   	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
>>   	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r2)
>> -- 
>> 2.13.3
