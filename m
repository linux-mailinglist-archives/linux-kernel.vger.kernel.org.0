Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9147B653
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 01:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfG3XlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 19:41:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37303 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfG3XlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:41:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so29550109plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 16:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSa7l69bHF4dPAb8gb5NP/5/SL+YaF6sYOOZvuhAWNI=;
        b=MoqGY6iTg3hEO4gKx4Wtf3pREuvvP0H7nvS1wLo0diUb+vTJKR+vvBSQ4FF0nxpYzg
         sHGhTOg6OVimuC48NJhn/Hwu3P2aK1D/xsIJWXY8WLT0vAw/qDbF0cJE8bST3SvdkZoU
         bNhwoPpAdn+FnMjJdzKHo4F+aetnvnhz7ohTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSa7l69bHF4dPAb8gb5NP/5/SL+YaF6sYOOZvuhAWNI=;
        b=QpGBlWg+0klwv9PBpC7UXWJKcmmBwANYtJhV9URw6V4h8h4bBowaP0E2xVPRtDWfsv
         8wXe2yRxYl18+YfyN2a15KfAJL6ylUBea0dVGfLsK8MQSK3x9wEvBmuuvg030UUJdwYB
         rrNW9jfZV/rKAarLQ1mmaoSFA07hDmVXzW++wl/7cELOFtxaD/jJnXAdYeZ/0jeQIqor
         PaMYVK5oxMv++JKoEiV76wkZE68FNltGkKlo8y/GsFkT+ZUeaxzL1z9nNdPxvpSZWF0L
         GtnQ+FvViwXHNoDt3SzG1ghWb9lEp0HaW9+pGRg5a9S69rm2mxaCpfgvks5cssCWaQtJ
         p8gw==
X-Gm-Message-State: APjAAAWdOF5guu62CBGZ6/EXD/aYcSEd0jWR6C/axqONozWpJNT2r4Hk
        Px6BrkRwQtfb4sqFaF05uHFA2Q==
X-Google-Smtp-Source: APXvYqw50DenQEnXnau8Bdn4emzZ6IKTq2ieNJ4qbNkD4Vd5HZ17BL/ufMmVvw8xiv/DUn1JsEA6mg==
X-Received: by 2002:a17:902:24a2:: with SMTP id w31mr41359301pla.324.1564530065665;
        Tue, 30 Jul 2019 16:41:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id u128sm74772530pfu.48.2019.07.30.16.41.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 16:41:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/gdb: Handle split debug
Date:   Tue, 30 Jul 2019 16:40:52 -0700
Message-Id: <20190730234052.148744-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems (like Chrome OS) may use "split debug" for kernel
modules.  That means that the debug symbols are in a different file
than the main elf file.  Let's handle that by also searching for debug
symbols that end in ".ko.debug".

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 scripts/gdb/linux/symbols.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 2f5b95f09fa0..34e40e96dee2 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -77,12 +77,12 @@ lx-symbols command."""
             gdb.write("scanning for modules in {0}\n".format(path))
             for root, dirs, files in os.walk(path):
                 for name in files:
-                    if name.endswith(".ko"):
+                    if name.endswith(".ko") or name.endswith(".ko.debug"):
                         self.module_files.append(root + "/" + name)
         self.module_files_updated = True
 
     def _get_module_file(self, module_name):
-        module_pattern = ".*/{0}\.ko$".format(
+        module_pattern = ".*/{0}\.ko(?:.debug)?$".format(
             module_name.replace("_", r"[_\-]"))
         for name in self.module_files:
             if re.match(module_pattern, name) and os.path.exists(name):
-- 
2.22.0.709.g102302147b-goog

