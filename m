Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041E0D0C20
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfJIKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 06:03:30 -0400
Received: from foss.arm.com ([217.140.110.172]:58736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfJIKDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:03:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A435F28;
        Wed,  9 Oct 2019 03:03:27 -0700 (PDT)
Received: from [192.168.1.124] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 137A73F68E;
        Wed,  9 Oct 2019 03:03:25 -0700 (PDT)
Subject: Re: [PATCH] arm64: lse: fix LSE atomics with LLVM's integrated
 assembler
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20191007201452.208067-1-samitolvanen@google.com>
 <CAKwvOdmaMaO-Gpv2x0CWG+CRUCNKbNWJij97Jr0LaRaZXjAiTA@mail.gmail.com>
 <CABCJKufxncBPOx6==57asbMF_On=g1sZAv+w6RnqHJFSwOSeTw@mail.gmail.com>
 <CAKwvOd=k5iE8L5xbxwYDF=hSftqUXDdpgKYBDBa35XOkAx3d0w@mail.gmail.com>
 <CABCJKucPcqSS=8dP-6hOwGpKUYxOk8Q_Av83O0A2A85JKznypQ@mail.gmail.com>
 <c0f0eb7e-9e46-10cc-1277-b37fcd48d0be@arm.com>
 <CAKv+Gu82ERZjaEH265+RNVjtQSk51ekHONniDZg-4vWy1VHkuQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <240f81a1-4fe5-0ff3-f97a-0c9aa6b68e03@arm.com>
Date:   Wed, 9 Oct 2019 11:03:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu82ERZjaEH265+RNVjtQSk51ekHONniDZg-4vWy1VHkuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-08 10:03 pm, Ard Biesheuvel wrote:
> On Tue, 8 Oct 2019 at 18:19, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 08/10/2019 16:22, Sami Tolvanen wrote:
>>> On Mon, Oct 7, 2019 at 2:46 PM 'Nick Desaulniers' via Clang Built
>>> Linux <clang-built-linux@googlegroups.com> wrote:
>>>> I'm worried that one of these might lower to LSE atomics without
>>>> ALTERNATIVE guards by blanketing all C code with `-march=armv8-a+lse`.
>>>
>>> True, that's a valid concern. I think adding the directive to each
>>> assembly block is the way forward then, assuming the maintainers are
>>> fine with that.
>>
>> It's definitely a valid concern in principle, but in practice note that
>> lse.h ends up included in ~99% of C files, so the extension is enabled
>> more or less everywhere already.
>>
> 
> lse.h currently does
> 
> __asm__(".arch_extension        lse");
> 
> which instructs the assembler to permit the use of LSE opcodes, but it
> does not instruct the compiler to emit them, so this is not quite the
> same thing.

Derp, of course it isn't. And IIRC we can't just pass the option through 
with -Wa either because at least some versions of GCC emit an explicit 
.arch directive at the top of the output. Oh well; sorry for the 
distraction.

Robin.
