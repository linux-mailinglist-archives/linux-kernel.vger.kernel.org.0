Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A23214B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 02:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfFBAi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 20:38:26 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:59819 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFBAi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 20:38:26 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x520cKBo006195;
        Sun, 2 Jun 2019 09:38:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x520cKBo006195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559435901;
        bh=VPMWdmiaMMit8aN3x2Svzq92UM7PBXY5o/g1AChMeqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rIWMv8hNY4lqui1No4RF7wbo/bN5gy3vTAda/lC5cTq8bPLlEBCZbsqjZ5Ex4wqKt
         0kjfGsFGMV5r9p6VzVV+rhu+PGTHbBk1sWB74VBjTr2hVhSKmrw2rbkjZovPOCIalx
         2xmaWGzJUozR3soe5kAwII6KTUuJtyeeYCJDIIULsqtiPLR7qZzTSXCLpUkmO5EaP7
         T+Lzd5+DR4DZ6+0tMooKWTWr7d6yPrjCIfXNu7poNweTpjRjhg60hJSFMC5o719LgG
         WDvc6eT+RBwknd9x1biTV6KvJ5AiJMBXA4+Di6m68KAF18pP058nOtHwna3rQmPa8D
         CnvQfqhiSbodg==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id 7so5250768uah.1;
        Sat, 01 Jun 2019 17:38:20 -0700 (PDT)
X-Gm-Message-State: APjAAAVB94RgSPzS/XJv0ATYD3TMhvZ5DnRW3GlOJRQRVxiq8Bc5Vyb3
        11swrhTyh7JIEvZS3essSv2jKITjjvtflKBsHWk=
X-Google-Smtp-Source: APXvYqzqZ75H6WWeaX+LmWXIu9i2MAyw2MtmcZ5+WQel0nCu4TR+kFBGEkCow4ynoBFcyfjMf0nwuCrztJEVw9Vvwt4=
X-Received: by 2002:a9f:24a3:: with SMTP id 32mr8228855uar.109.1559435899588;
 Sat, 01 Jun 2019 17:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190601144943.126995-1-alex_y_xu@yahoo.ca> <20190601162907.GB6261@kroah.com>
 <155941810155.1991.11907646865432946934@pink.alxu.ca>
In-Reply-To: <155941810155.1991.11907646865432946934@pink.alxu.ca>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 2 Jun 2019 09:37:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASoaiBCObeEPO-hcrg9ftsGq2QWXoG+R8TWv1z53HJvXw@mail.gmail.com>
Message-ID: <CAK7LNASoaiBCObeEPO-hcrg9ftsGq2QWXoG+R8TWv1z53HJvXw@mail.gmail.com>
Subject: Re: [PATCH] crypto: ux500 - fix license comment syntax error
To:     Alex Xu <alex_y_xu@yahoo.ca>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        allison@lohutok.net, alexios.zavras@intel.com, swinslow@gmail.com,
        rfontana@redhat.com, linux-spdx@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 2, 2019 at 4:41 AM Alex Xu <alex_y_xu@yahoo.ca> wrote:
>
> Quoting Greg KH (2019-06-01 16:29:07)
> > On Sat, Jun 01, 2019 at 10:49:43AM -0400, Alex Xu (Hello71) wrote:
> > > Causes error: drivers/crypto/ux500/cryp/Makefile:5: *** missing
> > > separator.  Stop.
> > >
> > > Fixes: af873fcecef5 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 194")
> > > Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> > > ---
> > >  drivers/crypto/ux500/cryp/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Also, how did 0-day not catch this?  Is this an odd configuration that
> > it can not build?
>
> I had to run "make clean" to get the error.

I think this copyright block is ugly.


# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) ST-Ericsson SA 2010
# Author: shujuan.chen@stericsson.com for ST-Ericsson.

looks nicer IMHO.




-- 
Best Regards
Masahiro Yamada
