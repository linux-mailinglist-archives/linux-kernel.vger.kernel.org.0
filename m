Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B066370E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 15:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGINhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 09:37:19 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:30081 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGINhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:37:19 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x69Db7Js021418;
        Tue, 9 Jul 2019 22:37:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x69Db7Js021418
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562679428;
        bh=ObKEOLR2UbFEeFTWRY9OPCc16z3rd26SnSFncXPuWbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XSevLwhRcDuoYBqb/kB42Ni5nStGcoveUoWvEgSCp15o5bjj8Xxbc0Q84F5nP6N4B
         pCe0i754DFtUJ1FGjPr06MZeEUlRpjKfsZHWRujJkP5AOjdMkyLB+o65Y28SayNHcy
         UBUaGfflZA6c3xVWkhMbG1hdPUAsrWPzpsjaY/PyjPMDBswAvG01cxlE+bJqAQHdRR
         3NcoOEip1hHptCTzcPjWj/IGAUQVS2jUBS8hXFz3mfMZZKYefmF4GKIFXiZ4BmjHnX
         04yT+AcEc9byxm0pUeDju3nW+HTlfJDvDtwvrtjL6J1COOTP9z6wG0rbC4nY923xhd
         l4IF/3C4qZ/LA==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id k9so10630344vso.5;
        Tue, 09 Jul 2019 06:37:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWRPgfOjqdPuk5OyNby5YgWotx8lBa3ZJxG2lyfiBlIWTZ2WZo8
        uT6snb9E9L99YB0qP8taJHzgmvdEnnYHEUHtqt0=
X-Google-Smtp-Source: APXvYqyGPtmfLEn9rBW7ihZhvrJgW4nZtGiWD36NunhGiORc2fmpyab0TS4YqtBrz/EDtZruAE01UplHwZOi6/ypFwM=
X-Received: by 2002:a67:f495:: with SMTP id o21mr14546426vsn.54.1562679427317;
 Tue, 09 Jul 2019 06:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190709222019.5359e707@canb.auug.org.au>
In-Reply-To: <20190709222019.5359e707@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 9 Jul 2019 22:36:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARBUkmcgOzMSHav7_w2OjX-_FHBpZ5ir_kP59_27VE6Ug@mail.gmail.com>
Message-ID: <CAK7LNARBUkmcgOzMSHav7_w2OjX-_FHBpZ5ir_kP59_27VE6Ug@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

On Tue, Jul 9, 2019 at 9:20 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   8eaeddd155af ("kbuild: header-test: Exclude more headers for um and parisc")
>
> is missing a Signed-off-by from its author and committer.


Sorry, I was trying to squash this, but missed to do that.
Will fix it for tomorrow's linux-next.

Thanks.


-- 
Best Regards
Masahiro Yamada
