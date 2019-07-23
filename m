Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2F071ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 16:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbfGWOwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 10:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbfGWOwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:52:53 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 536C7227CC;
        Tue, 23 Jul 2019 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563893572;
        bh=mxAyG2JWokyVjQwpLu0BobuO2nOu71LIAdILH2OdHK0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SsT/GmA7WLxu60XFYod8t1s+fvkmxf73mvaoLNNxbiTOvhxPnPw/1IkqXSXvvxKQl
         ZCROOwBxWxMqCKY2Q4lqljcMP0vZMuhMJX9L2lBqGVf6amVNzvsTt0LN1G4fFEGCFi
         GUR4fiX5KQgNIpL+X3wCr+/3XOzhM7SxTu7asOV8=
Received: by mail-qk1-f171.google.com with SMTP id r6so31364320qkc.0;
        Tue, 23 Jul 2019 07:52:52 -0700 (PDT)
X-Gm-Message-State: APjAAAXJA1qTN0YpeC8Xa5ifzu8Li/EwsXSOiw1dsy5ca33e+opoQ+7E
        QrHav89cPZfMtSXUHd6jyeTAdchyPZYKxKFBbA==
X-Google-Smtp-Source: APXvYqwZiOcoe1s7qhiFAJYivK+N5IPJMZGWxi+ThTt1Kn4ty2xNdEW6gS2kpNUOpRp3jkH0X+VUlMMwP04mvYWysaQ=
X-Received: by 2002:a37:6944:: with SMTP id e65mr46744250qkc.119.1563893571463;
 Tue, 23 Jul 2019 07:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190723002052.2878847-1-vijaykhemka@fb.com> <CAL_Jsq+uAjK6+xzkyOhcH96tZuqv7i6Nz5_nhUQkZ2adt2gutA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+uAjK6+xzkyOhcH96tZuqv7i6Nz5_nhUQkZ2adt2gutA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 23 Jul 2019 08:52:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Kw0TFW_v54Y2QHcChqpNDYhFyCSO5Cj-be9yLSCq-Pw@mail.gmail.com>
Message-ID: <CAL_Jsq+Kw0TFW_v54Y2QHcChqpNDYhFyCSO5Cj-be9yLSCq-Pw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add pxe1610 as a trivial device
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <trivial@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Patrick Venture <venture@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jeremy Gebben <jgebben@sweptlaser.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        sdasari@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 8:50 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jul 22, 2019 at 6:46 PM Vijay Khemka <vijaykhemka@fb.com> wrote:
> >
> > The pxe1610 is a voltage regulator from Infineon. It also supports
> > other VRs pxe1110 and pxm1310 from Infineon.

What happened to the other compatibles? S/w doesn't need to know the
differences?

> >
> > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index 2e742d399e87..1be648828a31 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -99,6 +99,8 @@ properties:
> >              # Infineon IR38064 Voltage Regulator
> >            - infineon,ir38064
> >              # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
> > +          - infineon,pxe1610
> > +            # Infineon PXE1610, PXE1110 and PXM1310 Voltage Regulators
>
> The comment goes above the entry.
>
> >            - infineon,slb9635tt
> >              # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
> >            - infineon,slb9645tt
> > --
> > 2.17.1
> >
