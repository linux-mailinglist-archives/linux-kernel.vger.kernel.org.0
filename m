Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C78387FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 12:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfFGKb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 06:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfFGKb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:31:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 830A230821EC;
        Fri,  7 Jun 2019 10:31:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 275595BBCF;
        Fri,  7 Jun 2019 10:31:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  7 Jun 2019 12:31:26 +0200 (CEST)
Date:   Fri, 7 Jun 2019 12:31:22 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Wong <e@80x24.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH -mm 0/2] aio: simplify/fix the usage of
 restore_saved_sigmask_unless()
Message-ID: <20190607103122.GA22167@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 07 Jun 2019 10:31:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Absolutely untested. Benjamin, please review.

This depends on

	signal-remove-the-wrong-signal_pending-check-in-restore_user_sigmask.patch
	signal-simplify-set_user_sigmask-restore_user_sigmask.patch

Oleg.

 fs/aio.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

