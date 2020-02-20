Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A97E166077
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 16:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgBTPIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 10:08:10 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5360 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgBTPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:08:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4ea0900000>; Thu, 20 Feb 2020 07:06:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 07:08:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 07:08:08 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 15:08:05 +0000
Subject: Re: [PATCH v3 05/10] ASoC: tegra: add Tegra210 based AHUB driver
To:     Sameer Pujar <spujar@nvidia.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-6-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d6fec11f-3ea3-6da3-ef96-74e4c0a9293e@nvidia.com>
Date:   Thu, 20 Feb 2020 15:08:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-6-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582211216; bh=1fxGENVsrBJEQvVJW5203qUrMQ2k8GsjvtaSYcWTupg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WdHPV5jTvllydXKqWZyKo6EBlgdMZLp/IxTT1Aw7dvi/Fg/i9tcpwbLRgqoFEOiDP
         Ot29wZkYEN0vaVQ//R+yG/uYnD8pOVwRnKpTf17zUsjqVxG/0y7/6WSbfQ1Duca6un
         sLTZS5OdHNpEkncE29OMirsLCGIRJmkGrVQCP76FGGVTHaLXrOupWqivrgoREHb8jw
         R80vLvNjtFaphj5Una7wahQJSgPioMKQ5MZl+hb2LSYQ+w8MKgZj14OBQSovO+3Sya
         dZhjFY/rlY4VugyU/hoFWgXEdNO9u6m3smwK8QwP0BvBdvDEXcahbITGg+Wvn5yLVK
         dYMm4GbS/9g+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/02/2020 06:34, Sameer Pujar wrote:
> The Audio Hub (AHUB) comprises a collection of hardware accelerators for
> audio pre/post-processing and a programmable full crossbar (XBAR) for
> routing audio data across these accelerators in time and in parallel.
> AHUB supports multiple interfaces to I2S, DSPK, DMIC etc., XBAR is a
> switch used to configure or modify audio routing between HW accelerators
> present inside AHUB.
> 
> This patch registers AHUB component with ASoC framework. The component
> driver exposes DAPM widgets, routes and kcontrols for the device. The DAI
> driver exposes AHUB interfaces, which can be used to connect different
> components in the ASoC layer. Currently the driver takes care of XBAR
> programming to allow audio data flow through various clients of the AHUB.
> Makefile and Kconfig support is added to allow to build the driver. The
> AHUB component can be enabled in the DT via below compatible bindings.
>   - "nvidia,tegra210-ahub" for Tegra210
>   - "nvidia,tegra186-ahub" for Tegra186 and Tegra194
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/tegra/Kconfig         |  10 +
>  sound/soc/tegra/Makefile        |   2 +
>  sound/soc/tegra/tegra210_ahub.c | 651 ++++++++++++++++++++++++++++++++++++++++
>  sound/soc/tegra/tegra210_ahub.h | 125 ++++++++
>  4 files changed, 788 insertions(+)
>  create mode 100644 sound/soc/tegra/tegra210_ahub.c
>  create mode 100644 sound/soc/tegra/tegra210_ahub.h


Aside from Randy's comment ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
