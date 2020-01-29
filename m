Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C2914C4B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 03:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgA2CpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 21:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgA2CpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 21:45:06 -0500
Subject: Re: [GIT PULL] uml updates for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580265905;
        bh=bb6Unxg9OUmrUkSHwUqeiee1T9xhm2drQELfuj87QZI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vM2YQy+6ULmaVqRnHE6j3RGeUjaRmm8FqEc83yeuJ+/Zyhy2LW26sxfT/i3VAFiu/
         doRdmab2OM+m43eOA+CZFV6wxnNx4vbJBJnJGNWcFI3mv1HK3ckSxJhoYt8PL307Ox
         BDTWGL6TlyACo0OummU0D+5cX0OSa15z6Opvglwo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <aaf07936-6fd2-be40-15dc-f87e8e84091d@cambridgegreys.com>
References: <aaf07936-6fd2-be40-15dc-f87e8e84091d@cambridgegreys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aaf07936-6fd2-be40-15dc-f87e8e84091d@cambridgegreys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 tags/for-linus-5.6-rc1
X-PR-Tracked-Commit-Id: d65197ad52494bed3b5e64708281b8295f76c391
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fad7bdc9b054a3dc2f5e77a8061c07aead6f5a5e
Message-Id: <158026590586.23129.18144901503354575122.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 02:45:05 +0000
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>, johannes@sipsolutions.net,
        linux-um@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 09:24:07 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fad7bdc9b054a3dc2f5e77a8061c07aead6f5a5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
