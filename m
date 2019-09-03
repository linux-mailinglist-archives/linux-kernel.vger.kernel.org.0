Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B00A64AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfICJHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 05:07:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfICJHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J6j49cj68Onl6GxrmHEWi3URmmwTtpkehzdrsN2EvRc=; b=RcTYGGHZ6U4kbVK1h79q9oNKk
        I33lOlERli2rOQfVzFWRuqb1OHF4RT9A6GO0qbzjm5Ib52auuIM9n/YkGUihXuzy9vBCF18dWYbdx
        4YTjFWVUwVgncgwyYNSvzt4hqzOQ0dTe98Gwk2HTG6NdP5dOe76WJ0tD5PLnVIXBnmPzrUvgiLbjx
        IEjGwmlUjwKwwN84Z6NB5L1vncjN7755RI3yPVI86J6WmLDANnXsahGhkAlAK5ZWYIG+l3BH/OSss
        ijDS20PtDL+3zr77zfUpp9DLqgb9gBiwxg30UWKdqBX30eGzK4CB62k+TvFw0IE68BrIwXh9iRqQ/
        1gccFtusg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i54mR-0002oa-E6; Tue, 03 Sep 2019 09:07:15 +0000
Date:   Tue, 3 Sep 2019 02:07:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 4/4] Documentation:kernel-per-CPU-kthreads.txt: Remove
 reference to elevator=
Message-ID: <20190903090715.GD10407@infradead.org>
References: <20190828011930.29791-5-marcos.souza.org@gmail.com>
 <20190901232916.4692-1-marcos.souza.org@gmail.com>
 <20190901232916.4692-5-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901232916.4692-5-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2019 at 08:29:16PM -0300, Marcos Paulo de Souza wrote:
> This argument was not being considered since blk-mq was set by default,
> so removed this documentation to avoid confusion.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
