Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90841377F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 21:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgAJUcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 15:32:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37480 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgAJUcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:32:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id o13so3447402ljg.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJY/k139t+jKR9coVO4oz8lqyEAClB7/i7kGMDvcB1E=;
        b=U8Kl+MGD1543lW5ezWJsO8oq463sERmIzSWDKAZ0apd6rJM0caY/D1COvpgRRh4ogt
         f0LM83WBDcyAgnUvGHNZKwxdRv2C3u5xmjLuY4iFlL+tm7t3iSVOg0qnmO68SsJpMHRG
         cmTIA35ClvhnccnTJ/L6rXx1hGLazRA7WgJpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJY/k139t+jKR9coVO4oz8lqyEAClB7/i7kGMDvcB1E=;
        b=q2ETfVPpM3yzf2vKIkfriByotUWTEQkqJSOWFyR9XXRktRLL8NwvXZ0YyRbncFvj4k
         rT7Ep/XQxrFCipvi7IIZuWMhSvG3zT24WO7BxnuKjIsEn5AeMO97m13RRyiKqQ5coj33
         UqFezU8tLG6IcLgDbDI3gn9GFZ/cJKa1ZSKAEBsuAc+X9U3WTJ5JrRbKklmKnqnzKoL7
         IgXTL/fOrU2cExsbWlRam/NDWhwQMbPTzSSLIDmnj39NJRhavjxkMSV/dgOv9H4ElDH8
         ULiFd82/43ris2n23wZrbxPrEz+ClMMeD7hrqzSQRo4NSbs25zuXrf1d/1n6IDQs7JSZ
         7kUw==
X-Gm-Message-State: APjAAAV2vFgNmzqt5T/gNpcLMY1HN3jtZuXl7pc4OmXtavLLnA6WWxnj
        JSYLKhRDfnnzvuALqU4zDJ2IQWvtSrc=
X-Google-Smtp-Source: APXvYqxxWhn/4JPTkUyrueypxrj3GrzrNC8nsDBHX2SoOrwacjxkhH+8oD/dXefr4eYdOnDfQa8grg==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr3720082lji.247.1578688326994;
        Fri, 10 Jan 2020 12:32:06 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id d24sm1596088lfb.94.2020.01.10.12.32.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 12:32:06 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id m30so2442076lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:32:06 -0800 (PST)
X-Received: by 2002:ac2:58ea:: with SMTP id v10mr1444385lfo.202.1578688325770;
 Fri, 10 Jan 2020 12:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20200110154218.0b28309f@xps13>
In-Reply-To: <20200110154218.0b28309f@xps13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jan 2020 12:31:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=8=nTeOYGoAbJ=VjS47Nh4-_OFK9zKsK3mK4nAi2dNA@mail.gmail.com>
Message-ID: <CAHk-=wg=8=nTeOYGoAbJ=VjS47Nh4-_OFK9zKsK3mK4nAi2dNA@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Fixes for v5.5-rc6
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 6:42 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> This is the MTD fixes PR for v5.5-rc6.

Hmm. I've pulled this, I've pushed it out, and I see it on the public
gitweb and I see the email on lore.kernel.org.

But I don't see a pr-tracker-bot reply.

I _did_ get one for Jens' block pull, so pr-tracker-bot is alive. I
can't see why this pull request didn't trigger it, though.

Konstantin, can you see what's wrong?

            Linus
