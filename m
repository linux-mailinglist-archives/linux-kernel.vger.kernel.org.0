Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1473363
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 18:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfGXQJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 12:09:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfGXQJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HXDgC3r+QZndYF+JhGOtU3oBVmxVpcd58tRMaOLYpnI=; b=d3D/6SvIZRlTvJ4R8TcVqF4SL7
        PnO32n2UOdRKzi4R406Kmnuht+z1TH4GbopOWqBzcNBF9gF8gOB0Z2HeZdfLqE9uDgdzC46V1Aa6g
        S+5KtgJ+4KPjAEDUGO6DKj2FkIqx1roD3g56z56/APJMkoBJU8T/8lQLTrwpeahrDBzP55c1khSuo
        WE5aUK5ELeoDcQPo9qOh+s3vok/HYoxbT9gUrYk6FyVb5baCCQjTii446Tz57dE91gw+FWqr3B0YY
        7DzwclfUBhNY88751AsXNCMbRP+hl//FBMqE+dkRJ1DRC2wWKq994Pb0vCVLdnisJralEi2i8YPnG
        lSMeoenQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqJpZ-0000Rp-EL; Wed, 24 Jul 2019 16:09:29 +0000
Date:   Wed, 24 Jul 2019 09:09:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     sivanich@sgi.com, arnd@arndb.de, jhubbard@nvidia.com,
        ira.weiny@intel.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] sgi-gru: Use __get_user_pages_fast in
 atomic_pte_lookup
Message-ID: <20190724160929.GA14052@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the atomic_pte_lookup / non_atomic_pte_lookup helpers
should simply go away.  Most of the setup code is common now and should
be in the caller where it can be shared.  Then just do a:

	if (atomic) {
		__get_user_pages_fast()
	} else {
		get_user_pages_fast();
	}

and we actually have an easy to understand piece of code.
