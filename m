Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E43F1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfD3IT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 04:19:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:55528 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfD3IT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:19:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7A6FAE3F;
        Tue, 30 Apr 2019 08:19:24 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     gorcunov@gmail.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, mkoutny@suse.com,
        rppt@linux.ibm.com, vbabka@suse.cz, ktkhai@virtuozzo.com
Subject: [PATCH 0/3] Reduce mmap_sem usage for args manipulation
Date:   Tue, 30 Apr 2019 10:18:41 +0200
Message-Id: <20190430081844.22597-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190418182321.GJ3040@uranus.lan>
References: <20190418182321.GJ3040@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

(apologies for late reply) I've aggregated the two previously discussed patches
into one series and based on responses made some changes summed below.

v2
- insert a patch refactoring validate_prctl_map
- move find_vma out of the arg_lock critical section


Michal Koutný (3):
  mm: get_cmdline use arg_lock instead of mmap_sem
  prctl_set_mm: Refactor checks from validate_prctl_map
  prctl_set_mm: downgrade mmap_sem to read lock

 kernel/sys.c | 55 ++++++++++++++++++++++++++++---------------------------
 mm/util.c    |  4 ++--
 2 files changed, 30 insertions(+), 29 deletions(-)

-- 
2.16.4

