Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB518B15C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 11:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgCSK2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 06:28:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgCSK2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gqy+zebrYjBGvhaO6SqPF4xkV6Hd+2qwfnT0NaMfqFw=; b=HxxXR8a33Mlo3LPRSF0OtzifxY
        nZ01RbqIrsYECyTprO9a4Hg+e3YXhyA4NLOMZ4FamuSC0hPDqUWZOpIL8mW3tSr2/Z84Gd4YWpk/k
        ik1t+Xy+FiIkf/cgwCAwlt8977GoyAnubuWtzebqXHCQepNE/v5cRD6J4eErvjnLkXVr5YW357D3A
        v8lJ3EUL21H8uG46NCpPiE+qVvQiTWG69rtNBEkqpaEYQKD3QC7Xd6i7Ed9JiziqTzp/OL4sVtVCR
        /WkNXcTrYw/IKBMcO36OdHXhXeM8ltAoUckM3cXppBVPB3RnbCjw0BPEuM1rVMPFef1ssjBf3R8Gi
        RF4NTWzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEsPT-0007Vs-O0; Thu, 19 Mar 2020 10:28:19 +0000
Date:   Thu, 19 Mar 2020 03:28:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, bob.liu@oracle.com,
        darrick.wong@oracle.com, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, song@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] block: Introduce REQ_ALLOCATE flag for
 REQ_OP_WRITE_ZEROES
Message-ID: <20200319102819.GA26418@infradead.org>
References: <158157930219.111879.12072477040351921368.stgit@localhost.localdomain>
 <e2b7cbab-d91f-fd7b-de6f-a671caa6f5eb@virtuozzo.com>
 <69c0b8a4-656f-98c4-eb55-2fd1184f5fc9@virtuozzo.com>
 <67d63190-c16f-cd26-6b67-641c8943dc3d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d63190-c16f-cd26-6b67-641c8943dc3d@virtuozzo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 04:08:58PM +0300, Kirill Tkhai wrote:
> I just don't understand the reason nothing happens :(
> I see newly-sent patches comes fast into block tree.
> But there is only silence... I grepped over Documentation,
> and there is no special rules about block tree. So,
> it looks like standard rules should be applyable.
> 
> Some comments? Some requests for reworking? Some personal reasons to ignore my patches?

I'm still completely opposed to the magic overloading using a flag.
That is just a bad design waiting for trouble to happen.
