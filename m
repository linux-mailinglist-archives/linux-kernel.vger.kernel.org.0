Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0FE183EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 02:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgCMBXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 21:23:53 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19182 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMBXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:23:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e6ae04b0000>; Thu, 12 Mar 2020 18:22:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 12 Mar 2020 18:23:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 12 Mar 2020 18:23:52 -0700
Received: from [10.2.175.141] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Mar
 2020 01:23:51 +0000
Subject: Re: [PATCH v1] arm64: tegra: Add reset-cells to mc
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <nkristam@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1583899366-1588-1-git-send-email-skomatineni@nvidia.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <407b5d00-4a79-d063-31a2-74e3154625f6@nvidia.com>
Date:   Thu, 12 Mar 2020 18:23:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583899366-1588-1-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584062539; bh=wFF0EY/KkghrKnMj1Y0t6Hft+dTR9Y4gWUc7Q+aNSFU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=SQbL/xPi9OslwaGdzRO5hgYJcjCHAllPHjK0/ojl0gUeLYaSkCjwFWZTbSHxvblIP
         U5ftV8XSwKkGDGIlmEOBRq1Ua797+B2Xi4z2u/j9ZGW83BaKDsoLJ2qJOCiw9OoPoQ
         yqgOJYVJCVwz4nCI/7pY9RmS0C0UddX7iln3TA7zGIP+sBwC4wcRkG/Fbehd47tYsi
         gGd3amqEwD3rTAIkxBi/sZQEfHFhxBRdyUgj8OVDJJsqfs/k2EbnZWlhTYJv70aL7g
         kXWQJAbnM+ucFU/dLm1khEwSEk9g3KiQxxrZ5jmazYBuHhnoBGXNAYsE0F3DysW5bV
         6wJpr0zvs8jtA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Sorry for inconvenience.

Please ignore this patch. This is needed before next updated patches for 
tegra video as they use mc reset on Tegra210.

So will include this patch as part of tegra-video patch series so 
dependencies are taken care.

Thanks

Sowjanya

On 3/10/20 9:02 PM, Sowjanya Komatineni wrote:
> External email: Use caution opening links or attachments
>
>
> Tegra210 device tree is missing reset-cells property for mc node.
>
> This patch fixes it.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra210.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> index 66dd1df..9241163 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -935,6 +935,7 @@
>                  interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>
>                  #iommu-cells = <1>;
> +               #reset-cells = <1>;
>          };
>
>          sata@70020000 {
> --
> 2.7.4
>
