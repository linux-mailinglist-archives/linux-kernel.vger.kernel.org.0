Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5D8E9080
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 21:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfJ2UBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 16:01:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35271 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:01:30 -0400
Received: by mail-io1-f66.google.com with SMTP id h9so16258735ioh.2;
        Tue, 29 Oct 2019 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fMpmkb6Q3Bm8xhrhOXX6nQC6H6neaOxwC8CKMBthM8=;
        b=APyoryN6M0zLCXg7NCF7cOgSlOFe5/k6MkHmSEvDG4PhyTRi8NaJXSpWWnU1i3ORnL
         Vp+EeqDevgbxq0PQtzbFme0XHIzCoXX+6/hac2d9SQuSlYssp+zhlfSdBFeiD81K1zgg
         jLDhUm5RalCO92asrfpUAMNwkZxmenjp6y65Q0n1Yc682pXKbzxW94iZWJ/ga+vl8fW4
         r6HqWgaEVeUIiUw5lGUnuUxFIwMHDf9T3omTfAlylsv9TntjInB+dNFAVg3UaHBePzI7
         FncqFtxkKHbVy2cSIRjypx4Emvblq1CoWyyWEu5PJMqw0/bSJu7ee67JB6WxERVfiK8m
         Mu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fMpmkb6Q3Bm8xhrhOXX6nQC6H6neaOxwC8CKMBthM8=;
        b=tNh04+AlNVMHVPLUscw4M9fl+51PhqgQhldrEzPEp8QQhDXedvjikuAwyZb43bD2iD
         BWXeIIhFsy0TDl5cT3Pnh7I2z5h93TEO+eoorblYOTmwXQEm/ryYOXPETVjHuKeA82W9
         Dt5SGvE9nUw6RsezaMRjgh8iTrXC1XNH9Yz7G6eXwy4FctpErVPSUOwoGcBeUKGbtg/Z
         ZnwxyUlCqidcEqWzz6Ki2CPBRPGUG2fEW/bkS+YJEEgDtSHT7kqJvEbLYLdMInLX753q
         ylXBgwXRXdRe7n1tojL5yhOzt5SOm4x6MswS1U9VxoEybZd8jM9kJvr5wqL91v4UdI4u
         8Prw==
X-Gm-Message-State: APjAAAUNT1vSFTWnLyAvXDaR+IYji+P+b/3ERxQ7zKe0N4mHhFoSjPBZ
        TbeDphLLal0fGS6NE842oR4=
X-Google-Smtp-Source: APXvYqxQ1FHqGO126uIAmuSle8b1H2fT14BYgTqF44NQfFKIHD2kAcnqkDmA1zqlzILW9TQToI4dQg==
X-Received: by 2002:a02:330e:: with SMTP id c14mr25098762jae.5.1572379289408;
        Tue, 29 Oct 2019 13:01:29 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l2sm1073804ilc.34.2019.10.29.13.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:01:28 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: [PATCH 13/16] dyndbg: extend ddebug_parse_flags to accept optional filter-flags
Date:   Tue, 29 Oct 2019 14:01:05 -0600
Message-Id: <20191029200107.10253-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change ddebug_parse_flags to accept /^ filterflags? OP modflags /x, as
well as the currently accepted /^ OP modflags /.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 18 +++++++----
 lib/dynamic_debug.c                           | 30 ++++++++++---------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 689a30316589..cdc45dcb3e0c 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -209,13 +209,19 @@ line
 	line -1605          // the 1605 lines from line 1 to line 1605
 	line 1600-          // all lines from line 1600 to the end of the file
 
-The flags specification comprises a change operation followed
-by one or more flag characters.  The change operation is one
-of the characters::
+Flags Specification::
 
-  -    remove the given flags
-  +    add the given flags
-  =    set the flags to the given flags
+  flagspec	::= filterflags? OP modflags
+  filterflags	::= flagset
+  modflags	::= flagset
+  flagset	::= ([pfmlt_xyz] | [PFMLT_XYZ])+
+  OP		::= [-+=]
+
+OP: modify callsites per following flagset::
+
+  -    remove the following flags
+  +    add the following flags
+  =    set the flags to the following flags
 
 The flags are::
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 173b28250bd6..c6273fabe52c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -426,34 +426,36 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
 }
 
 /*
- * Parse `str' as a flags specification, format [-+=][p]+.
- * Sets up *maskp and *flagsp to be used when changing the
- * flags fields of matched _ddebug's.  Returns 0 on success
- * or <0 on error.
+ * Parse `str' as a flags-spec, ie: [pfmlt_]*[-+=][pfmlt_]+
+ * Fills flagsettings provided.  Returns 0 on success or <0 on error.
  */
-
 static int ddebug_parse_flags(const char *str,
 			      struct flagsettings *mods,
 			      struct flagsettings *filter)
 {
 	int op;
+	char *opp = strpbrk(str, "-+=");
 
-	switch (*str) {
-	case '+':
-	case '-':
-	case '=':
-		op = *str++;
-		break;
-	default:
-		pr_err("bad flag-op %c, at start of %s\n", *str, str);
+	if (!opp) {
+		pr_err("no OP given in %s\n", str);
 		return -EINVAL;
 	}
+	op = *opp;
 	vpr_info("op='%c'\n", op);
 
+	if (opp != str) {
+		/* filterflags precedes OP, grab it */
+		*opp++ = '\0';
+		if (ddebug_read_flags(str, filter))
+			return -EINVAL;
+		str = opp;
+	} else
+		str++;
+
 	if (ddebug_read_flags(str, mods))
 		return -EINVAL;
 
-	/* calculate final flags, mask based upon op */
+	/* calculate final mods: flags, mask based upon op */
 	switch (op) {
 	case '=':
 		mods->mask = 0;
-- 
2.21.0

