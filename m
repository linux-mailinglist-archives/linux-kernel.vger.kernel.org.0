Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3EEA104750
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 01:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKUAOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 19:14:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32832 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfKUAOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:14:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id h27so614028pgn.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 16:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWcHlEgNUMXWNtKMo9fnHArr6iM67LDOF9B6/mC5eh0=;
        b=FtsVZiHS0XjHawCmjdwhHMQklah08Y+cI5JlQyrmYL0+HJeWbW4B5FqM/V3xIUNFps
         ESSb1QTy3Nqa2LHI/2Q9ErojKLztxhds+mZVEt7luzVOAlUOw+yHR1vuNjdrYy6VwAX4
         l1DeaynlLib7Wb9UOYvUSuEjZ1gM7AqyJI9iFecvlu2FBuwabg+BznsHDiwda8a6qIkC
         lgFeurHDPHcZEfCAG0tH1S5MrFlAc8Kxj3zegQIr3/f/xnuN7kR5OTaAN+1rXyfvMsH0
         Hrj+lDNatJ0cM0EbflECXE+f9IQSp0Cb7RqlGH+cKLhgphjzx7e/q+1yXg7MbHNKT781
         /hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWcHlEgNUMXWNtKMo9fnHArr6iM67LDOF9B6/mC5eh0=;
        b=RpnxtHynXSenWXYKuhG1EWgbrmNLl15AI8cAfh/nWXBxyxvmDSiPqmlcp8mhWQFjHv
         IjmkLUBSDopzalLQ/rqcFKN8CRDCWHmxVTM+0JGqVYRQmjyklTJ5aQIpmzdVCoOUw/5D
         2tI8FuK2EIfENFc8Z4e/Elg/dlaVfiRtnQJ9XJcCSc9rL4PdmnUtuVo8MMK9Vmms1YqK
         n/vralQ5El+Zl7MlWEPROfMdlL37oD933u6TIptkRk/BPrJKzhv1tHKPmopoWTCq3yyn
         GCOCknC6G2sUvs0GhS2L3NNp+skztIlxd3u78VQHjjJZg0+W+QPdUaXw2DDoUvz9MfIL
         hBlw==
X-Gm-Message-State: APjAAAXX3OHEvlp4YzStluGXe8toDa2dgVdLrXWZMTnFNzXuLEGvXaD4
        A8nlqvYcWpjQ2YKAN6DtOR0TQav3t6U=
X-Google-Smtp-Source: APXvYqzMz3F5gc0bmdB8045zo0z/zHlARfgRPm4Md5Gby/s36OsyddwO4k65Ri++p+1zF7BVsSTEyQ==
X-Received: by 2002:a63:f48:: with SMTP id 8mr6308884pgp.329.1574295264037;
        Wed, 20 Nov 2019 16:14:24 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id r4sm565981pfl.61.2019.11.20.16.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:14:23 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 0/3] iommu: reduce spinlock contention on fast path
Date:   Wed, 20 Nov 2019 16:13:45 -0800
Message-Id: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains three small optimizations for the global spinlock
contention in IOVA cache. Our memcache perf test shows this reduced its
p999 latency down by 45% on AMD when IOMMU is enabled.

Cong Wang (3):
  iommu: match the original algorithm
  iommu: optimize iova_magazine_free_pfns()
  iommu: avoid taking iova_rbtree_lock twice

---
 drivers/iommu/iova.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

-- 
2.21.0

