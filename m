Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2B1446C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 23:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAUWBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 17:01:08 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46675 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAUWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:01:08 -0500
Received: by mail-oi1-f193.google.com with SMTP id 13so4121068oij.13;
        Tue, 21 Jan 2020 14:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Ir79vLg3FoHaHwlmcCw656rkZCmfJ7cHN0A8fbeWIs=;
        b=WxMl15x6WkUUW4agIFPeOB9abKmzkR++qKVp0N/OfQxmlOvYEVkTaeTv1pAj+MOtE+
         j7QDgcPxljGTQTTfNgSB8SSMb5naB94eu6idGogaaJPK+dZd1LwiHWGRM25l7NFtFsPS
         A3M3dLNP3KWTGrOF5Rc23ReSqVMRYb8tR7y5wKModwRxp2IT/cBFLzNIyg/RUJdkoJqY
         zhPUkjS7fT53QJqIGs+QJRC+dzPOM6eCYS1OkAzMmwXs0mpuW7V3yX7JvVscR16YxF+o
         dR62DtA55ShnGESxO/KCXLFqIMWi+o/Y2obBtMV6OiNVpK6mjE9DaYkHtS3rVZw4dnag
         gLWw==
X-Gm-Message-State: APjAAAWUo6cRde17a50kbPcM9af3EIwnwlPyr1xAl5sa1rvdJ4SfuxBW
        KChBACdB61pMEABhGtd4Cg==
X-Google-Smtp-Source: APXvYqw+acre/6tfGHQEKYTUqEH5WDUyB6vxhmpXiYsDnWp+R0PRuG7hQ7iZAnQdG7hRP9jTrhc9WQ==
X-Received: by 2002:aca:4fc2:: with SMTP id d185mr4696608oib.33.1579644067350;
        Tue, 21 Jan 2020 14:01:07 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm13942596otq.46.2020.01.21.14.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:01:06 -0800 (PST)
Received: (nullmailer pid 14562 invoked by uid 1000);
        Tue, 21 Jan 2020 22:01:05 -0000
Date:   Tue, 21 Jan 2020 16:01:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/3] dt-bindings: clock: Convert i.MX8MM to json-schema
Message-ID: <20200121220105.GA14466@bogus>
References: <1578965167-31588-1-git-send-email-Anson.Huang@nxp.com>
 <1578965167-31588-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578965167-31588-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 09:26:06 +0800, Anson Huang wrote:
> Convert the i.MX8MM clock binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  .../devicetree/bindings/clock/imx8mm-clock.txt     | 29 ---------
>  .../devicetree/bindings/clock/imx8mm-clock.yaml    | 68 ++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx8mm-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8mm-clock.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
