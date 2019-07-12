Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB4867231
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfGLPSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 11:18:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfGLPSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21D2459455;
        Fri, 12 Jul 2019 15:18:46 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBF005DE6B;
        Fri, 12 Jul 2019 15:18:45 +0000 (UTC)
Date:   Fri, 12 Jul 2019 10:18:44 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.3 (second try)
Message-ID: <20190712151844.GA24064@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 12 Jul 2019 15:18:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.3

This set removes some unnecessary debugfs error handling, and
checks that lowcomms workqueues are not NULL before destroying.

(Dropped the commits related to incorrect wait_event usage from the
first pull request.)

Thanks,
Dave

David Windsor (1):
      dlm: check if workqueues are NULL before flushing/destroying

Greg Kroah-Hartman (1):
      dlm: no need to check return value of debugfs_create functions

 fs/dlm/debug_fs.c     | 21 ++-------------------
 fs/dlm/dlm_internal.h |  8 ++++----
 fs/dlm/lowcomms.c     | 18 ++++++++++++------
 fs/dlm/main.c         |  5 +----
 4 files changed, 19 insertions(+), 33 deletions(-)

