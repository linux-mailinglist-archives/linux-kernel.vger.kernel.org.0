Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A38E159230
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 15:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgBKOri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 09:47:38 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6314 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727511AbgBKOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:47:37 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BEhxtu031462;
        Tue, 11 Feb 2020 15:47:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=4odbdGyV5/+IAGjp9TQdg9pxlhPR5wtUbp4gIY0SBm8=;
 b=1MOS4e4ncw/kDNfQr8/cX7QpgjwFPMEHqD2n3akoDcWaw3SXXs3MZlNcqXzns/nILAQ0
 AYy55VbzeWSDdblBzLcEYdCK4g+MV2mz9OkgqpDZvNMBjsKn+My9En+6sPGXgWrHu2HX
 ksFM9bc3uNFzNl1b5zGh3gk3h4HtRsaI3tcmBuzZjC2uDwMFnVt85Fx4Tmd2/nxTT2gA
 6MnF8IUPsr2umgdYLnc0uzdxu2rwNR3LY/Jyc/uVsz3NXbl4hD1ji9uThAIF45emp3Le
 YiK1M1ljfRs+ohhH4uYRuu/UT0XVfA2pknjw0LAAbPdIaKbjX9TDtqVd/B/f4MQqcKbB IA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1uvddt9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 15:47:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2BDBC10002A;
        Tue, 11 Feb 2020 15:47:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1AC802BD409;
        Tue, 11 Feb 2020 15:47:27 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.48) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb
 2020 15:47:26 +0100
Subject: Re: [PATCH V2 0/9] mmc: mmci: sdmmc: add sdr104 support
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200128090636.13689-1-ludovic.barre@st.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <0d4a3df8-fd1a-4839-116c-149f9e478f42@st.com>
Date:   Tue, 11 Feb 2020 15:47:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200128090636.13689-1-ludovic.barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_04:2020-02-10,2020-02-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

Just a "gentleman ping" on this series
https://patchwork.kernel.org/project/linux-mmc/list/?series=234011

Regards
Ludo

Le 1/28/20 à 10:06 AM, Ludovic Barre a écrit :
> To support the sdr104 mode, sdmmc variant needs:
> -Hardware delay block support for sdmmc variant
>   with tuning procedure
> -Voltage switch callbacks
> -sdmmc revision 2.0
> 
> V2:
> -regroup host->mmc_ops & mmc->ops assignment
> -add timeout define
> -rename prep_volt_switch to pre_sig_volt_switch
> -rename volt_switch to post_sig_volt_switch
> -add 'why' comment for "mmc: mmci: add volt_switch callbacks"
> 
> Ludovic Barre (9):
>    mmc: mmci: sdmmc: replace sg_dma_xxx macros
>    mmc: mmci: sdmmc: rename sdmmc_priv struct to sdmmc_idma
>    mmc: mmci: add a reference at mmc_host_ops in mmci struct
>    mmc: mmci: add private pointer for variant
>    dt-bindings: mmc: mmci: add delay block base register for sdmmc
>    mmc: mmci: sdmmc: add execute tuning with delay block
>    mmc: mmci: add volt_switch callbacks
>    mmc: mmci: sdmmc: add voltage switch functions
>    mmc: mmci: add sdmmc variant revision 2.0
> 
>   .../devicetree/bindings/mmc/mmci.txt          |   2 +
>   drivers/mmc/host/mmci.c                       |  42 +++-
>   drivers/mmc/host/mmci.h                       |   8 +
>   drivers/mmc/host/mmci_stm32_sdmmc.c           | 204 +++++++++++++++++-
>   4 files changed, 248 insertions(+), 8 deletions(-)
> 
