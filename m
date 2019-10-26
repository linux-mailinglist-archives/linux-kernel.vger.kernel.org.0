Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F87DE5960
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 11:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfJZJHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 05:07:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbfJZJHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:07:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8ABD7B0C6;
        Sat, 26 Oct 2019 09:07:42 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: patch for 5.4-rc5
Date:   Sat, 26 Oct 2019 11:07:40 +0200
Message-Id: <20191026090740.9581-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.4-rc5-tag

xen: patch for 5.4-rc5

It contains just one patch for issuing a deprecation warning for 32-bit
Xen pv guests.

Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

Juergen Gross (1):
      xen: issue deprecation warning for 32-bit pv guest
