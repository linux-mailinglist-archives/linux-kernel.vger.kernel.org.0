Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E045412B0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 04:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfL0DYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 22:24:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfL0DYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 22:24:11 -0500
Received: from localhost (unknown [106.51.110.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BFD520409;
        Fri, 27 Dec 2019 03:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577417051;
        bh=s944JgsWuexqbpJwZEh5NgcpT/2p+A42CXGeuiQy7Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lniWdE+1CfCD2taWKoVqrH7HpvP+yRHnD2Ra7FVmywg6c0/03a2CJdRyCluQakkCv
         GLSWslgnSUy5vY2amMPTrS1yi0Nm8jJO3XKDLjIsOpjN44R8He1v3fBFQRQU6It3t1
         UBblyNrF0bExvBoZgH91fh6akV7tZfdj3g6R0I7o=
Date:   Fri, 27 Dec 2019 08:54:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/5] phy: qcom-qmp: Add SDM845 QMP and QHP PHYs
Message-ID: <20191227032406.GA3006@vkoul-mobl>
References: <20191107000917.1092409-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107000917.1092409-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-19, 16:09, Bjorn Andersson wrote:
> Add support for the two PCIe PHYs found in Qualcomm SDM845.

I have tested this on db845 so:
Tested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
