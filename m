Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157FFE4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 16:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfD2Omx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 10:42:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41064 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2Omx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:42:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id t30so8084353lfd.8;
        Mon, 29 Apr 2019 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+FUhoAG0fL/FjGxEsCS+PUjM/aNhQ8xffw+Uis7okk=;
        b=OqnjRWjIkIWfMSl6TLYqvoVGZTIodXRpmxOG3jqpcZYB+Aye6qqATR+S2FNwFmeKK1
         I9V3FDjAszSWtSa4QcMB2Ap8X+n3Vm7OlaWVJQ8bt5niHkBrR0xjl43mRdLm+DTaeS9T
         pk+x5W2VjsALPWa3UjxR4Zq9qFrC8Wtrn9vmwd0owFjp+cYL+q51ntFWN4Dyane918Jx
         hXJVMgnqfTxhUZrb+COweBf8/dn4oyP3Ke+q+qFsgy3fpVWB/7LUDCPciCCNgBuT9cju
         9TMNbBpNXWed6EX8rC7wGevRFU67enf5yAwNZHqkqNTrwEbk6ZAktksFyBmVLtPjuc/X
         kBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+FUhoAG0fL/FjGxEsCS+PUjM/aNhQ8xffw+Uis7okk=;
        b=DbL/AKllJFZoNbSNA4RbjCGtFp4c6xjxG7oJR4mt9bYTYKL5MJzGbacvdz7Qo/FL3v
         aWBVqzwRpoVBSDjDVpTRWwQfBfQIXtnQtmSjmJxXHVrGIF/qHhQ5mpgUqp1R6c1ChioZ
         6cFzUdxYRgwCKnNatz8nHrYpbDnprcZ++B4mURnk0oQOYuJQEEk+7xfOP993us4KEJZE
         VzVaBCXd+7UbSCYOxA0lhj/1SU3UJrAPpAWbo9QDYtBunAIh9IwQEWqdNKEpcvhTEUqj
         O4iGUiCPHabMB7rT4BpWVkz2WTu03ctCtV2YEpm2TT1XwLyDlwXpOMnhxhEUv6swMQcm
         vY9w==
X-Gm-Message-State: APjAAAUlO/8Ml/ATm/3GHenFspQLFfSQtdGRUM4mbJ8Ek4+TERbMfl6G
        Fibhutr0QSVQRIpT36mhwPU=
X-Google-Smtp-Source: APXvYqzyknSkge7EA+KXTt5slr4ggcDQid3eyM3jg8HEnwSHC6GOo2KwrkuoDuhiJTUvNFhhsfK2FA==
X-Received: by 2002:a19:384d:: with SMTP id d13mr13068296lfj.38.1556548971256;
        Mon, 29 Apr 2019 07:42:51 -0700 (PDT)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:605a:8802:3f56:a345])
        by smtp.gmail.com with ESMTPSA id l79sm7371044lfe.92.2019.04.29.07.42.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Apr 2019 07:42:49 -0700 (PDT)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kyungmin.park@samsung.com, bbrezillon@kernel.org, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] mtd: onenand/samsung: Add device tree support
Date:   Mon, 29 Apr 2019 16:42:47 +0200
Message-ID: <1813629.D8pu8sOiIg@acerlaptop>
In-Reply-To: <20190429101928.265998b5@xps13>
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com> <20190429101928.265998b5@xps13>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On poniedzia=C5=82ek, 29 kwietnia 2019 10:19:28 CEST Miquel Raynal wrote:
> Hi Pawe=C5=82,
>=20
> Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote on Fri, 26 Apr 2=
019
> 18:42:19 +0200:
>=20
> > This patchset adds device tree support to Samsung OneNAND driver.
> > It was tested on Samsung Galaxy S and Samsung Galaxy S Fascinate 4G,
> > an Samsung S5PV210 based mobile phones.
> >=20
> > Tomasz Figa (5):
> >   mtd: onenand/samsung: Unify resource order for controller variants
> >   mtd: onenand/samsung: Make sure that bus clock is enabled
> >   mtd: onenand/samsung: Add device tree support
> >   dt-binding: mtd: onenand/samsung: Add device tree support
> >   mtd: onenand/samsung: Set name field of mtd_info struct
> >=20
> >  .../bindings/mtd/samsung-onenand.txt          | 46 +++++++++
> >  drivers/mtd/nand/onenand/samsung.c            | 94 +++++++++++++------
> >  2 files changed, 113 insertions(+), 27 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/samsung-onena=
nd.txt
> >=20
>=20
> I think you should use "mtd: onenand: samsung:" as prefix.
>=20
> Thanks,
> Miqu=C3=A8l
>=20
Hi Miqu=C3=A8l

I'll fix all issues and send new version of patchset.
Thanks for review and comments



