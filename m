Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242B2118CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 16:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfLJPkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 10:40:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:38018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfLJPkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:40:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9CEBAF24;
        Tue, 10 Dec 2019 15:40:29 +0000 (UTC)
Subject: Re: [PATCH] x86-64/entry: add instruction suffix to SYSRET
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <cbecab05-9e95-5dec-ef81-499617c153a6@suse.com>
 <08B92B44-CCA9-4B83-B9CC-F1601D44B73F@amacapital.net>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <0053f606-f4f7-3951-f40b-b7bd08703590@suse.com>
Date:   Tue, 10 Dec 2019 16:40:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <08B92B44-CCA9-4B83-B9CC-F1601D44B73F@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.2019 16:29, Andy Lutomirski wrote:
>> On Dec 10, 2019, at 2:48 AM, Jan Beulich <JBeulich@suse.com> wrote:
>>
>> ﻿Omitting suffixes from instructions in AT&T mode is bad practice when
>> operand size cannot be determined by the assembler from register
>> operands, and is likely going to be warned about by upstream gas in the
>> future. Add the missing suffix here.
>>
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -1728,7 +1728,7 @@ END(nmi)
>> SYM_CODE_START(ignore_sysret)
>>    UNWIND_HINT_EMPTY
>>    mov    $-ENOSYS, %eax
>> -    sysret
>> +    sysretl
> 
> Isn’t the default sysretq?  sysretl looks more correct, but that suggests
> that your changelog is wrong.

No, this is different from ret, and more like iret and lret.

> Is this code even reachable?

Yes afaict, supported by the comment ahead of the symbol. syscall_init()
puts its address into MSR_CSTAR when !IA32_EMULATION.

Jan
