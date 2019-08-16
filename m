Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28568F822
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 02:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfHPArP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 20:47:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42505 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfHPArP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 20:47:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id i30so2188497pfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 17:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f+DKEab44F9AeQ6FXUg5sKUUx2aIFaYp+J+ptKupBqc=;
        b=pkDZMd72fjY8P2a1OU9edU+9T8WR8jnpneXXE/lAjecduC2TO94bIQgpy2q60gt8Xq
         lQKXHs2ZdqpksxEPJpXnGOVli9PRo2OUrPH9/KEhFunAV2g8/G3TMG67F3LpsoQQCJq7
         uXg/Ic5A5I7eccQf7nvV1RvyicUMhlKlzzLU7zLjW9eERh9oXYfWOF65f+DOYrC2v6D8
         LT6CmgUZEdop2fl2SdBRnzSAWm3sKzZBRDFPdpj3rzS5pFascXPpkhlIA0W4EmucHZo4
         J6/lEFsxoi95+EWQa/itV+B8DorNpiH3p9I6e3sLlLle0u9tYDIhR1G7FK46HlC/fikN
         eBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f+DKEab44F9AeQ6FXUg5sKUUx2aIFaYp+J+ptKupBqc=;
        b=Iuu2205wDGvaIbJ7Sj4voqFTNYZEJqHLBsoBffEoKwoqkVVU76BCg1bRCdXSxykyx2
         8bF+XpRgYgJRblfKqIL6DJYsMg0bWBuoy0t+pRt9axIo+FOWmEJqRl4l8Qhf2+9xdPrG
         c7PAuUMxrGkRjFp2N9CDi3QFlyp72WLrt0iP2uvCnzIo45IDdYaWhGMecBEcpcFozXKz
         kOKpolSO3Ac2jH0Yc8wxuWruyFE6+sMWsDGSNg3Q27eyAjigZDDiOTGrt3JvqIDRA/XV
         d7cl2rW6ls7g9zuucD//8c7hRUSBfLl+aPpEj2Mq7AG9miXbcQIYThTrEvXIyASDB3Ck
         UZyg==
X-Gm-Message-State: APjAAAWufPzYbNM1XbxdMvhHaz0FXFUoaebn1wZQ4yJrtrKBKO4BYHxt
        mAZFiRhOEZujugDkxFxPPJ602NVkCUo=
X-Google-Smtp-Source: APXvYqwNaeYJhV1qwV8QIS7K6oGuHB4NlZwPVJRG+Ge0+F0e7oep/DKcI3Rze48O3x9X02y5jv0y7g==
X-Received: by 2002:a63:dd16:: with SMTP id t22mr5593357pgg.140.1565916434324;
        Thu, 15 Aug 2019 17:47:14 -0700 (PDT)
Received: from ?IPv6:2600:1010:b04e:b450:9121:34aa:70f4:e97c? ([2600:1010:b04e:b450:9121:34aa:70f4:e97c])
        by smtp.gmail.com with ESMTPSA id f205sm4785497pfa.161.2019.08.15.17.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 17:47:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 08/21] KVM: x86: Add kvm_x86_ops hook to short circuit emulation
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <20190730024940.GL21120@linux.intel.com>
Date:   Thu, 15 Aug 2019 17:47:12 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-sgx@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <25BBDA64-1253-4429-95AF-5D578684F6CC@amacapital.net>
References: <20190727055214.9282-1-sean.j.christopherson@intel.com> <20190727055214.9282-9-sean.j.christopherson@intel.com> <CALCETrU_51Ae=F9HzUwsUuSkJ1or63p_eG+f3uKkBqFx=bheUA@mail.gmail.com> <20190730024940.GL21120@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> On Jul 29, 2019, at 7:49 PM, Sean Christopherson <sean.j.christopherson@i=
ntel.com> wrote:
>>=20
>> On Sat, Jul 27, 2019 at 10:38:03AM -0700, Andy Lutomirski wrote:
>> On Fri, Jul 26, 2019 at 10:52 PM Sean Christopherson
>> <sean.j.christopherson@intel.com> wrote:
>>>=20
>>> Similar to the existing AMD #NPF case where emulation of the current
>>> instruction is not possible due to lack of information, virtualization
>>> of Intel SGX will introduce a scenario where emulation is not possible
>>> due to the VMExit occurring in an SGX enclave.  And again similar to
>>> the AMD case, emulation can be initiated by kvm_mmu_page_fault(), i.e.
>>> outside of the control of the vendor-specific code.
>>>=20
>>> While the cause and architecturally visible behavior of the two cases
>>> is different,  e.g. Intel SGX will inject a #UD whereas AMD #NPF is a
>>> clean resume or complete shutdown, the impact on the common emulation
>>> code is identical: KVM must stop emulation immediately and resume the
>>> guest.
>>>=20
>>> Replace the exisiting need_emulation_on_page_fault() with a more generic=

>>> is_emulatable() kvm_x86_ops callback, which is called unconditionally
>>> by x86_emulate_instruction().
>>=20
>> Having recently noticed that emulate_ud() is broken when the guest's
>> TF is set, I suppose I should ask: does your new code function
>> sensibly when TF is set?
>=20
> Barring a VMX fault injection interaction I'm not thinking of, yes.  The
> SGX reaction to the #UD VM-Exit is to inject a #UD and resume the guest,
> pending breakpoints shouldn't be affected in any way (unless some other
> part of KVM mucks with them, e.g. when guest single-stepping is enabled).

What I mean is: does the code actually do what you think it does if TF is se=
t?  Right now, as I understand it, the KVM emulation code has a bug in which=
 some emulated faults also inject #DB despite the fact that the instruction f=
aulted, and the #DB seems to take precedence over the original fault.  This c=
onfuses the guest.=
