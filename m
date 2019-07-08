Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3798A626AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 18:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfGHQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 12:56:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43148 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGHQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:56:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so15581569qto.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vy9ys/2bQQSDSqndEUZv1UFDSZv3wfHfDVoGA/l/PSQ=;
        b=Dl4Au+FGHs+p/cUU0u56qJWYLl/edLqC0vL8cYn6OkDXSkCHlF9eICtXKyj1DkngFt
         I4XEvj5CznEQvF82DG+yFXOVmccyn1MewzhWI3x6pO6N3+9a5SgTvZUdnr8ozET64Tbd
         zpeI0Rqq1TLt04ORFycqBJx4fqpjlYhtP/kKgO5ScqPpF76cSHdfRTgUSK9XpFts30tC
         xYkmGJ+03FiW+TRKmwJx9ysJm1R9rIXJ42QKpRLS8E7vua1kVs+D++1EgIJvfNf3epP+
         HKQX3uBlkb+z5+klyAKLTXc6YqS3k6jEOae7RmSWgQeDCzbwvWdDrpluH2wjswgcB4Ec
         07bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=vy9ys/2bQQSDSqndEUZv1UFDSZv3wfHfDVoGA/l/PSQ=;
        b=ECtTZNcbS6+wKN+cF3ShedYFSXdrn4t7phBFEG34H0qcbJHbuX7L4zrBfP9QWevTOH
         auIIcB6wVjVTiqHBFW1W9PRgJlJbXF/ouGi9YfURxIxCK7ffvGK5lN+D54Hy7Is1/mDz
         X2HNOZV+pWWmBM4n1Hktk3mAvzLdn7i+GQH6rGwLqnkZDWuBb4iZ4tz0xYzmbAVUjYOu
         SKMScub5XTVcZ/Q/QWzOmG/I6XuJMs/t8zP/tpJ630p1bd7e/WILxSqtALMtPmCOqlDV
         gCh8dGIO78/vbCmf4Lz9cNASzyE27NMqaWakiS37717eqdzUUIW83Wgr6bMi+jTcduB5
         rtHA==
X-Gm-Message-State: APjAAAUWDQVwdMQeQp0XhRUAQjaEIim9jaCtClSFWsyga2+1C/uM5PXL
        WUQMSru+jNDQntFybJb1TGE=
X-Google-Smtp-Source: APXvYqwu/Bufyl48Q19XEIO9eLLuoRZ/PyZamcaWHgmOkAOb43gxjHBqRnTTH37r3o8hj+TQJ9/z0A==
X-Received: by 2002:a0c:d216:: with SMTP id m22mr10492355qvh.84.1562604983243;
        Mon, 08 Jul 2019 09:56:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id x8sm1925497qkl.27.2019.07.08.09.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 09:56:22 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:56:20 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v5.3-rc1
Message-ID: <20190708165620.GF657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just a couple cleanup patches.  No functional changes.

Thanks.

The following changes since commit 249155c20f9b0754bc1b932a33344cfb4e0c2101:

  Merge branch 'parisc-5.2-4' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2019-06-25 05:52:31 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.3

for you to fetch changes up to be69d00d9769575e35d83367f465a58dbf82748c:

  workqueue: Remove GPF argument from alloc_workqueue_attrs() (2019-06-27 14:12:19 -0700)

----------------------------------------------------------------
Thomas Gleixner (2):
      workqueue: Make alloc/apply/free_workqueue_attrs() static
      workqueue: Remove GPF argument from alloc_workqueue_attrs()

 include/linux/workqueue.h |  4 ----
 kernel/workqueue.c        | 28 +++++++++++++---------------
 2 files changed, 13 insertions(+), 19 deletions(-)

-- 
tejun
