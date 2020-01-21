Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB01446BD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 23:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgAUWAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 17:00:48 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37623 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAUWAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:00:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id z64so4158490oia.4;
        Tue, 21 Jan 2020 14:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p2Aap5NFUqMa77n/+b3hDbspOjP5JJgkLK77uRQX50E=;
        b=my9OeU7Jnu4ZR2GkAxzppgxkn9Eje108fXeJaadpBRU19HAmI2YTJuV0P8uO4bZMJK
         ih8fxJofshbTBUSrNKVQRWX6iXWqg5MPjZJycKcCwruhO9l5cE1ZYfVC5uLcdAMcAO0H
         A5yVxPdNQ2LD4nJ7uPuY6jL0NFRTEhUCKNqGv1lulQl0U+QSsqfLifgYqSqVw6n9OQ/j
         yGM/lemk5Zohf2SPj9bmpKs2oW7nwlxJm/PuUr2Wmt98H3p5Z6XGY5wOZF3+MJ3pQ6eZ
         2JFUXELKdDnrpvmSvSbzoGHCuJPaWzAuyZpfuv4vGO1cqoXOyKnx8cq7naYXXe/mXgdt
         eHUA==
X-Gm-Message-State: APjAAAXopIVsfomYa55usnTfpT14pkJHcmpSFalGrRDfX+TcyEB+Jk4M
        9zro6V0zrl/dPb4CIOzgfg==
X-Google-Smtp-Source: APXvYqxKBYMeO352fDo1BAP8tkycFEuGstxKeRhGS0pwBdWJpiC1n2wUfiMqntTT/6xQkubrVGgV4w==
X-Received: by 2002:aca:3241:: with SMTP id y62mr4611216oiy.31.1579644046532;
        Tue, 21 Jan 2020 14:00:46 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n2sm12341870oia.58.2020.01.21.14.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:00:46 -0800 (PST)
Received: (nullmailer pid 13995 invoked by uid 1000);
        Tue, 21 Jan 2020 22:00:45 -0000
Date:   Tue, 21 Jan 2020 16:00:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] dt-bindings: clock: Convert i.MX8MQ to json-schema
Message-ID: <20200121220045.GB13566@bogus>
References: <1578965167-31588-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578965167-31588-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 09:26:05 +0800, Anson Huang wrote:
> Convert the i.MX8MQ clock binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- Correct the compatible string, should be "fsl,imx8mq-ccm";
> ---
>  .../devicetree/bindings/clock/imx8mq-clock.txt     | 20 ------
>  .../devicetree/bindings/clock/imx8mq-clock.yaml    | 72 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
