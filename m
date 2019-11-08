Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2446CF3EF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 05:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfKHEeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 23:34:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKHEeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 23:34:17 -0500
Received: from localhost (unknown [106.200.194.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5A4B214DB;
        Fri,  8 Nov 2019 04:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573187656;
        bh=4B2SnwZXzTaWLQOUtTDx9eWlfS8vkBMKoHWOE/PahJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wSIakb2/1ko+CiiCkHi1ttysGhal65v5mgjLDtF9qU/ob4jB5gfxU6Z3lagM+vR/v
         Wwbg0HkIM/OuUwRNPSboaV4e2SJPuu4yUPd3JQMINlHJCvuRn5MKA1XMNhgnLpVaXE
         robUyeeS3cARWcg6F3Q4oV3sDBuvz8/E7Y+nYGdw=
Date:   Fri, 8 Nov 2019 10:04:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: rpmh: Reuse sdm845 clks for sm8150
Message-ID: <20191108043412.GX952516@vkoul-mobl>
References: <20191107214018.184105-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107214018.184105-1-sboyd@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-11-19, 13:40, Stephen Boyd wrote:
> The SM8150 list of clks is almost the same as the list for SDM845,
> except there isn't an IPA clk. Just point to the SDM845 clks from the
> SM8150 list for now so we can reduce the amount of struct bloat in this
> driver.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
