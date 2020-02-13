Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501D715C100
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 16:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBMPGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 10:06:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36704 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbgBMPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:06:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so7118978wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljdX2toI1glkUCHAbgskAX4FstAA5OW+os6LVO25kAo=;
        b=xIThK0kuWRRu5Y/bTutWxrzpIW+BSCNi0v8BmUX+XuR5+Ft7S3ZZCcvzk6P/neUQ70
         VjqW+5MupHA0wCCA4rVskUR1a/9n79Jd5MtHw1ofG5qF+24seGbyfRkAx6SNTQdgHSkc
         cJLcT3fqoJhU2hvbFuOUfReP6NWnGD+vhSk5d4wtsamH3/+hQspt4IlCNTwleMs+KKyq
         ImjrTLR/wyrXE+P8ar9XkOjLTVUEJelIi8xWuhyWFx9hIWXwCM28ndOv7DWlJSVY0VqG
         /giR5bIHISKcVY0xbBMxojHvxSKEIbm5K30TRELmiDY9yaFwAE8VKpeU/NUxyDWQVWAc
         B8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljdX2toI1glkUCHAbgskAX4FstAA5OW+os6LVO25kAo=;
        b=lwtEPJT4Yit58Fqc69saKzw42jwmO1RtcpPjk6WqkWV8y9OsczC6cZKXy3ZIF6hqGW
         RAFP+d2d8oTN80btGpsMdC9zG1VjKRD6we2ADrw7F76IwxVrdKOxSFsblIibgVdT2Pj1
         91CekcwGm3IJELscKUs7HS9lP2ZzKxdK7k4l1xlnn4y4mqyErPTG2EaKuYYMm6esX5iD
         u+/RI/8he/lmwQ6UVsdz1zfw0nUue2w/zCTvE8WPyAUYq1gyra6aGNDGcpOwQLSkOiwG
         +JKIT9N7wUqPBVikqhPfQ7/zm7IxgO7QaxnC7Zb6t5YSNFCc8l0HnUWAx4zIe5yvMZE9
         OtTg==
X-Gm-Message-State: APjAAAXjt3D1H1o7QF6kshXMktEMPhI6eRwG4+aW3zBkYfmb3mefr+9n
        dlSHYw6OAGvAV4K8uLxeDbB4sw==
X-Google-Smtp-Source: APXvYqxlbxmp9sQUBchL7xCXNDeCu6p5vWmmPGNO5ZyJ0If8Armv9gfRQLVqlWf476Igqo9LNYFNbA==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr21750911wre.404.1581606368580;
        Thu, 13 Feb 2020 07:06:08 -0800 (PST)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id m9sm3162376wrx.55.2020.02.13.07.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:06:08 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH] kdb: Eliminate strncpy() warnings by replacing with strscpy()
Date:   Thu, 13 Feb 2020 15:05:53 +0000
Message-Id: <20200213150553.313596-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the code to manage the kdb history buffer uses strncpy() to
copy strings to/and from the history and exhibits the classic "but
nobody ever told me that strncpy() doesn't always terminate strings"
bug. Modern gcc compilers recognise this bug and issue a warning.

In reality these calls will only abridge the copied string if kdb_read()
has *already* overflowed the command buffer. Thus the use of counted
copies here is only used to reduce the secondary effects of a bug
elsewhere in the code.

Therefore transitioning these calls into strscpy() (without checking
the return code) is appropriate.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index ba12e9f4661e..a4641be4123c 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1102,12 +1102,12 @@ static int handle_ctrl_cmd(char *cmd)
 	case CTRL_P:
 		if (cmdptr != cmd_tail)
 			cmdptr = (cmdptr-1) % KDB_CMD_HISTORY_COUNT;
-		strncpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
+		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
 		return 1;
 	case CTRL_N:
 		if (cmdptr != cmd_head)
 			cmdptr = (cmdptr+1) % KDB_CMD_HISTORY_COUNT;
-		strncpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
+		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
 		return 1;
 	}
 	return 0;
@@ -1314,7 +1314,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		if (*cmdbuf != '\n') {
 			if (*cmdbuf < 32) {
 				if (cmdptr == cmd_head) {
-					strncpy(cmd_hist[cmd_head], cmd_cur,
+					strscpy(cmd_hist[cmd_head], cmd_cur,
 						CMD_BUFLEN);
 					*(cmd_hist[cmd_head] +
 					  strlen(cmd_hist[cmd_head])-1) = '\0';
@@ -1324,7 +1324,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 				cmdbuf = cmd_cur;
 				goto do_full_getstr;
 			} else {
-				strncpy(cmd_hist[cmd_head], cmd_cur,
+				strscpy(cmd_hist[cmd_head], cmd_cur,
 					CMD_BUFLEN);
 			}


base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
--
2.23.0

