Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7647B176385
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 20:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgCBTLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 14:11:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34888 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgCBTLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:11:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 022JBITB103346;
        Mon, 2 Mar 2020 13:11:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583176278;
        bh=z3LjQa/lvG261qfCTQihr6ev+Qd8qiUMnEg6eeQxmsU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=k25nYhd+7xWeA1M1Z5smp2xB+4qiEzgiU2lswKgrJOQb/8TGzJz8czFUsIACw7jbH
         I6L76g3DAImkDdLGg59PwDFsfW1VFh46/xE9V9DvCiSl8ZUcZrqHaUJvRFxaXy4e/5
         MJOPZGl2EgR/aowt8t1YPBw6gHLQ3rP+aQ1Jdr1Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 022JBIoG071859
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Mar 2020 13:11:18 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Mar
 2020 13:11:18 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Mar 2020 13:11:18 -0600
Received: from [10.250.132.245] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 022JBFGB065948;
        Mon, 2 Mar 2020 13:11:16 -0600
Subject: Re: [PATCH 0/3] Update phy configuration for AM65x
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <robh+dt@kernel.org>
References: <20200108150920.14547-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <7edb2c28-11fd-e282-a8d7-e61aad8cace2@ti.com>
Date:   Tue, 3 Mar 2020 00:41:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200108150920.14547-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uffe,

On 08/01/20 8:39 pm, Faiz Abbas wrote:
> The following patches update phy configurations for AM65x as given in
> the latest data manual.
> 
> The patches depend on my fixes series posted just before this:
> https://patchwork.kernel.org/project/linux-mmc/list/?series=225425
> 
> Device tree patch updating the actual otap values will be posted
> separately.
> 
> Tested with Am65x-evm and J721e-evm.
> 
> Faiz Abbas (3):
>   dt-bindings: mmc: sdhci-am654: Update Output tap delay binding
>   mmc: sdhci_am654: Update OTAPDLY writes
>   mmc: sdhci_am654: Enable DLL only for some speed modes
> 
>  .../devicetree/bindings/mmc/sdhci-am654.txt   |  21 +-
>  drivers/mmc/host/sdhci_am654.c                | 247 ++++++++++++------
>  include/linux/mmc/host.h                      |   2 +
>  3 files changed, 192 insertions(+), 78 deletions(-)
> 

Can you help merge this?

Thanks,
Faiz
