Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A20E126F83
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 22:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLSVPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 16:15:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43786 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSVPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:15:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so8880734oth.10;
        Thu, 19 Dec 2019 13:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0xC+wpXWMUIqOw+a/OxtRwSmn/rGkdHgjrx5rfxU+UE=;
        b=i+EjdI452kZFcgCXz/HMIhDHRNw05bvOWOXRYrmnroPD17WNOgVEvNdMKucZMLY8Mu
         2jx/GoOdiChr3qtOoPxPYqQ3/L56ED+5TimgJ4xppL5v05ec1tBq+hhI01IRN7AyrgH9
         Mx2pCY9uUK6hie2BgNyUNpnN2GKG4Xrmoo05kRMNIfZ+oS5llEFWPhAUh3lDlsvUgRco
         2A0DJw7AZeWpve4vwWduK+i0Uyp54RRnTkYvA/n6KidZtzwN4FcQkKS4/nvSVP/8O5i9
         91PCNyDEHSP5jg8BOH/mzhc/qdZPSn9/wucwsqFF/oq8EUPJryGl872tqqOGauS3+PL3
         dz+A==
X-Gm-Message-State: APjAAAV2usf0meSqxYbLTlNc+IQP0yMU3H7HExLlCzAAgF0jU8pqeGWN
        nemCZRvjKQ2idP+bVwzGRtjYtylq8g==
X-Google-Smtp-Source: APXvYqz6lOzn3r96kUG+oxphG2Cda/2wTdIIqnUFxOl527gFCWlQkfjEHUUod08DRAknBbhAGf6Gbg==
X-Received: by 2002:a9d:4796:: with SMTP id b22mr10256701otf.353.1576790138802;
        Thu, 19 Dec 2019 13:15:38 -0800 (PST)
Received: from localhost ([172.58.107.107])
        by smtp.gmail.com with ESMTPSA id w201sm2408927oif.29.2019.12.19.13.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 13:15:38 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:14:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, mark.rutland@arm.com, jsarha@ti.com,
        tomi.valkeinen@ti.com, praneeth@ti.com, mparab@cadence.com,
        sjakhade@cadence.com
Subject: Re: [RESEND PATCH v1 08/15] dt-bindings: phy: phy-cadence-torrent:
 Add clock bindings
Message-ID: <20191219211314.GA15184@bogus>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
 <1576069760-11473-9-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576069760-11473-9-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 02:09:13PM +0100, Yuti Amonkar wrote:
> Add Torrent PHY reference clock bindings.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-torrent.yaml         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index 4fa9d0a..8069498 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -17,6 +17,14 @@ properties:
>    compatible:
>      const: cdns,torrent-phy
>  
> +  clocks:
> +    maxItems: 1
> +    description:
> +      PHY reference clock. Must contain an entry in clock-names.
> +
> +  clock-names:
> +    const: "refclk"

Don't need quotes. You don't really need *-names when there's only one 
entry.

> +
>    reg:
>      items:
>        - description: Offset of the DPTX PHY configuration registers.
> @@ -41,6 +49,8 @@ properties:
>  
>  required:
>    - compatible
> +  - clocks
> +  - clock-names

ABI again. You can't add new required properties.

>    - reg
>    - "#phy-cells"
>  
> @@ -53,5 +63,7 @@ examples:
>            num_lanes = <4>;
>            max_bit_rate = <8100>;
>            #phy-cells = <0>;
> +          clocks = <&ref_clk>;
> +          clock-names = "refclk";
>      };
>  ...
> -- 
> 2.7.4
> 
