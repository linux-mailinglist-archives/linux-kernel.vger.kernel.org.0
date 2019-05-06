Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0CD1482B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEFKIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 06:08:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34040 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfEFKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:08:17 -0400
Received: by mail-io1-f68.google.com with SMTP id g84so2630215ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPw9HMAZKBAlaM7aQ8kW599HIhJT+slQnT6wJ8ywJZc=;
        b=lB3f0yaUHCel/mtomjebDNpmu9vE/l3BAyDwiEPbz6Knp49gfO0+9jiHbrRhqeTH1g
         XITpYV1XFCAvDP7gEEEMn/qYUW2CAyW3FFkOSMvSmAUF7Jkq3CqNBPNT7jxIVqUY5THz
         mMsSfttlIxws2jJqap4JBAR24kA5sRAhl99uF5cxMxpN7MK3gbvE7ixvmwTrLiAo8yQg
         hAyK0aJntF/wMUO2LlVhlig62vil4OsoWn2c7EPmpOlbZD4urxVnPJm68mMOJpmj9CC1
         XBb4kL74+TNVYenxMrBXlosdp2MH8354tIEQx5jeN16C3T2KD4wK6Ja/DtlmzUOJx/GE
         5wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPw9HMAZKBAlaM7aQ8kW599HIhJT+slQnT6wJ8ywJZc=;
        b=sChHD6BD4AbpSjEXdsL+5Aab9V3bAh/GoAZGDO745qy35mY1M3jivd1vo3wd2B8xzc
         bNDLCmpZeeUUVD37GWQmzQTCp0CdQTcAaCiIbAb+sASrjawnmb6S7im1DekKm1M9lUOO
         o7/TLaLEMWbChg9ehkFLXUr1VOllfR/SQkeg7cryQ39T3RLHlN+9bPcj49M9xW7ar2Z9
         sIB6HA50ducXadCh6wJPZlTSA0tDVaybbSweVcPlkzB2lnzAAvAKb5bwglWCqd3TctU5
         H2vjo+VV8rMlMb/ONM4+X0KZ4TiSbkX33nPDOOgTUxYzXW7Y75LHcrmsGtWxxbMLEJ6B
         bVPg==
X-Gm-Message-State: APjAAAVbsNG33UCoCcIXlC85DZJA0rn/FpEaVB8r0ZZNX4pEZ/VBSTGJ
        QWJ1ntpAi4HAELjSdaI/uA35TTOcCoMuOZwy5g==
X-Google-Smtp-Source: APXvYqzLFZuE2HfzV3Q7/PIRPjxG1vRCusXUBYGpoJhFmkzo+BtOmmmQs+MpEOBkc/SJuJOGP+M5WXP75lwE1F1oI4c=
X-Received: by 2002:a6b:b408:: with SMTP id d8mr13618774iof.12.1557137296650;
 Mon, 06 May 2019 03:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
 <1554703115-15299-3-git-send-email-kernelfans@gmail.com> <20190416190128.GL31772@zn.tnic>
 <CAFgQCTuDVk+Zav0v-WfPmEjmuOW-P+n3x9SmZj54ky-FJ82_+Q@mail.gmail.com>
 <20190417160618.GG20492@zn.tnic> <CAFgQCTsPGp3vwDYndXR2Qk=t2X9Gqg-82KicoAKLon+TgkkAWg@mail.gmail.com>
 <20190418123216.GG27160@zn.tnic>
In-Reply-To: <20190418123216.GG27160@zn.tnic>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 6 May 2019 18:08:05 +0800
Message-ID: <CAFgQCTs90E-m1kZNNQOZZOeMTAVmRBsMJ_eMoyPJjYkh9tf4uA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] x86/boot/KASLR: skip the specified crashkernel region
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 8:32 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Apr 18, 2019 at 03:56:09PM +0800, Pingfan Liu wrote:
> > Then in my case, either no @offset or invalid argument will keep
> > "*crash_base = 0", and KASLR does not care about either of them.
>
> Ok.
>
> > It is not elegant. Will try a separate patch to fix it firstly.
>
> That's appreciated, thanks. It is about time that whole kexec/kaslr/...
> code gets some much needed cleaning up and streamlining.
>
I had tried it v1 on https://patchwork.kernel.org/patch/10909627/ and
v2 on https://patchwork.kernel.org/patch/10914169/. It seems no more
feed back and hard to push forward.

Since "x86/boot/KASLR: skip the specified crashkernel region" has no
dependency on the above patch, I would like to send the next version
for it.

Regards,
Pingfan
