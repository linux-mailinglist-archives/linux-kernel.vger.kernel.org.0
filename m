Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F00EFB56DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 22:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfIQUYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 16:24:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43649 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfIQUYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:24:12 -0400
Received: by mail-oi1-f195.google.com with SMTP id t84so4027035oih.10;
        Tue, 17 Sep 2019 13:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L86DG7FjMIlZ9GjeaW9bo4Zl8CPlfcAwMoJ04R6XmYw=;
        b=T3vgjOeJiMPaNyWW7kWdkuCjR8gqgdekKk6uPY69iaKxB5NDdJTiTQ+CDdslcZpE84
         gAAOt0XWapVL/C0Tc1jusXe1ZL6NYIP23HPavJnlvPl95sfY0jTlYN4P/OHsTgYtWVyb
         MTL4ywSLKnOmy8AVHYXh9gu60LKgPK7d9ARkXfk/AKA51tNSISUaygJtHfVEaiGHlhA9
         bqrP1BLav5XV7JLM5bEFjL7+F+VSjBsudFOlSniBYrybbIBuD5EgH6LPBu1Wf3A9tsaY
         76IsSZ5e0+FJde0Ay+uFDBJ5Yl1RlGQE3VBfd6jiu7OuUf3uQbvZJvNyPZ2nlZzlNrAG
         H3Hg==
X-Gm-Message-State: APjAAAVA3cn2LMDMxvx7+93FWJJ9MuGFFpVdoBhNCoPHMOMXdn3iSTeO
        NdUuyRYKt5jKNKG0tlaFzQ==
X-Google-Smtp-Source: APXvYqwnNKesPon0IV2MJhAJUypSV84Z46WSnp6uH+aDsn/vNtFjO0Wg+O6hPVmcMNwnCMor2mkUtw==
X-Received: by 2002:aca:4a09:: with SMTP id x9mr5153491oia.32.1568751851936;
        Tue, 17 Sep 2019 13:24:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o19sm998420oic.26.2019.09.17.13.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 13:24:11 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:24:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML schema
 for LGM SDXC PHY
Message-ID: <20190917202410.GA6574@bogus>
References: <20190904062719.37462-1-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904062719.37462-1-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:27:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add a YAML schema to use the host controller driver with the
> SDXC PHY on Intel's Lightning Mountain SoC.

Same issues on this one as emmc phy.

> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  changes in v3:
>    - Rob's review comments addressed and updated the patch
>    - merged syscon and sdxc yaml file as single file after discussion
> 
>  changes in v2:
>    - As per Rob's review comment syscon node entry added instead of reference
>    - splitted two patches one for syscon and another for sdxc phy
> ---
>  .../bindings/phy/intel,lgm-sdxc-phy.yaml           | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
