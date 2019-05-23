Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CEF2861F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 20:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbfEWSow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 14:44:52 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35126 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731521AbfEWSow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:44:52 -0400
Received: by mail-ot1-f45.google.com with SMTP id n14so6424538otk.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yNILfyJChXA1qHX1Kqi1owLnUHep4ERKIkS79Wu1+tk=;
        b=ytyrCd/qOMiw0SMCH3uGeCH96UCKXfeNngBh+3fqTLyrvfr3w1CggUfgpYbxePvNdH
         mgBFPc9L9iqibPjumTk2GvTbWndammyucmWOw7SoENj+v2wcyYufN6wiTU612eG5yOFW
         L3WLFb7W/s9PKX9oom+IMNnX0YkzBTk+WZOnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=yNILfyJChXA1qHX1Kqi1owLnUHep4ERKIkS79Wu1+tk=;
        b=pag5wCnraxsEf7uBgc+8NsUuQ6lkax4+AjGXjyXaxrd3de/vSyB4Z46izVsfYnSum8
         RcNGokcyAc70le5SqO0yo5wCxcP1fPEWFAogwZdqpPvwN2m7pz6C8RvGw+qCbUZC4iVU
         q0JEKfYfozYXbQoUZvxyQWCalZHrZqktM8rzC0pwQTPveTFonZICm8XuMO5SAcLsoXyF
         +eTf7tm4IrJC7adtbVucSxBUmFWY+R4m4nOMfOrmrmkD0sDXG4HqD80u8Uogf5jgWHMx
         p3Zv6pIppVXwfTKG6QlnQDywHB8mfxpyyP8dyYQDnYucEDV4Xoza9mfaOPfuemlNLKL4
         aQWg==
X-Gm-Message-State: APjAAAVbEUMEEJgDeZzv8+h3mgTZzeivRAl6tqU53jumwJcsbuGzoQVf
        F8X627bFUS53KHAawdWwkKTGew==
X-Google-Smtp-Source: APXvYqzrg3W4K8wR2ebTIsIl4Uob3uxGrA1mPsTDJ1btsxIfLnHK4XWZ6ckIo/J0Nrexypt51+CS8w==
X-Received: by 2002:a9d:7a93:: with SMTP id l19mr3843085otn.49.1558637091094;
        Thu, 23 May 2019 11:44:51 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id s63sm83801oia.34.2019.05.23.11.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 11:44:50 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
Date:   Thu, 23 May 2019 13:44:46 -0500
Message-Id: <1558637087-20283-1-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog v2
    - Fixed some checkpatch errors in the commit message.
