Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD16D834BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfHFPIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 11:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfHFPIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:08:41 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5977A216F4;
        Tue,  6 Aug 2019 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565104120;
        bh=VpWEkU6IuB9MKJEVKTtxrOVk3OpmDNPUntTQRVdPPjI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gBKJg6TxdC+vQExGKn64eE75JBTmBoihbkbw9SdnbrmNUVEnIOjtwjUK1H01EXo6M
         Br04JxfAeakIv0j+fapypAxNhtF6XfDzUUS55gf2LFd0Y+SDq5sfAEzmps22/yacwg
         Wbyy7JOUZwflGgSMqI8oU5Y8AQAKP81GbnpD13z8=
Received: by mail-qk1-f178.google.com with SMTP id r21so63205510qke.2;
        Tue, 06 Aug 2019 08:08:40 -0700 (PDT)
X-Gm-Message-State: APjAAAVuXoJtWCEDH6TCsLFeXMZkbbKWLM1Znie8T6xASqnfX02n3Gfh
        r/rWd6B0RO9HfDffmZ8eg/aYZmu8ZbAFRerXMA==
X-Google-Smtp-Source: APXvYqyQV4wEEmZhSA+j8ENwA9FbtFTNYI7k0yHe988e2uBxbQ2pr9cpCaAhs+c/HhAj3FcSjiAMbKO0gd3bXaJy+Qk=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr3707706qkl.254.1565104119510;
 Tue, 06 Aug 2019 08:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190806124416.15561-1-narmstrong@baylibre.com> <20190806124416.15561-3-narmstrong@baylibre.com>
In-Reply-To: <20190806124416.15561-3-narmstrong@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Aug 2019 09:08:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKS7KeUBhEn1kxT0HZddOZ6oDaZDStUppSdL2vXfAuccg@mail.gmail.com>
Message-ID: <CAL_JsqKS7KeUBhEn1kxT0HZddOZ6oDaZDStUppSdL2vXfAuccg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: amlogic,meson-vpu: convert
 to yaml
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 6:44 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic Display Controller over to YAML schemas.
>
> The original example has a leftover "dmc" memory cell, that has been
> removed in the yaml rewrite.
>
> The port connection table has been dropped in favor of a description
> of each port.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/display/amlogic,meson-vpu.txt    | 121 ---------------
>  .../bindings/display/amlogic,meson-vpu.yaml   | 138 ++++++++++++++++++
>  2 files changed, 138 insertions(+), 121 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
>  create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml

> +  power-domains:
> +    description: phandle to the associated power domain
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle

You missed this one.
