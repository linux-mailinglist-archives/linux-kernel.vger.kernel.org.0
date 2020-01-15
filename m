Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F48213B723
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 02:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAOBnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 20:43:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44595 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgAOBnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:43:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so13862174oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 17:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iLGTssc9FHCMcOGMTyr/UYKoEZZS9tYZ4rHOO35XpvA=;
        b=O6ZDq2kfy6UEz9rv1hL1oz4k6p/fQMmY8AaF4ao79ohPynj1mxCo3/tf7lruB0P9Ri
         ve6Hj4QDusZCg7ZKJDTa1ZFTSwBvm/paZ25fDQfdDYnXBx6TgoQeSsARa2McCNTYwhCB
         f4UMvEy81AJVr9AO+Vo0her1h8JHcN2fMX1mrjTavzo4oD0cM19h8EU3XIftx6MpoZCZ
         CrUtM2BtOoQYd7hrQymuNEhZtVFIFUE4R0ucpXvJssZyBJFivy0Gj+Ee7J1oATvV40MK
         57XtWRXEX8jFtzyI/6P40eL694SxvQnOkbO7OQCfkkA5SgDh9o/uuESC8KrLPgK931dD
         P10w==
X-Gm-Message-State: APjAAAUUEoEGRa+hqD6ZLI+IXLOTrDNE088MHL8llk2annFtBff2IcfG
        K+xXAlGoz0BskTe5oTidxFBjeKE=
X-Google-Smtp-Source: APXvYqx6wNabFEq9rJdXHoUttvdrPTSoMmdk3YAl5qAnG+zVOYZShW8b3SW5/l6ggEoPrXL0nCgYTA==
X-Received: by 2002:aca:f20b:: with SMTP id q11mr18421272oih.78.1579052629268;
        Tue, 14 Jan 2020 17:43:49 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l1sm5184135oic.22.2020.01.14.17.43.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:43:47 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220a2e
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 19:43:46 -0600
Date:   Tue, 14 Jan 2020 19:43:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     support.opensource@diasemi.com, linux@roeck-us.net,
        robh+dt@kernel.org, lee.jones@linaro.org,
        stwiss.opensource@diasemi.com, Adam.Thomson.Opensource@diasemi.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/3] dt-bindings: watchdog: da9062: add suspend disable
 option
Message-ID: <20200115014346.GA20553@bogus>
References: <20200108095704.23233-1-m.felsch@pengutronix.de>
 <20200108095704.23233-3-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108095704.23233-3-m.felsch@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jan 2020 10:57:03 +0100, Marco Felsch wrote:
> Document the watchdog disable option which can be used if the hardware
> automatic suspend option is broken.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/watchdog/da9062-wdt.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
