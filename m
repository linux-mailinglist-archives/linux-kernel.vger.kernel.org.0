Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA08190A51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 23:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfHPVeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 17:34:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45342 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfHPVeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:34:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id v12so2160296oic.12;
        Fri, 16 Aug 2019 14:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4hNsomfhtkJYSRxFCtvdSXbTEe2gnNz6ZO7wI+Pq18o=;
        b=ZYQ0g6wMFJewD6bnIwSQd+FPyIVoaNbKcTcvuuP+kvJdsRZO8ESnfAmt3BCueH1vT5
         M/hguVOTlx9xa6weQqeWUq2pwYn0GNRHBBUDvH97IjexdW71dp1kVzRm4BXkpWeLL2vs
         /3uZBJclK7IOH1WlnwSDhHMkNtngjKdqCh8a0I4McRajb1tbW8+2vQ1IbAQFXnjdOc2P
         B6cH5KaenR0nN4ElebD0zqw+T5gIAGcb+SvggFlNAUZlCe78DsGQa2ap1k27JkJr5gi6
         PkvTJ7F/AOdwC0ATDecwVWWDYSfAZrg3kA0dFiWefs7U6JMiliyD066o+ZS+WSbNvLYE
         s/xg==
X-Gm-Message-State: APjAAAWUFJ2dbcu7i0Gob3duSrMe/irOQOUppto+hUZIzDS1acaP/FQR
        uqncTx7Q8C1Juv1Y11TNsQ==
X-Google-Smtp-Source: APXvYqzVTr6SY3zMx27b1xrZeQTBRdnyvGPEGp4i/6TzKTbXmLOC8H924Fjk8F3isGbIJmv9jK4SCw==
X-Received: by 2002:a54:4414:: with SMTP id k20mr5963078oiw.120.1565991258547;
        Fri, 16 Aug 2019 14:34:18 -0700 (PDT)
Received: from localhost ([2607:fb90:1cdf:eef6:c125:340:5598:396e])
        by smtp.gmail.com with ESMTPSA id y62sm426676otb.69.2019.08.16.14.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:34:17 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:34:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: regulator: Document regulators
 coupling of NVIDIA Tegra20/30 SoCs
Message-ID: <20190816213417.GA9123@bogus>
References: <20190725151832.9802-1-digetx@gmail.com>
 <20190725151832.9802-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725151832.9802-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 18:18:30 +0300, Dmitry Osipenko wrote:
> There is voltage coupling between three regulators on Tegra20 boards and
> between two on Tegra30. The voltage coupling is a SoC-level feature and
> thus it is mandatory and common for all of the Tegra boards.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../nvidia,tegra-regulators-coupling.txt      | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
