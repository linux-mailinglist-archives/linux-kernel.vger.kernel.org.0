Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC914F962
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 19:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgBAS2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 13:28:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43822 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgBAS2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:28:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so6996258lfq.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5IZAnCMpe8DW4khvlse83k3bVZJhm44NmP/u82ve7Vg=;
        b=N6WC6YbLEkYpGK90chX8z0G9lK4WcDblSzCh5VurtZtsJhEf3zIu29kgqCw1IWPMS9
         dMfaHr3I7HyMTWSkKGqK2Rdc6Uc6m307lrzA6BY+4we7tol7x7i0C2gba2oNsDxXmsK9
         oqiaQzWnez0t+y/f1iVkzxzs7TmiOtXC2cvg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IZAnCMpe8DW4khvlse83k3bVZJhm44NmP/u82ve7Vg=;
        b=NvS4Ae53FqIljHHO89fWRkijohEqZCqQ0YlPk7ZePUJaC9ibBHqWsdOzHW0PS7ETTo
         vHBsGx5MoVUUOO8KFy7wPk/+XIvswjhY82Re7ScvXulDyzUmEHZoIXIFzYMdrk0xEefv
         O9qe4/WaNQIaZDWT8+VbpsJcU53fThhCgkpijNfZlBuWp/5r40XtUvUDd1MAO+z4F+GU
         /XinQOpMWALWx3cpRH6MzxalkORAWf2Yxi0wlpeu3BgQXaYzbGmoSG76waxsJmTths/J
         kMCjuDEGoJZfn34ov43SOOxOrdWaIS634olyPDfwKRYCoYjQunr2NwHAQ2PQgiRGrYN7
         +hqg==
X-Gm-Message-State: APjAAAVrJdG+BSCD1d6fT4IdlTh9eJU5cVA+PfkOmKr2rolHbVArHOlG
        wO9bTn/XB7Dl1onQ8HlMc0NBVQ/mqVw=
X-Google-Smtp-Source: APXvYqxJEisymNwfZCooy3gQViSa6wZtEAMawQwnZTwsYuyUZyHeramFktSP3oVBI+sGh9hM7UHu5w==
X-Received: by 2002:ac2:46c2:: with SMTP id p2mr8084902lfo.139.1580581700650;
        Sat, 01 Feb 2020 10:28:20 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id z1sm6383851lfh.35.2020.02.01.10.28.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 10:28:19 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id z18so7037792lfe.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 10:28:19 -0800 (PST)
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr8314743lff.142.1580581699074;
 Sat, 01 Feb 2020 10:28:19 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAT2Z=_ig0CnCcCS-=MVN409XrPay5-62LhVRRtvOPshTA@mail.gmail.com>
In-Reply-To: <CAK7LNAT2Z=_ig0CnCcCS-=MVN409XrPay5-62LhVRRtvOPshTA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Feb 2020 10:28:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj1K6DR65Vg0-KreeRdK7AKhJ3XwbJ7Gqk5L0=QkKfvDg@mail.gmail.com>
Message-ID: <CAHk-=wj1K6DR65Vg0-KreeRdK7AKhJ3XwbJ7Gqk5L0=QkKfvDg@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Kconfig updates for v5.6-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 8:06 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>  - add 'yes2modconfig' and 'mod2yesconfig' targets

It would have been appreciated if you'd explain what the point of those are.

Yes, I looked into the individual commits to check, but it wasn't
exactly obvious why anybody would ever use this.

                    Linus
