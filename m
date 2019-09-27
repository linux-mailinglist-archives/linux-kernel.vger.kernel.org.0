Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D98CC0E16
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 00:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfI0WnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 18:43:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI0WnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DTe5NnCzHgfMpVyo/Fe5sQAhAwSz3rHDVU/GleK05Fw=; b=ZjdYgL4JVCppL6076/v9h5YwW
        CsHC0GgIO8C14LrDVd62LqlZbmA2dpoI4JsVMtBSeWERIFWXERYCW9rcefXC+1tecsowLuu5qWRZb
        96ZNyfiqp1OdbAaPF+LckuzCqZLtKYcrkdqJDRMq7JXl8LBwfbbQA3j0wh5xl87Hn5maOvFbEoB0a
        5P3y2xb23L3Za8NMPKY1KQJE9VvJtQInNf2XAMgEv1XxJaPaqmztR2cnqbG08ZbqFxIqGRgBEw8po
        +ibXLK3vi5hB4A2ixzyMDpCW36AXpm6Y9NE1OhQBILZvP8vw69m3ifUNx6mb3TYUCvUg4ivNldbO7
        GO7sDoN1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDyxH-0001ee-LN; Fri, 27 Sep 2019 22:43:15 +0000
Date:   Fri, 27 Sep 2019 15:43:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        paul.walmsley@sifive.com
Subject: Re: [PATCH 3/4] riscv: Correct the handling of unexpected ebreak in
 do_trap_break()
Message-ID: <20190927224315.GH4700@infradead.org>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
 <1569199517-5884-4-git-send-email-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569199517-5884-4-git-send-email-vincent.chen@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks ok:

Reviewed-by: Christoph Hellwig <hch@lst.de>
