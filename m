Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C31B1257B0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 00:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLRXYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 18:24:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36134 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfLRXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:24:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id w1so4569060otg.3;
        Wed, 18 Dec 2019 15:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ETUxOpgQ7F0pLVm01ESXed5S9gdzK8r7fuHrkhEgfqk=;
        b=o5/kvao9waI4YPTxXhoocFJ5jHWlk+Xy7x7zBHoVSNOGea73bgdfahw+oGkHpnhmlm
         6qoFzJY48EON0Ms9hFirGCYo/60S4LLPw5pZ4TMT4cbWG7+Tcse93tGo+fJATmp/czlp
         kGc4mNEjMxEZgXQoEzz4GECpS8RBCZnnZAq5o65o37w7oh4hZA/ROdO5++yy3mw9LdJD
         phMCLbi7PMHlJ2PxAI0do/6Gk6vzbbKhjRuf1V1hu81jUOwK63CzmaC2obQQs0WPIA2a
         94IRE2y6duLXKcc/7GfPu3JMLn9oRIawmgbFleWmghcIyVmMsBi/Va9ssTQBJhgPrtj5
         K6yw==
X-Gm-Message-State: APjAAAX91fSNwq8f5kWzQE0NmDs5UEHCutGYKRXkuviQDoNEXf2rjHHP
        6TO1Rj5EdHg1hXPfdw21aw==
X-Google-Smtp-Source: APXvYqyPUOqnsp5Fq28ymg4AaPaisJ5viFWYBbVO4iBHtqnXMTnenHiKbGkM5hdcGBGGYAVNQXwpKQ==
X-Received: by 2002:a05:6830:1208:: with SMTP id r8mr5372896otp.105.1576711447577;
        Wed, 18 Dec 2019 15:24:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j130sm1339912oia.34.2019.12.18.15.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 15:24:06 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:24:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mark.rutland@arm.com, kishon@ti.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch V2 02/18] dt-bindings: usb: Add NVIDIA Tegra XUSB device
 mode controller binding
Message-ID: <20191218232406.GA19924@bogus>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-3-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576660591-10383-3-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 02:46:15PM +0530, Nagarjuna Kristam wrote:
> Add device-tree binding documentation for the XUSB device mode controller
> present on Tegra210 and Tegra186 SoC. This controller supports the USB 3.0
> specification.
> 
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - used enum instead of oneOf and const.
>  - Moved reg, reg-names, clocks, clock-names to property section from allOf.
>  - Limited allOf to min and max items based on soc.
>  - Updated description for power-domains.
>  - Added V1 reference
> ---
> V1
>  - This document is yaml version of [1], with difference of usb-role-switch
>    removal.
> [1] https://patchwork.kernel.org/patch/11156253/ 
> ---
>  .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 190 +++++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
