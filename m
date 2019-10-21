Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C0DE26B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 04:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfJUC6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 22:58:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44540 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfJUC6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bNOfY12uB6OkDBc28u8KRb7H8TREHQs/UdzmM7USCL8=; b=BFiBkZx3blmLyO3y9CNA6KIFq
        9H7LR1mKsQGhNxemJDsd9ZDbIScnH2r6lVktfbUI7kq+lyF+BiSl3m6F2wPFgfEd+Jda4A/Q2dRuG
        fgbEokmn7Pw7eFGXSsImVUjbWK3QSVkBDfuH3yJ+aD0g5LiRqdah/BiW3V40soROtdWmRIQsxaR2Q
        idkWLimE1tsXTZm3pdfx0ZFqJ9AxXjEZG3ipOelH8h0m3OHcwjQ0Y1GUHjPLGuqg29l6KxzzEmCGC
        WgZNvUg+2j5x8YGa7+CZ+RmnfPnvhf+Ic3mbLflsWKiT3XgvQI2VgtbssxipDTaxXVa267jq6E1t/
        tIZbIki5g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMNtc-0008SR-57; Mon, 21 Oct 2019 02:58:12 +0000
Date:   Sun, 20 Oct 2019 19:58:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] docs/core-api: memory-allocation: fix typo
Message-ID: <20191021025812.GB9214@bombadil.infradead.org>
References: <20191021003833.15704-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021003833.15704-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 01:38:32PM +1300, Chris Packham wrote:
> "on the safe size" should be "on the safe side".
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Yes, it should.  Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

If you like, you could do a follow-up patch mentioning the use
of struct_size(), array_size() and array3_size().  I think this
document is the right place for those.  Their kernel-doc is included in
driver-api/basics.rst, but referencing those functions in this document
would draw peoples' attention to them.

