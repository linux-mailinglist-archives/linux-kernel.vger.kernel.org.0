Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7CABD21F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 20:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395459AbfIXSxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 14:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfIXSxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:53:41 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB54E214DA;
        Tue, 24 Sep 2019 18:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569351221;
        bh=HMiXmV2aUG4Tvw658BNY0FPEirpb/JTORRKcPcXKIZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=onjfFMrxzG2cEGnNFTjw8WdtVtC9c5fpOcii/eR04dtD+9f6tfWPbW6lYqo5hSuhf
         mYvoTzOPP/UtJZAgC2NnIzEmbkM7s9knHn+ZWJ5HNX7fL/a4rqc+Tn5fS+uR1SlmPQ
         BbI0yUrSbxlSy/wblyCrr0D9OKC5HurWaLvozdwE=
Received: by mail-qt1-f174.google.com with SMTP id r5so3458714qtd.0;
        Tue, 24 Sep 2019 11:53:40 -0700 (PDT)
X-Gm-Message-State: APjAAAUpmYS6Li5lzNQSETScYnmCj+5HMtuY6v3w95Lb1ioN4WkmR6TX
        30tqMj3qOrTRoLm2b4MOnofE8/X2ZgJrshyQag==
X-Google-Smtp-Source: APXvYqyJbcKGU/WuI+VqqQqNQyegr27nfbYT7yNSKP+o30RTEmhgidLW2fbwPtWzi4ErOmeKpHZ8UG6w5pH23aMZ87s=
X-Received: by 2002:a0c:fa49:: with SMTP id k9mr3911313qvo.72.1569351220051;
 Tue, 24 Sep 2019 11:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com> <1569248002-2485-5-git-send-email-laurentiu.palcu@nxp.com>
In-Reply-To: <1569248002-2485-5-git-send-email-laurentiu.palcu@nxp.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Sep 2019 13:53:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK1egTpkqsgVUMUiYzKvVJ=nWtJu+OeujJotRCD9ADsnw@mail.gmail.com>
Message-ID: <CAL_JsqK1egTpkqsgVUMUiYzKvVJ=nWtJu+OeujJotRCD9ADsnw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: display: imx: add bindings for DCSS
To:     Laurentiu Palcu <laurentiu.palcu@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 9:14 AM Laurentiu Palcu <laurentiu.palcu@nxp.com> wrote:
>
> Add bindings for iMX8MQ Display Controller Subsystem.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> ---
>  .../bindings/display/imx/nxp,imx8mq-dcss.yaml      | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml

Fails to build with 'make dt_binding_check':

https://patchwork.ozlabs.org/patch/1166073/
