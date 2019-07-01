Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE91024E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 00:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfD3WYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 18:24:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37628 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfD3WYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:24:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id k6so12639378oic.4;
        Tue, 30 Apr 2019 15:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MyOJCP+P9cbGTkqaQ+gM72dvr3UEtLfUje9xWwcxdRM=;
        b=CGV5kuurp7iW7xSLeMFchoktCVAbxCErutMQrGn1RmV6TY2yGVbO70DOdHq+AsHdhY
         DzlsMhg+YWdDgNwZtNlv3bj1ClA6hVbrAMv7ZR1hMa1XSO6JZkwvWhGFYIbgez5oZ1CD
         8mPTfs62pdxdZOg1fw4VWLY2VhxdPhWmBr66OCHHtDiActLZZOvdoT8/2z8Q6Fiv4g5s
         R41rNGyYyx+INTq2QAcHeBSF/8ZnjeEeJ8/LdIedmiYkjKQqDWQCwQwkgmiHqvMAr1Uh
         Oxot4a8SNfNHEfXoMlh8q3gBus56ZhHKVr7D2tD81g2cX+LylkIMRwMkgWRMzIZHdVbl
         ol0Q==
X-Gm-Message-State: APjAAAUc+ntsjZV4NczB+3xabSqGicLN8mGmKeIR+jOKKWruQDwiY7UP
        Mm37tY8MEQhmFngAHSmFoQ==
X-Google-Smtp-Source: APXvYqw4JhJjcmKbH1sQuC0lBNbYVFG1NpxdTXInzLvoWK38OT5etr7o7ik3qtuYPr0A5OmNK5lWtA==
X-Received: by 2002:aca:eb11:: with SMTP id j17mr4718250oih.67.1556663080990;
        Tue, 30 Apr 2019 15:24:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u127sm2204372oif.14.2019.04.30.15.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 15:24:40 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:24:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, tglx@linutronix.de,
        jason@lakedaemon.net,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        linus.walleij@linaro.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 08/14] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190430222439.GA7845@bogus>
References: <20190430101230.21794-1-lokeshvutla@ti.com>
 <20190430101230.21794-9-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430101230.21794-9-lokeshvutla@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019 15:42:24 +0530, Lokesh Vutla wrote:
> Add the DT binding documentation for Interrupt router driver.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v7:
> - Changes interrupt cells to 2.
> 
>  .../interrupt-controller/ti,sci-intr.txt      | 82 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
