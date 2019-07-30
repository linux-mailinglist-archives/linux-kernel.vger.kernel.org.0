Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC3AA7B5AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 00:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbfG3WZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 18:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbfG3WZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:25:02 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCD4E206E0;
        Tue, 30 Jul 2019 22:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564525502;
        bh=EZ44k/sCpc+uxAS9CQv8KcvzYhn09rJBtgAtVNMkk40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jp4Aj20Ud3njZVz1FOAP+UNWkp08Kn3jyCe9wmROw2B6EdJBaIjluEyIjUuyN5v9D
         D1+Hdz2yBORvZO3KRWhJpUy20z5rOLNXDNChSIv8lnkTQ6KdSYB8z+oO0T8Cik8RKS
         NnNn+nis5chOqUYQUhhWz2Fkbqzk8Ju0MLHtrlEw=
Date:   Tue, 30 Jul 2019 18:25:00 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Adrian Vladu <avladu@cloudbasesolutions.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Subject: Re: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for
 lsvmbus
Message-ID: <20190730222500.GG29162@sasha-vm>
References: <20190506172737.18122-1-avladu@cloudbasesolutions.com>
 <20190506173331.18906-1-avladu@cloudbasesolutions.com>
 <PU1P153MB016957AD2B1C356FA1BFB1A8BF310@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190509010941.GT1747@sasha-vm>
 <F5008595B06C564AB347C30B4FDE4BC559697F85@CBSEX1.cloudbase.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <F5008595B06C564AB347C30B4FDE4BC559697F85@CBSEX1.cloudbase.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 02:53:35PM +0000, Adrian Vladu wrote:
>Hello,
>
>There were two patches you have queued for hyperv-fixes a while ago, but I don't see them anymore in the hyperv-fixes tree:
>https://lore.kernel.org/patchwork/patch/1070848/
>https://lore.kernel.org/patchwork/patch/1070806/
>
>I have checked them and they can still be applied successfully on the latest master tree.
>Please let me know if I need to make some amends to get them merged.

They must have got lost when we dealt with the clocksource mess. I'll
re-queue these, thanks!

--
Thanks,
Sasha
