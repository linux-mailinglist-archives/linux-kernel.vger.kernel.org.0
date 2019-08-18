Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD1915B3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfHRJIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 05:08:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfHRJIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e+O2aoiz2diKfBtl4/embp/7xoIG/bN4LQJcAaqtku4=; b=ur9iGQGu6Vzub7Y28WrS1GrmE
        h2bcrFZdf+/QZFVZSFVD5pMssp6nEp/2wEareZZi0Ai57s+tDhJWb2pJZ/gXZEW5tQCanP7WCM0O7
        Y11YAjqCGerBkBuJg2AAMLD9Ba4lGzNm455GLTzqZ1HGKUOPUBORPcRvRaED42z3W26iZnqQ+V7c0
        h1RRlLhQ4mX3tM8momBg/QozzGt19/KJjfIFDyD598N88YXl2cVT2knYNo//MyXcWc/N3JX9pmGqa
        E6lXYnUKANKf3rBlJrXDedPP34cNwckV3gfAtnQ5FG/x7olCrhEX1E4AJJssD39b0qgF6uLUMy4NR
        j0DPXbc3g==;
Received: from 213-225-6-198.nat.highway.a1.net ([213.225.6.198] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hzHAX-0004ow-3h; Sun, 18 Aug 2019 09:08:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: add a not device managed memremap_pages v3
Date:   Sun, 18 Aug 2019 11:05:53 +0200
Message-Id: <20190818090557.17853-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan and Jason,

Bharata has been working on secure page management for kvmppc guests,
and one I thing I noticed is that he had to fake up a struct device
just so that it could be passed to the devm_memremap_pages
instrastructure for device private memory.

This series adds non-device managed versions of the
devm_request_free_mem_region and devm_memremap_pages functions for
his use case.

Changes since v2:
 - improved changelogs that the the v2 changes into account

Changes since v1:
 - don't overload devm_request_free_mem_region
 - export the memremap_pages and munmap_pages as kvmppc can be a module
