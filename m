Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB011C15A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 01:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfLLAaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 19:30:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37183 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLLAaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:30:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so261580plz.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 16:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98MiLyb51h/Cn9dLTiDsE8vJncDIeF6YECGtn7W0cKg=;
        b=lP5Q5crX7/86Q1Xp9XhlJT2FRQD7zC9MxT79L9+amXZP+PhH3+YyDU+ctYKmPb17dW
         Q2cO/iO/ITwDzdv1X2LTcZl2EBQL0lUpWBssaHesdTeOEJ7ZFWYHQqJRR+tUg4n+Calt
         iNFRm8QOAzdf4KF96xSvwJznLTkB4VYX8ZP3hfFaqjDjBiL6PkseF3kJB/r2Y8gU1TIi
         UlimAMy4UwP96pqrj1AMt5GHymW2cJwEa9U3nOF/qWGj3RAXjQ2hnCRvMWvmtZEvSp5B
         FMpsl4O4HQMYL6cr4l/B9Kizp0uceT4htzL1ROd3IO0a5ZjWDA1skCCReslvqApFuwTR
         6J+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98MiLyb51h/Cn9dLTiDsE8vJncDIeF6YECGtn7W0cKg=;
        b=qcdl1+ev45sWQCmR0+xPgdCqicyvojdJS/7pSkSZYsms8jgBjn3NWWZRvp/P2tsxBQ
         iw5/fcVLVHmZSO8j1tx3F4/Xo4W8oqxHoRmriAx+v/kDXAgmBjHcDUUSaGrZAAvRks6l
         O8G5bKpjSqSkqp385tiZFC4micuNe54kdvr4Q6GNhNzb1YoRgCqpPpv6ehhuteqlenTl
         IHtQLdMx+UIyg1yqDE99oJAktuuCTucUwtLoJXruflO7lv9E4bnkqytwFs6VL43U9f7r
         IjaMjG7DwQ7WYH1eBdFNxONiGF58+Sjntmi+htur6sByDkdPX3MyDRPA+4ItU6yv2vJm
         sETg==
X-Gm-Message-State: APjAAAWSfvtIy4GvpNqibtFwwy7YCEIs3HorDVjXRNWnA6FEguDRZXPa
        d7UYeFuhDl/p8npOeu2damwW9Oz7nShmrvwhbu6TdQ==
X-Google-Smtp-Source: APXvYqzq6Vm4MF0LJmgPetQ0HfLygKQDroi15h3w98cajYBED64kJb4iyOD59iDuYqSx2M7otcQUFs5SP10L1YECnr4=
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr6600338plm.232.1576110614370;
 Wed, 11 Dec 2019 16:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-8-brendanhiggins@google.com> <CACPK8XctCb9Q2RaFVHEDuWxKDXpCWMWs-+vnKZ=SeTa3xRnT_g@mail.gmail.com>
In-Reply-To: <CACPK8XctCb9Q2RaFVHEDuWxKDXpCWMWs-+vnKZ=SeTa3xRnT_g@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Dec 2019 16:30:03 -0800
Message-ID: <CAFd5g45MFYMK-eZWPC5fhm2OkynUXKfArUVhbanYVH+qKRUwPg@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] fsi: aspeed: add unspecified HAS_IOMEM dependency
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Jeffery <andrew@aj.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>, linux-fsi@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 4:12 PM Joel Stanley <joel@jms.id.au> wrote:
>
> On Wed, 11 Dec 2019 at 19:28, Brendan Higgins <brendanhiggins@google.com> wrote:
> >
> > Currently CONFIG_FSI_MASTER_ASPEED=y implicitly depends on
> > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > the following build error:
> >
> > ld: drivers/fsi/fsi-master-aspeed.o: in function `fsi_master_aspeed_probe':
> > drivers/fsi/fsi-master-aspeed.c:436: undefined reference to `devm_ioremap_resource'
> >
> > Fix the build error by adding the unspecified dependency.
> >
> > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> Nice. I hit this when attempting to force on CONFIG_COMPILE_TEST in
> order to build some ARM drivers under UM. Do you have plans to fix
> that too?

The only broken configs I found for UML are all listed on the cover
letter of this patch. I think fixing COMPILE_TEST on UM could be
worthwhile. Did you see any brokenness other than what I mentioned on
the cover letter?

> Do you want to get this in a fix for 5.5?

Preferably, yes.

> Acked-by: Joel Stanley <joel@jms.id.au>

Thanks!
