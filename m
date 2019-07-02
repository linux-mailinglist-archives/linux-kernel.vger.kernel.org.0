Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D535D06F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 15:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGBNWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 09:22:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z/ZbN5cvj2XpUVIzcCPq0VBb2qvNquH4MnclmPIzjtI=; b=rpAw8GjzIoT4tfLgsUvItvY4Z
        4ndgUhYh3ga80TcUWABfWQhk7MnXqq8n+S5NQuHFSVDLRhdPbLqDBNQngUYzO60/tqBeyYvt5Qjnr
        gKPSxnHhPBFbywm3ZRyhbBRhDYzEC4FNLqqjCK6dwAuXAc0u2zOlworvf4WVRIKWQ3Kv8cfAMzhlx
        0USGvtICfe7ZXeyp/7Xzt341i+kQiXRVIGAHb6jKNhS3uKvFR6C+XBAtmBBJJBysW/VVfsWMVH2dB
        c2VOSxXwc/RiYqv7EufM/g7qK6ieXSzrhPBZXqZp6cdSxZJTz+A/VhclZ08khm+oJXRC5IPpsX7jQ
        zVTtAppxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hiIjt-0004Xq-JT; Tue, 02 Jul 2019 13:22:29 +0000
Date:   Tue, 2 Jul 2019 06:22:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Clement Leger <cleger@kalray.eu>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Pallardy <loic.pallardy@st.com>
Subject: Re: [PATCH v2] remoteproc: copy parent dma_pfn_offset for vdev
Message-ID: <20190702132229.GA8100@infradead.org>
References: <20190612095521.4703-1-cleger@kalray.eu>
 <20190701070245.32083-1-cleger@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701070245.32083-1-cleger@kalray.eu>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just increasing the mess remoteproc has created with the vdev.
It is poking its nose way to deep into the DMA layer internals, and
creating massive problems that way.  Can we go back to the table
and figure out what the root problem even was?  To me it seems if you
clearly need separate devices they should be declared as such in the
device tree.
