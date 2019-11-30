Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65810DECE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 20:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfK3TN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 14:13:29 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41820 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfK3TN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:13:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so23092035lfp.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 11:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LVgMGL6TsgB3lm4PtejpFpxtB2Ve5gBgTZF/idEeYI=;
        b=GioxllDGT2eS886RUhKNrSfKjQ9P2TXZy5xyeCNfQvcb8FQ9FwWw565sT/eUWR4iWB
         BUuKChkLMnBQ4PD7kE0pjmsryOGaRW9T3Jyfd0e6SZs4RfSyU2DyOYZMVpryGG18viWW
         xfdV4jJho2gJjKH/dAiyTqJzFPNjh7Abp2D0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LVgMGL6TsgB3lm4PtejpFpxtB2Ve5gBgTZF/idEeYI=;
        b=mdFGFPvGPm/UgGvAbffDhyUq01gnIh0xS/x/90BJ41XbRsbyLVOcd765RK51zkkYuT
         5jVNBX9lpaA4/YmemcJZJQDFSOl1Ylx/d/ULnWSOQZsPB1DoI7LN0Xr76zIbQ24d3+D7
         g228ugldxueq/8eV7uf4Zr2Im/6nh19yFioEHGs7KshpPUYt3BLdPgBxO2AkPXFawiGy
         fYbMnq3+s89/hU+m1yRpHQ1Qw9LoIPF5ZELSaDoWGOmtDheQnjsLMpN+SjFDENNW4vvv
         N0siob+PLFFB37yC8UiQ6E949z6PJUxtOIJJNokeJZvOpfyj0XzK8faN3TjepDKjlBxV
         Jdug==
X-Gm-Message-State: APjAAAWdXLJMoI/zHLc8u3yJoCcbinfBueQB2pwsFPR5eoAvqz1fFkHG
        T6cHORhZ6CEUzB1w18SPzfH5Bm8hcA8=
X-Google-Smtp-Source: APXvYqwNfXCHYAhVGnUsgRAIoE8szZ9iBryjPem9Lc/HykiX0hu/6FC/BXL+Ay9XM9oVT7x7yDXkdg==
X-Received: by 2002:ac2:5c09:: with SMTP id r9mr36779326lfp.136.1575141206613;
        Sat, 30 Nov 2019 11:13:26 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id c22sm12219166ljk.43.2019.11.30.11.13.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 11:13:25 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 203so24917359lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 11:13:25 -0800 (PST)
X-Received: by 2002:ac2:5a08:: with SMTP id q8mr38766418lfn.106.1575141205423;
 Sat, 30 Nov 2019 11:13:25 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mtDpwY=MrQ=yN29JeWUqf+ozgYvgnzbnb91VoK8Vg4Zmw@mail.gmail.com>
In-Reply-To: <CAH2r5mtDpwY=MrQ=yN29JeWUqf+ozgYvgnzbnb91VoK8Vg4Zmw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 11:13:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiy3Bh5c6mCYSzxOL63oQWO40s1PNM9q6hD46M3wPKR_A@mail.gmail.com>
Message-ID: <CAHk-=wiy3Bh5c6mCYSzxOL63oQWO40s1PNM9q6hD46M3wPKR_A@mail.gmail.com>
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 3:49 PM Steve French <smfrench@gmail.com> wrote:
>
> Various smb3 fixes (including 12 for stable) and also features
> (addition of multichannel support).

That's a _very_ weak explanation for many hundreds of lines of code changed:

>  23 files changed, 1340 insertions(+), 529 deletions(-)

Please spend more time explaining what you send me, so that I can
write better merge messages or what is actually going on.

                Linus
