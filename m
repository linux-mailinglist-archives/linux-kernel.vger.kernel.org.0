Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058741858FC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 03:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCOC3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 22:29:08 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36160 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgCOC3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:29:08 -0400
Received: by mail-oi1-f196.google.com with SMTP id k18so13983418oib.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2Vtp6RziDROzvH8yIpP+NdD0+3UH936uqc8V70qQipQ=;
        b=YzxmYKTSEsNy4DT+S0weqMXMr5P/1nzCYGs7YS0f5LFK69IBCOIg7sExvuMPd2kwAr
         zyWtVr5EsMuWOKAittBQyKGgGbzsYH9Gc2K3WWRnzqeGGYingVIIIF49pgzLPbChCciV
         ZpN2FeU2lqEGAlFNTZFVS/uHPgO0YiewmSxas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2Vtp6RziDROzvH8yIpP+NdD0+3UH936uqc8V70qQipQ=;
        b=gPFAQV6BnSWM2LD8q475IyrSkxyL1yy/Not/0VO/ebddyL5S/pF7cnNrxlwCUUHeZE
         /Do3AJKTa10YnOZuniO/MtxKzswEaWKpZE3AUWn5Kwo1hc1nWYqE9L+RQuIcpuqzeF3k
         k5cG/4YgyoRJRJAWQGWgM1u04XRgmr/WO4kcc+CiWg2GyIK+QH+0Fk/fxl7rqbC+UPHb
         jbhZFfMsdicEqiB0yWzcaOEpLGOPZC3PxQcdLxznb4cWFGqLZ5sdYRplSyd9JFSlOORC
         l85rvDynZvnpEYYJ+eXoA5PT+g4ZAJwNZGxQ8fbiwwdDdje9+Ra0ANsJzEsbKwJNud2M
         XYiA==
X-Gm-Message-State: ANhLgQ3SlOLUDpvmnR9fo9RwlKJyL4DmupIyt0Fuzwt0QgNlEclviuvv
        lir1j11KBqWw4j80+I6IfJ+mCYtc6Lg=
X-Google-Smtp-Source: ADFU+vtcv4mmKyVQD6HwYI0JfKVikRY3fBaC0JTroah921NcWDc4xFgcfScoMqYygxt9fTA2h70mSQ==
X-Received: by 2002:a17:90a:c715:: with SMTP id o21mr17508203pjt.160.1584224992481;
        Sat, 14 Mar 2020 15:29:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 63sm22033516pfx.132.2020.03.14.15.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:29:51 -0700 (PDT)
Date:   Sat, 14 Mar 2020 15:29:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: deprecated.rst: Add BUG()-family
Message-ID: <202003141524.59C619B51A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus continues to remind[1] people to stop using the BUG()-family of
functions. We should have this better documented (even if checkpatch.pl
has been warning[2] since 2015), so add more details to deprecated.rst,
as a distinct place to point people to for guidance.

[1] https://lore.kernel.org/lkml/CAHk-=whDHsbK3HTOpTF=ue_o04onRwTEaK_ZoJp_fjbqq4+=Jw@mail.gmail.com/
[2] https://git.kernel.org/linus/9d3e3c705eb395528fd8f17208c87581b134da48

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/deprecated.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 8965446f0b71..38843c7a9ad6 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -29,6 +29,28 @@ a header file, it isn't the full solution. Such interfaces must either
 be fully removed from the kernel, or added to this file to discourage
 others from using them in the future.
 
+BUG() and BUG_ON()
+------------------
+Use WARN() and WARN_ON() instead, and handle the "impossible"
+error condition as gracefully as possible. While the BUG()-family
+of APIs were originally designed to act as an "impossible situation"
+assert and to kill a kernel thread "safely", they turn out to just be
+too risky. (e.g. "In what order do locks need to be released? Have
+various states been restored?") Very commonly, using BUG() will
+destabilize a system or entirely break it, which makes it impossible
+to debug or even get viable crash reports. Linus has `very strong
+<https://lore.kernel.org/lkml/CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com/>`_
+feelings `about this
+<https://lore.kernel.org/lkml/CAHk-=whDHsbK3HTOpTF=ue_o04onRwTEaK_ZoJp_fjbqq4+=Jw@mail.gmail.com/>`_.
+
+Note that the WARN()-family should only be used for "expected to
+be unreachable" situations. If you want to warn about "reachable
+but undesirable" situations, please use the pr_warn()-family of
+functions. System owners may have set the *panic_on_warn* sysctl,
+to make sure their systems do not continue running in the face of
+"unreachable" conditions. (For example, see commits like `this one
+<https://git.kernel.org/linus/d4689846881d160a4d12a514e991a740bcb5d65a>`_.)
+
 open-coded arithmetic in allocator arguments
 --------------------------------------------
 Dynamic size calculations (especially multiplication) should not be
-- 
2.20.1


-- 
Kees Cook
