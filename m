Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367DFA7F68
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfIDJa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 05:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbfIDJa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:30:28 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B0A21670;
        Wed,  4 Sep 2019 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567589427;
        bh=5A9Vcn8Wbx2ac8gtPDwlVez5G3AlEtznhc3EeNKZ6O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBDyIX2wKFW6B58iWnY1iy0cRV6uBL01HgiPIHX0t6i8G3XRVAAb30f1bh49zpAcB
         wEaxqXnAwVTxGemhdTiP7xFxc02yySQRGiKDK2Kszh7AhQrimP/xcT5M/EVj5yIEo3
         MPYVir2eVWMSrBN66PAli4U3LfSMv5shj73SFFQI=
Date:   Wed, 4 Sep 2019 14:59:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
Subject: Re: [PATCH v2 2/5] soundwire: stream: make stream name a const
 pointer
Message-ID: <20190904092919.GP2672@vkoul-mobl>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813083550.5877-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-19, 09:35, Srinivas Kandagatla wrote:
> Make stream name const pointer

Good catch,  Applied, thanks

-- 
~Vinod
