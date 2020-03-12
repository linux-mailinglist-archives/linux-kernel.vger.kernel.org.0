Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E481C182B21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 09:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCLIY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 04:24:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCLIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pi5g+s1ujX3UxcqTGfbFflaOLd+J6XOmhrwuu7dcsb8=; b=S0efvC8TFOTstC5NeU1RYxqqm4
        J5dsqN5Ws6PsXgBt0BG5lxT08pqRvh7NFrr3n/96KlskzfbXRtuxXyijpt0xXzj+bMsQXjGn1MKSZ
        mCMuf6F09XkFXMD0ijuOHSnRJ87a+9Yz8+/nFeQV/mh34/spIfVss3V/j1J3isYqTK3rrJpZMQ1Nm
        gxfS9XgufgFBXasKiUHT+YLoi37McsvjirgaWguEqMyHFmsnL5bCBd2rcS/3XtO9YySs2NNeSwRnC
        /ArmyLisTnyv0uSS9w7FI3bFhDPPwKZV8Cb7NaDnQwot6nCOMWoKWsyOcTtg/xuiJtFio+l9BpD14
        ZmQVczdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCJ8l-0000M5-33; Thu, 12 Mar 2020 08:24:27 +0000
Date:   Thu, 12 Mar 2020 01:24:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ram Muthiah <rammuthiah@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] Inline contents of BLK_MQ_VIRTIO config
Message-ID: <20200312082427.GA32229@infradead.org>
References: <20200311235653.141701-1-rammuthiah@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311235653.141701-1-rammuthiah@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 04:56:53PM -0700, Ram Muthiah wrote:
> The config contains one symbol and is a dep of only two configs.
> Inlined this symbol so that it's built in by the two configs
> which need it and deleted the config.

So now we build the code twice instead of once.  Nevermind that you
have dropped the copyright noticed.  What is the point?

