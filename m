Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FDE168AD9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 01:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBVAPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 19:15:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgBVAPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:15:15 -0500
Subject: Re: [GIT PULL] xen: branch for v5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582330514;
        bh=w0AXXX5Jnq2K8zg6+WlX1jXoupG0xTojsceuNIVWrxk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EcOCVlt9VEUDCBTzS1POuptZJSZwJrbT1nzO7Knrys+Hy7H77RRL9FMdWYbT9d8Xm
         zUudFUjxZPfxyY6ClKViQwi/8RmBBdmzTQ3/5doqIldtuB2ajKA8rOOeyQm8s4o9Dw
         YajPwQkDgShXAlXtzE56yGtURuEPauK3L/MLT20s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200221193331.6580-1-jgross@suse.com>
References: <20200221193331.6580-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200221193331.6580-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.6-rc3-tag
X-PR-Tracked-Commit-Id: 8645e56a4ad6dcbf504872db7f14a2f67db88ef2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54dedb5b571d2fb0d65c3957ecfa9b32ce28d7f0
Message-Id: <158233051462.15315.1311300506464261075.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Feb 2020 00:15:14 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 20:33:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.6-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54dedb5b571d2fb0d65c3957ecfa9b32ce28d7f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
