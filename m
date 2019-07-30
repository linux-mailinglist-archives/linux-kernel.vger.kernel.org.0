Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8247A09B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 07:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfG3FwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 01:52:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfG3FwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a6luPAARjEvL6+wrepaiTAj3y4NIety29NPDFmox12Y=; b=TcyrmqgStzKv1ExUPq4X25C2K
        GsS0yBUn84eEzTV3G+bIV6w/Wz+zdOtTQgYRWctpWBG4m8RZX8Wy5MsS4r7N3hmMjWfF6ufk06OEH
        Lb7wBYPu04YPbG9Q8/2AJ6Yg8EEmECICcfu4PZLtOkUbiZWv74mKnfRaChmb+dINOOXncvrUhYWIv
        FKLVC7qSEfWk3r47f87nsmoAX+/yb/XktofWaUBfRO6uAoKsabsXIxOdJ5S8pbSz8XGvfre96fE80
        m2Gz/7orow4ek0yS3DFI6va1nnSu5TOByhwgh6aRhwa3qUsmh/YCoO7ECAkPuk19GkYAT1cbpKh6f
        QmbBIraeQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsL3W-00014y-Mf; Tue, 30 Jul 2019 05:52:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: hmm_range_fault related fixes and legacy API removal v3
Date:   Tue, 30 Jul 2019 08:51:50 +0300
Message-Id: <20190730055203.28467-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jérôme, Ben, Felxi and Jason,

below is a series against the hmm tree which cleans up various minor
bits and allows HMM_MIRROR to be built on all architectures.

Diffstat:

    7 files changed, 81 insertions(+), 171 deletions(-)

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git hmm-cleanups

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-cleanups
