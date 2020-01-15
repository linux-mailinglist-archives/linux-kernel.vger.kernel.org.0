Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D24B13B678
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 01:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgAOAN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 19:13:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44973 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgAOAN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:13:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so13686772oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 16:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vm6D/kKtAQPyA/3q2QOxNghbHuIfBqj+2jZduMBeUh4=;
        b=Y1rzILxklFeXH9V08W3OKGxzgl3HIFMwjEdGBmyMXKPs9/uZJL3H/dBf6LXGZ8Roep
         5ksROmM7K6DosI1CqkvtUiPe+Z7O30SbePlzPEbN32Z6noqYQ10EDHeHwx/j+Nnjs6nP
         Dm82bIqoIrXyg8VBpaWHBvw6NLNIXmVxEBS64yMeUm3biZavrcZzf19aPQbIofXW6KhF
         kpEYRMZmsGD1rbABRHkGeQuur5GEvOLaTKQUvml3XXFZ9b6leMwQ+kWPJTKoc/b0luLi
         I8r42rdhqVECf5rdVexk5mcjLQIuvlNt6XxbHQjYBtAO4Awhwqa8oAYrT7K8Pueq9sO4
         PolQ==
X-Gm-Message-State: APjAAAVjO96uPhzEJYCSLSsAt1Wvj7cR74oLOHrBpT9c6kI0tkAsI2Yk
        ECGXeWbe6PLirzNsfuNQ17INBEU=
X-Google-Smtp-Source: APXvYqxUuHmJwKZMmKljnEkATjnwyq3633mdJ8ju8YSLMH2nVyviykaR5yd7CFtWnwn0MVWEJ19P/Q==
X-Received: by 2002:aca:2109:: with SMTP id 9mr17430465oiz.119.1579047238512;
        Tue, 14 Jan 2020 16:13:58 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r205sm5163483oih.54.2020.01.14.16.13.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 16:13:57 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220a2e
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 18:13:57 -0600
Date:   Tue, 14 Jan 2020 18:13:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, kernel@pengutronix.de, linus.walleij@linaro.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] dt-bindings: pinctrl: Convert i.MX8MQ to
 json-schema
Message-ID: <20200115001357.GA16961@bogus>
References: <1578629120-25793-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578629120-25793-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 12:05:18PM +0800, Anson Huang wrote:
> Convert the i.MX8MQ pinctrl binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- use "grp$" instead of "-grp$";
> 	- use space instead of tab for "ref$";
> 	- add missed "reg" property;
> 	- remove the "maxItem" for "fsl,pins" to avoid build warning, as the item number is changable.
> ---
>  .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        | 36 -----------
>  .../bindings/pinctrl/fsl,imx8mq-pinctrl.yaml       | 69 ++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml

Actually, it looks like you can combine all 3 into a single schema. The 
only diff is the compatible string.

Rob
