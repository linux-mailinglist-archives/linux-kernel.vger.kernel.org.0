Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50506675A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 22:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfGLUBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 16:01:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36726 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLUBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 16:01:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so10476303ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GgMOwJo+Cv2ZJcFQPj3+vdndvfK6fOvh4fsxhvC7BIY=;
        b=LQV603pv4BNPDCoa+rZ7vrcUFPUXj4MxinKs7ufiljCBRgiOTeX+qfDTRdylfLhcWa
         yd/o4b5CmJTyxgaB2ikp92iEOSoDb3Btmrkez5zCb4qIFfFvLQY2uWxQ51m8PU7muyWH
         UXHOgoRTATF20tXYviWli006FC5WBqbxu2DBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GgMOwJo+Cv2ZJcFQPj3+vdndvfK6fOvh4fsxhvC7BIY=;
        b=Mw9CiE7wFTRVp1RREqtdw94SWts74KUlhu4yy+Xg+8o94pQilOSW74F+SNN5auXKor
         m8Yg84pkLYy//f4oybhMBjGKI9YtrdE7yu0ImAXhHYtk6uYM/8+Kgk3g8zA2Pjzir9e5
         V6768hD69zOYFMVNFE3y8igXRUBKXh2IpOmRl9A1E5ONH+gAmqAqTgPBnKnCwBRIZ/e+
         CoR75ifGsqgmQPlu4UHE/xH3fGz0ESc3Hw/70KCvIcTkkWFHCst2pJJiWfxHH2ufdB54
         Ldjk8LPSScrtKsyFytIe0QyaTPLalSx1L6tIBzCb7H5MCPjHHvSlSvPLN6NZwJWDw3nA
         wi3w==
X-Gm-Message-State: APjAAAVMyoAY843YchXRVKB7bdbu0o87StJpYW/y1Q93J1zWGk2hh2M7
        WD46cOop6/ytwNgmC37ZQS63xDBRkTI=
X-Google-Smtp-Source: APXvYqy5oh6dTOuBHYI8vA4+sQM+l7jj5xg0dqQc2WPN7DT3xoc7UXeo149PrHi8SH3/uisf+Y/npg==
X-Received: by 2002:a2e:1290:: with SMTP id 16mr6758461ljs.88.1562961677569;
        Fri, 12 Jul 2019 13:01:17 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id l24sm1620400lji.78.2019.07.12.13.01.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 13:01:17 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id t28so10467154lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 13:01:17 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr6577493ljk.90.1562961206889;
 Fri, 12 Jul 2019 12:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190712035802.eeH5anzpz%akpm@linux-foundation.org>
 <1562935747.8510.26.camel@lca.pw> <CAHk-=wjBYYjNj-Mn861p3uPjOx3oRpJA3CJnU1nEg++QOGDCBA@mail.gmail.com>
In-Reply-To: <CAHk-=wjBYYjNj-Mn861p3uPjOx3oRpJA3CJnU1nEg++QOGDCBA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jul 2019 12:53:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFdfgH=v9quf=bo494kniZktOXS0dZ0myzC44SN9+bGw@mail.gmail.com>
Message-ID: <CAHk-=whFdfgH=v9quf=bo494kniZktOXS0dZ0myzC44SN9+bGw@mail.gmail.com>
Subject: Re: [patch 105/147] arm64: switch to generic version of pte allocation
To:     Qian Cai <cai@lca.pw>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        anshuman.khandual@arm.com,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>, deanbo422@gmail.com,
        deller@gmx.de, Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ley Foon Tan <lftan@altera.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Hocko <mhocko@suse.com>, mm-commits@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>, ralf@linux-mips.org,
        Guo Ren <ren_guo@c-sky.com>,
        Richard Weinberger <richard@nod.at>,
        Richard Kuo <rkuo@codeaurora.org>, rppt@linux.ibm.com,
        sammy@sammy.net, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 11:20 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I fixed it up, hopefully correctly.

.. and it's pushed out now so you can all point and laugh at me.

            Linus
