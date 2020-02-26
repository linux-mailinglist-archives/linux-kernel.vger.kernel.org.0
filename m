Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5FE1704AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 17:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBZQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 11:45:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40025 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgBZQpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:45:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so17910otr.7;
        Wed, 26 Feb 2020 08:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+jpf9V7GJci9zFA7xE/ne4mBwHPRwJxrYPbYAK7KP8s=;
        b=Hfn0zTuUmMcPqBZPMWJX6WOltAdMtGAKoE/KOBAcGnuTaNC3ctMDjMBhKri4QePEub
         h+aHAOR5LauMlGzwkyDWQybPlhkmfG8X/1EOaP0oiJ2GX77zYYBAXlfTII24YstDyoER
         ltETp33iX7CA4323RYt4VwLXLdc2oMcT1EgwvZBRtUi1vOY1qpG42KZe5J9/bJQn/pKT
         zRnb0i1tW4C+z5PUbrpcgUXGGijuXBp4wlQuNQbsLZx55or1/jhAzvIVbrqpUWyWCiRF
         CW9qV4RdNon00XQ0h9UM3i990oNE2JgF8tdCj859YzsIqEigcDnFyH5dENsgYEtR/0Nr
         /tkA==
X-Gm-Message-State: APjAAAUdfKGCwuLqkCBrF/WWlb7+2PLpM666y+L2gitmNMx83Z76pg8U
        n2U2TDAekwd6qTF5Eprs8g==
X-Google-Smtp-Source: APXvYqyTEDvRxEo9nOKGqg12BjH4WR+4WGsY68JsuPWIkt4Xfv+GYGW8LItBxGawTREHNUpS0RlOhA==
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr4120984otq.281.1582735543458;
        Wed, 26 Feb 2020 08:45:43 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 60sm957984otu.45.2020.02.26.08.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 08:45:42 -0800 (PST)
Received: (nullmailer pid 15869 invoked by uid 1000);
        Wed, 26 Feb 2020 16:45:42 -0000
Date:   Wed, 26 Feb 2020 10:45:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-serial@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: serial: Convert UniPhier UART to json-schema
Message-ID: <20200226164541.GA15714@bogus>
References: <20200221021137.19443-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221021137.19443-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 11:11:36 +0900, Masahiro Yamada wrote:
> Convert the UniPhier UART binding to DT schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../serial/socionext,uniphier-uart.yaml       | 46 +++++++++++++++++++
>  .../bindings/serial/uniphier-uart.txt         | 22 ---------
>  2 files changed, 46 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/uniphier-uart.txt
> 

Applied, thanks.

Rob
