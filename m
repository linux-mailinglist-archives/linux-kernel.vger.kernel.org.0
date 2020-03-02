Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D22E217669E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 23:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCBWN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 17:13:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37243 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBWN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:13:28 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so975810otp.4;
        Mon, 02 Mar 2020 14:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uGARtVGb5GQcRJdnLbZgGSdPsUcgBwNPE/vctX/sjkM=;
        b=Od4Eloo5fE07MvzTIY6OHAXefNYxN2f5HUdX6K0dmiu57/Q5ZaA9ceNc5qgfhnF6ZQ
         0cO/M7MJZLVHZYX2SDxUTK0dLu7C9J5K5LIyNfKhQeNCVZxWhCmNicWab4Lt/3grhfKw
         mfB2dZKOJinKU4V6Bl7lY4v6JwcShN2EQkKTCyCui55VM0JASJMZp4HS9iUmNAgLxEhX
         fTGhpXzAFVj5jaB1OTYAv7bx43nV4bbhqJF2vBagpJIGCtW3zPPOudJBHRIdSxVQ06qu
         ipL79PO+e1eYkWx9ThNFP9JjfAGvujtD3csPCjqf3JFttYRTdjsXtYrdJlu6IPsHRSeI
         kUIw==
X-Gm-Message-State: ANhLgQ1iRa4xTEEXUVBxbl+TZgZs+BGRrqJaaIxjj0FRJpJ9jUmqOBPY
        2nUm4O1qjltWWiftNWXDY6BggiA=
X-Google-Smtp-Source: ADFU+vsW/Ftc+zw0bkyoQI7ygt1in3IUwH41Y0ReqXzak1w+/RwutHp8ko7jGUtVL4RV0SiqGHVaZg==
X-Received: by 2002:a9d:21b4:: with SMTP id s49mr998093otb.294.1583187208115;
        Mon, 02 Mar 2020 14:13:28 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p65sm6809911oif.47.2020.03.02.14.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 14:13:27 -0800 (PST)
Received: (nullmailer pid 24401 invoked by uid 1000);
        Mon, 02 Mar 2020 22:13:26 -0000
Date:   Mon, 2 Mar 2020 16:13:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com, huijuan.xie@mediatek.com
Subject: Re: [PATCH v2 1/4] dt-binds: display: mediatek: add property to
 control mipi tx drive current
Message-ID: <20200302221326.GA17941@bogus>
References: <20200225114730.124939-1-jitao.shi@mediatek.com>
 <20200225114730.124939-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225114730.124939-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 07:47:27PM +0800, Jitao Shi wrote:
> Add a property to control mipi tx drive current:
> "mipitx-current-drive"

'dt-bindings: display: ...' for the subject prefix.

> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt     | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> index a19a6cc375ed..780201ddcd5c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> @@ -33,6 +33,9 @@ Required properties:
>  - #clock-cells: must be <0>;
>  - #phy-cells: must be <0>.
>  
> +Optional properties:
> +- mipitx-current-drive: adjust driving current, should be 1 ~ 0xF

Perhaps should be a common property and use the existing 
'drive-strength-microamp'.

> +
>  Example:
>  
>  mipi_tx0: mipi-dphy@10215000 {
> @@ -42,6 +45,7 @@ mipi_tx0: mipi-dphy@10215000 {
>  	clock-output-names = "mipi_tx0_pll";
>  	#clock-cells = <0>;
>  	#phy-cells = <0>;
> +	mipitx-current-drive = <0x8>;
>  };
>  
>  dsi0: dsi@1401b000 {
> -- 
> 2.21.0
