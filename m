Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7BB18320
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 03:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfEIBJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 21:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEIBJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:09:04 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AADC214AF;
        Thu,  9 May 2019 01:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557364144;
        bh=pDCafj+bjsCyznGwymYj00MFrCFLI6De8nHmj1P8HIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJpeF8JZVxPVoOS1Lyr1pFtAjPAbYyGJfNKOSpXYhToH+mHyUIMB31XntDoAaCYLA
         4b9kJgqwVmrx2fvPXN2UkIuBjTjymhrhrVJQLmO2/aKIQztxHTMi5nZHmNADrbxm8v
         F1L7amPQLn8ajeMquFUdJzAdeZ1LoZCNQkyn/jbg=
Date:   Wed, 8 May 2019 21:09:03 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Adrian Vladu <avladu@cloudbasesolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Subject: Re: [PATCH] hv: tools: fix typos in toolchain
Message-ID: <20190509010903.GS1747@sasha-vm>
References: <20190506165124.6865-1-avladu@cloudbasesolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190506165124.6865-1-avladu@cloudbasesolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:51:24PM +0000, Adrian Vladu wrote:
>Fix typos in the HyperV toolchain.
>
>Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>
>
>Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Cc: Stephen Hemminger <sthemmin@microsoft.com>
>Cc: Sasha Levin <sashal@kernel.org>
>Cc: Alessandro Pilotti <apilotti@cloudbasesolutions.com>

Queued for hyperv-fixes, thanks!

--
Thanks,
Sasha
