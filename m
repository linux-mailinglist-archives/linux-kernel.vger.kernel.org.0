Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A7145A43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 12:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfFNKVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 06:21:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54900 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfFNKVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C/mJGHsUXNarC0adgGvdVnC+DHqIGH0Q83nZGJCdLIM=; b=RezFpL5px34ciiZ/i44h9iOt1
        Tg9UgniUaV7oeWDNZZe8opEoXrmda1RA+qPswhrUyGH39B5/OfH+F3Gk1VnLilmuZY44mFMXIUfjz
        ZW+mMb75M1z75WHPiEM2FIhKJ8pp43OS8PHyHgkFEHD7Elhly0/vW8p9LOeDFuyerjMpf2i0monI+
        zVJLfNcLAAnzUszYuLIMu7i0JLsNS5BCEqTZDMYXy/Zngs8NNqxpguEu1ih1aXU7BuP619rOI7TKo
        2kI9RfJ+8MFwjJycGqu72i8wA72y5eKcPKTSc9Xjp+YaEp5EUdU+ycnit2ROvjjMTlvk5XUwTUIkm
        SF4kfJbAg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbjKr-0005Kj-Lf; Fri, 14 Jun 2019 10:21:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] switch m68k to use the generic remapping DMA allocator
Date:   Fri, 14 Jun 2019 12:21:24 +0200
Message-Id: <20190614102126.8402-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert and Greg,

can you take a look at the (untested) patches below?  They convert m68k
to use the generic remapping DMA allocator, which is also used by
arm64 and csky.
