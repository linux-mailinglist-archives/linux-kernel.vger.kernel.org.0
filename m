Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0EE27B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 03:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392373AbfJXB2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 21:28:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXB2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jD3ajuwfKZdk4JSIR8vGZp1pzv/W899TJw8TAPz4bwc=; b=FRnJsusz6bSIUrtKJ6Rs+PrZV
        Rc9FtFgXZBhIBEkKenmtYBEcir5YrbubUFQYHHfE9g3/FDpXB9kOL6/1Qi8+G01C/rQSE9aNme4yY
        MMUmUSJI9YGor3UtogZ2VQcLoi4/y5H1P5oNsd1xDjt91IesmvUN7ADATTlrxwp1MnQEiafDwsv/F
        LNFly8yS18xzdzOqDRwRCYir98guFp+/o/79TgnadysBMIB1udT59a6QXxt800zUNNA2746hL0T3H
        zlkrcgr/f2f6i3eHFi9uPvDkQD/xlBuvSX6NWogmJNaCUZQqy6hFOUK7QAqJowy+BBJYut9znFEQU
        jrUOn0UQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNRvl-0000AW-1o; Thu, 24 Oct 2019 01:28:49 +0000
Date:   Wed, 23 Oct 2019 18:28:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] habanalabs: support kernel memory mapping
Message-ID: <20191024012849.GB32358@infradead.org>
References: <20191022063028.9030-1-oshpigelman@habana.ai>
 <20191023092035.GA12222@infradead.org>
 <AM6PR0202MB3382B554A4C7F0F677A804D7B86B0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR0202MB3382B554A4C7F0F677A804D7B86B0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 01:39:41PM +0000, Omer Shpigelman wrote:
> I'm not sure I understand. Can you please pin point the problematic line?

Every line you touch addr field basically.  If you have a kernel
address please store it in an actual C pointer type, not in a u64
to ensure that the compiler can do proper type checking.
