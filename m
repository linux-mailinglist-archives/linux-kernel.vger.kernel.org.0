Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224E18FB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfHPGyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 02:54:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPGyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GereEEuIF570EiKueg45SrscGAcsm53Jmc8D7sejksY=; b=PpvYvAH+KP58nV6izstqduOxt
        6xZbDzbpIZtPEsO9CQjgqucxq7ocLr0SIseaBoGaJY4NFwkG+IubSesgQwLQBlyQE3QsLPmjVLVfY
        GmuBb7lhlEtEosRF0w8bMzrYlcr4QdtE+hmgmB54j6YH/sFwlDhne3pDBbJ/V4GtymNSSSbJVKDdF
        pelq9A1cESIRK5Y7ix33Fs7hOIYdzquVSs7ZiqG/uL2n4RaGVkxFDL4C94ertZYqFI3nEFVCoZA7F
        Y6FcG+haPB/P3GUmrdK2i7hzOmUO2/m5N1zpZf9U/PzEfFf4snYbd23glYY5wlJvTPC7/fEyFlLeX
        t8QFPJsVg==;
Received: from [2001:4bb8:18c:28b5:44f9:d544:957f:32cb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyW8D-0008H2-1p; Fri, 16 Aug 2019 06:54:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: add a not device managed memremap_pages v2
Date:   Fri, 16 Aug 2019 08:54:30 +0200
Message-Id: <20190816065434.2129-1-hch@lst.de>
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

Changes since v1:
 - don't overload devm_request_free_mem_region
 - export the memremap_pages and munmap_pages as kvmppc can be a module
