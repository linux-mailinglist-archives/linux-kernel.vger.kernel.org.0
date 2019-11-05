Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D526F0826
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 22:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfKEVWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 16:22:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbfKEVWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:22:01 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D83C2084D;
        Tue,  5 Nov 2019 21:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572988921;
        bh=0kkkMfA630BywA1Wx1CXNtFvrebEU8gznAn98t3tvt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S86IXm5gYkYw9cMyKvFhdX6L+ZTBrdSQ+m9Tn/2v3u6zJ69MIZAPLRd/Gf+cGsG6F
         aKpxJJ8/vyGCHUXDphUTymlLYQ6+EhUZfMUoCwlLwrkZuRzlNlQwb6n0Dv7cN2tI1e
         2n+qRsza7NNO0P1LGA3W/mQQ66l8QVrLmwvJsBbU=
Date:   Wed, 6 Nov 2019 06:21:55 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Charles Machalow <csm10495@gmail.com>
Cc:     linux-nvme@lists.infradead.org, marta.rybczynska@kalray.eu,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64 to explicitly mark rsvd
Message-ID: <20191105212155.GA645@redsun51.ssa.fujisawa.hgst.com>
References: <20191105061510.22233-1-csm10495@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105061510.22233-1-csm10495@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied for the next 5.4-rc pull with an updated changelog to
indicate the "Fixes" commit since not having the padding does indeed
break the compat ioctl.
