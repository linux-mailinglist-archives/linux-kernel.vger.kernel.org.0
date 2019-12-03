Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE771104ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 20:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLCTS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 14:18:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39977 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCTS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:18:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id i15so3970881oto.7;
        Tue, 03 Dec 2019 11:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLXMRyKICPlNOZ05fFO5shGyYBI5uM+0oVnpeDhbnQM=;
        b=AcQySzs4hoQCM2vdX4KzFNhCtwYcNHnNQd84c2LfrhNJo3wnFS9JPsxwh+aU/jkpff
         Ogqb+/wBIwizJyiZCYstotHrxcDSbd3Ld4XBqyIjLfTG063acBdYoihc4zQ5jTPd8+qE
         r9FKGJafK3b7NLykhu35BMRBRhsqZzdkxe7FCJ4Fk1ATgnbjCfnc4nvDu6j3Pat3GE3+
         5LNrJE0jGNsOeQwYnRGmlXpDRnz70l2WIzU8Ju30Z2cUoBFnm8bg5tI6JEzBjYR1g7yf
         5y8fM+o7OqTZcIlwl8BaO9Cki8VV+O1mwaL19fH9zDTMCYBtsqOu4ZbK+KRJUDPBV1/1
         vI5w==
X-Gm-Message-State: APjAAAUrIOCnzFqkZnPIRUqU7IBzIsF4jStfTuFGom/uC23r8ZJ8WVKg
        V2XZYkawhVeeAPwvtfHguA==
X-Google-Smtp-Source: APXvYqzfMXYRpS6RB54EALQSkRj1NegXLtdiWeUYH7IkLsa+ocFmXr6dZDyL/GCEN559Imx4AOyWZA==
X-Received: by 2002:a9d:74d8:: with SMTP id a24mr4704586otl.100.1575400737646;
        Tue, 03 Dec 2019 11:18:57 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z17sm1445722oib.3.2019.12.03.11.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 11:18:57 -0800 (PST)
Date:   Tue, 3 Dec 2019 13:18:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v12 2/7] dt-bindings: sun6i-dsi: Add A64 DPHY compatible
 (w/ A31 fallback)
Message-ID: <20191203191856.GA17427@bogus>
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
 <20191203134816.5319-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203134816.5319-3-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 07:18:11PM +0530, Jagan Teki wrote:
> The MIPI DSI PHY controller on Allwinner A64 is similar
> on the one on A31.
> 
> Add A64 compatible and append A31 compatible as fallback.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v12:
> - none
> 
>  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml         | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
