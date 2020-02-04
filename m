Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB561513AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 01:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgBDAhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 19:37:20 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51456 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgBDAhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 19:37:20 -0500
Received: by mail-pj1-f65.google.com with SMTP id fa20so553307pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 16:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:subject:cc:user-agent:date;
        bh=5xp67ajba0eEYfuQWFHz2Q1LL+I8M21VgbW1mPqOZiM=;
        b=PWYQGV03wKCsNXbzuSHLA8kf8THah3SW1Vmi1VohM14Ijyz7Nh9d9gjY1WpJ817EMC
         MT4hMGre6d7iVp7ly2gGA1AKQgzRMsQFQUmpJV0iqABRgroFjgAWSBs6VP52gHqrRJXw
         Ir4f73Jg9Nj1w8VXA8eg+VTxb+nWegKWN0hFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:subject:cc
         :user-agent:date;
        bh=5xp67ajba0eEYfuQWFHz2Q1LL+I8M21VgbW1mPqOZiM=;
        b=cQ7UdTlNRGlbr//EADcXBkXx0luvgg+DDiyWPpZPIz3ald/+kKXdqsFfJLLYDtpfNj
         sJ4gFVVGoqTyFepkdwdEOxYkNxWB5J+9bfq+987r16ekeVDGrpXXTwzQs7f71lQFRb5/
         b5BBIXLnes02kbwTlGhX9eLHUO38qy9+5kYSnjfBj9Z7tD3n+UXPBTU135YVFg8u1ZJK
         dTWgPK8sfHwdmCE+Tv6R2p+lJlnZDOXWsTL1oREzXbMUbUoA08jvpbaeKjLk35P/FidQ
         +AUg21OzvXMEFbBHTTOhMu56Dy5jSpIOVLaa+b4dkkNDYUMF6FlzjvD0uShzCFH5a6sT
         kDGA==
X-Gm-Message-State: APjAAAXuDz4mZwIl9aTVhFy4uuY1NrTMQvf6IO97C+gb+NhvNrjiyODV
        VYfRWmNfQI++NWHii9qSbbQI0g==
X-Google-Smtp-Source: APXvYqyk8G1DkyHXQEPuiXrNHcLN5PgZGWYKE6wajbWdR4DdrJbTMCe2Ur8jIXXG1eqg5oY9kUCR7w==
X-Received: by 2002:a17:902:462:: with SMTP id 89mr26639753ple.270.1580776637895;
        Mon, 03 Feb 2020 16:37:17 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x143sm21884895pgx.54.2020.02.03.16.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 16:37:17 -0800 (PST)
Message-ID: <5e38bcbd.1c69fb81.a383.c572@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <007dfd87-5170-684a-26dc-9e7533d42034@infineon.com>
References: <20190920183240.181420-1-swboyd@chromium.org> <20190920183240.181420-5-swboyd@chromium.org> <007dfd87-5170-684a-26dc-9e7533d42034@infineon.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v7 4/6] tpm: tpm_tis_spi: Support cr50 devices
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
User-Agent: alot/0.8.1
Date:   Mon, 03 Feb 2020 16:37:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexander Steffen (2020-02-03 01:13:29)
> On 20.09.2019 20:32, Stephen Boyd wrote:
> > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > index a01c4cab902a..c96439f11c85 100644
> > --- a/drivers/char/tpm/Makefile
> > +++ b/drivers/char/tpm/Makefile
> > @@ -21,7 +21,9 @@ tpm-$(CONFIG_EFI) +=3D eventlog/efi.o
> >   tpm-$(CONFIG_OF) +=3D eventlog/of.o
> >   obj-$(CONFIG_TCG_TIS_CORE) +=3D tpm_tis_core.o
> >   obj-$(CONFIG_TCG_TIS) +=3D tpm_tis.o
> > -obj-$(CONFIG_TCG_TIS_SPI) +=3D tpm_tis_spi.o
> > +obj-$(CONFIG_TCG_TIS_SPI) +=3D tpm_tis_spi_mod.o
> > +tpm_tis_spi_mod-y :=3D tpm_tis_spi.o
> > +tpm_tis_spi_mod-$(CONFIG_TCG_TIS_SPI_CR50) +=3D tpm_tis_spi_cr50.o
> >   obj-$(CONFIG_TCG_TIS_I2C_ATMEL) +=3D tpm_i2c_atmel.o
> >   obj-$(CONFIG_TCG_TIS_I2C_INFINEON) +=3D tpm_i2c_infineon.o
> >   obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) +=3D tpm_i2c_nuvoton.o
>=20
> This renames the driver module from tpm_tis_spi to tpm_tis_spi_mod, was=20
> this done intentionally? When trying to upgrade the kernel, this just=20
> broke my test system, since all scripts expect to be able to load=20
> tpm_tis_spi, which does not exist anymore with that change.
>=20

I mentioned this during the review of this patch set. I thought nobody
would care, given that it's just a module name.

Can your scripts load the module based on something besides the module
name? Perhaps by using device attributes instead?

