Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B014180045
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 15:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCJOdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 10:33:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43557 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgCJOdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:33:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id l13so4689248qtv.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OS3DRJg+3W57g5Emu/IKpN2zktyimdd83c8dc82YO5E=;
        b=PfLH649Xafb18jKxixuwudbIRBhw3f1iAhZMf1aB8cCPMmoRom0w1oI8RbRUxflRQ3
         2cH2d7ksnC/u/c7CYXZq+TiRljnnqVK3HFnLXaKGiq0qRq5MRYDO9N68v6Z6ENk212aZ
         G74ZLj1KevEFtZxclarGH+l8CS9wErj5idTFwtTz/XwgrD281pXsj1wnGyXxvn+prLKu
         ER60B5JnD8ZaZ6usisVtNG1vFVnuzcW/GwhfB+G4qHcg6/YC2kjoTLjOHyYJINoYUtPO
         iOqxDLE1fujV+noJyeK7fhGUc9x+qdd3xgde6CKSSzwapMHJAIdVjuSbHq8PbutoArZ1
         TEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=OS3DRJg+3W57g5Emu/IKpN2zktyimdd83c8dc82YO5E=;
        b=mlxAmjvFKavRSdOujbXQpRJjo0MroACADEP/46uEKaOlmBxr4f4Aw0y3Y3ahUsUfaE
         KNbFhIm5qTukb6EklQCe5/0Zx0H/QhEd5icXzhGZsrM5FTZZjfZ1DtkHGCM+DyPw0HD5
         wFLo0fhn54KN423E75g425O3jISqEKwODlxSEkbua6BGVJfA35klr70Mj5OY5Zz/f40e
         lSS2upAxuM4L//lNZ22VYXLZq55Wf2CgTCqzMF9dXKlNj4fLPyrdLy5fuWFZFghpR22w
         9sEV6gz/VUTtGRIX/IjL8RDRa+DpqVA7subF8lgt1u5Wcsa/PvruNKdmyQNVfZIlTEkl
         j4Sw==
X-Gm-Message-State: ANhLgQ34PLVOEy2s2ZyEvJdtgrGaodktHBzWRycyblHgeAqgA3k+GZDL
        ZLUBpUzXTe7vJeRfPnBIQsFc9lgKdGo=
X-Google-Smtp-Source: ADFU+vuGVlaAjulUafD2IcjTSX/LWkoNLKu5pTCAqASrRUN66wQP39HGEKG/ZW74/SjTbBBctJLv2A==
X-Received: by 2002:ac8:7290:: with SMTP id v16mr19405235qto.197.1583850828228;
        Tue, 10 Mar 2020 07:33:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e8d1])
        by smtp.gmail.com with ESMTPSA id f22sm2593884qto.79.2020.03.10.07.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:33:47 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:33:46 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue fixes for v5.6-rc5
Message-ID: <20200310143346.GB79873@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Workqueue has been incorrectly round-robining per-cpu work items.
Hillf's patch fixes that. The other patch documents memory-ordering
properties of workqueue operations.

Thanks.

The following changes since commit 0bf999f9c5e74c7ecf9dafb527146601e5c848b9:

  linux/pipe_fs_i.h: fix kernel-doc warnings after @wait was split (2020-02-12 11:54:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.6-fixes

for you to fetch changes up to aa202f1f56960c60e7befaa0f49c72b8fa11b0a8:

  workqueue: don't use wq_select_unbound_cpu() for bound works (2020-03-10 10:30:51 -0400)

----------------------------------------------------------------
Andrea Parri (1):
      workqueue: Document (some) memory-ordering properties of {queue,schedule}_work()

Hillf Danton (1):
      workqueue: don't use wq_select_unbound_cpu() for bound works

 include/linux/workqueue.h | 16 ++++++++++++++++
 kernel/workqueue.c        | 14 ++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

-- 
tejun
