Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32ED7E8FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 20:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfJ2TRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 15:17:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37742 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2TRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:17:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id 53so10783985otv.4;
        Tue, 29 Oct 2019 12:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XpBCgi1acvYl0k5WNhVR7nXqVxi3RiMKOtGaD33sKEc=;
        b=rjuNEvLfPFPOAbd9TvVxJj4iyxyvZAe9m1g4Wz3NN33XFl7ZURx+Ik8u0I4+7CIUhj
         bt6ItQEczVipbMXqaK9jGTF0oVICf8yc5RkTO6vDgQXHv0CGqnqZcrR2YxJmXABIGjPD
         2xL+X4FLi6BXneeZ9H59sNKbRa3d+nInLIKKtnQd7+Nai9CbQdt43uVxHAPlCKmptEl4
         izCalgKkGwOWQ7kNU2HE0yv7u23JalnpcRUf7KB5xmwP+yL2EQnTU9+LGJgXz+DXTq+l
         54xRpyPB1IrXEzT2amHgBHLAw8FI+TD97nshBDFWxFn2ZbkP2+IPhS0Rswh1RAvRUnKc
         UFig==
X-Gm-Message-State: APjAAAXIqMk1LDcuS0xFrSJP/irzEcJ8nOj0IUxUKJA7xnQJCKPsbBKX
        fUePItiseIJXezNf4RMZYQ==
X-Google-Smtp-Source: APXvYqx/H3E5BHR/NyYmMy7qY+w/1yrITBdBvLYN/pDzX4Yrcd2QcMYM0p1KpSR9OqGRKzKomab6ZQ==
X-Received: by 2002:a9d:6e91:: with SMTP id a17mr5163289otr.31.1572376622117;
        Tue, 29 Oct 2019 12:17:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 38sm498129otr.7.2019.10.29.12.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:16:59 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:16:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     kishon@ti.com, mark.rutland@arm.com, bivvy.bi@rock-chips.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH 2/3] dt-bindings: phy: add yaml binding for
 rockchip,px30-dsi-dphy
Message-ID: <20191029191658.GA9628@bogus>
References: <20191023223851.3030-1-heiko@sntech.de>
 <20191023223851.3030-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023223851.3030-2-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 12:38:50AM +0200, Heiko Stuebner wrote:
> This adds a yaml binding for the external dsi phy found on Rockchip
> socs of the px30, rk3128 and rk3368 variants.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/phy/rockchip,px30-dsi-dphy.yaml  | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
> new file mode 100644
> index 000000000000..c2e1a998a766
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0

(GPL-2.0-only OR BSD-2-Clause) for new bindings.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
