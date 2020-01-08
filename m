Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADDF51344E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 15:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgAHOWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 09:22:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33153 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgAHOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:22:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id v140so2768824oie.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M8y8BO0K5anvHEqPlUm8ymjBDQnclkOVB7xmvdmunFM=;
        b=P34kRQQYNNB9f+xk3eRmaAdVVSRjh1cQIcKfadQzaOag3PhVXVEHCiHP1Lpo1314SJ
         5MMSujqP7J+v2mus9AnNPiSq46Gt4NJjJYBQTVex+1fdVKQDaQ4eEpjiibL2+NAMbZNG
         GwLqU5IfyqAd7BICalY+VqKg9okiP39vCpvA8G116XAW6A4wJRoar1dtbfdg87h48Yi8
         BvXh9sELcJ+dz0pSrc+d+vUwapg222BGI8ykHKtRoahEsMc7iF8kglKEDar0nSbUebX0
         h6mu4YnPshaAuTxsiFok1XKBm0wuwcEbb3QJvPafYr7FzBOiJO9bjG+Wb86ihdvFUzlv
         mCAQ==
X-Gm-Message-State: APjAAAVswK4bFS+WpjeWCFgPvooEQ7bDYSJjfG+bc3twnBx1Xluvqnly
        tHCgJz2rkS7HQBWJK6jZ48o82vs=
X-Google-Smtp-Source: APXvYqxddw6u3IBB6w8Vk1rIDAzFRGLMo2zlpF84oy0Wow57gSgJdcOdju2KlugnSXzourO+VZaVMQ==
X-Received: by 2002:a05:6808:8e6:: with SMTP id d6mr3100077oic.78.1578493363968;
        Wed, 08 Jan 2020 06:22:43 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g25sm1149178otr.8.2020.01.08.06.22.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:22:43 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22001a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 08:22:42 -0600
Date:   Wed, 8 Jan 2020 08:22:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, andrew.murray@arm.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: Re: [PATCH 1/1] dt-bindings: PCI: intel: Fix dt_binding_check
 compilation failure
Message-ID: <20200108142242.GA8585@bogus>
References: <3319036bb29e0b25fc3b85293301e32aee0540dc.1576833842.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3319036bb29e0b25fc3b85293301e32aee0540dc.1576833842.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 17:53:24 +0800, Dilip Kota wrote:
> Remove <dt-bindings/clock/intel,lgm-clk.h> dependency as
> it is not present in the mainline tree. Use numeric value
> instead of LGM_GCLK_PCIE10 macro.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
