Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621BD585F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 17:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF0Pfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 11:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfF0Pfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:35:44 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC2A220B1F;
        Thu, 27 Jun 2019 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561649744;
        bh=/4h+ONBgi96kmLFUK3aNMR+0Nf/soN2dsmTEDJ58TlA=;
        h=From:To:Cc:Subject:Date:From;
        b=E4JaFDusIJNP6oyyqK7SuYpdHoFiV1aup93/k0m6wLBGHTbAvhezYBW0J6Su41vur
         VM0GVoCPR1nKrYGyl+fd2AeDgc4Z24uE82q2Ks3TpDEiGNmb7JVjyoaICmFjwgYPPW
         l/rsoHOheoxpuy8iATahkGnh7Xnp7TaezWIojN+8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] tracing: Improve error messages for histogram sorting
Date:   Thu, 27 Jun 2019 10:35:15 -0500
Message-Id: <cover.1561647046.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace-hist-sort-err-msgs-v1

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

