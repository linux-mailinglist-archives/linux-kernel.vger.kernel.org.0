Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C938174E9C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 17:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCAQzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 11:55:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgCAQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SnbXFd/E25ngDXXq5Lh/mAWbnynYG5+//K6zA7Uakz8=; b=NPuewaH3yDoNoouMAO77qdaY+D
        58SP3KlQZ4C2cCoslqotXrH8YGgI9uJ+IGwr86EwTw34fV5Q3cSHgGQIskSVL1IdiNjOuNDC64Htl
        +cD2Vaidt3qp1Ec1wNhB9e8Re961EtF1GQCPWmsE2BjNfupYG7OhAdjKC0ByK2CiAx1AvtULA7sdk
        UL34EFVmXMaZvEH073NLdP4Mo/TNpM79vojN8tX8UBKw0OfEadHKsKwAYPK22sYVoUkCfi8A4MFzn
        Yal4CYO86hFHWq1nDoCtAwsV9n+HsKikghjvILsL6ICQNeFr9gsus7qKvKfZUU44yYtkgxA84XFxW
        AgIaMqqw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8Rrm-0001qB-Io; Sun, 01 Mar 2020 16:54:58 +0000
Date:   Sun, 1 Mar 2020 08:54:58 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/shmem.c: Clean code by removing unnecessary assignment
Message-ID: <20200301165458.GO29971@bombadil.infradead.org>
References: <20200301152832.24595-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301152832.24595-1-mateusznosek0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 04:28:32PM +0100, mateusznosek0@gmail.com wrote:
> Previously 0 was assigned to variable 'error'
> but the variable was never read before reassignemnt later.
> So the assignment can be removed.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
