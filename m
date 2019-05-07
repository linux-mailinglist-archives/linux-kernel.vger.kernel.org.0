Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6010116DD6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 01:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfEGXcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 19:32:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42137 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726276AbfEGXcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:32:12 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x47NW8Nx014155
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 May 2019 19:32:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1CE9A420024; Tue,  7 May 2019 19:32:08 -0400 (EDT)
Date:   Tue, 7 May 2019 19:32:08 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random changes for 5.2
Message-ID: <20190507233208.GA28817@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git tags/random_for_linus

for you to fetch changes up to b7d5dc21072cda7124d13eae2aefb7343ef94197:

  random: add a spinlock_t to struct batched_entropy (2019-04-20 00:09:56 -0400)

----------------------------------------------------------------
Initialize the random driver earler; fix CRNG initialization when we
trust the CPU's RNG on NUMA systems; other miscellaneous cleanups and
fixes.

----------------------------------------------------------------
George Spelvin (1):
      random: document get_random_int() family

Jon DeVree (1):
      random: fix CRNG initialization when random.trust_cpu=1

Kees Cook (1):
      random: move rand_initialize() earlier

Rasmus Villemoes (3):
      drivers/char/random.c: constify poolinfo_table
      drivers/char/random.c: remove unused stuct poolinfo::poolbits
      drivers/char/random.c: make primary_crng static

Sebastian Andrzej Siewior (1):
      random: add a spinlock_t to struct batched_entropy

Theodore Ts'o (1):
      random: only read from /dev/random after its pool has received 128 bits

 drivers/char/random.c         | 199 +++++++++++++++++++++++++++++++++++++++++++++---------------------
 include/linux/random.h        |   1 +
 include/trace/events/random.h |  13 ++---
 init/main.c                   |  21 ++++---
 4 files changed, 156 insertions(+), 78 deletions(-)
