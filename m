Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683C8E5579
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 22:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfJYUwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 16:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJYUwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:52:32 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FF9F21D7F;
        Fri, 25 Oct 2019 20:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572036751;
        bh=ORFhXAsCQweMyIE5fdnoRCbGtyZgtGzZu0oJWpRtLEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zKhAr6iNnKxRR/OmHBwiVBHmMVqC2w3IDMpMyuLTzBntt41I4IEmwx7XdBVyCmlbC
         sivlIhCM88ecHVAD6G5rMcOVtNc7FNH/2TJnfGsp8C3xX5semVb8HDNqCKBN4ZPjdO
         lS+G9ZhgAkXpyHUoAmWJw+8Kb1Uu02GfX64m/JGU=
Received: by mail-qt1-f169.google.com with SMTP id g50so5317466qtb.4;
        Fri, 25 Oct 2019 13:52:31 -0700 (PDT)
X-Gm-Message-State: APjAAAWIIXHYm+nCdcSo2lqXzo4ozIXbNWBp/PZ8CBaM6atae8VCgk1h
        AIqv5Wt9kBeAy930bg5YjfK8JHHGR7whWXE3sA==
X-Google-Smtp-Source: APXvYqxsld9ImE31xEIRyd/SNyuF7ml49eI3ypfs2k0j66vMlw4KSS63PN5eOAFHsHZIQ0enGsLdpRKYXUAsMTLF2Do=
X-Received: by 2002:ac8:741a:: with SMTP id p26mr5205325qtq.143.1572036750395;
 Fri, 25 Oct 2019 13:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191020040817.16882-1-afaerber@suse.de> <20191020040817.16882-6-afaerber@suse.de>
In-Reply-To: <20191020040817.16882-6-afaerber@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 25 Oct 2019 15:52:19 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+OhiZZ4Ei3wg4s-1z+WsqQSvvRMNrK37Yq+1XR3-3_uA@mail.gmail.com>
Message-ID: <CAL_Jsq+OhiZZ4Ei3wg4s-1z+WsqQSvvRMNrK37Yq+1XR3-3_uA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] arm64: dts: realtek: Change dual-license from MIT
 to BSD
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 11:08 PM Andreas F=C3=A4rber <afaerber@suse.de> wro=
te:
>
> Move the SPDX-License-Identifier to the top line and update to SPDX 2.0.
> While at it, switch from GPLv2+/MIT to GPLv2+/BSD2c before adding more.
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
>  v2: New
>
>  arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts | 3 +--
>  arch/arm64/boot/dts/realtek/rtd1295.dtsi          | 3 +--
>  arch/arm64/boot/dts/realtek/rtd129x.dtsi          | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

It's really only schema files that I'm pushing towards BSD2C. Maybe in
hindsight we should have done MIT as that's more common in the dts
files.

Rob
