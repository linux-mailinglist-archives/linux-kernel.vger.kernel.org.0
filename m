Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B60156FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 08:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJHB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 02:01:57 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:45212 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJHB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:01:56 -0500
Received: by mail-pl1-f169.google.com with SMTP id b22so2429251pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 23:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/Uqf0cAo0ZaftdD+fKlUjMMosjhaUfrXiaXMp/MBl0=;
        b=lvTgdLWd12v7qr2FJW/0QWxay8lD9/hbynw7gOH6SIQOW4au2TM5QNnahkM49djAgu
         9Y6NA+afiRrv8qnMSK0iuoyp14v24JdA2lm54+GI0qYLhS8qAvszo1pzJKAiE3JKQ85M
         Guk76Irk2VT0IWzfTtbpzbs93/Sa2io1qhzy0mQ7qyCR2GjthX/3RaebrV0ESr8UBAnz
         rktgiFu0cEuygy8bnfl8cykpDpeOgUBDGl8fdG8R/+7hQWf+dMw6SZ/FHH6nrhdTciIC
         F+981qF5BzhcbaBi0f0UJTYk0JeAZDdWsh3XQZGRJowf/5HIvP0HX1sYnjPffAsPHSB+
         fAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/Uqf0cAo0ZaftdD+fKlUjMMosjhaUfrXiaXMp/MBl0=;
        b=d6Mw009vgd/Fx8VnCSqfTrxcy1Jt3mu2Eknk/YBiDkPw7u1U955LqGtyRzE1+YRdy/
         lynu1LKDtIQ/A4NjgveTq/UqiQYc239EIiab9FdJFyQ33upngbml1sym2gAwpvU69NP5
         QXZF8GsOUYhDAumx70XKBhvZC29GEmPAxNbL3c5mgc6YwTsvxcx96er16CWnFmemaqdM
         jmtfHSUamuaYzKp8TW5Md3uk8X+wh9DSpbZHEFkEXE2N0w7LFpv2QqpDqw5sfuDgRioY
         riQUsa4uXJO2ZyBmoGXwU4595hSBcXknsr8OHcYNnOaQbJoFlMuDMPlZdNgOStVSDqs2
         TTCA==
X-Gm-Message-State: APjAAAWurXH4GLwnxodOv1ylmQaQYkCaRLQX5GE9uPONcnyplY39SrtP
        PgQA7C/AJNUWmFhkHejyb5I=
X-Google-Smtp-Source: APXvYqxFzAHn7Zg4UwudS4ifdwH+q4d9oCUWM26i6ToplRzGsAXnuMugXN93gA+K3A0aPh7OqE7SNw==
X-Received: by 2002:a17:90a:930f:: with SMTP id p15mr129247pjo.0.1581318115800;
        Sun, 09 Feb 2020 23:01:55 -0800 (PST)
Received: from localhost.localdomain ([2408:821b:3c17:8200:2ded:347a:248:b2da])
        by smtp.gmail.com with ESMTPSA id m71sm20043233pje.0.2020.02.09.23.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 23:01:55 -0800 (PST)
From:   youling257 <youling257@gmail.com>
To:     masahiroy@kernel.org
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        youling257 <youling257@gmail.com>
Subject: Re: [GIT PULL] more Kbuild updates for v5.6-rc1
Date:   Mon, 10 Feb 2020 15:01:30 +0800
Message-Id: <20200210070130.1029-1-youling257@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <CAK7LNAQs-KVCM7xXqJchQrMG+nnajPFRMB2Z+RJ9VTsg7XGRAQ@mail.gmail.com>
References: <CAK7LNAQs-KVCM7xXqJchQrMG+nnajPFRMB2Z+RJ9VTsg7XGRAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this branch cause 64bit kernel build failed on 32bit userspace.

kallsyms: malloc.c:2379: sysmalloc: Assertion `(old_top == initial_top (av) && old_size == 0) || ((unsigned long) (old_size) >= MINSIZE && prev_inuse (old_top) && ((unsigned long) old_end & (pagesize - 1)) == 0)' failed.

