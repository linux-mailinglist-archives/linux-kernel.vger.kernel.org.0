Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED977237F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 15:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbfETNYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 09:24:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35852 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731794AbfETNYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:24:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so13046482wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkbCQ7VLxxV84GOCLiupDk7D4ceZNFha/9g8ZxwaMpc=;
        b=I+6LT1jPljL1/kHdgpVTtxdN/cVmRqnlHeCcuhm/2wPmXlDeZK9r8Alk5felot5vpn
         yvNMMG6fab3mENr+PtDxhgEqkK0cy4Ko1HXuDRfwEYOSxAhUI4roMtLpDVhpR6j/PXrH
         G39/gCaGFGAGjnGcFeE9OW7Nt6j6BxR9QKgOnGjdYgih75XxlTCZuoYFVVhgvolhL699
         PCaZbHG0oKyvozMhp0/UBuZGappCER615w5/QZBiTEsReSx7Vj7ibdXQD8xaQ7Nt7lOQ
         +UPSWD+JfnBK/aNd/u/xO5bWi72i8w1OUsksSw4g5hQxNh3LgOc1sFcRmuTxhmTNGg9k
         gG8g==
X-Gm-Message-State: APjAAAWjAVKytox2surw6cxhgqV+wJN/Cob1ON5tYG4S78J5Ld18OgLe
        DvfDqhNDcuVkRMqKVtTLStlhEg==
X-Google-Smtp-Source: APXvYqyN/mxq9VS6gCeRHYEQS4C+v0zVIO5ujX6L7WbQRPqKuWQjJqWCsc3PGUbWPz/r0G6ILo3xkw==
X-Received: by 2002:a1c:2dd2:: with SMTP id t201mr30512846wmt.136.1558358660296;
        Mon, 20 May 2019 06:24:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id x9sm18965416wmf.27.2019.05.20.06.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 06:24:19 -0700 (PDT)
Subject: Re: [PATCH] x86/kvm/pmu: Set AMD's virt PMU version to 1
To:     Borislav Petkov <bp@alien8.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Liran Alon <liran.alon@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
References: <20190508170248.15271-1-bp@alien8.de>
 <aba3fd5b-e1ba-df66-2414-3f1109b68bbb@amd.com>
 <20190508171450.GG19015@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fbb1b27f-6393-6228-5b32-01dcd618253e@redhat.com>
Date:   Mon, 20 May 2019 15:24:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508171450.GG19015@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/19 19:14, Borislav Petkov wrote:
> On Wed, May 08, 2019 at 05:08:44PM +0000, Lendacky, Thomas wrote:
>> On 5/8/19 12:02 PM, Borislav Petkov wrote:
>>> From: Borislav Petkov <bp@suse.de>
>>>
>>> After commit:
>>>
>>>   672ff6cff80c ("KVM: x86: Raise #GP when guest vCPU do not support PMU")
>>
>> You should add this commit as a fixes tag. Since that commit went into 5.1
>> it would be worth this fix going into the 5.1 stable tree.
> 
> Paolo, Radim, can you do that pls, when applying?

Yes, done (and queued the patch).

Paolo

