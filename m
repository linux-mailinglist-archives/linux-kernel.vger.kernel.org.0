Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F892191506
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgCXPj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbgCXPj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:39:58 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66AC120714;
        Tue, 24 Mar 2020 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064398;
        bh=lGDpf82yhyBXP69b0NUOoaMPEW8UINXiLyyIVIv/9FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TBo0lPlwRXSdnDE+bhsL/UEUB7N0XVLgFH+hU/exJbLOlwW6l8RIeGAHBtqAGTcn8
         oRxxbw7wAaDleMZ7E11AEcjWbIIcAik+kexPMsReTLLghhpUoZSXSPR06MU6lp5L61
         iJudVQ+Bw7LlGuG6kKh4jPNdimy8Zce/k4zMC+JQ=
Date:   Tue, 24 Mar 2020 08:39:57 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2] f2fs: compress: support zstd compress algorithm
Message-ID: <20200324153957.GA198420@google.com>
References: <20200303094602.50372-1-yuchao0@huawei.com>
 <1ee0c565-930b-2379-b22b-40ddca271de3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee0c565-930b-2379-b22b-40ddca271de3@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2020/3/3 17:46, Chao Yu wrote:
> > Add zstd compress algorithm support, use "compress_algorithm=zstd"
> > mountoption to enable it.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> > v2:
> > - avoid accessing invalid address
> > - introduce .{init,destroy}_{,de}compress_ctx callback functions.
> 
> I guess we merged related patches with wrong sequence as this patch
> depends on ("f2fs: compress: add .{init,destroy}_decompress_ctx callback").

Done.

> 
> Thanks,
