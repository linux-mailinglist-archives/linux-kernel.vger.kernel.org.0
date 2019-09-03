Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39AC3A64A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 11:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfICJGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 05:06:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfICJGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gsu9O8OHvKqb4JIZdShzGB5nnk0JAhdnMec/nmfP8Qk=; b=f0isHbclVEqkgVNbuBUL5Tcfd
        cDlV4fidUHK+yM6d64Uez4Kw42ueClakR2UCOpayR8sM0ZXqLO/rUsa+TyhUmgLDqIHMXpnM9AY5K
        aCt2sz3WHmABgyAl5IPncjNugarCbYOYfqjgT5wOh0Pq5JL3RWFopH0yO6bqWBgiWsqM7kB+FfMwu
        8U5V0+LSMxzxJYH9fg0ssFgu6Kf7CyKDDg/i4RKFYaEibE11QpZf3ZpDWEvWXj0pR4SQBRp0Cr0oW
        csuhj9m/Nz+tAavrJjdE7X55vS7G1WNLq64aKORBfKldxbIGP3EjOMmXOuD+d8/OQ1jTgLKMnyF9G
        IjFJoiPqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i54lO-0002jQ-2u; Tue, 03 Sep 2019 09:06:10 +0000
Date:   Tue, 3 Sep 2019 02:06:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Hannes Reinecke <hare@suse.com>,
        Bob Liu <bob.liu@oracle.com>
Subject: Re: [PATCH v2 1/4] block: elevator.c: Remove now unused elevator=
 argument
Message-ID: <20190903090610.GA10407@infradead.org>
References: <20190828011930.29791-5-marcos.souza.org@gmail.com>
 <20190901232916.4692-1-marcos.souza.org@gmail.com>
 <20190901232916.4692-2-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901232916.4692-2-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2019 at 08:29:13PM -0300, Marcos Paulo de Souza wrote:
> Since the inclusion of blk-mq, elevator argument was not being
> considered anymore, and it's utility died long with the legacy IO path,
> now removed too.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Bob Liu <bob.liu@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
