Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D5C5DB59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 04:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfGCCH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 22:07:26 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:56012 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCCH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:07:26 -0400
Received: by mail-wm1-f46.google.com with SMTP id a15so485887wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AILGqXbQNeXBXoSRV7QFYeMgCHelpEqxjEYxNS5agoc=;
        b=smbjF5DVBT8tA0JFvIhQL+ANP4Y5xOOvFPXvOY4yKZmuUiiKrO85YIOP8N4+caV49l
         Ii+4ojMVjn6YnWw2UBcX1c3c2+MaRMap/qo5Sgp0r3PAA60LRDwwOjCKcfwyfnw0kQXm
         2mv7qhNZZTkzsYqYXM2jknUB3jiuNN4mr3GYF4Qn4LspHDIfohrCc5Ru3+yo79Uy52Jd
         6ckOn5DD08jHddu3llyKoFx1wOkAm0wkv4tEb3JcEHsNH88r4qrL3gGLwVYoGTD6FqNy
         2CGc2D35R0XLfNtyaTzzBjUKXZR4/2YLG6/Mzbs++7zsuVG/vs/OUIZKlu/G7H6vlGDH
         MjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AILGqXbQNeXBXoSRV7QFYeMgCHelpEqxjEYxNS5agoc=;
        b=YLp/CS4tK/rVX+BWTpQ9bbSK4pKRgRamErQoGTQoWlhLCNzaQaj5ssLOkdqYR+n2MV
         z5wf0ux6peiHvfdYeOZH6xepN9Fvy9j4mRff8WCwqYmaNz94MFkaDDmfwIBAy1iMMtU9
         LWCedfr9y8CdAFksVLne3Izha0Mpc/wLTlt89KOBu6j8LKyfv68qLMrFdC6sd/lxYJPF
         oCicXOhPM67ef3Zin49iu3YqNgzFtJ7TQzNSSbV8CNQaWZnqtDK3Dbd6xlVOOfNofm7F
         Jzph6PgKfzmgXkhWgH5pqMCITTjwa/frO6lKVMpzPuCUQwyxpgTF0ydyiW6V9u63ylXc
         yzhg==
X-Gm-Message-State: APjAAAWMSi5/l4nWm7+SiXRhICxF/z7ma9Gk/uslnQojloa/eBTgMBwb
        ZhHVq5VKOTaeNMoCHLId1oHmJk7peGwmICAe4KZ51TkDUaruJA==
X-Google-Smtp-Source: APXvYqxvG8CLeu2JltDGCOjTmRPNh8ZrD6o96rQKNS+rWo47LI1fBkbCHLov9IcgQKHodDGLTNQokiSbHRRptEU2kqw=
X-Received: by 2002:a1c:228b:: with SMTP id i133mr4574948wmi.140.1562098390313;
 Tue, 02 Jul 2019 13:13:10 -0700 (PDT)
MIME-Version: 1.0
From:   Dhaval Giani <dhaval.giani@gmail.com>
Date:   Tue, 2 Jul 2019 13:12:58 -0700
Message-ID: <CAPhKKr-0SiE=_UFEUovbVpLvhJmZMq_i2tA6Pp0v6cy2aLS_YA@mail.gmail.com>
Subject: CFP: LPC Testing and Fuzzing microconference.
To:     LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        knut omang <knut.omang@oracle.com>, shuah <shuah@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>, guillaume.tucker@collabora.com,
        mark.rutland@arm.com, ndesaulniers@google.com,
        Veronika Kabatova <vkabatov@redhat.com>,
        Eliska Slobodova <eslobodo@redhat.com>,
        andrea.parri@amarulasolutions.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        brendanhiggins@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I am pleased to announce the Testing Microconference has been accepted
at LPC this year.

The CfP process is now open, and please submit your talks on the LPC
website. It can be found at
https://linuxplumbersconf.org/event/4/abstracts/

Potential topics include, but are not limited to
- Defragmentation of testing infrastructure: how can we combine
testing infrastructure to avoid duplication.
- Better sanitizers: Tag-based KASAN, making KTSAN usable, etc
- Better hardware testing, hardware sanitizers.
- Are fuzzers "solved"?
- Improving RT testing.
- Using clang for better testing coverage.
- Unit test framework.
- The future of kernelCI

Thanks!
Dhaval and Sasha
