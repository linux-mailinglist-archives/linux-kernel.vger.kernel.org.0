Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910521D0D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 22:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfENUtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 16:49:15 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40817 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENUtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:49:14 -0400
Received: by mail-oi1-f193.google.com with SMTP id r136so162224oie.7;
        Tue, 14 May 2019 13:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6T3Ip6O04LTKLd5qWK9Ww230fOKy3msDw8KUYfWmvPM=;
        b=iUbAM7QVkpgpoEs5CcDQYrjDuiU7qevvs5/5MiHV9I6wywOPNPwdFu9LzxlkKW2M8a
         ZgU8/4PLCwQ10jbE/4cyahAHMdDFF1mm6H48hg6EGX0HqmyJk2MWiVhJq6++sJqgv1Mn
         E6w6XsUtbQVG1iGWAtefVo1HFGhAmYhaUiqamv1/ldA4VWHnkIfIRtcdZ5qYrSsLtiyV
         jLAH1/PxmxFxEuK4zNVR01Ozc63cL5qzVRDe1cagk+WLel+ENBkAoxFzFEbqEFH4KDrW
         gwcQIvZyqZQSfbnLB8xqvgIYDtbCWq62vOF2bdugMrhyvB1fOKKcQjEATUlIMx9hI6tP
         fBig==
X-Gm-Message-State: APjAAAWV+CFoExpfjbut8SMr3UC783FXAEPyJ2Wlm3m7MyGk1TNq9LO5
        II8qCj5DfxnSo+lLTgRAZg==
X-Google-Smtp-Source: APXvYqw9r62Myv1ZK5vENIP2ad0ZFC9OJdOjoMmtmV5w3i5Ay9PLbIuaxAG0cmS6uL2JJgGZGo7oTQ==
X-Received: by 2002:aca:7255:: with SMTP id p82mr372346oic.119.1557866953685;
        Tue, 14 May 2019 13:49:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o124sm1524501oig.23.2019.05.14.13.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:49:12 -0700 (PDT)
Date:   Tue, 14 May 2019 15:49:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/5] dt-bindings: drm/bridge/synopsys: dw-hdmi: Add
 "unwedge" for ddc bus
Message-ID: <20190514204912.GA25548@bogus>
References: <20190502225336.206885-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502225336.206885-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 May 2019 15:53:32 -0700, Douglas Anderson wrote:
> In certain situations it was seen that we could wedge up the DDC bus
> on the HDMI adapter on rk3288.  The only way to unwedge was to mux one
> of the pins over to GPIO output-driven-low temporarily and then
> quickly mux back.  Full details can be found in the patch
> ("drm/bridge/synopsys: dw-hdmi: Add "unwedge" for ddc bus").
> 
> Since unwedge requires remuxing the pins, we first need to add to the
> bindings so that we can specify what state the pins should be in for
> unwedging.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../bindings/display/rockchip/dw_hdmi-rockchip.txt         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
