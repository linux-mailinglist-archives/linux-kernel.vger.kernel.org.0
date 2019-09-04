Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E20A7F28
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfIDJT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 05:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfIDJT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:19:27 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCFA42339E;
        Wed,  4 Sep 2019 09:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567588766;
        bh=S1pPR8kYm3GgjDH2PeJWltdjDyxvR4gNZq7jBCIvKQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmmS6wZvYfKMmgaTxNubGIBTcdAqZIc+U2r48nAwkvDaUfnbfEMo4HCgwVWrGjUtX
         HgGMIPik2CYApB0pkyuFrXtQrkoQPk/NtkEpWl6IVf6bsJ28JPP85sUfey+7lW3hI5
         gQq4TS8/HpTZYpXZt3ekDoEJeXJGqsBvgQ9xGr60=
Date:   Wed, 4 Sep 2019 14:48:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, spapothi@codeaurora.org,
        bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/4] soundwire: core: add device tree support for
 slave devices
Message-ID: <20190904091816.GN2672@vkoul-mobl>
References: <20190829163514.11221-1-srinivas.kandagatla@linaro.org>
 <20190829163514.11221-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829163514.11221-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-19, 17:35, Srinivas Kandagatla wrote:
> This patch adds support to parsing device tree based
> SoundWire slave devices.

Applied, thanks

-- 
~Vinod
