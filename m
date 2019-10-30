Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E7E9C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 14:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfJ3NZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 09:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfJ3NZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:25:05 -0400
Subject: Re: [GIT PULL] gfs2: Fix remounting (broken in -rc1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572441905;
        bh=KgXJ9j5HWnetaN9CgIX50RksIn17hT55GgvLirltvWs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q6xYfSL12b0zumb3Xva9awmwsht1kRzKQl0VBVX9BI8coeE+mWjIQShWLHryLWcKe
         yLweQu+wq+9lMhBGLFCVjO/8hOSm9TFYNJEVhcJqH05bsK3J2ZbHg6ggLXwq+szbwH
         j9sgs+z3ydMSr15UU4qj1dWbYpQ2W4CtpwCve2dA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191030112449.24984-1-agruenba@redhat.com>
References: <20191030112449.24984-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191030112449.24984-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-v5.4-rc5.fixes
X-PR-Tracked-Commit-Id: d5798141fd54cea074c3429d5803f6c41ade0ca8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b66b449872d3652651cec775267f72f274eb7d7e
Message-Id: <157244190524.19806.14233336921494801373.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Oct 2019 13:25:05 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Oct 2019 12:24:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.4-rc5.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b66b449872d3652651cec775267f72f274eb7d7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
