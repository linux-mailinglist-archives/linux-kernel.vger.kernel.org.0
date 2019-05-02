Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DA311961
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 14:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEBMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 08:52:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbfEBMwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:52:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2D22ADE0;
        Thu,  2 May 2019 12:52:13 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     gorcunov@gmail.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, mkoutny@suse.com,
        rppt@linux.ibm.com, vbabka@suse.cz, ktkhai@virtuozzo.com
Subject: [PATCH v3 0/2] Reduce mmap_sem usage for args manipulation
Date:   Thu,  2 May 2019 14:52:01 +0200
Message-Id: <20190502125203.24014-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <0a48e0a2-a282-159e-a56e-201fbc0faa91@virtuozzo.com>
References: <0a48e0a2-a282-159e-a56e-201fbc0faa91@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Just merged the two dicussed patches and fixed an overlooked warning.

v2
- insert a patch refactoring validate_prctl_map
- move find_vma out of the arg_lock critical section

v3
- squash get_cmdline and prctl_set_mm patches (to keep locking
  consistency)
- validate_prctl_map_addr: remove unused variable mm

Michal Koutný (2):
  prctl_set_mm: Refactor checks from validate_prctl_map
  prctl_set_mm: downgrade mmap_sem to read lock

 kernel/sys.c | 56 ++++++++++++++++++++++++++++----------------------------
 mm/util.c    |  4 ++--
 2 files changed, 30 insertions(+), 30 deletions(-)

-- 
2.16.4

