Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3681B0D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 09:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfEMHJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 03:09:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfEMHJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cy0TUN/UYoKBRHbCakileFYBci2k3WMghvEhPXpB9dE=; b=PZEEb890+3R3o7Tj0hw5OGOqD
        Nc+9VlVulxufzd2dcGgd7vgI4ABjj/dMAdLF5F/pDXjNu308qqb0U9r9DKVzFvQKBacciIYGwl30d
        2272ABQ5/N/daZDrjhkalP0fBgmYhRbuMNDhIvHpBXGXoZLBY7ZoGSCn1sbgZRU0ieBeD1sT0gYPo
        V2R3BqepaQGu6fTdYTsbUBQjJnj4rZPi1akhHk1+duz/vLFWUZ66LBo66DSr7e94rrjlCcwho64II
        ST9qWVYtMemu9MnCCcvKejU3uTxUZpmYTAsad+h9fWxhkAPbVlI5nM+IqA7XjAyOHIYfgwmX02lOX
        usiVtYYCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ556-0001pr-TY; Mon, 13 May 2019 07:09:04 +0000
Date:   Mon, 13 May 2019 00:09:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fdomain: Add ISA bus support
Message-ID: <20190513070904.GB31342@infradead.org>
References: <20190510212335.14728-1-linux@zary.sk>
 <20190510212335.14728-2-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510212335.14728-2-linux@zary.sk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 11:23:35PM +0200, Ondrej Zary wrote:
> Add Future Domain 16xx ISA SCSI support card support.
> 
> Tested on IBM 92F0330 card (18C50 chip) with v1.00 BIOS.

Where did you find that thing? :)

> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>

The driver looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
