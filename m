Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115D9124BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfLRP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 10:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfLRP1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:27:48 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFDA1206CB;
        Wed, 18 Dec 2019 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576682868;
        bh=fMJ24E+BrVePbr+BJKMUx9pBydYryJPa/wD8enggb/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=l9nbCplZQGQo/EWSs2xDK6kyRSv9uIgvsB6tlJ69fzT0IcDrVEnqHIF6iHjXJDKCY
         HT8kY55NDwXIXOxecdjULNQqemwhd7WDKXE/g6CgYFK0pDd3FkUxwQRekLnJbg1Dg/
         W7oS9VmlT/NwS52iKxI/RXro8702P/OzmcvPUjlI=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 0/7] tracing: Add support for in-kernel synthetic event API
Date:   Wed, 18 Dec 2019 09:27:36 -0600
Message-Id: <cover.1576679206.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've recently had several requests and suggestions from users to add
support for the creation and generation of synthetic events from
kernel code such as modules, and not just from the available command
line commands.

This patchset adds support for that.  The first three patches add some
minor preliminary setup, followed by the two main patches that add the
ability to create and generate synthetic events from the kernel.  The
next patch adds a test module that demonstrates actual use of the API
and verifies that it works as intended, followed by Documentation.

Special thanks to Artem Bityutskiy, who worked with me over several
iterations of the API, and who had many great suggestions on the
details of the interface, and pointed out several problems with the
code itself.

The following changes since commit d783b3c08c14fccbc4d5ef33a38288ec9b264df7:

  tracing: Have the histogram compare functions convert to u64 first (2019-12-11 15:47:14 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-event-gen-v1

Tom Zanussi (7):
  tracing: Add trace_array_find() to find instance trace arrays
  tracing: Add get/put_event_file()
  tracing: Add delete_synth_event()
  tracing: Add create_synth_event()
  tracing: Add generate_synth_event() and related functions
  tracing: Add synth event generation test module
  tracing: Documentation for in-kernel synthetic event API

 Documentation/trace/events.rst      | 268 +++++++++++++
 include/linux/trace_events.h        |  53 +++
 kernel/trace/Kconfig                |  13 +
 kernel/trace/Makefile               |   1 +
 kernel/trace/synth_event_gen_test.c | 330 ++++++++++++++++
 kernel/trace/trace.c                |  30 +-
 kernel/trace/trace.h                |   1 +
 kernel/trace/trace_events.c         | 130 +++++++
 kernel/trace/trace_events_hist.c    | 722 +++++++++++++++++++++++++++++++++++-
 9 files changed, 1521 insertions(+), 27 deletions(-)
 create mode 100644 kernel/trace/synth_event_gen_test.c

-- 
2.14.1

