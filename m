Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A522589082
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 10:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfHKIMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Aug 2019 04:12:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfHKIMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 04:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=duSr/7/isMOllSiQdJtuYj1CP9drRkouK4Y/GwmPE9E=; b=jausoYlXofSB6fNPgltUVfKwO
        6u1d10UxCCDGkunYpexGn7ariKsfdVq5MMOrJ8+xUmsui3PRCPjLtcDqlhnk4H94uWAIfYVj0x0/X
        Y47lQw1ooEct2Q6hG1lyiKwTD5jkeB5tOPONHD+F7gW4dvLBVGX1+Rzzo8DhyNMuTJtCZzP6fTNfM
        5wCEUVJlCUBIoil8nqLRnPv8KTxoARl3gE9o2JN9JHPLnljViWNtgoxbiu6A3xpj1FPzVWEzeO8dm
        0981hJotdh4htrXntHclw1A5T1UspEkzRJoBDqKXRL8Si6jPvLLBsSJw4Ggn3MeffzO5KR2hQ11y0
        wanviGajg==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hwiy9-0005CR-Q5; Sun, 11 Aug 2019 08:12:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: add a not device managed memremap_pages
Date:   Sun, 11 Aug 2019 10:12:42 +0200
Message-Id: <20190811081247.22111-1-hch@lst.de>
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
