Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0752BFBDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 02:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKNBwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 20:52:24 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44461 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNBwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 20:52:24 -0500
Received: by mail-oi1-f195.google.com with SMTP id s71so3753658oih.11;
        Wed, 13 Nov 2019 17:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mzR6nG67pn8IlqJFDhdjYxot9QbuFGZP+Pet1HLMx08=;
        b=idsT+EhLW8oG+MyMYmfYDGPkRRl8z2UxhzyjW3oE74cfiiv0zt1l11qm9+hRzUom8e
         tpq89GYBCyW7tJiByUBlol0oXDaXCwFzF7kUK4pXlc0CmPxYWR+kvts7svgrm6EBRPCI
         4HibmGhWFk37Y5SXrvm3LVOykHO9N+bMpyIQFruhN87vw+IwaBobCom9fZJ+Qe+9BN2F
         JBJkeDGlHjge0hySrjKz32+5IWiSNzGNI7S+d8GKY69uURwpC3bWEPZz5C39rzOja9Y1
         Eh1XXOKEAf61M1vyVkqhhoOg8ntxQ2/kkE0DoA32qv+Da7ouEdvB7IqZxjsqiqfEEnBm
         aQKg==
X-Gm-Message-State: APjAAAXDOqXUkNKLK9uP71s184MFZcn8mUzYYDOMBtj4GDnRJ/ofcWdY
        cqP3ImQecHsInfx2qVdEXQ==
X-Google-Smtp-Source: APXvYqy1LyXkt7WGiuHxADhPr836dQgZX6Iact41M6WrKpL8aIdlSK3MOwv9B1/LdhtB661imE7fmQ==
X-Received: by 2002:a05:6808:103:: with SMTP id b3mr1326000oie.38.1573696343304;
        Wed, 13 Nov 2019 17:52:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e93sm1380668otb.60.2019.11.13.17.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 17:52:22 -0800 (PST)
Date:   Wed, 13 Nov 2019 19:52:22 -0600
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
Subject: Re: [PATCH v2 4/5] dt-bindings: display: rockchip-dsi: add px30
 compatible
Message-ID: <20191114015222.GA22800@bogus>
References: <20191108000253.8560-1-heiko.stuebner@theobroma-systems.com>
 <20191108000253.8560-5-heiko.stuebner@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108000253.8560-5-heiko.stuebner@theobroma-systems.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Nov 2019 01:02:52 +0100, Heiko Stuebner wrote:
> The px30 SoC also uses a dw-mipi-dsi controller, so add the
> compatible value for it.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  .../bindings/display/rockchip/dw_mipi_dsi_rockchip.txt      | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
