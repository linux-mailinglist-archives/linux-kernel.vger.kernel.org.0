Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187EB6B69A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 08:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGQG0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 02:26:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQG0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K7H/a4NErovUxRGU06/uLQsjkN/DLzAnnlN1h9ancXw=; b=lrTdWqvXNyoOtCzQpqjDXorzc
        SQhUNNHtbufMJYXk+tysnO6m3RMQbWASa8Tfa8j5YzLW5Ik+zuJJh4fkVrRl8LwcAbKapgowl1ak6
        z8CkMZJvg2aiDWlazThgXQ++CGLAaJal0tZiN64mj989OyIOXfIdnBKJIGFZZ7r9dixa0ICXLplLf
        N07/nfb+MB7wXbOh/Prhf3nDyQkPe5dJfBK90Qaoqx9mBIItlqLJ6Ixfle9H06iyuB8s4I/E1Po40
        hg1Rg2Ov/SgUNqOupzzgirMwputAO7Wbt+XIQExfidBQ3yuZ6179O3h5euvzLJHfNvxk2fl8d9L4z
        QF/pUXKxw==;
Received: from [213.208.157.38] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hndOL-0003lg-Tn; Wed, 17 Jul 2019 06:26:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: fix nvme performance regression due to dma_max_mapping_size()
Date:   Wed, 17 Jul 2019 08:26:13 +0200
Message-Id: <20190717062615.10569-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the new dma_max_mapping_size function is a little to eager to limit
the I/O size if the swiotlb buffer is present, but the device is
not addressing limited.  Fix this by adding an additional check.
