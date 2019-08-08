Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9951486AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 21:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404151AbfHHTxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 15:53:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39928 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbfHHTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so92175570edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 12:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=eApEJAGlOe9OjW3uADw7bJwJZMMK25w8bF16dCIIdK8=;
        b=OQdDHwRhkdT7sJoSvZlGdVM7KtxiycnRSpWEYyPpN6F+IMQTqLy/nhik+A/4ai+LXN
         poGQVA+D4Fxzb9BX4FitTxx4+EIiI+EwnCGSF5cv3e1scubM8nVkcMQjAYVsP/O6PY7x
         JQtVI9RSta+t8Fi3P/20BK3MbvZfktAXLmEUmx7RmCoSEpMdk214IiF2vj/5Tg4s8bSJ
         +rXY8okRVgG+L3FGD5seRHgKcuo17ZVm76TE8zRRD+vvWdec8xNME8F/nHYmoZDDHRus
         CRBHFeCEzDWyfmY5hHT9XSSU8cYmVLRUfSOWDTpw9NHGVderL8/FV9e9LXlG3B+b7amB
         zFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eApEJAGlOe9OjW3uADw7bJwJZMMK25w8bF16dCIIdK8=;
        b=eK5pfg5YfiD8Jb9kpUWrQukUmRxMF0hcb/mkwgNvuMYRllSM90w4XQ4cnwnWV5Fq+d
         FLqZ69iWbrU7Mvp+BKu0saW5kBmkx3EiINjEuzxYtnlplssX2ftU9J2/W0x9IinCA+Ol
         jr5r592g6qG1xcpr/jpqNkj8wzvwJfBfo5SKLCjZNDhQOTsD9wR+sQ3xDrFG7oMdtd2+
         qtsa1EfZmIuzy1LW8xdCQoA5ndn3qRWNY5iZgOSBtTxfMtYNUIo4YvX2ZY1AACf4bRLT
         9Kxf7hJfClXd96BWfMKkjfmTzdRbJuYWmo01sXOGaOOLEQgvBuKC2RNZ7tD2QFPaKCW5
         EfgQ==
X-Gm-Message-State: APjAAAUtRyCkkX1muRQwtuRqW5YFWZOF356pmtLSKeibL/mIHXMgm6UO
        Whj0JhKCeJwXoPeqEDKh5sG+q1aI51M=
X-Google-Smtp-Source: APXvYqw2YFkIEK8+ZXOMiQcpqvT6xFQOk/VA/XPZmLKJi14r7DYmMP1BTcnuVB9Cd/SJVQkn6j+7xA==
X-Received: by 2002:a17:906:cc81:: with SMTP id oq1mr15043934ejb.124.1565293983096;
        Thu, 08 Aug 2019 12:53:03 -0700 (PDT)
Received: from localhost (97e6989d.skybroadband.com. [151.230.152.157])
        by smtp.gmail.com with ESMTPSA id f10sm22440508eda.41.2019.08.08.12.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 12:53:02 -0700 (PDT)
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Suravee.Suthikulpanit@amd.com, Borislav Petkov <bp@alien8.de>,
        Thomas.Lendacky@amd.com, Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH v4 0/2] sched: Improve load balancing on AMD EPYC
Date:   Thu,  8 Aug 2019 20:52:59 +0100
Message-Id: <20190808195301.13222-1-matt@codeblueprint.co.uk>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another version of the AMD EPYC load balancing patch. The
difference with this one is that now it fixes the following ia64 build
error, reported by 0day:

   mm/page_alloc.o: In function `get_page_from_freelist':
   page_alloc.c:(.text+0x7850): undefined reference to `node_reclaim_distance'
   page_alloc.c:(.text+0x7931): undefined reference to `node_reclaim_distance'

Matt Fleming (2):
  ia64: Make NUMA select SMP
  sched/topology: Improve load balancing on AMD EPYC

 arch/ia64/Kconfig         |  1 +
 arch/x86/kernel/cpu/amd.c |  5 +++++
 include/linux/topology.h  | 14 ++++++++++++++
 kernel/sched/topology.c   |  3 ++-
 mm/khugepaged.c           |  2 +-
 mm/page_alloc.c           |  2 +-
 6 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.13.7

