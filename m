Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4DB63D78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 23:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfGIVqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 17:46:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44768 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:46:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so21032127ljc.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Iag3LSwtxbGH/6JXykV0X2cYRNwhwRjefA47JZ1iyg=;
        b=HxwB0twpmxNCaV1pxwV8vfkgNh1oFJQAhGF6eY25qjofRadbo+wwDsJ+ySl+oAzjh9
         PTL+wrSTjcrHQjvYntl/xpsqXOxQCq95sJVDTEmke1HpziwTIRDLj+9ejhDDBTjUNi7t
         wBDoSkn/dtcxI97Nifc2jlmWj4Pv3k7Ay3vjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Iag3LSwtxbGH/6JXykV0X2cYRNwhwRjefA47JZ1iyg=;
        b=OIvVX3EILc4W+Nb3julyaIF4Vgq6eiWixZQOePPQuoRIwV93mjma+ohFGXrQcvPQyG
         XLk2Ly109oUPhr3YwrrGIYC5nJshGjEqO548eSznM+xxfjRs20dF4KY9mlXDMES/OPXR
         jrNN/XvYYp5jnDZcbfMrnhDWV1bxJlmkGLpYhDadMos3RwJVPIU45pritZZli3Pj23kA
         OwKq+Q0tp7jxQfElE09D0S4S2laT3aZ+Ae1KOSduz9fuyIhOXqhfH7LUI25KwF47tsql
         TFEC5ni+owhwjvPPET7OKKmXdX1B0VlUWNJxnrsDrPzkmLhn1goIWerscaW4MVugkDsC
         D5NQ==
X-Gm-Message-State: APjAAAUiGe7ll3qeuMbjhonY3mDriEBhGnR0sVfoN9Kox/xmfZotuIWz
        fVV+fn9A3oc81n2/73bEb5SQeX1J41M=
X-Google-Smtp-Source: APXvYqzv2Zyngqu7fFXqiI3mDyOsQQ07ONdD9iEQECEzAk7K7BBO3xuz7WEFbZFvxly3rWFJoSveGw==
X-Received: by 2002:a2e:9a87:: with SMTP id p7mr15114127lji.133.1562708759073;
        Tue, 09 Jul 2019 14:45:59 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id w6sm18056lff.80.2019.07.09.14.45.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:45:58 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id s19so80267lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 14:45:58 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr12824867lfm.170.1562708757887;
 Tue, 09 Jul 2019 14:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190708162756.GA69120@gmail.com> <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
 <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
In-Reply-To: <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Jul 2019 14:45:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
Message-ID: <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 2:26 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> but still bisecting to pinpoint the exact thing.

One of:

  c21ac93288f0 (refs/bisect/bad) Merge tag 'v5.2-rc6' into x86/asm, to
refresh the branch
  8dbec27a242c x86/asm: Pin sensitive CR0 bits
  873d50d58f67 x86/asm: Pin sensitive CR4 bits
  7b347ad4938d (HEAD) Merge tag 'v5.2-rc5' into x86/asm, to refresh the branch
  9db9b76767f1 Documentation/x86: Fix path to entry_32.S
  7231d0165df3 x86/asm: Remove unused TASK_TI_flags from asm-offsets.c

and I suspect it's the sensitive bit pinning. But I'll delve all the way.

                Linus
