Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A16B3194D99
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 00:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgCZXzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 19:55:35 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21175 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZXze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:55:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585266914; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KZrkNpXebfUaekI+dNCmYKw6tAtHJO4O/lvIVrupaGBq7J6fkYN+WhlwU9A7W357Qeh877gnx+Ax4OKxFCUc8AD5RkDveIuMpr/LLn+elermZlnKJNnn44ztd/tm7indiVBm3k054LllnPOCZ9aVBjpQwWGKovSaJCwbCOSQltc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585266914; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=98AFnfaneY2CA2/XDvmxHsgX3TWxJ+b6tmqlt+SeVLo=; 
        b=lIYbs4Fw/ErPy02RG+ew3RN/BhOj1QLgyFQvIvzJ3IHQuR2+Vir8VO9gEm1b+ZAiEHEB11+2/hVGmn1j4b9Z5JTlFrh8YMAv7iIymXl6tdpBCfuKOnjkgyxuPklqFlvjtSeHYWV44zrRgFmxQVX8zQqDVd67QGlUqj3wGCc1lZM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585266914;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=98AFnfaneY2CA2/XDvmxHsgX3TWxJ+b6tmqlt+SeVLo=;
        b=RctuE4s9VpUO/juJO2tPPvXs9K9J9Air0qnqg9f+o1iJLiu7sg4nKISSdPTZZuEr
        spxK5KRBJJ+i7+5Q3I7MYaceJ0N7oEXJuMZdEDzhBit2YWhgLae7nT0ZG+t4OenUjFv
        Dolofr3k4xnGQVufvoVCKgzavYxTODzYKGAPrV0Q=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 1585266912730797.4012476636767; Thu, 26 Mar 2020 16:55:12 -0700 (PDT)
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel
 support
To:     Matthew Garrett <mjg59@google.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
References: <20200325194317.526492-1-ross.philipson@oracle.com>
 <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com>
 <bacbc25a-c724-d2fd-40bd-065799cd6195@apertussolutions.com>
 <CACdnJusRATYv3Une5r14KHJVEg5COVW9B_BNViUXjavSxZ6d5A@mail.gmail.com>
 <8199b81d-7230-44d9-bddf-92af562fe6b1@apertussolutions.com>
 <CACdnJuvxSaF96PkCiDp5u+599+bU5SnXRgLyWetaOKa0+1UqAg@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f64bc672-0c6e-d3f5-4b6c-4e60186d720c@apertussolutions.com>
Date:   Thu, 26 Mar 2020 19:55:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACdnJuvxSaF96PkCiDp5u+599+bU5SnXRgLyWetaOKa0+1UqAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 6:41 PM, Matthew Garrett wrote:
> On Thu, Mar 26, 2020 at 3:37 PM Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>> On 3/26/20 4:54 PM, Matthew Garrett wrote:
>>> PCs depend on the availability of EFI runtime services - it's not
>>> possible to just assert that they're untrusted and so unsupported. The
>>> TPM code is part of boot services which (based on your design) are
>>> unavailable at this point, so I agree that you need your own
>>> implementation.
>>>
>>
>> I appreciate this has been a heated area of debate, but with all due
>> respect that might be a slight over statement w.r.t. dependency on
>> runtime services and not what I was saying about the trustworthiness of
>> UEFI. If I have a UEFI platform, I trust EFI to boot the system but that
>> does not mean I have to trust it to measure my OS kernel or manage the
>> running system. Secure Launch provides a means to start a measurement
>> trust chain starting with CPU taking the first measurement and then I
>> can do things like disabling runtime services in the kernel or do crazy
>> things like using the dynamic launch to switch to a minimal temporary
>> kernel that can do high trust operations such as interfacing with
>> entities outside your trust boundary, e.g. runtime services.
> 
> I understand. However, it is *necessary* for EFI runtime services to
> be available somehow, and this design needs to make that possible.
> Either EFI runtime services need to be considered part of the TCB, or
> we need a mechanism to re-verify the state of the system after making
> an EFI call (such as Andy's suggestion).
> 

Yes if you are on UEFI you will eventually need to deal with RS during
the system's lifetime, unless you don't want to patch your firmware
which I won't comment on what kind of idea that is. And yes I have been
chatting with a few people in the LinuxBoot community about re-verifying
the RS. The answer seemed to be that it might be possible but it doesn't
look like it will be trivial.

>> Please understand I really do not want my own implementation. I tried to
>> see if we could just #include in the minimal needed parts from the
>> in-tree TPM driver but could not find a clean way to do so. Perhaps
>> there might be a future opportunity to collaborate with the TPM driver
>> maintainers to refactor in a way that we can just reuse instead of
>> reimplement.
> 
> I think it's reasonable to assert that boot services can't be part of
> the TCB in this case, and as a result you're justified in not using
> the firmware's TPM implementation. However, we still need a solution
> for access to runtime services.
> 

