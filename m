Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017E510853
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEANg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 09:36:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfEANg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 09:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GDvmo8APjKKAf1sS8t8MFe7S1hHEWEC3gdsaHrs41B8=; b=ekXutGokZQcHKQJr2Fg6jLrC+
        H0ANTOh0e+gQc5hh3bM3pwKr0Dbe4jxXpjVihwfbovHW/oXW/WJYNkKYvRnDgnXGKBrbQ4cTFhGxJ
        y4oT1xJ21qvem0IyOCq9HJC/8Mdbl8yxvlRcgW/JXEEtfeflPj02Pf+LrGTg56yWcOVoZsaQ+9M9T
        KqT/rnRmEXBXUv5baGG+wpb08YlM3tF4dz4A040wI0FlgIQ0iMiUibVVUOWQpEcWczMcWDUQudalT
        Z8OE2Pyq7tEAMpT0Dlqkpc2NLvc0ITaeZZNtbd1Z3irbAPO0IFDKIWgN6U3ueQdg9wwEIs2C7Uy0B
        49Dd++4rg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLpPq-00035h-S7; Wed, 01 May 2019 13:36:54 +0000
Date:   Wed, 1 May 2019 06:36:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix filler_t callback type mismatch with readpage
Message-ID: <20190501133654.GA26768@infradead.org>
References: <20190430214724.66699-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430214724.66699-1-samitolvanen@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This still leaves bugs around in jffs2 and nfs.  And it is a little
ugly.  This is what I'd like to do instead, so far untested.  I'll
post a series once it passes basic testing:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/filler-fixes

