Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 487221A315
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 20:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfEJSmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 14:42:18 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:52912 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfEJSmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:42:17 -0400
Received: by mail-qk1-f201.google.com with SMTP id x23so6321208qka.19
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wOa14NMz0aeQ1eZhOQXpH4R83q0A4PQ613uVYrgTwKk=;
        b=O9daZKnb6lsph6uYl9HBB9hRu/qMmwT1ofNHjurI/unOiZZLIadEhzJkLo8pX6sExs
         JOwFm3u6feiEMtwjR1XnF/HLhMW5llXWPSx0afwyC0NRQYzNoU0tg9gv6UtZ4P4cTQA8
         BKYwPDjg12gsN96y1i5qLAer3z2eo8UI2AWe0H9e7k1BuftDORZZ4WNWhyTFENRvcWlv
         EtFCjK2vMO7nV6DhYi+3bXXrgBY5UX6sh/M3FrY1M7+a4NiHo8hDWN+phg8G0mwjpFIS
         E6pwrkSCxreMdb3SgXIDuaywPoXOnCg4DaAQFn7y9ciBT1KgiP5TIPP/IDvc9PF9pCwt
         /5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wOa14NMz0aeQ1eZhOQXpH4R83q0A4PQ613uVYrgTwKk=;
        b=mLVpEn5fSBCHkawtsm22xy5U7PcVoqng7uDiTGgCAgRWnHZJf8tLbXID57NIxpBbzx
         9ay7K0jYmSQ+WtJqltEcPdGZywJuX25n3bZhlRym+wfGO/4gX8T0Z+UUv6HeD9vyleiF
         M37wjBmUsYXDKGbH31WpVFJix9XJtXrS4lvLvUHtz9xySg6KnApPV5d67QVYhOV/vaOG
         csJuObn4mNEwl2tsHbNapslrw0MoVqf79eBS1diO8pyFLztOBii0RxABMpxf8Dhe6iLf
         /znnVYFXNQhQBDkRvJcknI8vwHLliVjpJeleaPQSZWPZaiSOjLUwqjzHgnP9QWSZssFK
         fbEw==
X-Gm-Message-State: APjAAAWnUjJT7RvTEU9o7RbRU4t/N3lr5CUQZKoIAGp33J08nGBDJmqJ
        7628t/+23Kc0WSbpIn2X9Fl/D1Gd
X-Google-Smtp-Source: APXvYqwkJXJytOMER16R8ibq41cIslJjYB8DqAIk2r6ARasOffXObAl6ziuctfNcUv5gcSbKzyiEAa3o
X-Received: by 2002:a0c:b406:: with SMTP id u6mr10142924qve.20.1557513736776;
 Fri, 10 May 2019 11:42:16 -0700 (PDT)
Date:   Fri, 10 May 2019 14:42:04 -0400
In-Reply-To: <be47ac01-a5ac-7be1-d387-5c841007b45f@google.com>
Message-Id: <20190510184204.225451-1-brho@google.com>
Mime-Version: 1.0
References: <be47ac01-a5ac-7be1-d387-5c841007b45f@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] modules: fix livelock in add_unformed_module()
From:   Barret Rhoden <brho@google.com>
To:     Jessica Yu <jeyu@kernel.org>, Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When add_unformed_module() finds an existing module with the same name,
it waits until the preexisting module finished loading.  Prior to commit
f9a75c1d717f, this meant if the module was either UNFORMED or COMING,
we'd wait.  That commit changed the check to be !LIVE, so that we'd wait
for UNFORMED, COMING, or GOING.

The problem with that commit was that we wait on finished_loading(), and
that function's state checks were not changed.  If a module was
GOING, finished_loading() was returning true, meaning to recheck the
state and presumably break out of the loop.  This mismatch between the
state checked by add_unformed_module() and the state checked in
finished_loading() could result in a hang.

Specifically, when a module was GOING, wait_event_interruptible() would
immediately return with no error, we'd goto 'again,' see the state !=
LIVE, and try again.

This commit changes finished_loading() such that we only consider a
module 'finished' when it doesn't exist or is LIVE, which are the cases
that break from the wait-loop in add_unformed_module().

Fixes: f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
Signed-off-by: Barret Rhoden <brho@google.com>
---
 kernel/module.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 410eeb7e4f1d..0744eea7bb90 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3407,8 +3407,7 @@ static bool finished_loading(const char *name)
 	sched_annotate_sleep();
 	mutex_lock(&module_mutex);
 	mod = find_module_all(name, strlen(name), true);
-	ret = !mod || mod->state == MODULE_STATE_LIVE
-		|| mod->state == MODULE_STATE_GOING;
+	ret = !mod || mod->state == MODULE_STATE_LIVE;
 	mutex_unlock(&module_mutex);
 
 	return ret;
-- 
2.21.0.1020.gf2820cf01a-goog

