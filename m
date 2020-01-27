Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF114ACC3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 00:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgA0XzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 18:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgA0XzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:55:04 -0500
Subject: Re: [GIT PULL] Audit patch for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580169303;
        bh=sGORSLfgEUncLD86eTp1orYI44EIvU+DUWuct3t6Jjo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VT7L+G+nzXkJTDVG3xyxsmJEfw+/cJC4bNfMLKgBXBON4cdmMAkxjPe+zpq/1Ow5g
         NVkBpnakrrxIkTuNQJcdlGjki0JE4GCEZMa2TGpCSavt+tzz02N72vEkeb1Psett0k
         BGvDD+KMxsGjPTupFN9ot/j4NGe0jEqXjDU6PMTk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRm1dAsc+_eH7iKj4C6RVdzYeZLLqShcOjvMMbEaB4VQA@mail.gmail.com>
References: <CAHC9VhRm1dAsc+_eH7iKj4C6RVdzYeZLLqShcOjvMMbEaB4VQA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRm1dAsc+_eH7iKj4C6RVdzYeZLLqShcOjvMMbEaB4VQA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20200127
X-PR-Tracked-Commit-Id: cb5172d96d16df72db8b55146b0ec00bfd97f079
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07e309a972cae9de1807f48968f4673f6868e211
Message-Id: <158016930370.17044.5708242043522403584.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 23:55:03 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 15:33:04 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20200127

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07e309a972cae9de1807f48968f4673f6868e211

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
