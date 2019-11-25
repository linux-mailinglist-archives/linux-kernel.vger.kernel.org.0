Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3810868F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 03:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKYCpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Nov 2019 21:45:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfKYCpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 21:45:49 -0500
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 173AC20748
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 02:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574649949;
        bh=rRksThIk3ANMx0k3KKiqT1coowGHHsm3yp6vHSO/yJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OaV4TRIHyzlBynR9Odd2LazsvhxtgKgqcmg3sGJSaNVbTMVFUYZdIfZf2LTtX0Mx1
         CAK/p4/4sM7e58ITMAq+Iw9KK01SDr0qXBw2dpKUj++9Shy1PzlbNtH5znT7CAUrFi
         25mQVm+hZljRpj5y3LVO0lnt0qSa+RaztDefU2os=
Received: by mail-lf1-f42.google.com with SMTP id 203so9694928lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 18:45:49 -0800 (PST)
X-Gm-Message-State: APjAAAXddb2MK4TmToTBuzz15goYiR7Qa6G4o8okVdjAg1m5aMGZ1HSH
        rYl3mVuahQMo5xlz7I6p4v00Sn3wkajqAMJlEr0=
X-Google-Smtp-Source: APXvYqzebOUmdYdPzb72IJa+IGOWUcBhHCWcr75z1vCyIu5oO1Yvgn7kdusnuRFHuVlapdjfV/P1A0LFVthYvYj8z2w=
X-Received: by 2002:ac2:51b5:: with SMTP id f21mr18634983lfk.159.1574649947280;
 Sun, 24 Nov 2019 18:45:47 -0800 (PST)
MIME-Version: 1.0
References: <1574306457-6251-1-git-send-email-krzk@kernel.org> <alpine.DEB.2.21.9999.1911221853330.14532@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1911221853330.14532@viisi.sifive.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 25 Nov 2019 10:45:35 +0800
X-Gmail-Original-Message-ID: <CAJKOXPdHgXwt-E-DaKQdeD_jSkhYP5n2NWCZcSWr7Ny-cYxZKQ@mail.gmail.com>
Message-ID: <CAJKOXPdHgXwt-E-DaKQdeD_jSkhYP5n2NWCZcSWr7Ny-cYxZKQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Fix Kconfig indentation
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2019 at 10:54, Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Thu, 21 Nov 2019, Krzysztof Kozlowski wrote:
>
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> >       $ sed -e 's/^        /\t/' -i */Kconfig
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Thanks, queued with Palmer's Reviewed-by: (which I believe would apply
> equally to this version)

Thanks, I forgot to add it.

Best regards,
Krzysztof
