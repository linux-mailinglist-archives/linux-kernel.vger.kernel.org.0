Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96AC19CB0C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 09:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfHZH4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 03:56:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfHZH4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9D9DxG9HWmfufr942xdlZ3iywgwGdH94T1xD2+GS2kw=; b=DjO4a3kiB+bYCvPMJSS/aujKo
        3CBsC0SBDhlnQOnGP6/BTIRA5Yd4gMN2/0W/0v/Zqe9TQaDQVc2wVaRpapU75ZfOg++2PwtbEOkZd
        SOam3LNZPnxxw+a1mckwwvRbfd8md+swiyLhPVsA/DSkvjSqG/qtOjekDuT9N3syVtHvTZVt1KRNd
        QNz7KzI/9hpmRLgakWIJXYhD1qN0NaR/bd7iO7R13ud/IrwDtKup4znuFtnMs1fw9He6W0+b8AE1n
        2UaReBRwShwj7YTNYihR8lOO9frvWFzxhUMt2wucKhBGDN30Zq1PSRMIIXVSzBBiln4GJWEGiBNsD
        vaAZTPeXA==;
Received: from [2001:4bb8:180:3f4c:c944:137d:e92e:5fab] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i29r6-0000Mf-K3; Mon, 26 Aug 2019 07:56:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: remove various unused set_memory_* related functions and exports v2
Date:   Mon, 26 Aug 2019 09:55:53 +0200
Message-Id: <20190826075558.8125-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

while looking into implementing a DMA memory allocator for PCIe unsnooped
transactions I've started looking at the set_memory_* and related APIs,
and it turns out that many of them are unused.  Fix for that below.

Changes since v2:
 - dropped the already merged arm64 patch
 - fix a subject line to not mention the wrong functions
