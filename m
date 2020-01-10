Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86F136D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 14:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgAJNGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 08:06:49 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35671 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgAJNGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:06:49 -0500
Received: by mail-il1-f196.google.com with SMTP id g12so1732383ild.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 05:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eRVtfzsCGIossuuL7cnCXyDDfgkQkbd5CLV0LTy3I5E=;
        b=XWaCmKBFzN2Y5NZDm//zDs3SPd0G2WhOEgbl2BJTajnWYGTlYDyzynl+yAEx/sqzQP
         LFS7LV3uaXEFCwAVXLTNpOgZBHomeCBhKW9B72RGnlLbXPOnbJjnfvN+ZFejyU2qfra+
         Jskj37Zpnl7gVrwfRUz3uZIVeUBCJA84K/oGnt+lL2QYTTDYnAiGYSSP8b7vpBUeQxrO
         xxIhZm8xDqupKI9Xc5KUEF7mDLhAtPT0KSZSNfl+1KM0L7HJH35eObKc9bS6yVcbm1UY
         sbtEZhEdOY5F1X+nFNoTXp9kobsTlcVpCKab2Fq7+iIniPl/CWFyp6qKVPlVS6VZmm34
         57mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eRVtfzsCGIossuuL7cnCXyDDfgkQkbd5CLV0LTy3I5E=;
        b=iWpftgj3O80a/+2cAX3+BbUjA1scLfc2bu1N1aX7Z/LykNPSRB+TbU4ZwJNquCx8zQ
         HU/glzPPCvb3kDdf35zegqFJY86sWtbNdxDADJU6Ekk+6hqTjrF8fE0sUvhJ113jE79N
         px+YtCOGtwP0aFhWyvYuqZehofaTKGrcp94jSKA95zWXJHihoEse8r0P5WoJcjQkBFfU
         MdFP1uPn/0iVe0Qn0TivMdkG/i+T0bor7H7VqjkaMPZTBYyXRfnYWosoTWeOHPO764oW
         WkwXkvobfxzVMWzk0wuD15NzqcVaTfp3OzALfoGRNUWYGNviHqn+Qp/0wVCEzXdGtxf6
         Xavg==
X-Gm-Message-State: APjAAAU7hpasLcj1mUD0NZJz5YjATzW8cumcPEYk1m2vlOijaVog0u/n
        eBpTw2/Y32ZDjd2SyfNwCBc5fPuRFRaoMTafcAQmJw==
X-Google-Smtp-Source: APXvYqwYWJ9PiiNCPZyLCC9T8oTUWALv8iFTSCJyENrTo6u2vU1Ps8DqBOCwXX6I83W5rN3aQv8fh0944ArWbVp5iUk=
X-Received: by 2002:a05:6e02:5c8:: with SMTP id l8mr2529843ils.287.1578661608697;
 Fri, 10 Jan 2020 05:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20191210100753.11090-1-brgl@bgdev.pl> <CAMRc=MfZmMV58kYD=bhuUCY0n3eb5iVy1kY=6NJsx6guagCd=Q@mail.gmail.com>
In-Reply-To: <CAMRc=MfZmMV58kYD=bhuUCY0n3eb5iVy1kY=6NJsx6guagCd=Q@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Jan 2020 14:06:38 +0100
Message-ID: <CAMRc=MceORQp1L278uNykQP1T8mfi9hH1UMhRanU0asqVjjR1w@mail.gmail.com>
Subject: Re: [PATCH] input: max77650-onkey: add of_match table
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 3 sty 2020 o 14:12 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a)=
:
>
> wt., 10 gru 2019 o 11:08 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82=
(a):
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We need the of_match table if we want to use the compatible string in
> > the pmic's child node and get the onkey driver loaded automatically.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Gentle ping.
>
> Bart

Another week, another ping.

Cheers,
Bart
