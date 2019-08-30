Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E63A3659
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfH3MIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 08:08:05 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:53029 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbfH3MIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jLbS4wyC9BOXRvnGDvAgUlr1i1hEqcJjCnRO9VKhPUc=; b=BZpl7Ngf+S2Bt6nSPZh/NN47MA
        CZo5IsxbxOIhPbRsCUEEAISIcFO9gYpQ5qCF2AiymXNKNbg9f4BeKsz6+6KLYQKq45AcyCuJ7j/RF
        M5527anW5eKFWCBEMx8mneRbUBEDSHZ9Mv8tf0bfNx/s65Gf8jmvMppB5Vz72aX+gMlW/dLe+Jtqd
        eVM48GhC4uk0sljorhX3Hd1lR2p0z3iVFGOHDp7eSEO1Jwr3J7ADSYKNRYlwNJXcFGb2W4xx7XzL7
        loNQMDQEi191AvmYShK+cStNx6k99tOI6d/n/q70xO2q7cwuFZ0IddHyhhx21Tr+rMzZKchGnUeF7
        DkDDuyJQ==;
Received: from [193.209.96.43] (helo=[10.21.26.179])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1i3fh8-0001wS-Ip; Fri, 30 Aug 2019 15:07:58 +0300
Subject: Re: [PATCH 2/7] dt-bindings: arm-smmu: Add binding for nvidia,smmu-v2
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com,
        snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com,
        avanbrunt@nvidia.com, thomasz@nvidia.com, olof@lixom.net,
        jtukkinen@nvidia.com, mperttunen@nvidia.com
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-3-git-send-email-vdumpa@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <86cc6861-08e6-7e16-cb85-93de0aa62087@kapsi.fi>
Date:   Fri, 30 Aug 2019 15:07:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567118827-26358-3-git-send-email-vdumpa@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.8.2019 1.47, Krishna Reddy wrote:
> Add binding doc for Nvidia's smmu-v2 implementation.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 3133f3b..0de3759 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -17,6 +17,7 @@ conditions.
>                           "arm,mmu-401"
>                           "arm,mmu-500"
>                           "cavium,smmu-v2"
> +                        "nidia,smmu-v2"

nvidia

Mikko

>                           "qcom,smmu-v2"
>   
>                     depending on the particular implementation and/or the
> 
