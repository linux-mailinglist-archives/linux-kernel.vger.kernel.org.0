Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF916BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 21:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEGTzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 15:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbfEGTzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:55:12 -0400
Subject: Re: [GIT PULL] jfs updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557258911;
        bh=2lI3MfI2R6JOtn/xqkExTbji1ia0pxrZ/ynV1iR60kg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KjwMrF2+V/D3k0DYNEKl9varCLtVakJMgIxa5sa4ihKClWI4ppmB0lz1yyJaUaPw9
         Ta/pbg/imhydTu7UYryMu/1Wt4reewImIe0KY/yMAWXHPQ/fRKcr+wL8S+S7vptAaN
         aKNh+BpIzeX+vfvV52RABwlLP+G8+bNSu6XfnslY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e999ebed-a882-049c-dab5-631a2c0a4ec3@oracle.com>
References: <e999ebed-a882-049c-dab5-631a2c0a4ec3@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e999ebed-a882-049c-dab5-631a2c0a4ec3@oracle.com>
X-PR-Tracked-Remote: git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.2
X-PR-Tracked-Commit-Id: a5fdd713d256887b5f012608701149fa939e5645
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8cac3cd24c19113982f929c65c50ce99d4cb83f
Message-Id: <155725891187.4809.18201650844855593149.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 19:55:11 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        JFS Discussion <jfs-discussion@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 10:31:49 -0500:

> git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8cac3cd24c19113982f929c65c50ce99d4cb83f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
