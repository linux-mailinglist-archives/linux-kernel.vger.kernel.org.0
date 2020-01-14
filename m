Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127CF13B5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 00:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgANXbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 18:31:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33532 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgANXbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:31:36 -0500
Received: by mail-oi1-f194.google.com with SMTP id v140so13668624oie.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 15:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAkgnrf4y6WZwtNfVCRDWdRSB0xmK/6Aa/25HCZGKjg=;
        b=fiEb9wTyNIy2yWaQ0dzZ+umjsUOeY01lM+uwqfCEEO9bPp0voW3dTS5f/PJ9A47gY8
         9dmd/LIMr03dIk4HhfuiaTIRgruPLEGkf5QEX4/EuYZeu8iVZWFHjb34qy6TFbrUOG5Q
         5uG4Hs7BDNuAfafTCkTig+yC0trJp7HeCBwUiygxkUOhnX6guXDOT3MltZB4G2ZoxWuH
         779ejrw+dh0sqlUyPI9NqCBeLCOauw/57cLFb7K+Hkt99LQA0G49z0WUTEqIyIHnaeNn
         3cueBFjkzY/RsR7wa1Hh53s50zBwXIKkU8M0ZJkqOpcYhnQPK+hfC3SvvXSKSWwWsbyq
         Q1dQ==
X-Gm-Message-State: APjAAAXRrf9lgQ9bqHUomQkmb5nOVSEHo5WqOwR6MiErMdmbOLknqhMt
        ZDwNQz7c6lyBoTSqNgx8ulEFSZU=
X-Google-Smtp-Source: APXvYqxWS/jVux9ru0knCvxW9NCS0+hWVCH3qo+AgcgZYptyyETla0ILbP7NL6GfUjq26xtUEGE0zw==
X-Received: by 2002:aca:4ec3:: with SMTP id c186mr18370094oib.53.1579044695357;
        Tue, 14 Jan 2020 15:31:35 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm5078901oig.24.2020.01.14.15.31.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:31:34 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2209ae
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 17:31:34 -0600
Date:   Tue, 14 Jan 2020 17:31:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, hadess@hadess.net,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yannick.fertre@st.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: touchscreen: Convert Goodix
 touchscreen to json-schema
Message-ID: <20200114233134.GA23810@bogus>
References: <20200108091118.5130-1-benjamin.gaignard@st.com>
 <20200108091118.5130-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108091118.5130-3-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2020 10:11:18 +0100, Benjamin Gaignard wrote:
> Convert the Goodix binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 2:
> - enumerate goodix's I2C adresses
> - add description for irq-gpio property
> - reference the common properties used by goodix
> 
>  .../bindings/input/touchscreen/goodix.txt          | 50 --------------
>  .../bindings/input/touchscreen/goodix.yaml         | 78 ++++++++++++++++++++++
>  2 files changed, 78 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/goodix.txt
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
