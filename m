Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89F874066
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 22:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbfGXUsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 16:48:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36409 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfGXUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:48:24 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so92603777iom.3;
        Wed, 24 Jul 2019 13:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IHAe9r8SwKR0SOE7feOFdveA8IT0SDk7uX1IR0X6Pa8=;
        b=VKTL2mDmpsBNmsM1JMrLP2x6QIe3+uWnLOp5EzDvE6nhWDM8XNVOSx5ydDs1kFEYr8
         whKx74qjmDlGAoYUpQX8+WzgOxujj5pgyDPMCIL9YbgBcaK06Z1ye77Ml3svtDYi4B6n
         tHXxaFbxCMsoPhPU5gyFT18Q7e+yZJ77aSAs7qMitMdm8lV1LxTG7rgmVk8kbw0Dyfzv
         uSPmnczzM5Gxc8YtRDSL/Fp8+jhjXdCNV8ZP19Vh0sFYShtuNSJjO6kH/Z5YuyzrUrFr
         WOnEfGrzhylbFBEOwUPBLWQMkSC+CMtmgMgxr1SWT9Bgy9dTqCfc0uQT2B2XmsiMk6C8
         VYww==
X-Gm-Message-State: APjAAAXLMG8r4lCaVVD6DZz+y6D10X2ZfYsJdG3/7EjgJEHIWgFTkMGY
        E65eh2lOa8AJuecZuHr9ug==
X-Google-Smtp-Source: APXvYqyaS0TYvzjTPZIPuZme/uFk9QJ9Ap7J20wOVd2CKLqEYYi1duV0VS989NHcY60O65J0oEWMoQ==
X-Received: by 2002:a6b:5a17:: with SMTP id o23mr73100927iob.41.1564001303913;
        Wed, 24 Jul 2019 13:48:23 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id y5sm49459573ioc.86.2019.07.24.13.48.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:48:23 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:48:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] dt-bindings: bus: imx-weim: document optional burst
 clock mode
Message-ID: <20190724204822.GA17166@bogus>
References: <20190712204316.16783-1-TheSven73@gmail.com>
 <20190712204316.16783-2-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712204316.16783-2-TheSven73@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019 16:43:16 -0400, Sven Van Asbroeck wrote:
> An optional devicetree property was added to the imx-weim driver,
> which if present instructs it to operate in burst clock mode.
> Update the dt-bindings to reflect this.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  Documentation/devicetree/bindings/bus/imx-weim.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
