Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA6D4FBDA5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 02:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfKNBwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 20:52:05 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40879 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 20:52:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id m15so3479859otq.7;
        Wed, 13 Nov 2019 17:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tyy/iJPlcDNJd/yf1nrHt+l6qJbLFsBGezCH8MwXmmM=;
        b=WjPUsnCwEGuhN+pBizL6AdvKJtJt5YwWWOaH3J42XOorD045M0DRHSqWxAg3oBwERs
         vZfH3jmPWcU5vQ8+lz5a8aVRf//yef3vYGZQSToZQCQ/NbejTFyL/Ms2ES5tT71KlaOj
         CykS9ipFWekFZhJzh6VvapDBhCoi2C3E/bwcOhavJjBOyeFuAICvMcCZOQ9esnmLOSrf
         q8CkJ+A46wOBP2KuT5IJfjm+oE+et7sOA00QefGOG2wvVzKudLIOSZCZqgZkjNWPSXaG
         iPu//lvLjGEgKD4jspdJaH62tLf8z8k5qvzp9AYX7OeOxuNZIVDq3++cPI4c8f6lK2d7
         PYpw==
X-Gm-Message-State: APjAAAXcoUUX25UceQyNT/9Oh6YeK+5IL3ZJFPKy7cYiiLlSkT+KDYDY
        B63ZbqPPCokx9GWLO+AIY+Bzc8E=
X-Google-Smtp-Source: APXvYqwo1UUZAelKrLAwuSh6trS8OhtcFC9X3B8JtWLGubj/w8/T0NRDlQJnITZxmL8ShTtFhqgOQQ==
X-Received: by 2002:a05:6830:1d4d:: with SMTP id p13mr6025041oth.286.1573696322369;
        Wed, 13 Nov 2019 17:52:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o203sm1334139oia.4.2019.11.13.17.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 17:52:01 -0800 (PST)
Date:   Wed, 13 Nov 2019 19:52:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Cc:     dri-devel@lists.freedesktop.org, a.hajda@samsung.com,
        hjc@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, philippe.cornu@st.com,
        yannick.fertre@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: display: rockchip-dsi: document
 external phys
Message-ID: <20191114015201.GA22126@bogus>
References: <20191108000253.8560-1-heiko.stuebner@theobroma-systems.com>
 <20191108000253.8560-3-heiko.stuebner@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108000253.8560-3-heiko.stuebner@theobroma-systems.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Nov 2019 01:02:50 +0100, Heiko Stuebner wrote:
> Some dw-mipi-dsi instances in Rockchip SoCs use external dphys.
> In these cases the needs clock will also be generated externally
> so these don't need the ref-clock as well.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  .../bindings/display/rockchip/dw_mipi_dsi_rockchip.txt     | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
