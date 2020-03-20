Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8218CC76
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 12:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgCTLMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 07:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgCTLMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:12:41 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5841820732;
        Fri, 20 Mar 2020 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584702760;
        bh=jrxRPo3Al4EllmStVtukK8u75F0dpWLR0x6+rUwc8jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18UjZVsAMzB7G3D+8UiPRBRhGti9d8bXoDeEGqGx318Pa3fKia4NUxA3CWvEpPSl9
         TL4gh7DyjePqjv3ICrxWu30RmHTzJt1BmlNmyks88SM/AYTa0gIFSMCdFtkbY60R7y
         pSS5fPKhvhRUlYhThFheO4267115cyTZuv1IVf8w=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jFFZu-000nqZ-9e; Fri, 20 Mar 2020 12:12:38 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs: conf.py: avoid thousands of duplicate label warning on Sphinx
Date:   Fri, 20 Mar 2020 12:12:35 +0100
Message-Id: <16f1c270a9077032de379b1cb30dfbb3e3670aee.1584702515.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320112122.48244ec4@coco.lan>
References: <20200320112122.48244ec4@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The autosectionlabel extension is nice, as it allows to refer to
a section by its name without requiring any extra tag to create
a reference name.

However, on its default, it has two serious problems:

1) the namespace is global. So, two files with different
   "introduction" section would create a label with the
   same name. This is easily solvable by forcing the extension
   to prepend the file name with:

	autosectionlabel_prefix_document = True

2) It doesn't work hierarchically. So, if there are two level 1
   sessions (let's say, one labeled "open" and another one "ioctl")
   and both have a level 2 "synopsis" label, both section 2 will
   have the same identical name.

   Currently, there's no way to tell Sphinx to create an
   hierarchical reference like:

		open / synopsis
		ioctl / synopsis

  This causes around 800 warnings. So, the fix should be to
  not let autosectionlabel to produce references for anything
  that it is not at level one, with:

	autosectionlabel_maxdepth = 1

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index fa2bfcd6df1d..f193bae85a36 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -40,6 +40,10 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel' ]
 
+# Ensure that autosectionlabel will produce unique names
+autosectionlabel_prefix_document = True
+autosectionlabel_maxdepth = 1
+
 # The name of the math extension changed on Sphinx 1.4
 if (major == 1 and minor > 3) or (major > 1):
     extensions.append("sphinx.ext.imgmath")
-- 
2.24.1

