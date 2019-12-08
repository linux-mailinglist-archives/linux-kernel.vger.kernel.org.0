Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E36116416
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 00:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLHXT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 18:19:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36422 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfLHXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 18:19:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so9227438lfe.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 15:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ojb3aKElTAzJwxQ5h0zuVz/l+cicQW5NaTULtlrrrIY=;
        b=FOOSIEMEWzkeTCdv0j7WWFOvOveB7eeZ41DltRtm398mt7YLlRt4czpfLwyoVgXpxN
         wwQZpyxyCTxEC3t3kGP5oqxS+uiThGEdHcuPmPvuyw982C1L4HN95WrOEdgC7zSIwo0M
         +00QuF79OVnakEaAXrWa/isBNCbBlOsH+KBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ojb3aKElTAzJwxQ5h0zuVz/l+cicQW5NaTULtlrrrIY=;
        b=goNZxiqFbMx3w2vpgawYmZocN6j33fXK8hwzxeNUrUyDQ7i/ZvAuhfXQdKUJTzCDx1
         JS1USvqPozWwKSGNAqgrU1lnEHwEQZGQ/TMkxSRnX7yOPV8RbOwTTrRKrDPlTFOV6who
         t8pCaYae/ZH1AqXCk31hVLVdFM3B4qw/NPMakJliVQQhrMHB9NL5Ff8a7KiJRiP/B+ye
         k/n2V1bYfVWIM3vBCy9ukUtaZYI18ZzR2abYBXTtWHXxLE6ST/Fa9ykJ/06fofU2gVOs
         74CvF0a/O8nf1BxmerljcZtx0Ko2elz/0mj5CwJmf78dnu5PUE84fsOnM0zH8JTos3LV
         zX+Q==
X-Gm-Message-State: APjAAAU5e+oGarbKjc36Ltbf6qlIpNR6vxr3a0jOS+gCXs1s8yIammp2
        hI+mKixCKleAQQmUDJF04dzx2yhaAkU=
X-Google-Smtp-Source: APXvYqx/A4YVzSyfyvCGjTJHmxT3Bf2AafSSa0Yn0QU0mZUF7AHiwgVrSUTL6MtXfDaCfsu7laJs3g==
X-Received: by 2002:ac2:47e6:: with SMTP id b6mr13424048lfp.96.1575847196051;
        Sun, 08 Dec 2019 15:19:56 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id m24sm11716762ljb.81.2019.12.08.15.19.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 15:19:55 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id b15so9211879lfc.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 15:19:54 -0800 (PST)
X-Received: by 2002:a19:23cb:: with SMTP id j194mr2331195lfj.79.1575847194560;
 Sun, 08 Dec 2019 15:19:54 -0800 (PST)
MIME-Version: 1.0
References: <201912071144.768E249A4F@keescook>
In-Reply-To: <201912071144.768E249A4F@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 15:19:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnaWN1V2G1zyk8zqTVQBdHBBHcdkB-rek5z2VeRq4nmA@mail.gmail.com>
Message-ID: <CAHk-=wgnaWN1V2G1zyk8zqTVQBdHBBHcdkB-rek5z2VeRq4nmA@mail.gmail.com>
Subject: Re: [GIT PULL] treewide conversion to sizeof_member() for v5.5-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 7, 2019 at 11:48 AM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull this mostly mechanical treewide conversion to the single and
> more accurately named sizeof_member() macro for the end of v5.5-rc1.

So this one I'm _still_ not convinced about. It makes yet another name
for something we've had before, which just annoys me. And maybe it's
the 13-year old in me, but "sizeof_member()" just makes me go "that's
puerile".

I _can_ see why we'd want to standardize on one of the tree versions
we have, but I can't really see the problem with the existing #define
that we have, and that is used (admittedly not all that much):
sizeof_field().

                Linus
