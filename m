Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599AD394FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfFGS4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 14:56:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45219 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732102AbfFGS4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:56:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so2611939lje.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldUxE0mi4WaCkQbvj9tDP1Y3dc9QMW/mTJhHqgLzTEc=;
        b=RKAsnvIg7cohPa9ftFN/RAF3uODOQevDuoFKHSPc0Xl7WdRdmcZdyGnMNLHluRHbqx
         u1w+QeICOks1DEl+AX3rcan7uhfcKxu3t+qYGPITFJ/CPSgD+SwNUDgnEQevDh4687CE
         28hm9HoLaAqEQO2OQjx2RFtlsWUqCO4SqrVko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldUxE0mi4WaCkQbvj9tDP1Y3dc9QMW/mTJhHqgLzTEc=;
        b=MXP/lsE4v19JeU2vDZi/yxb5iwetP3ARfGcyUZ8oIcY9ByTDvzDBEWZV/UKNajHZr5
         itEC8yaaw1MKoyEa7nDmiS1PN1XqpsqRB+b652R/UCGi7y/uvZPsQUGRQT3NZVDUUBjQ
         1HMSb7piew1vdZa5pk5XAb2qnSggBY5TY/D8ykwhZhanNd/LAVVOBh6Pg8aL4MPs/RwQ
         AhMIe6a9eWZ50JMmvCy0tW+qMd6BDjvsB3asfzGo8zc3dsfZOAP/8YTF8CZrzRKXGQ3U
         yVBG7PfFd5QmwwGjtzTxEEs4+yOcJHMqqs+aAp4RAoFUhw4lNNeyawmcrcKcTOZNMEu4
         zA4g==
X-Gm-Message-State: APjAAAXNqmdCB6FwTQTDFkrgxzhCmI2QDMJlfASNvbUKOSh4TbFf1oHJ
        Xku+rUqgHSdGgiplAF4KVAA3cSIkBAA=
X-Google-Smtp-Source: APXvYqw4k9h+8l5LYLSMziyoCreWth1YzG5MAY4PdS3bFULzowNlRHtRX7KCNXXIDKiN7H3Uf4Isvg==
X-Received: by 2002:a2e:1201:: with SMTP id t1mr3323397lje.153.1559933793637;
        Fri, 07 Jun 2019 11:56:33 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id t21sm502921ljg.60.2019.06.07.11.56.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:56:33 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id a21so2630359ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:56:32 -0700 (PDT)
X-Received: by 2002:a2e:635d:: with SMTP id x90mr19091410ljb.140.1559933792458;
 Fri, 07 Jun 2019 11:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <871s05fd8o.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 11:56:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
Message-ID: <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 11:43 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> On the glibc side, we nowadays deal with this by splitting headers
> further.  (We used to suppress definitions with macros, but that tended
> to become convoluted.)  In this case, moving the definition of
> __kernel_long_t to its own header, so that
> include/uapi/asm-generic/socket.h can include that should fix it.

I think we should strive to do that on the kernel side too, since
clearly we shouldn't expose that "val[]" thing in the core posix types
due to namespace rules, but at the same time I think the patch to
rename val[] is fundamentally broken too.

Can you describe how you split things (perhaps even with a patch ;)?
Is this literally the only issue you currently have? Because I'd
expect similar issues to show up elsewhere too, but who knows.. You
presumably do.

                Linus
