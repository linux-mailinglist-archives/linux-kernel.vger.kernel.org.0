Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C479858CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 23:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfF0VZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 17:25:03 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:39299 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0VZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:25:03 -0400
Received: by mail-pl1-f201.google.com with SMTP id r7so2146332plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AUBiLRDaXXYQTlEQK9JZKaKPdCgCLgKOBXPW4l+cusM=;
        b=KYDVFWWvM8MWZ0JwZmErFvJH1/TehqnC1DnjZ9EfpIkjBrTZAWl5M2xhK0E9bA8oXC
         ej7Ckld7Whq1DExbE4I35pOSwM9pyBvwCP6QcaKo9S2S4AlX6Wir+KRnmVGANCqE3v++
         ncbAzl0FBqlbo4m7npGp9pled4MHDPNqJ/1lEHpeKNDGqSO3yHvtmYNDUrY2bk144Flt
         vSuTxw+rbcyla70jnz1nGPwQc77RGAPbjfR5DgV9eSiONauVuyFsjvVttIr/zT8ZnLwC
         /nhqnoCprsj72GXJHOsmycyG/JxpOxkS3+wPf3q7+xMOq0YYl4349VDM16W/suizXEx2
         bxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AUBiLRDaXXYQTlEQK9JZKaKPdCgCLgKOBXPW4l+cusM=;
        b=GXj0CxRf5SRq/toBcNWoEWGTCRJKeMAOqUIAuFriJ8ToNLJIl6ADPmAM+6H3cuq9TD
         glc29VfmVRRfXcY4ujmsNTYLmxJJ9xzvGpSqMTu+pK3Fn1wTBkj+N5vSem6u4h49V8e9
         B8rfWskP8yq6iMra7lOHfPpFKjPCWWpT4DyJ908anlFjtt6ljeBogWH0sx1wWfimw+RS
         C6CB0NNldGu0qxWZ+yq8A4+2pi070UddR/ucXlGSzlXj/XmmYZwy+sDzc7d9VjokgW0D
         r7jCJtHKPohEr52sZjXfz5Zn0c3rBdO1DVonGYL8XiQPgtKs4DWqAYuMfw5hikYUytSY
         Dl6g==
X-Gm-Message-State: APjAAAWGzzZMxoGNjSEzFdi0ogA7EGTMZz0E0XOW97vdHmjinOVcgkdO
        CEQyH/UBDuL87pwjs1xp+G1g8GHTMnhf8HXpRqY=
X-Google-Smtp-Source: APXvYqzoev0vXG5DK28jTKa5bDx5Z8oqnqEKW+QOzF1ZIBhuXc8DvyTZzsAVOZ0nhgQnM9CBTiaoDpxGk4vCDebsV2I=
X-Received: by 2002:a63:1322:: with SMTP id i34mr5930362pgl.424.1561670701984;
 Thu, 27 Jun 2019 14:25:01 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:24:46 -0700
Message-Id: <20190627212447.217059-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] .gitignore: ignore *.rej files
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     yamada.masahiro@socionext.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Rob Herring <robh@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such as those produced by the `patch` utility. We already ignore *.orig
files, and there are currently no *.rej files in the tree at this time.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 7587ef56b92d..f97430cb2efd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -119,6 +119,7 @@ GTAGS
 ID
 
 *.orig
+*.rej
 *~
 \#*#
 
-- 
2.22.0.410.gd8fdbe21b5-goog

