Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5011D264
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 17:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfLLQew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 11:34:52 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:41901 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbfLLQev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:34:51 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47YfXP2gjMzB09Zb;
        Thu, 12 Dec 2019 17:34:45 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=mUaC9PzR; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9WuTQ52ZLv0o; Thu, 12 Dec 2019 17:34:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47YfXP0ZwbzB09Zd;
        Thu, 12 Dec 2019 17:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576168485; bh=5ayd9PjJRgNmK3O5j33o8jKyMdGb9Kf50uNZGSjc28I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mUaC9PzRHUQgIKKPVsLlwj3RKssxuq6EeDV67OR9T/w6yH9ybBbXdRE0UC8mNYv6b
         iwCt44e25EqPI1h0UB4DarcGj1W790CZBg6CZI+atejs26GN/5qiD8nmGIFiGkCzXI
         9E2CYb9yDOhLKkxGHZQYxRtNjf8H4GjjTX1RWNdc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A93118B877;
        Thu, 12 Dec 2019 17:34:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hamxpM4AZs8F; Thu, 12 Dec 2019 17:34:46 +0100 (CET)
Received: from [172.25.230.112] (po15451.idsi0.si.c-s.fr [172.25.230.112])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8493D8B872;
        Thu, 12 Dec 2019 17:34:46 +0100 (CET)
Subject: Re: [PATCH v5] powerpc/irq: inline call_do_irq() and
 call_do_softirq() on PPC32
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <72a6cd86137b2a7ab835213cf5c74df6ed2f6ea7.1575739197.git.christophe.leroy@c-s.fr>
 <20191212125222.GB3381@infradead.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <878e4ac8-9bfa-394d-8bca-f09a78f54904@c-s.fr>
Date:   Thu, 12 Dec 2019 17:34:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191212125222.GB3381@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/12/2019 à 13:52, Christoph Hellwig a écrit :
> On Sat, Dec 07, 2019 at 05:20:04PM +0000, Christophe Leroy wrote:
>> call_do_irq() and call_do_softirq() are simple enough to be
>> worth inlining.
>>
>> Inlining them avoids an mflr/mtlr pair plus a save/reload on stack.
>> It also allows GCC to keep the saved ksp_limit in an nonvolatile reg.
>>
>> This is inspired from S390 arch. Several other arches do more or
>> less the same. The way sparc arch does seems odd thought.
> 
> Any reason you only do this for 32-bit and not 64-bit as well?
> 

Yes ... There has been a long discussion on this in v4, see 
https://patchwork.ozlabs.org/patch/1174288/

The problem is that on PPC64, r2 register is used as TOC pointer and it 
is apparently not straithforward to make sure the caller and the callee 
are using the same TOC.

On PPC32 it's more simple, r2 is current task_struct at all time, it 
never changes.

Christophe
