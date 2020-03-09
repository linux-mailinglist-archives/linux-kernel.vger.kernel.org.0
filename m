Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B798A17E9F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 21:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCIUYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 16:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgCIUYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:24:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60CF82146E;
        Mon,  9 Mar 2020 20:24:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jBOxH-0033zu-7x; Mon, 09 Mar 2020 16:24:51 -0400
Message-Id: <20200309202231.580868511@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 09 Mar 2020 16:22:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-linus][PATCH 0/4] ktest: Fixes and updates for 5.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ktest fixes and clean ups

- Make the default option oldconfig instead of randconfig
  (one too many times I lost my config because I left the build type out)

- Add timeout to ssh sync to sync before reboot (prevents test hangs)

- A couple of spelling fix patches

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v5.6

Tag SHA1: 72ff3685b8f4346bbb71515e9c4655524523c7d1
Head SHA1: 1091c8fce8aa9c5abe1a73acab4bcaf58a729005


Masanari Iida (2):
      ktest: Fix some typos in sample.conf
      ktest: Fix typos in ktest.pl

Steven Rostedt (VMware) (2):
      ktest: Make default build option oldconfig not randconfig
      ktest: Add timeout for ssh sync testing

----
 tools/testing/ktest/ktest.pl    | 16 ++++++++--------
 tools/testing/ktest/sample.conf | 22 +++++++++++-----------
 2 files changed, 19 insertions(+), 19 deletions(-)
