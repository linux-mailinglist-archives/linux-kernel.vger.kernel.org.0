Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4FC190309
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 01:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCXAp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 20:45:27 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33284 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgCXAp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:45:27 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48mXbQ0SMCz1rx8j;
        Tue, 24 Mar 2020 01:45:21 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48mXbP5Kc0z1qyF7;
        Tue, 24 Mar 2020 01:45:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id gC2vLJWwutXk; Tue, 24 Mar 2020 01:45:20 +0100 (CET)
X-Auth-Info: ksnt2ePpOv6cIiM3lWTVPmpZXSXFGTDMcknb+ITNjK0=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 24 Mar 2020 01:45:20 +0100 (CET)
Subject: Re: [00/12] add STM32 FMC2 controller drivers
To:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        tony@atomide.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <1584975532-8038-1-git-send-email-christophe.kerello@st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <466cf542-7575-d791-da81-da32c0919505@denx.de>
Date:   Tue, 24 Mar 2020 01:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584975532-8038-1-git-send-email-christophe.kerello@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/20 3:58 PM, Christophe Kerello wrote:
> The FMC2 functional block makes the interface with: synchronous and
> asynchronous static devices (such as PSNOR, PSRAM or other memory-mapped
> peripherals) and NAND flash memories.
> Its main purposes are:
>   - to translate AXI transactions into the appropriate external device
>     protocol
>   - to meet the access time requirements of the external devices
> All external devices share the addresses, data and control signals with the
> controller. Each external device is accessed by means of a unique Chip
> Select. The FMC2 performs only one access at a time to an external device.
> 
> Christophe Kerello (12):
>   dt-bindings: mfd: stm32-fmc2: add STM32 FMC2 controller documentation
>   mfd: stm32-fmc2: add STM32 FMC2 controller driver
>   bus: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver
>   mtd: rawnand: stm32_fmc2: manage all errors cases at probe time
>   mtd: rawnand: stm32_fmc2: remove useless inline comments
>   mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS for timeouts
>   mtd: rawnand: stm32_fmc2: cleanup
>   mtd: rawnand: stm32_fmc2: use FIELD_PREP/FIELD_GET macros
>   mtd: rawnand: stm32_fmc2: move all registers
>   mtd: rawnand: stm32_fmc2: use regmap APIs
>   mtd: rawnand: stm32_fmc2: use stm32_fmc2 structure in nfc controller
>   mtd: rawnand: stm32_fmc2: add new MP1 compatible string

This doesn't apply to either next or 5.6-rc7, do you have a tree
somewhere with those patches applied ?
