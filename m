Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2EFE6712
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 22:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbfJ0VRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 17:17:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43721 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbfJ0VRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:17:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id s5so4739397oie.10;
        Sun, 27 Oct 2019 14:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/iAJCHmYnu3MN/tSfMGe/nzIlm9sUPVCioEd8t0MfbY=;
        b=MbgsLCzQdzZ04vpnJakUlV16vgeyRw+UDCUKcRBeGoobsEBCQa0MnCF8L2nGZ+4xbL
         MtISKGN3IvNPKTnhak0Tv3iUPt9NGUB6ePldoZvOlB7IzbgVa9F3K4RP1Vff8EoZMQGk
         Bznwg5DSLi2OigPQOqvbIblLI7DsswyVfqhSxiYN/Vg/bXu8L3g1TrKeWgpNYoQeNlj6
         FJcZIYcA6vrpd9aX5tzXqCmF29cdRQoppoqiqUjGqCFlP2c3HkTdldgYM4bDuZSKXoGZ
         AWt0OB7rxEKIDOeC9DjAsZFHXPMAgKZDfl2MaebqhNhci69qkWvjcb+/BycBmB2Lx5ql
         Ml8Q==
X-Gm-Message-State: APjAAAWXoi+FwyGL5UTM7ooQhJn0VLgoRKtCVKnGtaT/x8Ot+S2AH+uX
        jndYDqZHJLiG1FRggm+ITw==
X-Google-Smtp-Source: APXvYqycENxBcO37SRF80CuuH2sAsSU8zEeqdg41f6o3Mskd1ZymMfnokYbEy29NcBFqqvPqzaY4dQ==
X-Received: by 2002:a54:4484:: with SMTP id v4mr7404163oiv.49.1572211058758;
        Sun, 27 Oct 2019 14:17:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm2960776otg.56.2019.10.27.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 14:17:37 -0700 (PDT)
Date:   Sun, 27 Oct 2019 16:17:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v11 2/7] dt-bindings: sun6i-dsi: Add A64 DPHY compatible
 (w/ A31 fallback)
Message-ID: <20191027211737.GA30896@bogus>
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
 <20191025175625.8011-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025175625.8011-3-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 23:26:20 +0530, Jagan Teki wrote:
> The MIPI DSI PHY controller on Allwinner A64 is similar
> on the one on A31.
> 
> Add A64 compatible and append A31 compatible as fallback.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml         | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
