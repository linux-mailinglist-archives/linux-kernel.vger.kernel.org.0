Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A175329387
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 10:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389870AbfEXIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 04:54:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35045 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389814AbfEXIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so13356419edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ap6gHVfG6PM+wYbkqC4KGmp/roHspJTrFKWjjYMA/To=;
        b=TcHOFSYpTZDVzEzFDwDdhVIyODgONPMw+T3NbmiYfQjRtHLOh8DAwQFpc9neVEvsg5
         3o1EvHY3jdbyMeWHIJy+cFE0Sf636G/ypqXGntdQR0FIhJ98nrM9Cb6YYB4awpiVkYmt
         LnPJOFzsIhXefcJvhqHx3iX6Le26pu/IwJvSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ap6gHVfG6PM+wYbkqC4KGmp/roHspJTrFKWjjYMA/To=;
        b=tQyCRQqMVmxaNgjJNjpnmOePgTn0CryXCtlS2Tzx5jEdv9x76bZ180b0Gp18+FZGTw
         cyxsPClqGk8fMboYW6bHQv9aokgYnNjAsF9Kb5px932ZBbGj/I6XaOUJ/RcJAXphsuEZ
         oNPSViPf7h9l5LW3lUHUQkE2O+urljaafmVG+hbnBhObEDkOix+JVT+qFrGHSaA38p6N
         aHkjjNQoRVZCyiVwFORxQpCI8mab4MZy8mkqyyR+gTxLX5vY7QAMlx9emsW6dNqD36qi
         bagP1NQ7egscNPAZw3zT7RsfwSWwRPOeIaLbDL1reRmtQnuHr4Por3WinYVh7HZht+RK
         C35g==
X-Gm-Message-State: APjAAAW2y7Z/iY1J7In+uOq/Ji9VVDHGjSIfxz1rJN6WyoIP9G8nSfYE
        WVLwJKXxSIUjNEk8H9H2tTOUt6qXpYA=
X-Google-Smtp-Source: APXvYqzhd4f3rrF1WDIdoewCydKwsOVaIfyCIIjufiU3/tV42BLUr8ae9tm+UecNxlXgltqO2gHb8w==
X-Received: by 2002:a05:6402:1214:: with SMTP id c20mr101983320edw.38.1558688044363;
        Fri, 24 May 2019 01:54:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:03 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Martin Hostettler <textshell@uchuujin.de>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 03/33] vt: might_sleep() annotation for do_blank_screen
Date:   Fri, 24 May 2019 10:53:24 +0200
Message-Id: <20190524085354.27411-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For symmetry reasons with do_unblank_screen, except without the
oops_in_progress special case.

Just a drive-by annotation while I'm trying to untangle the fbcon vs.
fbdev screen blank/unblank maze.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Adam Borowski <kilobyte@angband.pl>
Cc: Martin Hostettler <textshell@uchuujin.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/tty/vt/vt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fdd12f8c3deb..bc9813b14c58 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4159,6 +4159,8 @@ void do_blank_screen(int entering_gfx)
 	struct vc_data *vc = vc_cons[fg_console].d;
 	int i;
 
+	might_sleep();
+
 	WARN_CONSOLE_UNLOCKED();
 
 	if (console_blanked) {
-- 
2.20.1

