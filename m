Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6DCC1831F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 03:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfEIBIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 21:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEIBIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:08:52 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA490214AF;
        Thu,  9 May 2019 01:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557364132;
        bh=HHCN83sJGDHkgbhIwvLbEuO8IR+0t6CVcaGE9uGJjDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IaP05M3Q6k+0AQL9Jydqk2Th4poz3rAb6ArQfCkdC8jxuZPBw7zXo7tBMfSQimbEz
         pRT6COESspTWRihN0k5gsRgwC7RCB//5FzGYVj4awAholMTc8c4595ExPq77QGIz60
         QANGzL5zh4jTDWXjL+j79alegmGvdRnsgT9/tqC8=
Date:   Wed, 8 May 2019 21:08:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Adrian Vladu <avladu@cloudbasesolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Subject: Re: [PATCH] hv: tools: fix KVP and VSS daemons exit code
Message-ID: <20190509010850.GR1747@sasha-vm>
References: <20190506165058.6749-1-avladu@cloudbasesolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190506165058.6749-1-avladu@cloudbasesolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:50:58PM +0000, Adrian Vladu wrote:
>HyperV KVP and VSS daemons should exit with 0 when the '--help'
>or '-h' flags are used.
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
