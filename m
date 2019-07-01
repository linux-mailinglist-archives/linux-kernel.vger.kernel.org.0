Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2F6112CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 07:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfEBF6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 01:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfEBF6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:58:22 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940062081C;
        Thu,  2 May 2019 05:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556776701;
        bh=VVm1IT8lHYMG8BSjGXWoh+S3MS5Pme6RzDKRC1QF4oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+GHLooM/7U0+4+BYVcIrg/iHD0dyRhMeGbsrKlw6pPL9J+QrCmvb5Ugs8aXB2x/5
         awBmo6gka8d4mBFIBk3ZCiRWiNUyqVVBVxMxhNzjkE66f60oSN6N+YIZpONOkVLYF3
         Jq4AhjcL5a4NnaJJwGtxyKkR07dvL+9EOy88+ZmE=
Date:   Thu, 2 May 2019 11:28:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v4 00/22] soundwire: code cleanup
Message-ID: <20190502055812.GG3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> SoundWire support will be provided in Linux with the Sound Open
> Firmware (SOF) on Intel platforms. Before we start adding the missing
> pieces, there are a number of warnings and style issues reported by
> checkpatch, cppcheck and Coccinelle that need to be cleaned-up.

Applied all expect 2, 3, 6 and 22

Thanks
-- 
~Vinod
