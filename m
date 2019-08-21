Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA15D9860A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 22:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfHUUxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 16:53:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33744 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:53:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B9F3A14D7AA63;
        Wed, 21 Aug 2019 13:53:48 -0700 (PDT)
Date:   Wed, 21 Aug 2019 13:53:48 -0700 (PDT)
Message-Id: <20190821.135348.265984544498998282.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, khilman@baylibre.com,
        mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: use
 devm_platform_ioremap_resource() to simplify code
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190821135701.46780-1-yuehaibing@huawei.com>
References: <20190821135701.46780-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 21 Aug 2019 13:53:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 21 Aug 2019 21:57:01 +0800

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
