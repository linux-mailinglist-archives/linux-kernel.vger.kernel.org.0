Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3B5A3AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 17:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfH3Pq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 11:46:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfH3Pqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VI0bXCVY8P10H0YT3Rjq7E9GvaiLma/bGh4rBPUdQKg=; b=UNxWJcbn1PB9qyM05AHzrOjp5
        5OskrUVMmr8E657vBPDa4nkoWpXwS48U5vGj4wCTVjhSjPsYF9oRgdHtWUmvFMhrCJAYi/vj/FF0A
        eqtZ6wSH1lfvGv1GPkgsPpPIerkGgc7t5x48gBu1tOfBVOwSYvcK0/+EU/sPIZC46P/wLirq4zdqU
        XfhYtWeTiF4DB0ggGTGH8aPlSjIycvvzNj0plwZ/TqjzP75Kh270DOEmNsNXfzL6jiP1W4xRkNnM5
        QTf5A+zcHpKdOVTuqhQsqOUXWgmr7Sb/YmJMUEZy2PoFRAneQ98gZ5p6Kk+TNiIOqEihoP7TgLOWt
        aI3ChGSWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3j6w-0005vs-1C; Fri, 30 Aug 2019 15:46:50 +0000
Date:   Fri, 30 Aug 2019 08:46:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v3 6/7] erofs: remove all likely/unlikely annotations
Message-ID: <20190830154650.GB11571@infradead.org>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
 <20190830033643.51019-6-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830033643.51019-6-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 11:36:42AM +0800, Gao Xiang wrote:
> As Dan Carpenter suggested [1], I have to remove
> all erofs likely/unlikely annotations.

Do you have to remove all of them, or just those where you don't have
a particularly good reason why you think in this particular case they
might actually matter?
