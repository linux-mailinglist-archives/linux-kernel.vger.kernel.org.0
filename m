Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5216FC70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 11:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfGVJod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 05:44:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35258 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfGVJoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O26sc2nLoVFgJqI+86Nh+/jE5QZWcSMhT2Y2hH/y3V8=; b=AfgJ8lP1A7t1NBzOAMyaRjNbd
        T7I9Zn/foXgv6ag7KA/LDtL1Fh5GITciR4hIQAlS1u3mi0JtAqcdEFqbeD8V7L5YoeZQpj8qCpTEb
        w3J1/Qeffo9punlPAzBqh5esZiJsiko9MyMhJo15FFT3k4bJ5rW6JtUxbDeHdKRN5MoOM2ban6PLO
        vm80xm0u0Zd4kBX34rz+RMHF+g83+rgSzKOcWWeJtlM0NSyheBCY+FayqQuVWf2u+mhYMDA6LgPUT
        m8X2OIBfxYeAdHjxte71yKVXT/1qfYuiMLaSqLrcboQb5GQJHyKyIpj3af5EFzxqXsIe+SJKcOcE2
        5wys/HGlw==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUrs-0001rX-DG; Mon, 22 Jul 2019 09:44:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: hmm_range_fault related fixes and legacy API removal v2
Date:   Mon, 22 Jul 2019 11:44:20 +0200
Message-Id: <20190722094426.18563-1-hch@lst.de>
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

Changes since v1:
 - don't return the valid state from hmm_range_unregister
 - additional nouveau cleanups
