Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5746419A2A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 01:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbgCaXzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 19:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732068AbgCaXzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:55:14 -0400
Subject: Re: [GIT PULL] NTB bug fixes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585698913;
        bh=UY4X6QF5Bfy3V1pVtJ/M4nE/WgRyjfPeRFCXPafV/cA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gkAJAf7g3cRGzXE4rIoRGz9cfaQcU8hkGYPKVktdECG5QSyMgQM1ZpZ2kRnMejOUT
         hQy5gIT2I8cjqynyIPIePcznnEoNwHWOnirifCJkoa0R4jCoqespk+sTmje4KLWXm5
         ZIsE8lt9Ij6t6zNvd7Z3eObif3g9qxDleNtmeAtA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331152721.GA1719@athena.kudzu.us>
References: <20200331152721.GA1719@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331152721.GA1719@athena.kudzu.us>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.7
X-PR-Tracked-Commit-Id: b350f0a3eb264962caefeb892af56c1b727ee03f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56a451b780676bc1cdac011735fe2869fa2e9abf
Message-Id: <158569891371.16027.14099209625031293428.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 23:55:13 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 11:27:21 -0400:

> git://github.com/jonmason/ntb tags/ntb-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56a451b780676bc1cdac011735fe2869fa2e9abf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
