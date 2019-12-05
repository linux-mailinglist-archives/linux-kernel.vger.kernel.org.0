Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F67E1148D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 22:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfLEVwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 16:52:08 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39486 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbfLEVwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:07 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so5243739ioh.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dPQmr4Gy2qdgWTqBpMzYGw3HanW+MuNpIpNa1l5uMF4=;
        b=NFYVVguWt26xa0/5pW/rORwj/w6XFq+VRFfRSYDpRTQOADKs7isbYoBavKfJoIXfit
         47vJmal+NlZdBQ7kZtPlP6ytjptAe0TDV63d0Rfi/q9EWnGC5ntlnV2onIaTrB2AEmgR
         DFRdEtbSQMPseyUArpL1GpdZIpm7pVrTI2GuOdtDCModb69PfRQmrhUgO32jZ326tm4m
         Mczf75xum8T3MjgjGd/87vfrNH4ZtQ96qep2y9pWZBg65/OnyVgdudiWBVuYM6/grQ0q
         66mEhGoQ8q8EglbxzXIflrslSTI00ATuBSgv45Y1yiTJaAExsjRQvGsy8/Aw1m2KNf8U
         j93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPQmr4Gy2qdgWTqBpMzYGw3HanW+MuNpIpNa1l5uMF4=;
        b=UWETUeEJJ6OkufYZeu8frG77gPmaOhgCTNFuPJriDFAr+xT6QvbU1VDNN+WMLrXq7Y
         QHeKm0VKyxuPFEaRIGDir0MSvlW+k4US4Fpr9bCMW9rzD0gTG9GE87uMC/mH0cWyGIJS
         7DsZzAphQcncb0relE02Gv6iehIGubNhb/1iiIh5OB2k2ATFx6J1WxvViRBXjZitsafp
         sauxNDy/DrDZIF8y4MiJfKugRlj3mm7a8F1qVphDlu1CIV/K48LpOdaH9LnJSAEHm3ab
         zHKRZ57FCNuNcyAiT3usnOkLVXCtNndF1OG7HltDLlAC+m+gAWJ3s5s1kbfJnKyexduZ
         OEQQ==
X-Gm-Message-State: APjAAAWCfeRAbi3+Wd2o92M4/C0TI5O/vLtNVKokNW/Vh13deH+24mW6
        ebN8rvc4Lq86tRL1X6ovJjM=
X-Google-Smtp-Source: APXvYqwh2bqlenrPui3JZeb0IA3iLAo9cjfq78TQNopEN75X4bQn/iIlqo+5hz/GTxAAF3Opy/z9IA==
X-Received: by 2002:a02:7102:: with SMTP id n2mr10501825jac.76.1575582726601;
        Thu, 05 Dec 2019 13:52:06 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:05 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 02/18] dyndbg: drop obsolete comment on ddebug_proc_open
Date:   Thu,  5 Dec 2019 14:51:33 -0700
Message-Id: <20191205215151.421926-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4bad78c55002 ("lib/dynamic_debug.c: use seq_open_private() instead of seq_open()")'

The commit was one of a tree-wide set which replaced open-coded
boilerplate with a single tail-call.  It therefore obsoleted the
comment about that boilerplate, clean that up now.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60409138e13..6cefceffadcb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -853,13 +853,6 @@ static const struct seq_operations ddebug_proc_seqops = {
 	.stop = ddebug_proc_stop
 };
 
-/*
- * File_ops->open method for <debugfs>/dynamic_debug/control.  Does
- * the seq_file setup dance, and also creates an iterator to walk the
- * _ddebugs.  Note that we create a seq_file always, even for O_WRONLY
- * files where it's not needed, as doing so simplifies the ->release
- * method.
- */
 static int ddebug_proc_open(struct inode *inode, struct file *file)
 {
 	vpr_info("called\n");
-- 
2.23.0

