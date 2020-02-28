Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22BFF1732EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 09:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgB1IaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 03:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgB1IaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:30:16 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0E8B246A2;
        Fri, 28 Feb 2020 08:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582878615;
        bh=Q4d1ujfugZZbNPZoNXLm0GUaHiz3wA3NnL297v452LY=;
        h=From:To:Cc:Subject:Date:From;
        b=WYJCpbhTUHSWIe+uBteC4n05JfJwUz5R1/wbRvpWT0g4G4z2EbCQ0Ly21DPDnuHpc
         pZWbhzeqSTnQFkxWVH86xGDLeAc1jFnu1QlNuR5yaWySQbCBll87yUyyFyd8M+m+mA
         s2J0+JNFCgaMBWMDV5rzIimWgC7LjIhQ9m9PHCxA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v2 0/1] Documentation: bootconfig: Documentaiton updates
Date:   Fri, 28 Feb 2020 17:30:11 +0900
Message-Id: <158287861133.18632.12035327305997207220.stgit@devnote2>
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

Here is the 2nd version of the documentation update.
I decided to drop EBNF (extended Backus–Naur form) patch
since the ISO/IEC 14977 EBNF seems not carefully defined
and there are many variants which named EBNF.
I'll postpone it until finding better solution.

Thank you,

---

Masami Hiramatsu (1):
      Documentation: bootconfig: Update boot configuration documentation


 Documentation/admin-guide/bootconfig.rst |  180 +++++++++++++++++++-----------
 Documentation/trace/boottime-trace.rst   |    2 
 2 files changed, 116 insertions(+), 66 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
