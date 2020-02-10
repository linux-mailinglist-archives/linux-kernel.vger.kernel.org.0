Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32483156E18
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 04:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgBJDxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 22:53:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgBJDxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 22:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Vjbb/KdteHQAi18CNlMEoi7YtSU7M1n22U0ASM+2miA=; b=tkQVblP/JrGsAbn8GCicUcTxcM
        FfdV2AieTLHAWx1K6ItImexZ0V5qqkO7V8vKJNngaBt5sf1fN/O0k7DVhpA++RlZBOMyNitfWd75w
        SYqscXyqY7rcIWInxP9c1hqT0E6BQmdgXasFdqVREQUg45loR7e6DvsTmIv1zS5hroXb+RpyaISTE
        MDaHHLKLH3fZK3I3W76eeJ+gTHQwbwSnOKtOorFjAMTLHSYdmuxPncB6c0yveslbHGIp9CrcFsdEL
        zxIPxoM/r4476G7blvYQW8O3YfgJRUY4ZKNQol7C7KBKcuw+F3gYeSd3OrxgDYRt3b6g3dagN/Wvf
        DV9elrkA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j108M-0000Uf-8k; Mon, 10 Feb 2020 03:53:18 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: bootconfig: fix Sphinx block warning
Message-ID: <07b3e31f-9b1e-1876-aa60-4436e4dd6da0@infradead.org>
Date:   Sun, 9 Feb 2020 19:53:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx format warning:

lnx-56-rc1/Documentation/admin-guide/bootconfig.rst:26: WARNING: Literal block expected; none found.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-56-rc1.orig/Documentation/admin-guide/bootconfig.rst
+++ lnx-56-rc1/Documentation/admin-guide/bootconfig.rst
@@ -23,7 +23,7 @@ of dot-connected-words, and key and valu
 has to be terminated by semi-colon (``;``) or newline (``\n``).
 For array value, array entries are separated by comma (``,``). ::
 
-KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
+  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
 
 Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
 

