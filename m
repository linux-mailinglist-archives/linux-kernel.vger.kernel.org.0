Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81867746
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 02:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfGMAhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 20:37:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45961 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGMAhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:37:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so10887425lje.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 17:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/oHh+KfYiojX24PeRpNZ9bgkp3x+1zxibFblI44iD8=;
        b=afMlZbJR01uNxECvl553LyvXWUVnKt/aegDCJM2MxrhegX3SSsk/5/gMQJQ6IBucdb
         9Yz7UCGdOl/UOdKI0CoUM6jHTWhZ5X92Zgrb6P4bbkqvwin/seWkQJ4Oxjr4y5V68WaJ
         qaV+mrEf6aa+8YRLBmu2kMAhZTXwXmKrnmNes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/oHh+KfYiojX24PeRpNZ9bgkp3x+1zxibFblI44iD8=;
        b=mSDxz/+OGpId+QR+eJ5FXEn4M7jvPEn34ahV7CRQWFd5hLdHcHxBu4n987PUH9aS0K
         tDfkkzcJa3Buhlp3jnpwo41RzDJz/AW/jCy57L8JcWBQ4yLS0wMT15tudl2FZhQgM9vz
         eieqFfbr2h8wQY+SiY9yLtUzCqEs3wVq4wE/eO8QlsyBO2a1Ak3+4/HxFnmxlDbIhiL/
         AhEjUb0qPG+vPkLVg6BiYLxBA9osWJz1fBQme1YZg/vEb1kNhonp8LdgCrp/HLFrU68M
         VkJ3zMJLjSoAFuWW+hQ0i6jgZYjsC+IpWMnbepjuNgHD2QQts9zowKJKE6aWAyPs6DDS
         F/dw==
X-Gm-Message-State: APjAAAUoZ5ZtQyYDJqqrSlXVC+2zyiegDEqCilm1945vG1VuKQOmnerV
        pcgamsSG6Zvs1tUnGIiRgwXp9+duvH0=
X-Google-Smtp-Source: APXvYqwdvsI4mdqdL8tL+nZSjObsiKQh8QOzh5Hq+AooaDJdj97zve/NsAez7MEENmvUBMbZBWlA5g==
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr7612555ljj.137.1562978226406;
        Fri, 12 Jul 2019 17:37:06 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id g5sm1722423ljj.69.2019.07.12.17.37.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 17:37:05 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id r9so10938450ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 17:37:05 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr7071792ljk.90.1562978225234;
 Fri, 12 Jul 2019 17:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190712080446.GA19400@nautica> <20190712080824.GA22697@nautica>
In-Reply-To: <20190712080824.GA22697@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jul 2019 17:36:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWKQsGoWm_yf0WQ3bb+HgaU8mJVaYXQqwqtQAFrHEqUA@mail.gmail.com>
Message-ID: <CAHk-=whWKQsGoWm_yf0WQ3bb+HgaU8mJVaYXQqwqtQAFrHEqUA@mail.gmail.com>
Subject: Re: [GIT PULL] 9p updates for 5.3
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 1:08 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Just noticed this typo in version number here, should I make a new tag
> with the correct text?

No need,  The important part is the signature itself, the typo will be
embedded in the merge commit (as part of the merge signature) but not
really matter.

Nobody will ever really see that - even when asking to see the
signature with "--show-signature", it only verifies the pgp signing,
and doesn't show your typo.

(But just FYI: your shame is forever visible to future generations if you do

    git cat-file commit 23bbbf5c1fb3ddf104c2ddbda4cc24ebe53a3453

and start looking at the details ;^).

              Linus
