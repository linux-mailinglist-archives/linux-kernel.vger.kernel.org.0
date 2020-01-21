Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7D31446EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 23:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAUWHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 17:07:41 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33104 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAUWHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:07:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so4207971oig.0;
        Tue, 21 Jan 2020 14:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=jrV7x2HT1HzIJs/17V/npvjy8NaCs9LfSMbU1/e5LoE=;
        b=UMPe00fxYduyFq0Vg5gM9SWMTSiCp4t16JfUDgQtF0bpHPC2YSKJziECHJMprbxN33
         d2CUAiky+e/bWqhhOOE5RCHl50Oq8gEGfZI6jmeSYF1GGssc2iuedg323CoFbg8BRRUK
         qcLr+9/eTier5AyjQ/ExUG2jtqX8hkYVJIN0YTBXbZxHyAu9Mjsc6gpH8w4C4orrE0Np
         Oa1eo+rlJb2TfW48FQTEcX1eJc6FDS+ylvRX2qMKUBB1RQi7FcBte8Gt6c1N4qbTCMqq
         FVZncCJ8+upl9GRB5owOhFt5EhSuKBnpED5u2KoseGh7SPWToS3JebEdHE8RdQ4gH3w9
         CG2A==
X-Gm-Message-State: APjAAAXEGHc/cOdGiKEZXaJICIoNBGc0QthYZ2O2e+eP87GZCetTZXiL
        V9gPExNCClG8HJLdkV7QkXyx+RY=
X-Google-Smtp-Source: APXvYqwnNIFZJUWPyA92HwXngPZjGPZuBujZdvC603o0NUcsnM1zSTX/tUl2maBAnH23lN0yUOZkMQ==
X-Received: by 2002:aca:d502:: with SMTP id m2mr4531075oig.41.1579644459940;
        Tue, 21 Jan 2020 14:07:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m68sm12444096oig.50.2020.01.21.14.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:07:39 -0800 (PST)
Received: (nullmailer pid 24002 invoked by uid 1000);
        Tue, 21 Jan 2020 22:07:38 -0000
Date:   Tue, 21 Jan 2020 16:07:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: arm-boards: typo fix
Message-ID: <20200121220738.GA23950@bogus>
References: <1578983860-23747-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578983860-23747-1-git-send-email-peng.fan@nxp.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 06:41:49 +0000, Peng Fan wrote:
> 
> From: Peng Fan <peng.fan@nxp.com>
> 
> Typo fix, "withe" -> "with".
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/arm-boards | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
