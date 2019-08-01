Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F030A7D623
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 09:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfHAHOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 03:14:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40508 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHAHOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:14:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so72328869wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 00:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZtpEMYtf9IHdV3/wzdyegV2uPdXRwuCeceSmuY7Qe2Q=;
        b=kGxY5Un9HMbrQVikYl7BdRGEJNk5seUr9xeLQkOJDxIPzBL8ZCOo5hZEehQdRAPkM2
         OYSdq91UyJHcAXWkOS3fXNHZxPyQnrxo+Ulaf61evzNTscYjfi+7Cbehk+1E8m71/6mC
         U13xfhTyg6+jd90DZaFh0A0KMY2LjWgUkLkn+OkzulwZD2J+oyygxJdv3WJPQVymFs3U
         sYVSGFPXXiMGIgm0d6zF2kJtYo8sbLMA2okHxV9UWYZgZwDcwaR4342v7sjwNc+enXO9
         chXU8y7gejR3HdyXdtx+tSVGh00n063k6lp/OlfmcsCP+Uo4pszNnccKOwxJod40odcD
         BYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZtpEMYtf9IHdV3/wzdyegV2uPdXRwuCeceSmuY7Qe2Q=;
        b=cmlnX0bqJXLnyV5f05wq4XLLenvFdGC7gfn1nH00NaVgiPD3tR0ooj8ywDoO2jKU2O
         rzRKzheVD208Ej8BzCOJHP35BN9Z2zZr3LseYKgyiWawWok5YE31R/+Qj87Xr3QBBmWv
         x4CEWQrCt1EwOYRZz484vk/qQy7JpmdRyzxfEjxZhqaMghlTcILO0Is6C5Dvv7Y87fGu
         KfeHNXbndVniq6zrfOqx8P+4IQ9sCOUM/1VXlGvkb9If0hkIjcANHcKjCEZtNVxw3754
         f7L7rB8v4S3ike0Vwh3AsiHcAFP/+OOQNE9kZhrvkjBsu7B5zRsgbkEwVX2KRbP1hksI
         jXjw==
X-Gm-Message-State: APjAAAUQkEF0kgQhZKzkMu3PxflxDQg8r9ZDGQ6O1XtaajufJukHB6j9
        O6nFtlTwpXL3sDT0LNwHzEJVOHh9ETKerT3BamOkFA==
X-Google-Smtp-Source: APXvYqz2wqSKzTJIvgWm78hO385N0YvtpdJKQHPyq2WJg3IG6jUfYtbKcjYdcOtacK8hJh3nvmsajE/Vpys+rxreSuE=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr1158635wrs.93.1564643652032;
 Thu, 01 Aug 2019 00:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <1564578355-9639-1-git-send-email-iuliana.prodan@nxp.com> <VI1PR0402MB348576458A879D8F162D01C098DF0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB348576458A879D8F162D01C098DF0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 1 Aug 2019 10:14:00 +0300
Message-ID: <CAKv+Gu9LTy4Qpo8hDdjuv62NiecMHDuUu5H19WoCqY+UupeBRw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] crypto: validate inputs for gcm and aes
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 at 16:35, Horia Geanta <horia.geanta@nxp.com> wrote:
>
> On 7/31/2019 4:06 PM, Iuliana Prodan wrote:
> > Added inline helper functions to check authsize and assoclen for
> > gcm, rfc4106 and rfc4543.
> > Added, also, inline helper function to check key length for AES algorit=
hms.
> > These are used in the generic implementation of gcm/rfc4106/rfc4543
> > and aes.
> >
> For the series:
> Reviewed-by: Horia Geant=C4=83 <horia.geanta@nxp.com>
>

Likewise,

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
