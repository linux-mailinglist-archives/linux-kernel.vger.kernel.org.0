Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2CB7133B66
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 06:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgAHFsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 00:48:04 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16367 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgAHFsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:48:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e156d010004>; Tue, 07 Jan 2020 21:47:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 21:48:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 21:48:03 -0800
Received: from [10.2.162.131] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 05:48:01 +0000
Subject: Re: [PATCH v7 15/21] ASoC: tegra: Add fallback implementation for
 audio mclk
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <josephl@nvidia.com>, <daniel.lezcano@linaro.org>,
        <mmaddireddy@nvidia.com>, <markz@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-16-git-send-email-skomatineni@nvidia.com>
 <f3f550a2-c6e0-7a78-5c83-da3e54dab309@nvidia.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <d7ac6135-73b0-1087-dafa-4df558a06ef4@nvidia.com>
Date:   Tue, 7 Jan 2020 21:48:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f3f550a2-c6e0-7a78-5c83-da3e54dab309@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578462466; bh=GQANHx+miKT/xFnjFw8SvljwDPz/I599x2UEzMokWfU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=aV98CB9QC8JyG8GXOwpMrLT8QNkMj+OOzED8H0aLx8mhQ/t5Pu0P3tTV3m9Y7dMK9
         rc2TJY1XEY1p7bryNhFFUPUuZctVQD3Sl0U4YIxfKqqxnS7Mzil7c9j0TeRwbUdc6l
         eSlt1xo2llXnImNXhMu909wTqeDrAndEVyKVg5iNF9a349q2nD9A/OzRzLpX1CcabZ
         BTFLofk0Lkc0fYOuX90fm5hQzvfquwO1t9w4vjDx26I5jK7dy0CH8uG2cHqCCytxGN
         rW7yqReLPD7SST6+PpEvs1qwbeD9J9vLfHDZRkoWcIF/MWOusKNRGnN05jA+w1oaly
         tcYMJ/hLYqx/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/20 9:34 PM, Sameer Pujar wrote:
>
> On 1/8/2020 9:55 AM, Sowjanya Komatineni wrote:
>> mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
>> are moved to Tegra PMC driver with pmc as clock provider and using pmc
>> clock ids.
>>
>> New device tree uses clk_out_1 from pmc clock provider.
>>
>> So, this patch adds implementation for mclk fallback to extern1 when
>> retrieving mclk returns -ENOENT to be backward compatible of new device
>> tree with older kernels.
>>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>> =C2=A0 sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
>> =C2=A0 1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c=20
>> b/sound/soc/tegra/tegra_asoc_utils.c
>> index 9cfebef74870..9a5f81039491 100644
>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>> @@ -183,7 +183,16 @@ int tegra_asoc_utils_init(struct=20
>> tegra_asoc_utils_data *data,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->clk_cdev1 =3D devm_clk_get(dev, "mc=
lk");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(data->clk_cdev1)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev=
, "Can't retrieve clk cdev1\n");
>
> This error print can be moved inside below if, when this actually=20
> meant to be an error condition.
>
Want to show error even if mclk retrieval returns ENOENT to clearly=20
indicate mclk does not exist along with message of falling back to extern1.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(data->clk_cde=
v1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PTR_ERR(data->clk_cdev1)=
 !=3D -ENOENT)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn PTR_ERR(data->clk_cdev1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Fall back to extern1 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->clk_cdev1 =3D devm_clk=
_get(dev, "extern1");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(data->clk_cdev1))=
 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_=
err(data->dev, "Can't retrieve clk extern1\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn PTR_ERR(data->clk_cdev1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Falling =
back to extern1\n");
>
> This can be a info print?

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
