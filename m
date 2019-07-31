Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3067C8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfGaQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 12:37:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35960 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfGaQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:37:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so56320261wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k9lHw6B9Ay3/vCplj3SgYsX4eb1Pme037EAgf3NvKtg=;
        b=tojw8cmx28Zj3xBymdL2+ilZDQ/g1eJWCjDE1QIpuXEBwUoWFr0nX+JwADriB0Jqn1
         Wwa6o4f38kZoLQPgeFxn+iJ1awtsx90O9fSxx6zjSp1/GrjwdgYRqrONqiaL83yxD3tY
         ZjuVEILOaBs16Z67sFB0hyUBRe7QBuNIcYZtV6IQXa2a5czS38TsT3C+36QVAalUQoJ7
         5GRiSLVVRrYUepZfOWSRJYLepu3eG00Dgr9lK+VdKxWcDlH09TLS2GnhI1MvKKMnUm90
         /gxMChdt+8Gc/l1hNzCtzvDAH5aQMYyompPZ/HE7p2BMEVJzx+JiplxPGH40YmrsgrDC
         masw==
X-Gm-Message-State: APjAAAXWb+TxyakESM0ynw+88jPSARIdYskwlcgn2vXT0upzAaJv3Oam
        sRzyaeItL38sUzBWR75e/AhbxQ==
X-Google-Smtp-Source: APXvYqw3JtmnXbWqVtyDHXs/e63PE+rpDglm1BpjqY1zwCcvxMRD6Ciz/R6yEjZOfpXYBy6g7loLjw==
X-Received: by 2002:a7b:c310:: with SMTP id k16mr70840626wmj.133.1564591035839;
        Wed, 31 Jul 2019 09:37:15 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id s15sm51010880wrw.21.2019.07.31.09.37.15
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 09:37:15 -0700 (PDT)
Subject: Re: [PATCH RFC 3/5] x86: KVM: svm: clear interrupt shadow on all
 paths in skip_emulated_instruction()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20190620110240.25799-1-vkuznets@redhat.com>
 <20190620110240.25799-4-vkuznets@redhat.com>
 <CALMp9eQ85h58NMDh-yOYvHN6_2f2T-wu63f+yLnNbwuG+p3Uvw@mail.gmail.com>
 <87ftmm71p3.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <36a9f411-f90c-3ffa-9ee3-6ebee13a763f@redhat.com>
Date:   Wed, 31 Jul 2019 18:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87ftmm71p3.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/19 15:50, Vitaly Kuznetsov wrote:
> Jim Mattson <jmattson@google.com> writes:
> 
>> On Thu, Jun 20, 2019 at 4:02 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>>
>>> Regardless of the way how we skip instruction, interrupt shadow needs to be
>>> cleared.
>>
>> This change is definitely an improvement, but the existing code seems
>> to assume that we never call skip_emulated_instruction on a
>> POP-SS/MOV-to-SS/STI. Is that enforced anywhere?
> 
> (before I send v1 of the series) I looked at the current code and I
> don't think it is enforced, however, VMX version does the same and
> honestly I can't think of a situation when we would be doing 'skip' for
> such an instruction.... and there's nothing we can easily enforce from
> skip_emulated_instruction() as we have no idea what the instruction
> is... 

I agree, I think a comment is worthwhile but we can live with the
limitation.

Paolo

