Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3311C191630
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgCXQWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:22:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37695 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgCXQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:22:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id h72so7318477pfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=zElBZBLASkl8tIZVLgPF3Kl3otpP9bPotITVcSHs4/A=;
        b=YKsA+qFKquODHT56C8+xdEVHq5PkRJZux2YJFvXOkUhbrxCUFdkldgrmK4BBWiJwhV
         HkHSJbNBG53YtwqHLKXT/+GClot9/1kN3KdapmJEUH4vOQv8YgWpq17dA/Kov9QP8xAb
         FdVEg6AKKALqEdecwh4LHB6mVe6cLpQddbeAYZpavzoll3F9FWgUN6p+Tng7Z305SJJJ
         6on0Cfj206Fj/EdIhuJyCNhvqDsDcpT2zAydhlO3uusf+5oQP1JMgDoBWvFhjAU9rq/C
         IIJtDKfG8pPaZ1vpv7BdX85OGH0PlJ/iT+xU6GPqwgO5NbNmmj232UDHSs6QmXZQ6lqA
         GMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=zElBZBLASkl8tIZVLgPF3Kl3otpP9bPotITVcSHs4/A=;
        b=EQrVz8Nq3bPnP+fmDj0X2w0wdB1AssZPW7jofq8vbhupBwR4lWDz42yZzLAf4Uz6Ia
         1QXZW6yIH57ptBn+85GG0rZeNNOOGsA1WT8es6N63uVDC8kNmdPF86IOgSNoCpwFC5hp
         ZYrWut4LOchzrekoB3bBTGexGk59MjgYJfZaNDlShgjQG+w2Z4BRA10+QaPQQRaWANby
         Z7iRq9MVCCDGqWhPqpoYMFjNXRY+M+S0sar7GhgKiCM+3I7Jn+DsZ1G1Em6PndJAuC93
         FyNYVr8o4CwWmNIeJ+Ga7uKe1a3bD3LIPc88lhhEpi/3knfFO5YLyBxyQOAMqz9b7Bfu
         8bwg==
X-Gm-Message-State: ANhLgQ1dVh+A+laKCDUvGmV6Vr8Wup3JlCzPBziLkd7HNqdU/DR6W9GM
        ZDaFLyHbcdY8guQ8qGksYxn1nQ==
X-Google-Smtp-Source: ADFU+vswzxNLwCyKdFFTordzjTKv5qHUsjvez5zbgbxJZrzvooukN2NILC98BbLyPI2PE1K5MVtszw==
X-Received: by 2002:a63:1e44:: with SMTP id p4mr28437618pgm.367.1585066954419;
        Tue, 24 Mar 2020 09:22:34 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:f57f:ae28:7a6d:bb35? ([2601:646:c200:1ef2:f57f:ae28:7a6d:bb35])
        by smtp.gmail.com with ESMTPSA id nh4sm2706730pjb.39.2020.03.24.09.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 09:22:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
Date:   Tue, 24 Mar 2020 09:22:29 -0700
Message-Id: <86D80EA7-9087-4042-8119-12DD5FCEAA87@amacapital.net>
References: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
In-Reply-To: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 24, 2020, at 9:14 AM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BFOn Tue, Mar 24, 2020 at 7:25 AM Peter Zijlstra <peterz@infradead.=
org> wrote:
>>=20
>> Extend the static_call infrastructure to optimize the following common
>> pattern:
>>=20
>>        if (func_ptr)
>>                func_ptr(args...)
>=20
> Is there any reason why this shouldn't be the default static call pattern?=

>=20
> IOW, do we need the special "cond" versions at all? Couldn't we just
> say that this is how static calls fundamentally work - if the function
> is NULL, they are nops?
>=20
>=20

I haven=E2=80=99t checked if static calls currently support return values, b=
ut the conditional case only makes sense for functions that return void.=20

Aside from that, it might be nice for passing NULL in to warn or bug when th=
e NULL pointer is stored instead of silently NOPping out the call in cases w=
here having a real implementation isn=E2=80=99t optional.=
