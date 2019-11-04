Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69FF7EE3DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 16:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfKDPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 10:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfKDPcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:32:52 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25ECA2080F;
        Mon,  4 Nov 2019 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572881572;
        bh=hkH19nt9y9SaoU01HpS8NIZ2H9MH31Bv8tkTZlbHbPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vnh43AVaBsx8AFEejZriwjhRYdnEBMbh/bTK006mZot0xb4E9wL9Q+f4lkCkrtm1A
         e/D7jsxdk6Y35R06u9L7Bj1MaJ7nmJnHoAqnDfy7mqDJDQMJVVEbgu1NQ/bZjuqJuo
         CcTT7LmzbL4GHAXUPztm64W6v9UEFwHpjg/TCRn4=
Date:   Tue, 5 Nov 2019 00:32:49 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marta Rybczynska <mrybczyn@kalray.eu>,
        Charles Machalow <csm10495@gmail.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
Message-ID: <20191104153249.GC26808@redsun51.ssa.fujisawa.hgst.com>
References: <20191031050338.12700-1-csm10495@gmail.com>
 <20191031133921.GA4763@lst.de>
 <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu>
 <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com>
 <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu>
 <20191104150151.GA26808@redsun51.ssa.fujisawa.hgst.com>
 <20191104152916.GB17050@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104152916.GB17050@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:29:16PM +0100, Christoph Hellwig wrote:
> 
> Except on 32-bit x86, which does not have the padding.  Which is why
> the current layout is so bad, as it breaks 32-it x86 compat.

Yeah, fair enough.

Charles, let's just define an explicit padding rsvd field and use the
appropriate struct for the different ioctl's.
