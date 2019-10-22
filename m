Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B349AE0479
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 15:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfJVNFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 09:05:54 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38102 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbfJVNFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:05:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9MD5pLL077666;
        Tue, 22 Oct 2019 08:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571749551;
        bh=ieLw0UD3TwNfGq2EsjYftsH6Edo4lDfAf/yj37BOjiM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mF1FIsNT5Ib6vj+r6XWhXX5qijsZY1qb0QuDBC0F7UNZXcoR3lOZTbq7NCEnyYQp/
         so66Gene4HaEpi/nOoDbTfQgjk5w6cm99uMjvmmZFEzbWBWg85hCG1kiqCkWIltIKa
         LfQ2ZwltgNSTBxTZCYQsNv5hTBZC30uaSh2lUJ2w=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9MD5pqn086771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 08:05:51 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 22
 Oct 2019 08:05:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 22 Oct 2019 08:05:39 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9MD5XhK075548;
        Tue, 22 Oct 2019 08:05:33 -0500
Subject: Re: [PATCH 00/13] PHY: Add support for SERDES in TI's J721E SoC
To:     Kishon Vijay Abraham I <kishon@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20191016113117.12370-1-kishon@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <6bc9645d-28df-bcef-e94d-498516fc4ac2@ti.com>
Date:   Tue, 22 Oct 2019 16:05:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016113117.12370-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/10/2019 14:31, Kishon Vijay Abraham I wrote:
> TI's J721E SoC uses Cadence Sierra SERDES for USB, PCIe and SGMII.
> TI has a wrapper named WIZ to control input signals to Sierra and
> Torrent SERDES.
> 
> This patch series:
>   1) Add support to WIZ module present in TI's J721E SoC
>   2) Adapt Cadence Sierra PHY driver to be used for J721E SoC
> 
> Anil Varughese (1):
>    phy: cadence: Sierra: Configure both lane cdb and common cdb registers
>      for external SSC
> 
> Kishon Vijay Abraham I (12):
>    dt-bindings: phy: Sierra: Add bindings for Sierra in TI's J721E
>    phy: cadence: Sierra: Make "phy_clk" and "sierra_apb" optional
>      resources
>    phy: cadence: Sierra: Use "regmap" for read and write to Sierra
>      registers
>    phy: cadence: Sierra: Add support for SERDES_16G used in J721E SoC
>    phy: cadence: Sierra: Make cdns_sierra_phy_init() as phy_ops
>    phy: cadence: Sierra: Modify register macro names to be in sync with
>      Sierra user guide
>    phy: cadence: Sierra: Get reset control "array" for each link
>    phy: cadence: Sierra: Check for PLL lock during PHY power on
>    phy: cadence: Sierra: Change MAX_LANES of Sierra to 16
>    phy: cadence: Sierra: Set cmn_refclk/cmn_refclk1 frequency to 25MHz
>    dt-bindings: phy: Document WIZ (SERDES wrapper) bindings
>    phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC

Tested USB3.0 on J7ES using this series.

Tested-by: Roger Quadros <rogerq@ti.com>

> 
>   .../bindings/phy/phy-cadence-sierra.txt       |  13 +-
>   .../bindings/phy/ti,phy-j721e-wiz.txt         |  95 ++
>   drivers/phy/cadence/phy-cadence-sierra.c      | 695 +++++++++++---
>   drivers/phy/ti/Kconfig                        |  15 +
>   drivers/phy/ti/Makefile                       |   1 +
>   drivers/phy/ti/phy-j721e-wiz.c                | 904 ++++++++++++++++++
>   6 files changed, 1585 insertions(+), 138 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
>   create mode 100644 drivers/phy/ti/phy-j721e-wiz.c
> 

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
