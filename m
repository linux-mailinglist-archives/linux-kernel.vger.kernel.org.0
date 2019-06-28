Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F240A5A292
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 19:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfF1Rkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 13:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfF1Rku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:40:50 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 844EE208C4;
        Fri, 28 Jun 2019 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561743649;
        bh=E2rPaZ/w0QRIgp5Xnmu9zvuKAIr/KYB0EIpZnDe4dyM=;
        h=From:To:Cc:Subject:Date:From;
        b=LhWBthD/j/JmD/7Ru1eF8v5f6U7GFgrq3arYLW5P1Zg8IKOa7AzTatOhQZPIIGhLT
         sTXazWNnam6eMs1R2/xqfOLC6rTvtPm1NrO3IPlXI5wBlFWthGkMr3jormbUhjUmZM
         4Jcn7r7IV9Ccig+4dFZaUcqJc5zf5Io5VKpd2jS8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] tracing: Improve error messages for histogram sorting
Date:   Fri, 28 Jun 2019 12:40:19 -0500
Message-Id: <cover.1561743018.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of the histogram sorting error message patchset.  The code
is the same as v1 - this version only adds new Fixes:, Reviewed-by:,
and Reported-by: tags.

Text from original post:

Hi,

These patches add some improvements for histogram sorting, addressing
some shortcomings pointed out by Masami.

In order to address the specific problem pointed out by Masami, as
well as add additional related error messages, the first patch
does some simplification of assignment parsing.

The second patch actually adds the new error messages.

The fourth patch adds a new testcase for hist trigger parsing, similar
to the same kind of tests for kprobes and uprobes.  Additional tests
covering all possible hist trigger errors should/will be added here in
the future.

The third patch just adds a missing hist: prefix to the error log so
that the testcases work properly, and which should have been there
anyway.

Thanks,

Tom


The following changes since commit a124692b698b00026a58d89831ceda2331b2e1d0:

  ftrace: Enable trampoline when rec count returns back to one (2019-05-25 23:04:43 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace-hist-sort-err-msgs-v2

Tom Zanussi (4):
  tracing: Simplify assignment parsing for hist triggers
  tracing: Add hist trigger error messages for sort specification
  tracing: Add 'hist:' to hist trigger error log error string
  tracing: Add new testcases for hist trigger parsing errors

 kernel/trace/trace_events_hist.c                   | 94 +++++++++++-----------
 .../test.d/trigger/trigger-hist-syntax-errors.tc   | 32 ++++++++
 2 files changed, 78 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc

-- 
2.14.1

