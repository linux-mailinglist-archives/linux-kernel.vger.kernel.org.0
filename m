Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5659E7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 14:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfH0MUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 08:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfH0MUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:20:35 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7816206BF;
        Tue, 27 Aug 2019 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566908434;
        bh=10BPMi7ogBKEVUWUCp+OlUh6tWIYmElWTtO/pbCLCfE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hiSjrNzN9O29H/jZozkaXJ1RY7B2iPUnmPqzXqXAfbEHqvCNs2qwYPYjz+fe0bIVP
         3OWIUxGwCDw0ICc9roj00pPsDU+tYy6PMcG/TCSw0YwM5ErWb8psm8Fm/gJJGcB7wT
         Gdyvjxn2TXOQ9wvf0rvh4w1k9UfLYSxEan4/ebTw=
Received: by mail-qt1-f176.google.com with SMTP id q64so9348813qtd.5;
        Tue, 27 Aug 2019 05:20:33 -0700 (PDT)
X-Gm-Message-State: APjAAAXzNhZ+egjyhcIPGnxugc26lJPigKtAR8jh6r9xYli+sf86xObF
        5Rsx9eMA9EiXMdbzNfqEUK8f8qMr+nFyvoQexQ==
X-Google-Smtp-Source: APXvYqwMqxGiTa7rYYydtko9BqUul5ihk660b1Rd0cPJHim/fp9+Uq5BxXYH75v80lYawW9Ve2rEL384NDhcnbTwKFM=
X-Received: by 2002:a05:6214:10e1:: with SMTP id q1mr19735401qvt.148.1566908433096;
 Tue, 27 Aug 2019 05:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org> <20190822233759.12663-4-srinivas.kandagatla@linaro.org>
In-Reply-To: <20190822233759.12663-4-srinivas.kandagatla@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Aug 2019 07:20:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLjgOy3TKrpuNYYkRxy-Ln+3FOoKVE9KweS0ycTxriWMQ@mail.gmail.com>
Message-ID: <CAL_JsqLjgOy3TKrpuNYYkRxy-Ln+3FOoKVE9KweS0ycTxriWMQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 3/4] dt-bindings: ASoC: Add WSA881x bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 6:38 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
> Amplifier. This Amplifier also has a simple thermal sensor for
> over temperature and speaker protection.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wsa881x.yaml          | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
> new file mode 100644
> index 000000000000..ad718d75c660
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,wsa881x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +allOf:
> +  - $ref: "soundwire-controller.yaml#"

This is not the controller, so this should not be included here. You
should get lots of warnings from doing so. You did run 'make
dt_binding_check', right?

> +
> +properties:
> +  compatible:
> +    const: sdw10217201000
> +
> +  reg:
> +    maxItems: 1
> +
> +  pd-gpios:

powerdown-gpios is the standard name.

> +    description: GPIO spec for Powerdown/Shutdown line to use
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - pd-gpios
> +  - #thermal-sensor-cells
> +
> +examples:
> +  - |
> +    efuse@1c23800 {
> +        compatible = "allwinner,sun4i-a10-sid";

Huh?

> +        reg = <0x01c23800 0x10>;
> +        pd-gpios = <&wcdpinctrl 2 0>;
> +        #thermal-sensor-cells = <0>;
> +    };
> +
> +...
> --
> 2.21.0
>
