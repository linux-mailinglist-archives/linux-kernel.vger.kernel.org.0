Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF01A12565B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 23:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLRWPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 17:15:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35020 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRWPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:15:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id f71so4386529otf.2;
        Wed, 18 Dec 2019 14:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E8QNYLhSSLLibIm1kZjDoiOQpQC1DNZLoqpFwXuZW3A=;
        b=FTviATobmXf4EtyhQKPxjN1tMMWN28qLln4we3aNOWflqBINEsljAbjdwEqSappXyW
         QXMHyfX/IEGI+tjgacNE1nVqjE2LT6GdUMvsDzVEZlvj0013R4Vh4278Bj8TLIAgJ3AF
         vKqfcMAHSj/KHUXFjmsZcU0P2Moqhp6eu5o6s0lbbnw4CVKk91JR7J4DFcUjzppcYMkd
         Rtf8MQphpN3e1fCJ1O66G0RopFVv+43MQR5aeCSQfGdhSjcFZVHpy4dxWYaqR+chfuov
         V9y5Pp3a88+HbK9Iy25yawIE7zTbalJuQw1E2fmK7b7X0IRCdgMj59Pghau7ufQNrzb4
         zs4w==
X-Gm-Message-State: APjAAAX5l+Oau+0EmkID3FykVtW+Zo1tde/LMj5hDVjoPiyhZyXaFRpQ
        km6h14ShCHuLwN4nomOSow==
X-Google-Smtp-Source: APXvYqxbsuqp+Q5pltR9/cjYWkBjYlpqcAOa2oySxbaVfYzkDPTaEZs731kr8mefYacuVUAq7T78Yg==
X-Received: by 2002:a9d:6396:: with SMTP id w22mr5120271otk.364.1576707338086;
        Wed, 18 Dec 2019 14:15:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w8sm1270084ote.80.2019.12.18.14.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:15:37 -0800 (PST)
Date:   Wed, 18 Dec 2019 16:15:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: rockchip: Add Rock Pi N10
 binding
Message-ID: <20191218221536.GA20127@bogus>
References: <20191216174711.17856-1-jagan@amarulasolutions.com>
 <20191216174711.17856-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216174711.17856-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019 23:17:08 +0530, Jagan Teki wrote:
> Rock Pi N10 is a Rockchip RK3399Pro based SBC, which has
> - VMARC RK3399Pro SOM (as per SMARC standard) from Vamrs.
> - Compatible carrier board from Radxa.
> 
> VMARC RK3399Pro SOM need to mount on top of dalang carrier
> board for making Rock PI N10 SBC.
> 
> Add dt-bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - Move som binding on board side
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
