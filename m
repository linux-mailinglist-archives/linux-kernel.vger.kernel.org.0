Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857012776A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 09:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfEWHtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 03:49:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfEWHtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0UOe3xPv4tpUwRIkZkfVlFWaY+rv/9F/CDrwqS8tCBw=; b=btJQzFIdH0spHOia8h12MIpGZ
        hyqO0iQBKjDA7PUNzKr0b237KCIspdGUozEjkkXZkuydsmwcdfNG2PW/zzmCf/+YHhKcnTyPnkpYV
        MFHPW4TJjiKMctsav2sqMJEJxsadeZEW+41tG6rx8Q899LeJH7zFGZGuB1fkEo7XaPldlyFqaCot3
        q/bSs+y5xJZG+Drl6RqBpDzKPhEiS7CpEf3j9yitl8PgYWPGGhOQvSaKw3zPxD2D9S/+9dkzhBFp+
        cHiuAmkqcs7uGuplteGQgO5wDf9WW270aRy8KfDwQhAWVMJ9d5sxr5W+szsOHQSSN50MVNYYIlcUc
        gE7Bo/7Bw==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTiTe-00043A-6X; Thu, 23 May 2019 07:49:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: remove dead powernv code v2
Date:   Thu, 23 May 2019 09:49:20 +0200
Message-Id: <20190523074924.19659-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the powerpc powernv port has a fairly large chunk of code that never
had any upstream user.  We generally strive to not keep dead code
around, and this was affirmed at least years Maintainer summit.

Changes since v1:
 - rebased to v5.2-rc1
 - remove even more dead code
