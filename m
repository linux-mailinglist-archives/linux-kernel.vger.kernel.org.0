Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6463B718D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 04:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfISCVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 22:21:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34865 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfISCVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:21:05 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so4108700iop.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 19:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=28FR0iGdSsSntn0HXavBQASb15ncS9YhNIEPya+d/ZY=;
        b=QMhAwatWpTgV9Q79tPLRXDuYsGcn7T+ASU2X96tHXWftVa4ngLSP3VwpX7kdaEak5Y
         o0a+QXENkjEiRbXSYPCxyyqke/sSSWDHGKpQONvEvFS+7EGAjQbcybOqlenxKw9OZIpA
         zj70GUGkis+eScMnC4lXEsqefD3cvJ089cH9uIhos23Zfz8mDK8fA1gxOzuHRRASfbIm
         380J4A4iXCdKSNXlajDRMZYPdlVh+jeT8k+NWfP2ZMHwijhtXn6fFwAf6IymDDx9PiZU
         R2vM7p2e9lPGqbyg7rNLqGCdhZAGYIuansGpJwi1I6QriPhQATOKevAnZifIJWidGn5S
         vOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=28FR0iGdSsSntn0HXavBQASb15ncS9YhNIEPya+d/ZY=;
        b=Y+9X9kFb3sLfScrxeN7i4K9Qww/qfh1Fnsx5admfSGU4lTJKOoKerYCE80w8Yxsmoo
         teUUhkqz7/mZdt91PPWyFkQmt89pBtv6hKC5VGICx2qRwtBHPtswMTV1+NjeHoOF6Huq
         YfH7lT1iT4ff3ddyU3uRpUEfRHd9kK/xzTiv2aQIrUPtlWEkDHE73peTcT/m+TU3ABnP
         R0sU+0DLq8FsslA58Ph/Xf0aBHpw8XvRyB+VFV+bvXW8IRX3On9EkLsCCewxAE9rvN06
         j1Qr5DlhJcolHkDLg7JhfzdUVGWHJvVn26bgvfIiIdv4aj4f3WtUxlRwfmoxrEbyXFsy
         XNSQ==
X-Gm-Message-State: APjAAAUQ+me+63xkxZ203bF5iu0NDubVqoO2mJK9/AmupL7Cbq/jtmiX
        IlB1nqkc/iMAMC4CqCHwRany+ljgoPhJlb475aI=
X-Google-Smtp-Source: APXvYqzIjt/mvoTyN72tqDx3aUGKSUk8fTRKQjQr0hxKDeo1qLTcozizxASVMl1qI0/O8Y1KmhrvWRsYiQhLHkw6u+M=
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr4459674iod.261.1568859664907;
 Wed, 18 Sep 2019 19:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <1568801744-21380-1-git-send-email-gene.chen.richtek@gmail.com> <20190918105121.GB5016@dell>
In-Reply-To: <20190918105121.GB5016@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 19 Sep 2019 10:20:53 +0800
Message-ID: <CAE+NS37XG+kfbj6yJrL5A-d2O_aiRU90yV5TUk3Kfa0Rv7dWmw@mail.gmail.com>
Subject: Re: [PATCH] mfd: mt6360: add pmic mt6360 driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2019=E5=B9=B49=E6=9C=8818=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 18 Sep 2019, Gene Chen wrote:
>
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add mfd driver for mt6360 pmic chip include
> > Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com
> > ---
>
> This looks different from the one you sent before, but I don't see a
> version bump or any changelog in this space.  Please re-submit with
> the differences noted.
>

the change is
1. add missing include file
2. modify commit message

this patch is regarded as version 1

> >  drivers/mfd/Kconfig                |  12 +
> >  drivers/mfd/Makefile               |   1 +
> >  drivers/mfd/mt6360-core.c          | 463 +++++++++++++++++++++++++++++=
++++++++
> >  include/linux/mfd/mt6360-private.h | 279 ++++++++++++++++++++++
> >  include/linux/mfd/mt6360.h         |  33 +++
> >  5 files changed, 788 insertions(+)
> >  create mode 100644 drivers/mfd/mt6360-core.c
> >  create mode 100644 include/linux/mfd/mt6360-private.h
> >  create mode 100644 include/linux/mfd/mt6360.h
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
