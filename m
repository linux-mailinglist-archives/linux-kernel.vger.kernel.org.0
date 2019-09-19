Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B65DB8226
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 22:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392441AbfISUEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 16:04:34 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:40569 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390510AbfISUEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:04:33 -0400
Received: by mail-pg1-f201.google.com with SMTP id e1so2882063pgg.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LHD16OTYOtMJHpsagc+2yNBkh41gsuiOuQZ9m7ccpPo=;
        b=SoI2hgVHse8CBqzzfX01Lk6awpcoRFEWsdKxlBqS7RL/DnPXP4mRupYNbxRiVatC+B
         +MNgXOh6cV2rtGkFWwhBCF6othISIQUsnvGpL21MaXPk1xEfPS0MWPNoHVpI942t4svg
         C08AVcksRRJnGFM9Ohx+YqeSUAtslAX89MAYo+qpRs7gCYqFSDjsko2bsKxekme0G0Ht
         7qi/UTVXZNxdVhuhOfLeiy1kAy3GpP0QuSj7yU3iib76jr7brT4kDZiHrjHGDB3GjYgZ
         B5ADsj3e9c+eqDZgjnz7bXjHc9T9I5MQhuRmaqls7mkEx21jLT4zbD2eiLY2Xbiq93OC
         Q/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LHD16OTYOtMJHpsagc+2yNBkh41gsuiOuQZ9m7ccpPo=;
        b=FZ6x+3S1cWTZPHQV3IOEJ7shc41vgKX3Cbm/1o/yl3xbZwdJi/YjyPzxevQE+HGWss
         MR9f1+Kw/fAaORej+17oh7dpMqdlEdZqIm5n5+9AAGLEhm7s2QcxZH/GzB+QDYO/ANa2
         QisqvWtv9gdfhgeHmbtAItigz4NL1XnQ44wrWx/5vIsRNFqbiswftPkg2j1AopsA4YkG
         wzUXlX7FJOqGcA4l8kGVG9S3Ylb+rhRaGsnSsaxO8zbxCfA+6xUJoguShbsEwR9C5Ou7
         1N7Ecf99d16Ws91DT+P09IIkUZAxF8SO/5v6bTIOSFNsRJBBD8gAWTxjbxDIvc6QJu2j
         Bvsg==
X-Gm-Message-State: APjAAAU2+AX7w0x+2vJKF4a0ABHbAfk8riLb4TR0jgEKUC4eYGksOxRi
        DqqR6gvNhm6xAQZyaKtw/eFVigSbT9dKK1Jdlw==
X-Google-Smtp-Source: APXvYqx7AlLhlt2xpffaCvvrMuu5cxSoP4gYQv1vU/EzqRzPJh6hVjtVyBJzNZEOu0qc0OWerdRjfYP1HycnMUUibA==
X-Received: by 2002:a63:4d4e:: with SMTP id n14mr10661222pgl.88.1568923472695;
 Thu, 19 Sep 2019 13:04:32 -0700 (PDT)
Date:   Thu, 19 Sep 2019 13:04:26 -0700
Message-Id: <20190919200428.188797-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH 0/2] Cleanups to hugetlb code
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     almasrymina@google.com, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These couple of patches were part of my 'hugetlb_cgroup: Add hugetlb_cgroup
reservation limits' patch series, and Mike recommended that they are split off
into their own since they are generic cleanups that should apply regardless.
Hence, I upload them here as a their own patch series.

They have been already reviewed by Mike as part of the previous series, so
already hold the Reviewed-by tag.

Mina Almasry (2):
  hugetlb: region_chg provides only cache entry
  hugetlb: remove duplicated code

 mm/hugetlb.c | 180 +++++++++++++++++++--------------------------------
 1 file changed, 67 insertions(+), 113 deletions(-)

--
2.23.0.351.gc4317032e6-goog
