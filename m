Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4EEA1846FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 13:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCMMhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 08:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgCMMhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:37:10 -0400
Received: from localhost (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858A020724;
        Fri, 13 Mar 2020 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584103030;
        bh=w8p6PegwkaiexLvGM8j+H10uPvnpcBYb5kISfOONg3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2ag2hnxG8xh2WxxVoB1IhUhlMl1LBPWP2kHHkdWY0XvkpYi/hIArEpxgjM/vF4Q8
         0UXPhYtAW/nS+gaZaBfNShrr8+DVvZesS9uNoVQJhA32//kuOhsys8q5RciplTgqS4
         WM2XGt+a060gPSiCXjN5OSZyB7C4u49AX/AYrhT0=
Date:   Fri, 13 Mar 2020 18:07:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] soundwire: stream: use sdw_write instead of update
Message-ID: <20200313123705.GI4885@vkoul-mobl>
References: <20200312100105.5293-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312100105.5293-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-03-20, 10:01, Srinivas Kandagatla wrote:
> There is no point in using update for registers with write mask
> as 0xFF, this adds unecessary traffic on the bus.
s/unecessary/unnecessary

> Just use sdw_write directly.

Applied with typo fixed, thanks
-- 
~Vinod
