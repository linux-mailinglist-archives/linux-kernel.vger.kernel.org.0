Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E87534048
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfFDHfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:35:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44792 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfFDHfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:35:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so15621258lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cZ5vrBQdIFZDypwr9kljKVEFMA5gzDIaaO0eZaBBhU=;
        b=RHZt0cfmTHRKWuQe1JF9J8SkTLJTmMa4aVh3ac5uJcRc59YMsnqzDbx9thB0aVkCHH
         2NW/QaLE7G91ekYTZ64AeBbD2SCJAMSqPL8Re8EyVrSkkYxj11FwRRqO4B6ag6TowVTV
         2BeEZz6o2kUF8aevFEzjhtTSUwIz7SKmF8RgzsPVZ2utrQ186Gqmo6I+WfLniH/Ik28S
         TmZrMLjXcZdHEgYgCcxt5hVlWZRASKEL74j3l9w684NCaXyZNuuXnGK/K7g9RFDv2tie
         A2yLzSjf1IMcMAAVwG/OjmScgau0DpIvMDpHkIXMfwFTLm8xHwjxnefUNLsjbLaumVSy
         xiFw==
X-Gm-Message-State: APjAAAXNLtJuskwoIECi2N4OP6gi6T/pm+roRLHdSbBhmowajnzWnqaD
        DkFkQxPoqmBGJ/noWUBI5qYNK1lTa8kv7C4W91gTkA==
X-Google-Smtp-Source: APXvYqzdO8i4+jQJ0vwwHpPYk5r1+ltqOa44LD9ssUNlLgDYP1ute8FONlULT2TMVj9qsbxPicgCdZS0qObm2v3elRI=
X-Received: by 2002:ac2:5a04:: with SMTP id q4mr15815107lfn.90.1559633700810;
 Tue, 04 Jun 2019 00:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190429081937.7544-1-geert@linux-m68k.org> <20190603122608.GA21347@jerusalem>
 <d474e366-cf5f-bbf3-9521-c5ea29bb9c19@linux-m68k.org>
In-Reply-To: <d474e366-cf5f-bbf3-9521-c5ea29bb9c19@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 09:34:48 +0200
Message-ID: <CAMuHMdVTOO13Y49D82r5YgTFGwvgB0UdCZ3o1VAXHWzYof05xA@mail.gmail.com>
Subject: Re: [PATCH] m68k: io: Fix io{read,write}{16,32}be() for Coldfire peripherals
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Angelo Dureghello <angelo@sysam.it>,
        Logan Gunthorpe <logang@deltatee.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Jun 4, 2019 at 9:18 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 3/6/19 10:26 pm, Angelo Dureghello wrote:
> > couldn't seen any follow up on this patch. I tested it and at least
> > for mcf5441x it works properly and solves all issues.
> >
> > Do you think it may be accepted as an initial fix ?
>
> I'll add it to the m68knommu git tree.
> Seeing as you wrote it Geert I assume you have no problem with that?  :-)

Actually I wanted to look into the issues pointed out by Arnd, but didn't
get to that yet...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
