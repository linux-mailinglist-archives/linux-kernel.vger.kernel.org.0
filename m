Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34432C0B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfI0SkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 14:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbfI0SkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:40:23 -0400
Subject: Re: [GIT PULL] NTB changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569609623;
        bh=A/Y1zfR4jdpsMGSHUOe95iEWb2V4PbAMwawWX1yjIpY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iEObLx7T4yKHOYiQ1DIrgoBwelCiW5/kNYv8rzVFJ4xB51pE/8MfNN3OV6GG4UpRB
         p+GQTF+bHoVDGUpX/VQ3ebt0/7d06MlIVa+8+/6WkvCs2S6HO0vBhFLi22U/sIomAT
         lxyvm+ctZjb6yPFGKjOeOFcp+O8yhnvkF+NtH9rA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190926173522.GA15861@graymalkin>
References: <20190926173522.GA15861@graymalkin>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190926173522.GA15861@graymalkin>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.4
X-PR-Tracked-Commit-Id: 4720101fab62d0453babb0287b58a9c5bf78fb80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cd81d77d0569f1dc1e39abeea93c6184e9b5b54
Message-Id: <156960962332.11345.15498745655077922358.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Sep 2019 18:40:23 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 13:35:22 -0400:

> git://github.com/jonmason/ntb tags/ntb-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cd81d77d0569f1dc1e39abeea93c6184e9b5b54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
