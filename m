Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BED14EB06
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 11:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgAaKkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 05:40:24 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgAaKkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:40:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 488DJL5K8vz9sSP;
        Fri, 31 Jan 2020 21:40:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1580467218;
        bh=NpDbQvQ6a1gVpANE05CiJvGMkImEaOzhU76R7vlCsyM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Rti07r8wsEq5Cv2Oll1n+7tK55v/64zehHtajY+SpSJnAkMxgHfhLqY+HDr6VcpLS
         8GUBZZQXne2NFCa3W1n7IiZmmOPgIg1pd2M/blkyTI8Drd/eqCh0OexnldSyBoWAeH
         SJlXSM1rAlKhvco/yHCRsXmQq6yVKFauxYBbAHMMLqNS0Ya/PRDsOjD6NK1Kr8vPyF
         xtknii2clX37PXMKAssNCLCMwtOLIEtWdt13YEyv5xtr+7YZLUQixrz65ZPrFIyE0D
         VN3gvs/J48BWFxpdiIRy0/b6Xl8CfC6mfgW9uxqAnAMn9tm/u8+uw0rR6mHly/IxeY
         9HsYkw22XFWSg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, ulf.hansson@linaro.org,
        chzigotzky@xenosoft.de, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] of: Add OF_DMA_DEFAULT_COHERENT & select it on powerpc
In-Reply-To: <20200128142646.GA17341@bogus>
References: <20200126115247.13402-1-mpe@ellerman.id.au> <20200128142646.GA17341@bogus>
Date:   Fri, 31 Jan 2020 21:40:17 +1100
Message-ID: <87k157gb8u.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> On Sun, 26 Jan 2020 22:52:47 +1100, Michael Ellerman wrote:
>> There's an OF helper called of_dma_is_coherent(), which checks if a
>> device has a "dma-coherent" property to see if the device is coherent
>> for DMA.
>> 
>> But on some platforms devices are coherent by default, and on some
>> platforms it's not possible to update existing device trees to add the
>> "dma-coherent" property.
>> 
>> So add a Kconfig symbol to allow arch code to tell
>> of_dma_is_coherent() that devices are coherent by default, regardless
>> of the presence of the property.
>> 
>> Select that symbol on powerpc when NOT_COHERENT_CACHE is not set, ie.
>> when the system has a coherent cache.
>> 
>> Fixes: 92ea637edea3 ("of: introduce of_dma_is_coherent() helper")
>> Cc: stable@vger.kernel.org # v3.16+
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/Kconfig | 1 +
>>  drivers/of/Kconfig   | 4 ++++
>>  drivers/of/address.c | 6 +++++-
>>  3 files changed, 10 insertions(+), 1 deletion(-)
>> 
>
> Applied, thanks.

Thanks.

cheers
