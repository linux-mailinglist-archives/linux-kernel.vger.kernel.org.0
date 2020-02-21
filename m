Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792AA167FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 15:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgBUOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 09:09:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgBUOJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:09:39 -0500
Received: from localhost (unknown [49.207.58.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E99FA2073A;
        Fri, 21 Feb 2020 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582294178;
        bh=G0c3RZciV0M/UMF9TNEk6eDfPc3bbShhZ40xtyiPBCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcN5WgFIIDwPVo4ucx8qxxjjsOpjHOHwH7h6xnwAPDK1JTzY/9MImaWmLADfei+eL
         LF+ttlPSYhEXTYno+jWWyD622z3/HsQiJCr5ZVRFwREFHU2NnSrSpkCxw7SI9sFqQL
         Dae1WS9wzKR2d42NMG70jnXxvydBPNnNPU3qlkQM=
Date:   Fri, 21 Feb 2020 19:39:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] phy: qcom: qmp: Use power_on/off ops for PCIe
Message-ID: <20200221140933.GM2618@vkoul-mobl>
References: <20200106081142.3192204-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106081142.3192204-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-01-20, 00:11, Bjorn Andersson wrote:
> The PCIe PHY initialization requires the attached device to be present,
> which is primarily achieved by the PCI controller driver.  So move the
> logic from init/exit to power_on/power_off.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
