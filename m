Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329C460BA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 21:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfGETHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 15:07:03 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40567 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfGETHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 15:07:03 -0400
Received: by mail-yw1-f68.google.com with SMTP id b143so2707079ywb.7;
        Fri, 05 Jul 2019 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwR0O1DOb4cs6JZdrHtO21CSJzkHN85F1emfKPowXfA=;
        b=nTvI0cTN0FvDn5T2XZArJ46MGWfNan3OWUHB2ycDfp0STBMErkLnHhzptlyk5LbFp+
         nhYlImYW3naCUZHPDIOscHC68sCFpTiqI6YN2FHvmVBFVTIZLmOxPT6Tz+KsTt9YCNQv
         DbeMrSXv6aP9mbkB080jfCqUObrO6Ii88P3yplsf1Sl+EWxM2JWiY5CJhnC9ZgDllVrs
         qFo2cwUXd7aFO8ZmFeqHGcTQWJjj2Z8DIj5lZ2YZwKvcQJjW3j4FrHip4zw8EEao79gI
         smVBy/T+7CV5BW3grUZqSP+ig8kYXUrjHzy2ioJtoEWKsC1mAUqTXD9yN79nJSYMbmRF
         /0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwR0O1DOb4cs6JZdrHtO21CSJzkHN85F1emfKPowXfA=;
        b=tVJm2nawYmQhGqM7XiBpZhFWepN0z7RveGeKOqCzYuF3mAPa+JWEMNi2wE8ViOGD5H
         7/dWdObKgkHs2zTunTfAPs4Aj46VC78tjRnUXjAgJuWfZ7LNPOk4/GDnIfNAwGQ9/O2K
         4Sh22PSJRZmonaVmzwDFeeR2XauvYkZemIvM2OkoRoKl04aJq1/kAK6asT8WYMVN5Siw
         a21g6x7yBZ1i5bycJ1HrIisNOS5e9QPt/VVHXftaxDyI8Ie9TLpCnRFb7LPuXZ+8l944
         ixU6TrxZgPCBJ5F8X7mPLJVmEY+vmMhgQIsszW1OxF38OoH26xXJEJYaFFCA9+HXGekr
         a9wA==
X-Gm-Message-State: APjAAAUaxS/2nCxVhK6l+UplnOdHaWTJouJa48Tb3gpyO2ok3cyy7bcJ
        3gt1P03mEiKKE8ZFZ1yeMKC8J7UlvnMbTC/Fy1dN+w==
X-Google-Smtp-Source: APXvYqwao/Iv3grrGrBBYFJGPnHHheRJdUfAMNPbDhvlz4mrF4IG4QKJ+BCuo9gaMjkSSYEEAEiZ7ZhPjAt/2ZYMcT8=
X-Received: by 2002:a0d:fc84:: with SMTP id m126mr3115578ywf.501.1562353622327;
 Fri, 05 Jul 2019 12:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <495c9f2e-7880-ee9a-5c61-eee598bb24c2@web.de>
In-Reply-To: <495c9f2e-7880-ee9a-5c61-eee598bb24c2@web.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 5 Jul 2019 12:06:51 -0700
Message-ID: <CAMo8BfK_VuL4-xtmY+jYDmrJ-t9a-AyPNCxS7-Db4HzAqpr_BA@mail.gmail.com>
Subject: Re: [PATCH] xtensa: One function call less in bootmem_init()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On Fri, Jul 5, 2019 at 9:43 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jul 2019 18:33:58 +0200
>
> Avoid an extra function call by using a ternary operator instead of
> a conditional statement for a setting selection.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/xtensa/mm/init.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Thanks for the patch. It doesn't change generated code since
PHYS_OFFSET is a build-time constant, but it's a nice cleanup.
Applied to my xtensa tree.

-- 
Thanks.
-- Max
