Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2FA823C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 14:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfIDMRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 08:17:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfIDMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Obe2gdTCPdX2dJrsCnj1Gz4iZ+S/dsGP5h5Qib8KSnU=; b=uAFmJsF/nRbf4aZMB9yGxwJO5
        UUzPaS5YHSyHl6qr2zo6NOm/kOxGFV/rwokaS0z3i9y1efM2MVkGqNdIKUPyjqR3MdHOeaTrqCHKV
        VbH8SqGMWaJCRUD/TKXDurR/+g4RBZ3RPUcWLhO68TH5Qr1FariV9OCWyd9ERYMlS+4FAGxnO8SxX
        AvfmfHUeHiGXvV7iBCPiIWxA8glb5hOLpNX3KVYfUtzu9SUfQO1Eel2x7ovw4eooMTzB2n3jIxvLO
        ZJXVW0jmw6YWiMQ3WKRtYwFYquSsHv1//FkOT0kZu7CDa8dMu+CSVYBIaNgoAkj/sf+DBHQxY0bDP
        RWs87zYkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5UDy-0004No-6L; Wed, 04 Sep 2019 12:17:22 +0000
Date:   Wed, 4 Sep 2019 05:17:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dma api errors with swiotlb
Message-ID: <20190904121722.GA15601@infradead.org>
References: <e3c4b2e1-7518-ab0e-a6ce-3fae9903dac0@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c4b2e1-7518-ab0e-a6ce-3fae9903dac0@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call to dma_max_mapping_size() to limit the maximum I/O size solves
that problem.  With the latest kernel that should actually be done
automatically by the SCSI midlayer for you.
