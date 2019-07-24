Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9872886
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 08:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfGXGxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 02:53:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfGXGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nxIVoCpennKVcI7DbytWW21ua/k9dOz1onbRbm1cQCE=; b=oT1UkxwATR3uNfX9nvhPpejPy
        pzG4vC6QYUYgAgXlECubEZvLZDF5K+eNlTayweVvSxyqIO3v6nw9O4EZdfU+CvQWHVB71+n9N5k87
        MvKaAKSxHDWIO0SYlWaDUwo7zo9qYmIU6TX6Tzzj7Dyez5Rd9Obt8H4+L8SM2mtrm3UZG7AkYcWGp
        zzslZfgg8CUU/FA1z4RFQkBt8uCYQivm2n5RUam8BYNfDFwDlM8WYlubmQPRS2u+yDI9vScOTUpJo
        rwqpUvywoSh1seqL1wWx5ykh9VGgCyI5jt61j9WRluuS2LAkxLkB+HC8fjlVw/aeppuLqe6jgBNW9
        0YbLXShAg==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqB94-0004Hw-C9; Wed, 24 Jul 2019 06:53:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: hmm_range_fault related fixes and legacy API removal v3
Date:   Wed, 24 Jul 2019 08:52:51 +0200
Message-Id: <20190724065258.16603-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jérôme, Ben and Jason,

below is a series against the hmm tree which fixes up the mmap_sem
locking in nouveau and while at it also removes leftover legacy HMM APIs
only used by nouveau.

The first 4 patches are a bug fix for nouveau, which I suspect should
go into this merge window even if the code is marked as staging, just
to avoid people copying the breakage.

Changes since v2:
 - new patch from Jason to document FAULT_FLAG_ALLOW_RETRY semantics
   better
 - remove -EAGAIN handling in nouveau earlier

Changes since v1:
 - don't return the valid state from hmm_range_unregister
 - additional nouveau cleanups
