Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490D6123576
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 20:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfLQTPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 14:15:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34693 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfLQTPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:15:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id m6so12236863ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 11:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwxKP9VkMTLHcIkXkAhlZnnPpYJKd3aE1fwLTmr07lA=;
        b=gw9uUO3B1bY2CqL58B/WnUFNcYemCCJJ10TbZMfxkDt+pT4pcP7Ai0k2cgKNebRvVr
         7jy9UnQ8+BUgIisEKgV+NTw8WKhJjkvKLsJrwrjxKOs75dtv78pGVVMYwrhLZszAZKRI
         5X1KKWNwFzYkaXeUhZFRiavG0xOJrU5D9LpHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwxKP9VkMTLHcIkXkAhlZnnPpYJKd3aE1fwLTmr07lA=;
        b=sySssA8efnQ0E+GGSK5Nl7cF6YeTQrAR5hBDNHf5NHljD8jEiv2uiknidWvHWiuAnP
         KB0Qz3fYBRaNCqv92D74bJJi/G/HTbt+3os+eYLhOQUIUIPu7Sn9T3gbiF+X2QG7Xydz
         ALywiIE/fm4mRZuS8j0w29BrDbhrojoUFduiBscUaCeyhlXNigVFOGB7mnvIr/CB+rld
         tMZDcrg7WxFYolG6lqoIV/2mH+FueeevwCeNvqcijSGn7kzoIM6WS8d0aJ3KNX+I8D8m
         Tfmk87D4Ih8DvZ/G1XxV/1FhZtI9ewMlFSGOe0fy6sqNR347YCm4nb4R3BlwwZGstSki
         K3nw==
X-Gm-Message-State: APjAAAWBFcqm82Bfp36VjnkxZXS6GWGmyQVoISnUN53Z/DcG12lctFnV
        WHtj9P7NZzIHNLFeBm2/thosp5z0EBo=
X-Google-Smtp-Source: APXvYqyzJZbx7F/IkLcKwn8ThJF8DHcM85Ez+QJp3Uv7t1DfoBziXK0f85Kt/Ax1PRbCaaAtKmS8KA==
X-Received: by 2002:a2e:a0ce:: with SMTP id f14mr4189572ljm.55.1576610105300;
        Tue, 17 Dec 2019 11:15:05 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id a11sm13146918ljp.50.2019.12.17.11.15.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:15:04 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id b15so7771560lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 11:15:04 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr3839498lfo.134.1576610103833;
 Tue, 17 Dec 2019 11:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20191217115547.GA68104@gmail.com>
In-Reply-To: <20191217115547.GA68104@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 11:14:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiVZMU69qB7nmkkyvjtDenQ+89V94V=3mmdY88uWYrZiQ@mail.gmail.com>
Message-ID: <CAHk-=wiVZMU69qB7nmkkyvjtDenQ+89V94V=3mmdY88uWYrZiQ@mail.gmail.com>
Subject: Re: [GIT PULL] timer fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 3:55 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Add HPET quirks for the Intel "Coffee Lake H" and "Ice Lake" platforms.

Is there any reason we don't force-disable HPET by default if there
are alternatives?

I think that's what Microsoft did, which is why it's so broken on so
many platforms - it's often simply not used.

                   Linus
