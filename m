Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F35C1446B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 23:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUWAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 17:00:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46045 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAUWAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:00:25 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so4124573oie.12;
        Tue, 21 Jan 2020 14:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KLk2O/IKuSbiV0tR8rjrjmOXKw++jN6rlAX6P6oLFbI=;
        b=UUxvAKptw65tGmDmD8AtJPVrv5HawYbrlhLhi2IMgqjbRdRRi4ykJr4SD6Pg9V2SZ/
         KqjuN/0xSRpb4CxIHdvim1F+/BJzvhlIbmrmp2P6rDY4vvPl95dv6WxbclBJNTPWLf0w
         7kF0OmnQCG7N2nPpXe85Cer3o8i4T7dy1vuei5xoktrI7OVKAzFncqchN8LLC8eCWNV9
         XP9MsIHi0kvIimGcLoa2GJ9CPzO8M/jS0EzOcz3Jy9esz7YrexFvOhDVTkaobBfQDg6h
         07JMPaWshDWmr2W2Y1fAVLzRmBq96DDq3fJJblPxmE3nJhTR5J0KOgTVP/O6R0fupeyH
         IQHg==
X-Gm-Message-State: APjAAAVJF+y769pH+j1VTwq8fG3k2+CyuEDzPhrA4/32NEz/eeVHgSRp
        y1QLz/porBBc2EjCvIA8sw==
X-Google-Smtp-Source: APXvYqyrJcCLm65IFp9RrnaNPk0Kj24N9+PbvJbLGG+xddxwNzL2Rmb4y7wEB7BGH5EV0QhX139X+w==
X-Received: by 2002:aca:c74e:: with SMTP id x75mr4769148oif.140.1579644024678;
        Tue, 21 Jan 2020 14:00:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 69sm13989543oth.17.2020.01.21.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:00:23 -0800 (PST)
Received: (nullmailer pid 13395 invoked by uid 1000);
        Tue, 21 Jan 2020 22:00:22 -0000
Date:   Tue, 21 Jan 2020 16:00:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com
Subject: Re: [PATCH v3] ASoC: dt-bindings: stm32: convert spdfirx to
 json-schema
Message-ID: <20200121220022.GA12737@bogus>
References: <20200117170352.16040-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117170352.16040-1-olivier.moysan@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 18:03:52 +0100, Olivier Moysan wrote:
> Convert the STM32 SPDIFRX bindings to DT schema format using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
> Changes in v2:
> - Add "additionalProperties: false"
> - Also change minItems to 2 for dmas property, as both DMAs are required.
> 
> Changes in v3:
> - Drop minItems/maxItems for dmas property, remove ref to stm32-dma.txt.
> ---
>  .../bindings/sound/st,stm32-spdifrx.txt       | 56 -------------
>  .../bindings/sound/st,stm32-spdifrx.yaml      | 80 +++++++++++++++++++
>  2 files changed, 80 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.yaml
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
