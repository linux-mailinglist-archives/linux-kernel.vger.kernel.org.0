Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCBC578EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfG2POd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 11:14:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42314 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG2POd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:14:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so27671222plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cE8JJxtzOsAV8bSA3yfUSxM/sHfO/Ip7c2TSFLIj6es=;
        b=lShzhUhusv0TF61djjEp7G7d22h1fWbv2TyRJy4ZrLohIbqj47WPUfaA7UwD7fUxde
         44R/F5rdG4Xmq/hSpfmGAuHGhp75pr3PmmRMF1++ZSKOuSDZM7GB7KLGaQbhGfY2eUBx
         x6donM7ZNlI3gpsA3k61hHjrGFDrQqWZbnZYA0Edyo6ZhjSpWiVHVsq7/6f0SvzqDoYF
         I9Ty4ZkLJv5ewuAAtkdKQwMlVOYuRdoDxHpCclQzqtchrjK658i6CXcsRgc+ei5j3HG6
         Czn5kjnMpo9cSvgkq5rVOHBvL12e7VgbjUEhu0Jz4dWXZJ/epZi4P0TXfIBuQpMYa3b/
         Tbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cE8JJxtzOsAV8bSA3yfUSxM/sHfO/Ip7c2TSFLIj6es=;
        b=pVnJ5Iw7OF2VQG+0X0/za7f/oruIrg3WmMjV0J2sFlt7gKnHAdrtEREDQ5U3d1FAjC
         AaI6nBd6uhn539SbqhkgSVG9sjSgzCrQgUxCnhNihen7CyuKo1t+/rCGy6nCKfpQ01JV
         OvtAkzbk3Yr5N6N3TCyeSMdz1fE1xNJVMxKbFZjYNZAdGbvlT1gZJ665eRKpvKOeV6ZX
         hWSF7+kTnKaoIxJ7zCNQ0ss8ja5usMvZ9aq5RjgzD2FriXZC1HkU2eGfolT0UIkuXViv
         sQRTwNS2VBxwDpaXnChFT2NG8F9yIuECOUcxy6LtT4kfXxXiRhHCcSfxPw1LMe01NhM+
         jH+A==
X-Gm-Message-State: APjAAAW9OkEyTJ+M0LC39hnfB0bKu5XtV8te5+QvXc7lX4N5LfhYcaSg
        HAWw6bLx4mNAkbxsKMTen/Q=
X-Google-Smtp-Source: APXvYqwyMlH0JLg2LbqlniKupAXaDlVN1c0lpmuVWnYRonGuAnrnpE7AbDulz15LOwiP7+x4Oqwi+Q==
X-Received: by 2002:a17:902:2a69:: with SMTP id i96mr109374810plb.108.1564413272485;
        Mon, 29 Jul 2019 08:14:32 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id 195sm103728065pfu.75.2019.07.29.08.14.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:14:31 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 04/12] gcov: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:14:28 +0800
Message-Id: <20190729151428.9444-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone.
We had better use newly introduced
str_has_prefix() instead of it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/gcov/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index e5eb5ea7ea59..67296c1768b4 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -354,7 +354,7 @@ static char *get_link_target(const char *filename, const struct gcov_link *ext)
  */
 static const char *deskew(const char *basename)
 {
-	if (strncmp(basename, SKEW_PREFIX, sizeof(SKEW_PREFIX) - 1) == 0)
+	if (str_has_prefix(basename, SKEW_PREFIX))
 		return basename + sizeof(SKEW_PREFIX) - 1;
 	return basename;
 }
-- 
2.20.1

