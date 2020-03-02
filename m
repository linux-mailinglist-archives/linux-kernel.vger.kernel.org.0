Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71BB3175524
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 09:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCBIDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 03:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBIDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:03:43 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C68224699;
        Mon,  2 Mar 2020 08:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136222;
        bh=jvZ9ChLJEH+7A4zTPFo3Afj6QQThw+sgjPSHjQyNRPA=;
        h=From:To:Cc:Subject:Date:From;
        b=lqM/jfso67NF1Uij0Rcaa0+BM0Y7ccXC+sxB9qKKtuLfaGdlCc4Zribx6YHbZBf7Q
         Z80IdOFkkk05+9vXmTXkjbtPtp83Asjz/+CrLuhSZV9cF6z9bxlMABcE7xZ2vPj/IX
         GOLRhAxU95pWl9I43z6252VY94sz7r8ohzUWJ/OU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v3 0/1] Documentation: bootconfig: Documentaiton updates
Date:   Mon,  2 Mar 2020 17:03:38 +0900
Message-Id: <158313621831.3082.9886161529613724376.stgit@devnote2>
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

Here is the 3rd version of the documentation update.
I updated it according to Randy's comment.

Thank you,

---

Masami Hiramatsu (1):
      Documentation: bootconfig: Update boot configuration documentation


 Documentation/admin-guide/bootconfig.rst |  181 +++++++++++++++++++-----------
 Documentation/trace/boottime-trace.rst   |    2 
 2 files changed, 117 insertions(+), 66 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
