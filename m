Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D65140E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 17:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgAQQDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 11:03:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42385 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgAQQDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:03:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so22921734otd.9;
        Fri, 17 Jan 2020 08:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cc+2p/NdA2drwwZu+ds0cTqC+QOcu+GLQ3qVjGXmwRQ=;
        b=JcMdD1uwsgLOkMvVOLTprtJuk2IDVYTdtlQIkJ8jNWO9iv1BPoiH8TSCkpfNW6UcYV
         4izQizI+dtkV5JaeQxfiBR0TFKwEvh7psV8NfrqFbbFaCjTMXuEolKMgIzafmAanb15J
         zODNYdX0FAsbZUaYVG2+a1inKURG5y+/9Yce2bHX9Ckd6EnlewIn+On5tVI3P0HITOGS
         NC+q8l+umEXnvuEnsGVQJ7P+2Fgj2cMjprQ3b7I+HWhqs7aeH1fr9fE2An9GhhHNOiCk
         3e4MVtjuaK/v87AOkiAAydtIBTDTYgLNOyBqM/jtKeB6tJwhf5z6E5hKUFOvMjqtTJVC
         cSRg==
X-Gm-Message-State: APjAAAV0z1tu6H2YKO2V9ds7q0CuxjNH0LjRl+NttlCP28l9s4wNnqFW
        ebBSeQ7akEwnovDqMBwCxQ==
X-Google-Smtp-Source: APXvYqwStuMK0QFk68kshtVW2xFzRr4VY3Yud366nVGYgDR/8no0d8SbTl51F5kthpK2jtrWklQcQg==
X-Received: by 2002:a9d:5c86:: with SMTP id a6mr6621526oti.68.1579277012884;
        Fri, 17 Jan 2020 08:03:32 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f3sm8941303otl.38.2020.01.17.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:03:31 -0800 (PST)
Received: (nullmailer pid 15163 invoked by uid 1000);
        Fri, 17 Jan 2020 16:03:29 -0000
Date:   Fri, 17 Jan 2020 10:03:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v5 1/7] dt-bindings: Add AXG PCIE PHY bindings
Message-ID: <20200117160329.GA15110@bogus>
References: <20200116111850.23690-1-repk@triplefau.lt>
 <20200116111850.23690-2-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116111850.23690-2-repk@triplefau.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 12:18:44 +0100, Remi Pommarel wrote:
> Add documentation for PCIE PHYs found in AXG SoCs.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  .../bindings/phy/amlogic,meson-axg-pcie.yaml  | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
