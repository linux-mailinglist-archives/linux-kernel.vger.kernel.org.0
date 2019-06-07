Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6E23930B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 19:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbfFGRY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 13:24:29 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:45219 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbfFGRY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:24:29 -0400
Received: by mail-lj1-f179.google.com with SMTP id m23so2395890lje.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvs3ujD57naAfmKfNsIZ+NFc+doeqL+Vny0LiZy24zg=;
        b=HJLBkowV2olHeKEHPjimbZ4AIcfMLKHtIu0nL7BRIAel63MHnYXUHTX65sX00ikeCq
         Z6tHEUAlBObR3xwKed/8hqLdaXGObdkgGprO0NTrgJNl/pEIAUUDV8D/9pv0vUOJlBP8
         Frj3ERAz0q4FVPxu1SYZ53YyTGDvL3jzpjJLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvs3ujD57naAfmKfNsIZ+NFc+doeqL+Vny0LiZy24zg=;
        b=SVajuBpqL5IxEPNxz9MMCqwOHpXO3rfLNMjyI7CeFW7xH+rBXzcILQMmPdQ3FM+0VO
         p1GWB87pqa5ug9zPHZvLcQRYMC6E/W9E7qEYvLnctrreVC/pSpUF5I+cvdLN3xNxjWaq
         Fkf3FNrcm0qzitP5Y5P2cRbGnCFybw2Yx3V1WfmmMLYnpaEhh8i2ZsX3VtWQwX+/tTzo
         ZaPVdFTpEQ0PmQEbBS3MGbq6Hd7Tkr6BI650tABcxncKt93e9K4pQ41HmKxW9+o+D6dm
         1cF1wgTx21W1Kb/cv5CzqYqi1VsW4tJxRu4AxW24nuJqTyoQVA96ABtgOCx7ws0bRsYV
         pnFA==
X-Gm-Message-State: APjAAAWCZLICsYZazWj9hgCAHLpH8kNwUHZjUBpJrhXIS62eFGjvIqx+
        MQp+7ISYdb+kF1WxAVYEz1Z0vJT2e5Q=
X-Google-Smtp-Source: APXvYqzMhnOrv+eojlggJ1ttmUIxwyqbZksooiYwWPB8PZW34jfVi8vMhPESY7jnZ//kW0y8qCpe4g==
X-Received: by 2002:a2e:9ed9:: with SMTP id h25mr18647730ljk.13.1559928267122;
        Fri, 07 Jun 2019 10:24:27 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id l25sm500982lfk.57.2019.06.07.10.24.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 10:24:26 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 136so2197658lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:24:26 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr23902691lfm.170.1559928265813;
 Fri, 07 Jun 2019 10:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tx_2-ANvU3CsasrHkaJsyRV+NxP1AoM0ZSu8teht3FuEg@mail.gmail.com>
 <CAHk-=wgOGPPO6owAcRiBd0KJpmjH-C83-=_N6QeQzyiCW4kb0w@mail.gmail.com>
In-Reply-To: <CAHk-=wgOGPPO6owAcRiBd0KJpmjH-C83-=_N6QeQzyiCW4kb0w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 10:24:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipemA-iriz99pRYvoGszNjQn9cUHwzvV55HOrx-KEmWw@mail.gmail.com>
Message-ID: <CAHk-=wipemA-iriz99pRYvoGszNjQn9cUHwzvV55HOrx-KEmWw@mail.gmail.com>
Subject: Re: [git pull] drm fixes for v5.2-rc4 (v2)
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 10:20 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The second one has the subject, and mentions nouveau, but doesn't
> actually have the tag name or the expected diffstat and shortlog.

Hmm. I'm guessing you meant for me to pull the

  'tags/drm-fixes-2019-06-07-1'

thing, which looks likely, but I'd like to have confirmation.

                 Linus
