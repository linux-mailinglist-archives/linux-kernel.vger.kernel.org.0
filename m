Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB617A015
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 07:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgCEGoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 01:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgCEGoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:44:16 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F945208CD;
        Thu,  5 Mar 2020 06:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583390656;
        bh=a4aJEqUwvJ6/7STY08t7rKwFcED+LE1xGTYq8HoLoRA=;
        h=From:To:Cc:Subject:Date:From;
        b=vcRiLx5ON5PzsPLXKxh3FQZz4Ec+SMCO0kFvfohkqo00564mTrjuUuT/V5Zn7DYOb
         yrGWAKwuS5Hh7wOxUXYlgEKZy7+Jxq4RS8JmIo6q/nyPEDZfFc+Qu4EN7gkgWDfFtk
         xt5ZlWKLmkiMxWCJq8pZi0vrB/xfHxODIYODABEY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v5 0/1] Documentation: bootconfig: Documentaiton updates
Date:   Thu,  5 Mar 2020 15:44:12 +0900
Message-Id: <158339065180.26602.26457588086834858.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 5th version of the documentation update.
- Elaborated according to Randy's comment.
- Fix some typos.

Thank you,

---

Masami Hiramatsu (1):
      Documentation: bootconfig: Update boot configuration documentation


 Documentation/admin-guide/bootconfig.rst |  201 +++++++++++++++++++-----------
 Documentation/trace/boottime-trace.rst   |    2 
 2 files changed, 131 insertions(+), 72 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
