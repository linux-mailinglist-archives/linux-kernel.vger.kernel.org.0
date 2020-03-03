Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25EF41778ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 15:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgCCOaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 09:30:46 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35411 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgCCOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:30:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id c1so1755745oiy.2;
        Tue, 03 Mar 2020 06:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3giDTcmis7xuoYSVjRPJHKbcsBkDsi3FIKg6I//oj2U=;
        b=dW8vDaxSvu/x3DaxFVVsdgIzXFy7oRACP6jVk1NIT6YiAdMLQTs7oam2plcLLJHjV1
         UwYS/8V+6CVJaGhzkq8sc0wG5SdzQc6mNz9j5m3yTqf257yrZd3G9np2knyfMi8iZ3dY
         tOKAGLzulU7SoJU2C7ljbdEEZYmH70cWyCY+U5u9Evv3dOPns9pfxQb4SuUfnx8bs3ep
         BLRcSzzEWe39h0PWGXeU3Hr0OzqvsuUFhq0dVdtDZLDElSPQdpwzHpTeXWN1rMHD6VTV
         z6Et1oS4oQYFDPtwBWRzWFomyp0u/DFIRz+BteqjqAgs6iGjiOcSIwzBsSY55HOpgHSE
         7uvw==
X-Gm-Message-State: ANhLgQ0xtN6Uod5BzK6wkf+1dhldkKIbxHUkckE0PzRtKbXtn2nuQFiK
        Ao/X04r14l3Ajcrbg8fRTw==
X-Google-Smtp-Source: ADFU+vvfMW/0Fosxapnoh/aFQ3fRu6XOd3zB5JsdxNtRlGdL+ltkBAIjvhbLwLVfbP36SKvU92NEtw==
X-Received: by 2002:aca:4c91:: with SMTP id z139mr2568648oia.150.1583245845284;
        Tue, 03 Mar 2020 06:30:45 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y193sm6613292oia.38.2020.03.03.06.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:30:44 -0800 (PST)
Received: (nullmailer pid 24203 invoked by uid 1000);
        Tue, 03 Mar 2020 14:30:43 -0000
Date:   Tue, 3 Mar 2020 08:30:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: add vendor prefix for Linux Automation
 GmbH
Message-ID: <20200303143043.GA24147@bogus>
References: <20200226143826.1146-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226143826.1146-1-a.fatoum@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 15:38:23 +0100, Ahmad Fatoum wrote:
> Linux Automation GmbH[0] was founded in 2019 in order to develop
> electronics for embedded Linux. Add its vendor prefix so it may be used
> in future board and device compatibles.
> 
> [0]: https://www.linux-automation.com
> 
> Signed-off-by: Robert Schwebel <rsc@linux-automation.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
