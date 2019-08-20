Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F60D95E73
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 14:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfHTM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 08:27:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55173 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHTM1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:27:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so2448707wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fc9kgafPA2gUOPbQU1W3ajBr+1WrHB60fZSaC4Wi+Sg=;
        b=NlUKtmn9iGLGYzl/EGuxT5/QFDiWGwqT+SyseUqGQ8qv1eVKlAZutSafi0AbgwxVya
         6dqyEnKyli5cUAbyM+8YbVFbhOu1g4+mjswnShlQVVmHQ74gvUa5wUgoJq+rcOUOCvp2
         /U6ehhgch2rOD/YINXpXSo6Gl1MDVdnWaODFMbh+HsJrCi//AnlfQ1VitYLR3Vcqnujk
         4euj7syu8yOnXtSIDBrNYa44gL/mcHfIA5JvOAiTKPyRh/RjIEdyPBCtYMxXb3hmso6F
         dm3NpN8gr1s4exi5lvCCKYMLdjzcAo+jvdxcx8iU45Rf227pWO1z6xbvBMFCIZ1djaO5
         mSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc9kgafPA2gUOPbQU1W3ajBr+1WrHB60fZSaC4Wi+Sg=;
        b=HGGW42YnYXn35d+WOQNPP6htPBn4ERFVr19OHCMrnH7yylEwTCLDf9GDVBkCYqPnaj
         SGL91rTseD76y7dXmS/GdF4pkHwVnONdXUoiVWyl2YcObjxIz7ULjO3A3P1jarwThsKX
         5US8XkWODwYK4NA8rthocAMR+i/VhsKUn9p9pAqwLlwVMBEilT25m8LIbJCMvrUoSbyr
         2xklMiy19k30zLRjHsvZ2dTw+P1SdicZnatN8g4Daln/iDr7M1itCzc9bl/8t7LzXvCS
         uBr4CfPJwg/Gl06LCOZqizw+x9qpz25ypacDR2r47XxdhKVqocuLFHO///yeYUhU4ykq
         cp6A==
X-Gm-Message-State: APjAAAW76BdFK7J7bt5iTA4ED4t/ocXU3z6uGkb5uOHRBWN2f55hvIuz
        49UId1lqQM4Z2VTbD/Ao6Y5ZIuh6JvkVZ2J1E9i2jA==
X-Google-Smtp-Source: APXvYqzZ8/F9f0NciEUL0j31UKBINg5KnpUK5KcUIV+VxonHUHvdyeOCmoqDvaTzkRhT6wtLRbUezdw96auKzQMDFR0=
X-Received: by 2002:a05:600c:231a:: with SMTP id 26mr17871560wmo.136.1566304054078;
 Tue, 20 Aug 2019 05:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190802053744.5519-1-clin@suse.com> <CAKv+Gu-yaNYsLQOOcr8srW91-nt-w0e+RBqxXGOagiGGT69n1Q@mail.gmail.com>
 <20190820115409.GO13294@shell.armlinux.org.uk>
In-Reply-To: <20190820115409.GO13294@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 20 Aug 2019 15:27:23 +0300
Message-ID: <CAKv+Gu8DBA8SoJ49dMeYjXHchGZpAiLgxLEQF7jQGtdQ6camdw@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the kernel base
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Chester Lin <clin@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        Juergen Gross <JGross@suse.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Joey Lee <JLee@suse.com>, Gary Lin <GLin@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 at 14:54, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sun, Aug 04, 2019 at 10:57:00AM +0300, Ard Biesheuvel wrote:
> > (The first TEXT_OFFSET bytes are no longer used in practice, which is
> > why putting a reserved region of 4 KB bytes works at the moment, but
> > this is fragile).
>
> That is not correct for 32-bit ARM.  The swapper page table is still
> located 16kiB below the kernel.
>

Right. So that means we can only permit reserved regions in the first
(TEXT_OFFSET - 16 kiB) bytes starting at the first 128 MiB aligned
address covered by system RAM, if we want to ensure that the
decompressor or the early kernel don't trample on it. (or TEXT_OFFSET
- 20 kiB for LPAE kernels)
