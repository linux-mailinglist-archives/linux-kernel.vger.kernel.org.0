Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629782F77A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 08:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfE3GfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 02:35:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Ge7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jr8TFbprzSDAQ8IU8dPBj96p3eA/WBFaKx/uITpNZxo=; b=qw1P2yCe/tNQ53IWK8sRhTlQ/
        7BOzfMuds62GDyiMXXH0kaXp1Y+C9rv3rPLSzwvtXfy2QGuFj7Z4GM+RO8YF28VJED1HBAVuJiacv
        HfYJ8LtXhewzVwZPvZj+5oYXx2zT6rEK1SyEt/ODgaLXdjqFaYQUKil4+7nXra90GSGQk7EXlZj8Y
        zR8FSrFgCmzAQsmE0qwBRRVez9amvdlg3cLbTtuDXOhSU8dOxHmsBsyayqcOKZhpq7X5TjV0Vtph+
        SNe5iYHi6xjjdAMoXuQN3GXfEYLx/kF6PhaP+VsY3yVJyVgoDw6XzDkR0ixeywqN5YUy/hPRiubF1
        hBGqc8phQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWEeR-0000fN-4p; Thu, 30 May 2019 06:34:59 +0000
Date:   Wed, 29 May 2019 23:34:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 4/4] arm64/mm: Drop vm_fault_t argument from
 __do_page_fault()
Message-ID: <20190530063459.GA2181@infradead.org>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
 <1559133285-27986-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559133285-27986-5-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 06:04:45PM +0530, Anshuman Khandual wrote:
> __do_page_fault() is over complicated with multiple goto statements. This
> cleans up code flow and while there drops the vm_fault_t argument.

There is no argument dropped anywhere, just a local variable.
