Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0F8C38E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 23:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfHMVW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 17:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfHMVW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:22:29 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA2E20844;
        Tue, 13 Aug 2019 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565731348;
        bh=61BEBiism8+ah6KfYnPIAoueUmImP8BoQp3cWp1WYxw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QO927A/DHs15dKgl0uKA8E/PQY35yt2Fo1OFYfRmf998P122pPT5lvN4KSBMGd4sM
         XEaopRMIrtZESspUSyXgCBciNM/mvRbOqVtaLvj030AuZRit3cEVm7YYH6AGG3pYMK
         Ri24fFbSGjzGbbGIUswMvcQNC80RaWVAunXzAklM=
Received: by mail-qt1-f178.google.com with SMTP id 44so76852554qtg.11;
        Tue, 13 Aug 2019 14:22:28 -0700 (PDT)
X-Gm-Message-State: APjAAAXV46AhZD6lAPNH1c4lzajlB9Y7AbZAH7+MSCU1uyD8tXKGvN1V
        c6P6A4r/BQ6uE4TtozEkgxgOY923/VrObRkJDQ==
X-Google-Smtp-Source: APXvYqxSBfgtU0Qq0DmuHIKF4215omaq3x32du27czWIrPeuK1YLiDC7YDd/MNctQx5C2gGeVR82JMJ4pAiB4fPkMXY=
X-Received: by 2002:ac8:7593:: with SMTP id s19mr27846131qtq.136.1565731347578;
 Tue, 13 Aug 2019 14:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190813125147.29605-1-dafna.hirschfeld@collabora.com> <20190813125147.29605-2-dafna.hirschfeld@collabora.com>
In-Reply-To: <20190813125147.29605-2-dafna.hirschfeld@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Aug 2019 15:22:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJxQu1CYG3ZTFDME13cUwWgCt7hkQg41bdJKvY27JcCZQ@mail.gmail.com>
Message-ID: <CAL_JsqJxQu1CYG3ZTFDME13cUwWgCt7hkQg41bdJKvY27JcCZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: imx: add imx8mq nitrogen support
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 6:51 AM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> From: Gary Bisson <gary.bisson@boundarydevices.com>
>
> The Nitrogen8M is an ARM based single board computer (SBC)
> designed to leverage the full capabilities of NXP=E2=80=99s i.MX8M
> Quad processor.
>
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> [Dafna: porting vendor's code to mainline]
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
