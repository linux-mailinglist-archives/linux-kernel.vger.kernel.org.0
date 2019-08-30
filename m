Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452C1A3792
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfH3NLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 09:11:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43769 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3NLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:11:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so6016822qkd.10;
        Fri, 30 Aug 2019 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Pzf7XPCUmMJwHP1K5Kjcy/17KGNO9s1GqGEYtleLQJk=;
        b=ndCeD0CURVeX3KquL48qNjyaJ6CEXjp1nZ8VWkPrAPEA0hYNfCxrIHQFAt4avXxffr
         O3GUMxdIe1++IlRdFBFHdXOIoVU9I5E26AqyCNbFhmVblP9MADOekf6fUX9VFzKhV6SW
         TOaTNELuiM2eww/zpvob5IAQUiwiZGgynIIMPmcaGP2DTryJob3QkL2OckzMX4w1C+YW
         9mNqKL9Gd7Lmnal1jfIj7gZwljkPOd8XWtLB74de/vyHKAqY+SlYAW+dPq+rx+JGm+v7
         i8eBGvb6wb6PQum7QEYm2x79fHnvBUBu1jK1dukHfNyKJXBEhgJTmoo4WiALrD6hQ1E8
         F65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Pzf7XPCUmMJwHP1K5Kjcy/17KGNO9s1GqGEYtleLQJk=;
        b=lRuaTnvat4DO4NsWEbw+BSa/kf9wD8/SjT8MHrHTcXxv4JocNYVepr0gEZzwMnwnNi
         CVALlNsfsx4oNHOsXjBuoIiPB1P4Y94CuwmxcC4b3CwIKm29yuxN0fJXdy2TBI7gVa3z
         0ObX1N1Qz8DU2QqyozC56FnkklWe6o/7HJJWHi4dp8Ouqqk6n8Hn1jdwNfmAINyeGtXV
         iObOgwovW3k9ZCwtsIwE8y3d4WxZ5GIc+cWovcsvpEXvNi/0fS4jumOZ0gZhKWVHdZMK
         LRLSrySnRICorTFSnd9TTvpc0TQIxnRR4NNoU6cUFvUSrAJzOCgMcncuJmCVwhzyYXoR
         qeNA==
X-Gm-Message-State: APjAAAX+mS/jg8l0zR1mKkEHHp4+qIuAtXmjQXtsqrpfHYIy6XRdbliH
        cuE4C0MNphDAj6RpmBjRd6g=
X-Google-Smtp-Source: APXvYqweVJ7LuaqcKXPFM2tTBmyeDqjMAPN7OoITBSURFzKueGayFf/y4o1HyQhOaO0hQKVM/c5x0Q==
X-Received: by 2002:ae9:f804:: with SMTP id x4mr15131130qkh.178.1567170661695;
        Fri, 30 Aug 2019 06:11:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1b80])
        by smtp.gmail.com with ESMTPSA id r63sm697992qtd.95.2019.08.30.06.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 06:11:01 -0700 (PDT)
Date:   Fri, 30 Aug 2019 06:10:58 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH block/for-next] blkcg: add missing NULL check in
 ioc_cpd_alloc()
Message-ID: <20190830131058.GY2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioc_cpd_alloc() forgot to check NULL return from kzalloc().  Add it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kbuild test robot <lkp@intel.com>
---
 block/blk-iocost.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9c8046ac5925..2aae8ec391ef 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1888,8 +1888,10 @@ static struct blkcg_policy_data *ioc_cpd_alloc(gfp_t gfp)
 	struct ioc_cgrp *iocc;
 
 	iocc = kzalloc(sizeof(struct ioc_cgrp), gfp);
-	iocc->dfl_weight = CGROUP_WEIGHT_DFL;
+	if (!iocc)
+		return NULL;
 
+	iocc->dfl_weight = CGROUP_WEIGHT_DFL;
 	return &iocc->cpd;
 }
 
