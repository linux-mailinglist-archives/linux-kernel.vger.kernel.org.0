Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374F94AA55
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 20:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfFRSvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 14:51:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfFRSva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SKRSL9jnylaTQ6qXeJHCBAsp9dKQfYRmnXanorGc5eo=; b=LXa3IxlXYF9BK4XDFYoBkFK/C
        ayj7wVmS/70JjZnx+pA/SY/2Q7iEuexASOgoE1EhAN8aCIeaCsyHgduBAkwayw9iy21eApOGYiUVx
        Ne7xoTALEaJ7EydCcLjRisMFAWa3umScRvwd0i+xgZDzHlMRbILUOiCzmxWPLuIaq0Q4cF2IuyeER
        aNj0mI1gnd4iiqruK3JFsutCUD5NwBvMO1h7jIemayxgDHqgNGBIEvIZOYI/fDhpVYYBeRc2565tt
        SfICYZwjO5Dl0HXEGCy8bbfm8Kddvp9t6FkHu+VVIOBSOn0pSbZAt1MoMYoNb+DjnNsCzBOelmZzy
        tU97Zkv5g==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdJCa-0006RK-0j; Tue, 18 Jun 2019 18:51:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdJCW-0006U8-9m; Tue, 18 Jun 2019 15:51:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH 1/6] docs: trace: fix a broken label
Date:   Tue, 18 Jun 2019 15:51:17 -0300
Message-Id: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx warnings about his:

	Documentation/trace/kprobetrace.rst:68: WARNING: undefined label: user_mem_access (if the link has no caption the label must precede a section header)

The problem is quite simple: Sphinx wants a blank line after
references.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/trace/kprobetrace.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index b729b40a5ba5..3d162d432a3c 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -96,6 +96,7 @@ which shows given pointer in "symbol+offset" style.
 For $comm, the default type is "string"; any other type is invalid.
 
 .. _user_mem_access:
+
 User Memory Access
 ------------------
 Kprobe events supports user-space memory access. For that purpose, you can use
-- 
2.21.0

