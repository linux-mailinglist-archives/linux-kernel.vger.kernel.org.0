Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DACB210ED9A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 17:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfLBQ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 11:58:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfLBQ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kvx6skM6KVyZP6v62kIm1BhsFXAktdiWmhoWDqy+TEc=; b=ZqEi2ozaBFH7Wa44iB6r0PCBb
        Rs7SdB7N4Y0ct95W25LSYY89vpmWYvZi1BNw1dzj0ysG0iVnsGmVi/WJXcHSVSV1Q8+LC5TwwIKy6
        2aLZAY83lf55HTfR1UHHRNUPqc7TuWcboJmlFrlcO16k4mHPbALEp9RM8TpsRN3xMlPrWPl62pIqt
        Xgkn0nc70iRbSuvQ4PVIBgS2ZntcH4DDycZgo+7vxSnXT9rdcdihcFBxTElv6jJhYHTcVoG6ggQSy
        Pj5G2TV5B/ky+efAbARDW660Z105E3B/0HVyw4w168Xv34AQ096XHlbLhGemRPhofO83m73PhIAEF
        R/r2wuLEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibp27-0007sl-CK; Mon, 02 Dec 2019 16:58:47 +0000
Date:   Mon, 2 Dec 2019 08:58:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 1/3] iommu: match the original algorithm
Message-ID: <20191202165847.GA30032@infradead.org>
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-2-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129004855.18506-2-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think a subject line better describes what you change, no that
it matches an original algorithm.  The fact that the fix matches
the original algorithm can go somewhere towards the commit log,
preferably with a reference to the actual paper.
