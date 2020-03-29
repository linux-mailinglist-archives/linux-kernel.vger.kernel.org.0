Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D55FE196F86
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 20:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgC2Szz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 14:55:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35107 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgC2Szz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:55:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id t16so11361331lfl.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzKIqjkzj7/Eq13gEM5B5ww/GQ27+9p2+1RGc78xjeY=;
        b=D+OjUPi3ac95W7wx3JJ+HoZ9kpnqs7I9BWSpuiS7wpheI0dITNUhYwkvqOqLLBNYDh
         9WAbxP7m6Sa5QIhVj9VyhWYDMUKkVVEAbxSY/yCNmYwu25Zcr07r7yvq0asr3LG9inQo
         L7vDJ8tlVdyT5LHFiQVKewJYbq9Vs/tl4Vw6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzKIqjkzj7/Eq13gEM5B5ww/GQ27+9p2+1RGc78xjeY=;
        b=Z1VnqbQHuedhstImUk6zEOmS7JbFxMclBxCwUFkOpfaZLO5mPhd4e2NyynEqysv3sF
         cxu6JhGme9cyw3pRZ+Z2e2YnkSUOQMAMheKdmgnhLf7MWOAJzkCQ28VT7pACd7mU4RsX
         28GGZa77kht222K0/BAwqHtQp7tcMsyVNp7XTNHT+EX068Qjk7AvMOLtZQifwsweW41w
         +tjFYOW9iBAwqsuPH5BKp1Ts5i12dyXVrdVONoW+WM+qwaeNefgCFRrcS1QnsmdmqhnC
         qj1StQyfIK44UDkFUcB1mEZERBUycD8jbPSC2TsEFjriTJISeZc/XZ6GHoUjHg2Omf/c
         vSYQ==
X-Gm-Message-State: AGi0Pua41w0UiJcWy+qIkivRGBweLyDNA9F8Blwo18KrA+3YsTOvZgSy
        E9dUPnvEzl7hwTQKL02NaTOItC0ugFI=
X-Google-Smtp-Source: APiQypILsiLFycq+aESlfD5B3rkog8Ez8JD0Z7YN+JxXyQ36EB2fvwzPMenYIfHrjxRCf1giehSf5Q==
X-Received: by 2002:a19:c388:: with SMTP id t130mr5980962lff.175.1585508150955;
        Sun, 29 Mar 2020 11:55:50 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id e4sm777246lfn.80.2020.03.29.11.55.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 11:55:50 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id v4so12150000lfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 11:55:49 -0700 (PDT)
X-Received: by 2002:ac2:5e36:: with SMTP id o22mr5576296lfg.142.1585508149219;
 Sun, 29 Mar 2020 11:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk> <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com> <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com> <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
 <489c9af889954649b3453e350bab6464@AcuMS.aculab.com> <CAHk-=whDAxb+83gYCv4=-armoqXQXgzshaVCCe9dNXZb9G_CxQ@mail.gmail.com>
 <9352bc55302d4589aaf2461c7b85fb6b@AcuMS.aculab.com> <CAHk-=wjEf+0sBkPFKWpYZK_ygS9=ig3KTZkDe5jkDj+v8i7B+w@mail.gmail.com>
 <e7845564e66f41ccabbf6c23b28966ec@AcuMS.aculab.com>
In-Reply-To: <e7845564e66f41ccabbf6c23b28966ec@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 11:55:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTXXVn=Zxn4kYMG8sOJr0xL+6TzdVzi+XhAdx2Pu0UBg@mail.gmail.com>
Message-ID: <CAHk-=wiTXXVn=Zxn4kYMG8sOJr0xL+6TzdVzi+XhAdx2Pu0UBg@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit __get_user()
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 11:32 AM David Laight <David.Laight@aculab.com> wrote:
>
> Can't you simplify that by using the =d constraint rather
> than relying on a asm register variable.

No, because that asm register variable can be 64-bit.

Which on x86-32 isn't "=d". It's "%edx:%ecx".

The asm register variable thing handles that automatically, but "=d" would not.

                Linus
