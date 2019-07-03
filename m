Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 724985EBE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 20:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfGCSp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 14:45:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCSpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UYUSkq3MaywALpKQmbkqpd/XlsTvFn81MlHwxqWXibw=; b=m8HcPZ2yeJKhNSw16f2U4gwi8
        VaTgheKcvNfXeBOBmB/SsYKOJeJUuVqHvJ0+uwDyysD4GPpY3lM+PzTEkWhtLBBoggskp9VkHUsIk
        UyGPHDBv6lN6uVl40S7pfVGSDzMGXP3klgrtrx8i65i7XXeXSanBjwMihL5tpASfXcWHKK8049WC9
        4COYj4vK4P48hgNN3U8YbS8v6zZFinYOWgiAEjZk+THHb3vMXSTjZKjFTltedrmFPS6mdsp2vG2Cv
        lBShDGZVA77KiqJ0Ogl95z9sCHe597CJXw4e4rhrDdE12lmFKK4fpGmHckcPOwKSG/n3t9UTbQVja
        DEmxCAQ0g==;
Received: from rap-us.hgst.com ([199.255.44.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hikFa-00079g-W0; Wed, 03 Jul 2019 18:45:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: hmm_range_fault related fixes and legacy API removal
Date:   Wed,  3 Jul 2019 11:44:57 -0700
Message-Id: <20190703184502.16234-1-hch@lst.de>
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
