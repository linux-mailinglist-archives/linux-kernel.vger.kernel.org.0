Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625FA1514FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 05:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBDEfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 23:35:20 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11729 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgBDEfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 23:35:20 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e38f44f0000>; Mon, 03 Feb 2020 20:34:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 20:35:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 03 Feb 2020 20:35:19 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 04:35:14 +0000
CC:     <spujar@nvidia.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
Subject: Re: [PATCH v2 5/9] ASoC: tegra: add Tegra210 based AHUB driver
To:     Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-6-git-send-email-spujar@nvidia.com>
 <bd802f93-dd03-f39d-86e1-39f8571bbbb0@gmail.com>
 <f8c04460-f2ea-3102-4723-a5a75ba535ba@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <feea1f97-72fd-1746-3483-4a18fe8f5b32@nvidia.com>
Date:   Tue, 4 Feb 2020 10:05:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <f8c04460-f2ea-3102-4723-a5a75ba535ba@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580790863; bh=3oBPJ/AUZca843m18B8WtIQPG8BRCfQUcXnYum59kQQ=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=joInkOn0g+tkk/12jcZcONJOaVc+UjxiD6zLWWC1+izD2CemNeRLyRwsOsyzO4sBj
         2vBwK3oLvWZC7rUj4eokm2brZMDodeyeTi+8WHHqUYZ40BOnqI+NgoSzbsPCUELEUD
         AyPrm5KG/zO29dUiDLa6e4gz7Zorj2nH8RSueAcvI6kbLuQIyivfxd2yNPq1OWz6Hw
         MHxwazxPvV7EDe/a8bInVBFcx6CA6g+yJdLcMnRxcp0hQw4Qr1LyjgKhhitZ49t7Rt
         y8Oi/1js173RQOc5LnUve2on90+nISus48zLe+jQPhzNE9fNPh+ju/koapMbCOgIx8
         rTQQxUJoFdqlA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/2020 10:48 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 30.01.2020 20:09, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> 30.01.2020 13:33, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> ...
>>> +            dev_err(&pdev->dev, "failed to register component, err: %d=
\n",
>>                dev_err(dev, "can't register I2S component, err: %d\n", r=
et);
>
> Also, will be nice to have wording of the text messages to be consistent
> everywhere.

OK.

