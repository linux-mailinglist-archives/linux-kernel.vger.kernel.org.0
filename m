Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A4D13C6A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 15:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgAOOwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 09:52:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39956 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgAOOwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:52:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so16290972otj.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n8ZOYkpIoAOQdlGT8sz2BDJ8ZlJ/E1aAe+yKBj0gCtM=;
        b=QFWXbMcbbSaLyv0EENAPBO3bsc1xIivFlk01qsQ8LQIKig4x/44d5Bp3geo3GkpMua
         LPXmInuAN22emeRUJPjo9QPv4+PzUzyV80BLno04+vZP0CUsJTIMynYp3qJ/7ZCDJJro
         lJo1uMjFzXUu8edTGsAzjChe9jEV0jHL9cHXTC1pW0ET2fQo+NX6Oqi44/J7/srKxDXR
         n5ulsI1PTAqtyufFhB4ptXNLnvwuTKv/XAvK5whQJUkGDEcGGjcvml9aGJIWrbc4lFTi
         B0eat0NmA7ZexQw5Fcc6oMnlkSgddbp5TWmmjx3v/LCsfZf4m6V2dIFfjUR2FSY9WzQh
         ykjQ==
X-Gm-Message-State: APjAAAXphAMIHKToDO8CaXAGLLNsf+9JJleyOy6MW6CLxZMpDs3juBN1
        ZxaYRKFjWFRV66pNQ56a3mTLYYg=
X-Google-Smtp-Source: APXvYqy7P19NJRkXFKPP2LEPHcF+mqyNirR19MT4n7O3Qf8nxMG/3oI8NwMAz3J8MaYUEKjoGkmIoQ==
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr2978331otr.262.1579099924635;
        Wed, 15 Jan 2020 06:52:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p21sm6647069otc.21.2020.01.15.06.52.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:52:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 08:52:02 -0600
Date:   Wed, 15 Jan 2020 08:52:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: Add mt8173 elm
 and hana
Message-ID: <20200115145202.GA27021@bogus>
References: <20200110073730.213789-1-hsinyi@chromium.org>
 <20200110073730.213789-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110073730.213789-2-hsinyi@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 15:37:29 +0800, Hsin-Yi Wang wrote:
> Elm is Acer Chromebook R13. Hana is Lenovo Chromebook. Both uses mt8173
> SoC.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Changes in v2:
> - fix dtbs_check errors, use const instead of enum
> ---
>  .../devicetree/bindings/arm/mediatek.yaml     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
