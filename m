Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672B678DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfG2O27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 10:28:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfG2O27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gQDoUkRn7ohUi0AK4193GFFAVxKRpJGWSsD1aIDW0XQ=; b=p6H12wQgajmyDHgmBXKdemE7Y
        C8YxAS2Y+3b6ukgwoyVL9zbIvTacyBgW4tCrngVCwU+jaE8kWjD6arMSdL7X396OaWBv7cPNeR1sg
        wfirWKCQZYamFRQEpP35Crsfu7nifa9oziKwmOzjVzlhDro5Yn8PH0XkSZh7FQuxVrFF5vssBb95Z
        FzVuaLZZ787LDALYCdA1svJ9fKFIWVdIYLs5d1bWWzZO/pGHVpy4Y1Mq0JJctiKFck2EKLiQ1Ykdd
        EoLkzi9cw1xX9PIv4fjFm/IWGznw5KS+KN8yxTCxKhZo7oBCTYFqOwyygWPleV6mcS7+MsXs4LQ7f
        k8v32wtEg==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs6dy-0006J2-NA; Mon, 29 Jul 2019 14:28:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: turn the hmm migrate_vma upside down
Date:   Mon, 29 Jul 2019 17:28:34 +0300
Message-Id: <20190729142843.22320-1-hch@lst.de>
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

below is a series against the hmm tree which starts revamping the
migrate_vma functionality.  The prime idea is to export three slightly
lower level functions and thus avoid the need for migrate_vma_ops
callbacks.

Diffstat:

    4 files changed, 285 insertions(+), 602 deletions(-)

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git migrate_vma-cleanup

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/migrate_vma-cleanup
