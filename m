Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B1D56FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 19:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFZRgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 13:36:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:40900 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZRf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:35:56 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id CEB978E7;
        Wed, 26 Jun 2019 17:29:11 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 4/4] docs: Note that :c:func: should no longer be used
Date:   Wed, 26 Jun 2019 11:28:59 -0600
Message-Id: <20190626172859.16113-5-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626172859.16113-1-corbet@lwn.net>
References: <20190626172859.16113-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can mark up function() automatically, there is no reason to use
:c:func: and every reason to avoid it.  Adjust the documentation to reflect
that fact.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/sphinx.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index e60a56640c63..f71ddd592aaa 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -241,11 +241,14 @@ The C domain of the kernel-doc has some additional features. E.g. you can
 
 The func-name (e.g. ioctl) remains in the output but the ref-name changed from
 ``ioctl`` to ``VIDIOC_LOG_STATUS``. The index entry for this function is also
-changed to ``VIDIOC_LOG_STATUS`` and the function can now referenced by:
-
-.. code-block:: rst
-
-     :c:func:`VIDIOC_LOG_STATUS`
+changed to ``VIDIOC_LOG_STATUS``.
+
+Please note that there is no need to use ``c:func:`` to generate cross
+references to function documentation.  Due to some Sphinx extension magic,
+the documentation build system will automatically turn a reference to
+``function()`` into a cross reference if an index entry for the given
+function name exists.  If you see ``c:func:`` use in a kernel document,
+please feel free to remove it.
 
 
 list tables
-- 
2.21.0

