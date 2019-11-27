Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A359E10B17E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 15:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfK0OkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 09:40:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0OkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bl8Rh8t88KHHgsfkhyOpzdWKjTrI4QU0VJBcllAtpkI=; b=nCnXXFmFrQqiyYEKf0FEIyQIF
        5lTN8l1y1jkR39RZ0wCNl0z3VaudqVUGNuOtlN0govUDNX6hqsMkAJopoZOMYRKJccevJIlEc14qv
        0MIrnRKSfk/NxZkDC2aC/HfZggioP7ERcVzH1HBy+M/3bujgODevvQf5HAD7EVOndzMyKgnwxFU7U
        wfW1Lm5DKd4A0Mm9UshrLCMB7nDI7GQlHvY0UQac4+fjwCklOjKVhyw3YME+0fDjXmPYTxILFdTj7
        usBfsZoZw4bKr1htlttuGEIoC7b7ptM/dsrG4ekVZLq8q+EcKoQB3sbM058NuvYVDRs4GJAeAhM69
        EMFlxSq+w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZyUA-00066Z-M0; Wed, 27 Nov 2019 14:40:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: make dma_addressing_limited work for memory encryption setups
Date:   Wed, 27 Nov 2019 15:40:04 +0100
Message-Id: <20191127144006.25998-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this little series fixes dma_addressing_limited to return true for
systems that use bounce buffers due to memory encryption.
