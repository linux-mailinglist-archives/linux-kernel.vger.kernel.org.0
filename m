Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61278E06AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbfJVOsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 10:48:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36290 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJVOsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:48:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so16498036qkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UutYteqTWkPmD48f0jNhpK+dvRJrMgtVJxTJWvlNPEM=;
        b=vlBYE+fWCY++BNYbapfKjvbzLNzuEMvv1UXCfI27y9wdHR3b89oXrVKLA8ud68Zs6J
         LqUbEsGJanuyERO6T1Dr7kUcpK/YSTQME+H9oYcAKQK8vlmOLbgPDHBVeq26VXQ5aBSV
         PLA0dfTYtghWw83ibT/hu+u8uuDVMlHbIetO16tszI+oUcbVZebbbpEmbKXBydiHkwhh
         SpNoB7b3+RMat88O1vqGmMpg8SHgx/hJBUHzbR1h4NcFWBtScqVSQK29G5nTaq5xJENX
         iE9rdbBtv3zaV6M4uLKi7GapV5UGPecdZrvbJlyMr47HQqY5Z6EgsWs3ROMRTwlkHnVY
         HQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UutYteqTWkPmD48f0jNhpK+dvRJrMgtVJxTJWvlNPEM=;
        b=jqQLGlqiDcCe0BkEzPVhw1UIrV0Hj2lAAb+ZKtfhgke98JcA3ex9iOsAUOG1bxND8R
         DgooumFOUanw7uErd86D1TiBwRwG5CBv6hNrhiwjeeiuAvAyCGgoS3JBtmCq2Sx8vgP3
         UFOQxWnwtzSBb2zdN6uXHX/I/PHgROZ5hyn/LYsiDPPc3XRf4JIDqdFiMFwg1Fs1Wube
         nFBjgltlLVqQAYXAFpLGo4P3h1nktRuz4e6xKVTx7fEArxZn2hMk9KooXVuolrrma507
         nuBMcjwuWLFi9qCnNWqgtHuXwotcCK5V0JsxVW2QN326vsxAufP73IZECV4Kp1+w+NOA
         8TNQ==
X-Gm-Message-State: APjAAAX2JBgDd3cO9JAARwZqrZAVuvQn8F/Fg8THrrkhF6ggKmzXPwGs
        2VgPElJxb89G2ypwQIQrCZayZw==
X-Google-Smtp-Source: APXvYqwJfMO9PapG2G8kHgh7WguC131PB48mtdefCCPtc77Ol1aVlpfD5STGoZ9DimE2wTPM+r48Ww==
X-Received: by 2002:a37:4bd3:: with SMTP id y202mr3461923qka.390.1571755693554;
        Tue, 22 Oct 2019 07:48:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:10ad])
        by smtp.gmail.com with ESMTPSA id u27sm9321604qtj.5.2019.10.22.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:48:12 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/8]: mm: vmscan: cgroup-related cleanups
Date:   Tue, 22 Oct 2019 10:47:55 -0400
Message-Id: <20191022144803.302233-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 8 patches that clean up the reclaim code's interaction with
cgroups a bit. They're not supposed to change any behavior, just make
the implementation easier to understand and work with.

My apologies in advance for 5/8, which changes the indentation of
shrink_node() and so results in a terrible diff. The rest of the
series should be straight-forward.

 include/linux/memcontrol.h |  32 ++--
 include/linux/mmzone.h     |  26 +--
 mm/memcontrol.c            |  12 +-
 mm/page_alloc.c            |   2 +-
 mm/slab.h                  |   4 +-
 mm/vmscan.c                | 386 +++++++++++++++++++------------------------
 mm/workingset.c            |   8 +-
 7 files changed, 216 insertions(+), 254 deletions(-)


