Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA1CF889C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 07:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLGem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 01:34:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfKLGem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7abutWRYU4V+fTGc1DVabX8uQIzuLy5snVOekDPCHIU=; b=WqUT0oq3unGtVkO8rqqLMul8z
        iZQNGNzPLplyRJYINL1wNSRAK2a4cGphhV5IjgRDk417umk5HM76k3z4P+2Y9OionYyrpnrdV8mmo
        wslRIXvOmXfpQgK1GoKdK2dFETKDeeVlE5HvbGZAKm9D4/amRQoSHwLM9RR7fp4wO3ARVfrWo0m/a
        4tgbAfKmVk1S84qOEtPc9G2d+CM2NfdI0s+huhguQ2BN4kRpSkx9FfxIZvQkxVxCSvoxJfy2cv/tv
        8MVuq1LnJN0b5rsdNsrW6p+Zu8H3Pby1Da/PPmEZcMtOHYX8sjN3hEu73iSEPgvOg2MLOR+ubcFsq
        sjNOaywVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUPlA-0004Kl-FV; Tue, 12 Nov 2019 06:34:40 +0000
Date:   Mon, 11 Nov 2019 22:34:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] IIO fixes / Staging driver for 5.4-rc7
Message-ID: <20191112063440.GA15951@infradead.org>
References: <20191110154303.GA2867499@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110154303.GA2867499@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 04:43:03PM +0100, Greg KH wrote:
> The staging driver addition is the vboxsf filesystem, which is the
> VirtualBox guest shared folder code.  Hans has been trying to get
> filesystem reviewers to review the code for many months now, and
> Christoph finally said to just merge it in staging now as it is
> stand-alone and the filesystem people can review it easier over time
> that way.

No, this is absolutely contrary to what I said.  I told Hans to just
send it to Linus because it is ready and not staging fodder a atll.
