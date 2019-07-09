Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34CA62DB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 03:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfGIBwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 21:52:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35473 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfGIBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:52:23 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so30247323ioo.2;
        Mon, 08 Jul 2019 18:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/tzcZLlDxbC1twwv0AFnIwTd9l+z877k7LvqZNpQY/c=;
        b=kMwyIDadQowI9Se3474fkdqIU67ubqm8PaDM2K1pPoKp+c4wFFz5JaQXsxMGfdF0mL
         xbZFQj8bqgy/EF+i0XH94/dJe56NO8EibhLTDlrpNU+2saVGeRj2TNugjbrFwsW6Nx11
         vr/L+UzPQPW+w2devIJ+7Th1yQagCpdHH86X67oPfcpcv99bf/JB5j8Eie+ZnlxXpeQq
         YmVPOLm4Q/bUwi059pXwZUtI3xedcPnkhe2alJI71JaxtgmBm5zWwtX/T9wMBfvXz1fy
         8H6TEnq7JkMpQ+J0UpYOluZcASqaQ08ShXorknPJGzo+caNwES0FKdDl08xqsXUC+J3D
         0bNA==
X-Gm-Message-State: APjAAAUuRUkKPMlawxakxcP3yPT1myk3vHBBDZPUK6/NjcOVIBIxG2Wj
        ynLelUNQoEYmpd5OEpUcLQ==
X-Google-Smtp-Source: APXvYqyuoLXWQjUHBrmOlsWqa0z0KTgxi+6bb9MZ0KVWo5iYoxRliYViJNxGihIE2TjIS3iii9ESlQ==
X-Received: by 2002:a02:6d24:: with SMTP id m36mr25055180jac.87.1562637142441;
        Mon, 08 Jul 2019 18:52:22 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id e188sm16873548ioa.3.2019.07.08.18.52.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 18:52:21 -0700 (PDT)
Date:   Mon, 8 Jul 2019 19:52:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc:     p.zabel@pengutronix.de, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Joao.Pinto@synopsys.com,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: Re: [PATCH V2 2/2] dt-bindings: Document the DesignWare IP reset
 bindings
Message-ID: <20190709015220.GA18239@bogus>
References: <1559835388-2578-1-git-send-email-luis.oliveira@synopsys.com>
 <1559835388-2578-3-git-send-email-luis.oliveira@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559835388-2578-3-git-send-email-luis.oliveira@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 05:36:28PM +0200, Luis Oliveira wrote:
> This adds documentation of device tree bindings for the
> DesignWare IP reset controller.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
> ---
> Changelog
> - Add active low configuration example
> - Fix compatible string in the active high example
> 
>  .../devicetree/bindings/reset/snps,dw-reset.txt    | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> new file mode 100644
> index 0000000..85f3301
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> @@ -0,0 +1,30 @@
> +Synopsys DesignWare Reset controller
> +=======================================
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +
> +- compatible: should be one of the following.
> +	"snps,dw-high-reset" - for active high configuration
> +	"snps,dw-low-reset" - for active low configuration

This is really a standalone block?

Are there versions of IP?

> +
> +- reg: physical base address of the controller and length of memory mapped
> +	region.
> +
> +- #reset-cells: must be 1.
> +
> +example:
> +
> +	dw_rst_1: reset-controller@0000 {
> +		  compatible = "snps,dw-high-reset";
> +	 	  reg = <0x0000 0x4>;
> +		  #reset-cells = <1>;
> +	};
> +
> +	dw_rst_2: reset-controller@1000 {i
> +		  compatible = "snps,dw-low-reset";
> +		  reg = <0x1000 0x8>;
> +		  #reset-cells = <1>;
> +	};
> -- 
> 2.7.4
> 
