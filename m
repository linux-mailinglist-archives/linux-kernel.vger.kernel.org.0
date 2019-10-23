Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F25E10BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 06:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfJWEEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 00:04:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfJWEEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 00:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zfBwWqQHq61rOJZ2i70ZrVU4EchbEdFWfvJy9T3vcDE=; b=FRjbZ8W1cCHaQgjDR5o/7tfbP
        tM1M3sHWUmVyMhvKKlIizITSd3iRs+fCyzcJxvUcYCKiaax71eBOTHZaAM0lIbjn3EixvIlh/6Xot
        4TFYHMpEIu2Uo+OgMorYYQ+XYs3ON5xha9EXGXAzUW1EnH9W6HFA+h7Ls39wUaYrMf/wg8/+ACjAc
        fcDqyg+ojtjeV3V7vB48vL/cYWxf9WlVZw0vSzNXulHIVnnW9nO6HM4mVq0glBRQGeshVCnf/nrPD
        8g9t8tJNcjiWgicl8t7mTRYai8U91/KbjNfUl7+iZF6X/oIvuIlavntEaz3EWlGTS/uWEWmA+PKEe
        Ua9XLADcA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iN7sP-0006uX-8n; Wed, 23 Oct 2019 04:04:01 +0000
Date:   Tue, 22 Oct 2019 21:04:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dma coherent memory user-space maps
Message-ID: <20191023040401.GA26473@infradead.org>
References: <b811f66d-2353-23c6-c9fa-e279cdb0f832@shipmail.org>
 <0d59940d-1688-1b22-0524-c257c2401719@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d59940d-1688-1b22-0524-c257c2401719@shipmail.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, but travel for meeting.  I'll try to get to it as quick as
I can.
