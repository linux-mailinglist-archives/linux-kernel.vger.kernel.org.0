Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEDAF719E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390413AbfGWOEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 10:04:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46370 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfGWOEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:04:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so452071pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 07:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5umR8MvxdZ9OR/smdINjVLkwzMaeUth6ZBce+jpS3kQ=;
        b=uoRga+FAY2o2mR8+3IhTe1jM0eceNBrHTlypd5sM05CwI9xut7lnNGOj1vbRccktCH
         OWx8KAa3TNrFYuWtXCZomIsZFEAml0s+yfMCfmQFVJ6ZsPWRcOYpUW5tjMtBfdXdtlF1
         LsDSrWOJl8Hsr2T1W9Yb4SucH4xL5KhRvsRDa28kxkKfkKvnJmIW7i744voG11wB9D2c
         4WmTiANH3vYjQj9FI2QC2Ls2s2z57BqfpZOxj0tIQ+fuoz+SzSDLuESHAENUEC47iT92
         q375U1RzDNURNL4SK1r0hIYZ0vHIDc/por7MFoI+tnQmP+sR/2dpaVEupcl9AuH6r7CE
         1NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5umR8MvxdZ9OR/smdINjVLkwzMaeUth6ZBce+jpS3kQ=;
        b=Vhp6QDV628RDQPIM/flOYWWNwIgO1sQWyIOCD0Up0WZo+AiWKOwtVTubJVnBE9cWtD
         I2wOYIs7ke5uh3NnMb5h9GW+d1NnaJ7HFePJOAEQDBfYJQt64h8u+Jj9YqXP/nX1uDpJ
         ++I9ntm8m32lRuJPoXzum/+lpI0PMLf+Nvrdsm/32wqc+POPVfy0yo2CJWj8aKKX3s3/
         fs9O/qhsVKgzK6TaCOge2aPq9CAx6FNy7WUbjecH8HaXhLO2AjIEclT7Ila9zzRgIGon
         qN4pT6G7JedBRop6MjKjy90LA8caKZfwAsvO4kmA/1XobS7tBVEI9yFZz45/apLyaluv
         XrGA==
X-Gm-Message-State: APjAAAUpFWd4AwU145lZ5LaH5Qew5TOFuLgyhkvM5pM3kGxpp+kU8lbK
        IMa673S5RC4BnmLe/okFxjTE2Q==
X-Google-Smtp-Source: APXvYqx4QOdAS5EguGRpf7w1xyGWZvOIR9kqDgyroEiMeu2jtgY+sft2+DbwYpJYLHtpu02ucT9Szw==
X-Received: by 2002:a65:6216:: with SMTP id d22mr70848351pgv.404.1563890688637;
        Tue, 23 Jul 2019 07:04:48 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:10e7:e511:f3a2:19a9? ([2601:646:c200:1ef2:10e7:e511:f3a2:19a9])
        by smtp.gmail.com with ESMTPSA id 11sm44377909pfw.33.2019.07.23.07.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 07:04:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace on i386
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190723091820.GZ3402@hirez.programming.kicks-ass.net>
Date:   Tue, 23 Jul 2019 07:04:46 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <17F255F9-5084-4E30-9AD6-80A4F49BD0D8@amacapital.net>
References: <20190719170343.GA13680@linux.intel.com> <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net> <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de> <201907221135.2C2D262D8@keescook> <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com> <201907221620.F31B9A082@keescook> <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com> <20190723091820.GZ3402@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 23, 2019, at 2:18 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Mon, Jul 22, 2019 at 04:47:36PM -0700, Andy Lutomirski wrote:
>>=20
>> I don't love this whole concept, but I also don't have a better idea.
>=20
> Are we really talking about changing the kernel because BPF is expecting
> things? That is, did we just elevate everything BPF can observe to ABI?
>=20

No, this isn=E2=80=99t about internals in the kernel mode sense. It=E2=80=99=
s about the smallish number of cases where the kernel causes user code to do=
 a specific syscall and the user has a policy that doesn=E2=80=99t allow tha=
t syscall.  This is visible to user code via seccomp and ptrace.

Yes, it=E2=80=99s obnoxious.  Do you have any suggestions?=
