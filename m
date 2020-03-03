Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 558E5176A01
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 02:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCCB21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 20:28:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44380 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgCCB20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:28:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so1301387oia.11;
        Mon, 02 Mar 2020 17:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+1KyOHwBn/viSAsJSh8AjzAW83mdyjNjKZ1smKP6L5I=;
        b=gowULXKi1t2SA+eZriCLpHwrimvmr4FW+HFillEdE7x1kqJD2VaOom5qKx9Eob0WAP
         UroPv2PWNLU7TsH1GljP8OeHs2LQ6U8nSbhIF6QNus0Z1pZDYylyjIgSI30T3w6DlMFd
         HH0kCZVQeOQDoQBuSlzoWOakxmoG6WIh+kMGEJ+bJ0YbqID6+6tglial1yc1Mfx+ahCt
         /llVDTIb9Gvscmzp4N5ViHWTc6wsmXrY3DeJB3L6hZIlA180IFvQkXu4UTxifB1Sj62S
         2NcalEhmyyR1lSZTq6apg29V4IBsq5UBqJV041qrWrc/HfrlJvsq0If0w9Jq3ezgViLa
         GQpA==
X-Gm-Message-State: ANhLgQ1gsu9M7yvWhknj1GjaqtQK8+8qhI+6+m4nhpJlyZxWuubmBt8f
        zgRBt/yb5aNaTvavzkuqTg==
X-Google-Smtp-Source: ADFU+vuXH/1hxcsxPMVP9wigrFZpla2XwPEdAwOWERbHAnI6m6fNRmH5HugZb8pe9eB5At7zzu07xA==
X-Received: by 2002:aca:1204:: with SMTP id 4mr891001ois.143.1583198904510;
        Mon, 02 Mar 2020 17:28:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s23sm1981432oie.0.2020.03.02.17.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 17:28:24 -0800 (PST)
Received: (nullmailer pid 7901 invoked by uid 1000);
        Tue, 03 Mar 2020 01:28:23 -0000
Date:   Mon, 2 Mar 2020 19:28:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Add binding documentation for
 TI EHRPWM TBCLK
Message-ID: <20200303012823.GA7863@bogus>
References: <20200227053529.16479-1-vigneshr@ti.com>
 <20200227053529.16479-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227053529.16479-2-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 11:05:28 +0530, Vignesh Raghavendra wrote:
> Add DT bindings for TI EHRPWM's TimeBase clock (TBCLK) on TI's AM654 SoC.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
