Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC7DDE9B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfJTNXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 09:23:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33696 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfJTNXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 09:23:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id i76so6011603pgc.0;
        Sun, 20 Oct 2019 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQVDW7+SUCrGzKTHK4lHvxCTx5Hl2Z+Wu3sxv6NNXDM=;
        b=ukB5UznvwcpJx3YHnsvIuV55k54M2QKyi3xw3HtiLKj/T6xu7S7tZjlFOKzAq8I5Ya
         ukc35ZmZbJvGuLQChLZLKxZpTbWIH6uuVpsn+41h7cNtp7X5+OpP9Lwq4v3ymSQvdnjy
         IOC43s5ktSkDulAu2uMu+O8DQ/tN2Sl5XBMskVxDpZBNhMeOlZVLzcU5QZMUGQeRAubb
         H27AhbU5r0NysgYc+s8/lgHCCbDMkkGSncUekd2j33p5LhbZb+km+N2DP+bp+G1FiMwP
         Fz5HBNZyxN6usur1eHLbFsAfZD0zKg2w0nmdKAGQQzBJ73CKzepgqJ1zkWv+LdyNJiBn
         CjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQVDW7+SUCrGzKTHK4lHvxCTx5Hl2Z+Wu3sxv6NNXDM=;
        b=iNHwsVHXSWvkOTdPuyOKshkbIf2NkhEIu5LGpLrtkls9jIxLyzSF1T5sjuoG0aJYmf
         ZaBUS4KRV2JvZVIHAgJqwBJ5s0NDiJbgJtJ2172QKGUV9Ej8I1/SDk4ezbvbbrltQp0F
         4V05KfKrYfiCk2TaiBGgW0BYCb4cSnilRPPiD7ctJunxHqbNUMH8ndn7wt2eVQYxf5DM
         gCeCEu6TD0XPdIpo2lt4+zB8PJR7PXelxUjvoxMiyh4cEsfwPa1nXwM3pjrN8JhUZz15
         dv1FsDyd1vdq6311z4id54bBqDVhrKIT157WIklfLj5groqiuk1Yq3V9UlbaAztTNkcH
         bYJg==
X-Gm-Message-State: APjAAAWMOJGIVD8lCsHxiDm7i4/ohPglf5aQFtKMcXkcpxEPxdH1AQeu
        E78YCiHXW0ZDlkf1xUC5PME=
X-Google-Smtp-Source: APXvYqxQ/gT//V0dbnEM+U61UBdb45KOQSGZtqcO1IxW0yBrgmv8grrBnNkbO+IkPQNN1PXBGAokSw==
X-Received: by 2002:a17:90a:8003:: with SMTP id b3mr22790979pjn.43.1571577824154;
        Sun, 20 Oct 2019 06:23:44 -0700 (PDT)
Received: from localhost.localdomain ([111.199.15.214])
        by smtp.gmail.com with ESMTPSA id o185sm17414198pfg.136.2019.10.20.06.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 06:23:43 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] kernel-doc: trivial improvement for warning message
Date:   Sun, 20 Oct 2019 21:23:23 +0800
Message-Id: <20191020132323.29658-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The message "Function parameter or member ..." looks weird.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 scripts/kernel-doc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 81dc91760b23..cd3d2ca52c34 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1475,8 +1475,13 @@ sub push_parameter($$$$) {
 		$parameterdescs{$param} = $undescribed;
 
 	        if (show_warnings($type, $declaration_name) && $param !~ /\./) {
-			print STDERR
-			      "${file}:$.: warning: Function parameter or member '$param' not described in '$declaration_name'\n";
+			if ($decl_type eq "struct" or $decl_type eq 'union') {
+				print STDERR
+					"${file}:$.: warning: $decl_type member '$param' not described in '$declaration_name'\n";
+			} else {
+				print STDERR
+					"${file}:$.: warning: $decl_type parameter '$param' not described in '$declaration_name'\n";
+			}
 			++$warnings;
 		}
 	}
-- 
2.20.1

