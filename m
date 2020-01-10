Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6713D13780A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 21:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAJUi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 15:38:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40950 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgAJUi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:38:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id u1so3458016ljk.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwolBsIgDGCVUkuSZAXRmkjdEmEEA4cQUilISYO+J6g=;
        b=KMWtE7+YPwle9SL0j+y71fRurG4RTvYhGihBiblvXCB/Ffgesfl67Jf9uO2iN6Zowv
         V+httb+uJNwFOpVTmASjdnvw4XkNlnc15na/eSuYdTWfmU/csZGjKyNqoozQGm/sOVkq
         DI9KVcBBLukvUyMHO9zoVyU0CY//JZepI+q/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwolBsIgDGCVUkuSZAXRmkjdEmEEA4cQUilISYO+J6g=;
        b=S7TOCYg2Jh7Knf27AOC4rKckT4NneGs+X1iYUE/v71y3tenL3eHSONyF/DC5kQjqQY
         jDMltOAO8Cz2TRrF68vcBiz4Z7rW6DcmM95mTD2UGFNAAnuZnjpcA1A3+PJbr06C9x1S
         1fmUKMLD4isoDAUzYi/l5tXSWGmiqG0IkuaUpnmP1ER0kGQ2A5mk8k+C2Wb0P8nj9jLM
         oXodn4pHZupopUttGC1dhLW79zbdsQY3eEUOZMo6PpX7UZ4c2ouIv3Ua2XE5p/0jS7sU
         XWE10YZWPHn9hV/dmG84fgDodULAdfG6zBWb5v6tJHw0OqrBuOk1m1KzBCZOc8vSyC+P
         05JA==
X-Gm-Message-State: APjAAAUUcaIZ16jILQ0AWVwBYKA6ncOefI9lbqqhVyx8lNFuGrxo1tbk
        mD/tM2ikF+71XB++2xVWWYFOfIRhTuA=
X-Google-Smtp-Source: APXvYqzFfuskcsOfCzprAM7daevrNG9cvw1OFSknES31PSNMHxCwJJ3WImode4XaKxK0szUnrve8vw==
X-Received: by 2002:a2e:2c04:: with SMTP id s4mr3924378ljs.35.1578688734745;
        Fri, 10 Jan 2020 12:38:54 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id d20sm1573185lfm.32.2020.01.10.12.38.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 12:38:53 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id a13so3437389ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:38:53 -0800 (PST)
X-Received: by 2002:a2e:93d5:: with SMTP id p21mr3902573ljh.50.1578688733508;
 Fri, 10 Jan 2020 12:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20200110154218.0b28309f@xps13> <CAHk-=wg=8=nTeOYGoAbJ=VjS47Nh4-_OFK9zKsK3mK4nAi2dNA@mail.gmail.com>
In-Reply-To: <CAHk-=wg=8=nTeOYGoAbJ=VjS47Nh4-_OFK9zKsK3mK4nAi2dNA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jan 2020 12:38:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdsFSX0gTOiNkTANONgHHVY+8jUd1DmY2SJpdNOq5xJw@mail.gmail.com>
Message-ID: <CAHk-=whdsFSX0gTOiNkTANONgHHVY+8jUd1DmY2SJpdNOq5xJw@mail.gmail.com>
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

On Fri, Jan 10, 2020 at 12:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Konstantin, can you see what's wrong?

It's not just Miquel's. The sound, thermal, and power management fixes
pulls seem to also be lacking pr-tracker-bot responses.

But Jens got one for block - but that went to the block mailing list,
not lkml. So maybe it's specific to lkml itself.

Maybe things are just slow, and I have gotten used to the
almost-instant responses when I do a "git push" to publish my pulls.

               Linus
