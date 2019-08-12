Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E23A89764
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 08:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfHLGz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 02:55:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfHLGz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N9izlud1X1M8isjNbanP7dBva6cNYDlshJZyLYo2uvE=; b=ouMzO47aI+rXkMG5/+u5g0/Gq
        WsuVVX+4lw8Fbvmg7azW4oWnYqyHRQIN8o2bo2DbHxQz3mbazMFFi/NG4aM06gUY4Re6mKbJcsf1j
        cVbL5Hde6+H9CeHgYlKX98R2u+FC3S3ZllUNzu2xYefnkZlOqIefDUQmYyrHjLOHg2Wbr+OdDxXOP
        YjA5TtV3dBwisUkKzdiUJHp+Ek/yolZqF+N00hv8EEY7yLq06Rio6nIhfVRD6tzSIyh2gzM7+Aa3l
        ek0gPZas8iAPfG8cMvy8C3ozh3/GKvRvrbCz2hSffIG1ymdssIzg30ecZzNS5R31bKKJ3WafI2l4G
        YgzDsoMSA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hx4Ep-0000Ev-5W; Mon, 12 Aug 2019 06:55:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: fix misc compiler warnings in the ia64 build
Date:   Mon, 12 Aug 2019 08:55:20 +0200
Message-Id: <20190812065524.19959-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

this little series fixes various warnings I see in ia64 builds.
