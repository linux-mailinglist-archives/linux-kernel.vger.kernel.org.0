Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0620B02E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfIKRqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 13:46:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbfIKRqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:46:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA5D6307D98A;
        Wed, 11 Sep 2019 17:46:01 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-27.ams2.redhat.com [10.36.112.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AF3F10018FF;
        Wed, 11 Sep 2019 17:45:54 +0000 (UTC)
Date:   Wed, 11 Sep 2019 18:45:27 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v3] fork: check exit_signal passed in clone3() call
Message-ID: <cover.1568223594.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 11 Sep 2019 17:46:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

As was agreed[1][2], clone3 should fail if the provided exit_signal
value fails valid_signal() check, hence the new version.

Changees since v2[3][4]:
 - Rewrite the check to check exit_signal against valid_signal().

Changes since v1[5]:
 - Check changed to comparison against negated CSIGNAL to address
   the bug reported by Oleg[6].
 - Added a comment to _do_fork that exit_signal has to be checked
   by the caller.

[1] https://lkml.org/lkml/2019/9/11/503
[2] https://lkml.org/lkml/2019/9/11/518
[3] https://lkml.org/lkml/2019/9/10/764
[4] https://lkml.org/lkml/2019/9/10/765
[5] https://lkml.org/lkml/2019/9/10/411
[6] https://lkml.org/lkml/2019/9/10/467


Eugene Syromiatnikov (1):
  fork: check exit_signal passed in clone3() call

 kernel/fork.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.1.4

