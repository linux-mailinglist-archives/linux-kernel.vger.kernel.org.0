Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF32E7AAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfG3O26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 10:28:58 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:36093 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfG3O26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:28:58 -0400
Received: by mail-io1-f44.google.com with SMTP id o9so24899464iom.3;
        Tue, 30 Jul 2019 07:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kAtuEpDd8L0wuyG5KTCOq6+6EYUSQ36q8ea54S/878Q=;
        b=csfbOs+sd0s6WTnS0lC+ap3q9Ls8qPgP1QlBNj6MtJwEUyqJLQWVhwEtOdCqsk3GXQ
         JiwPrlU1fLlDcNSL5eQXyFD/8cEo2L1pqytw7wgO51B6NfxYJv1mPXgBDcFKk6LAJIkq
         EX0XnYL6ViVqPQXQFFuhy2qhIiK6ehwaMtelO8alwbGxRk7punmO4nLKBaK8K8IXQeM1
         B8ljLtPOoAlMqMFKrsGvKrXZw842x9oMjidltLaghZI72d36V/VtXk2V2iAsnEPjHfxg
         CseING+yQPO0Zd1NgtO/jEoTcwy0plHxPjQ8jPSrSttJHya2FORioGwxF3+P18qsshJg
         2ZYQ==
X-Gm-Message-State: APjAAAX6G0YMgsZogd5+pUpLtR+Z+vrn2/6JbdqfnpHuN5dNOKPp4879
        ZMRI+emD1frHWzj8Vsm3FEeBK/1V3NA9Vq2vv1M=
X-Google-Smtp-Source: APXvYqwpDSYCAoRB47jEz+ep4GIsFQL9gR9mPKwcKKfOZbr/KgKegpFg0Huh4ubF2MpXaNsJrIzTK2Hxx1rY8SLAlDQ=
X-Received: by 2002:a02:662f:: with SMTP id k47mr119705313jac.4.1564496937404;
 Tue, 30 Jul 2019 07:28:57 -0700 (PDT)
MIME-Version: 1.0
From:   Francis Deslauriers <francis.deslauriers@efficios.com>
Date:   Tue, 30 Jul 2019 10:28:45 -0400
Message-ID: <CADcCL0inG5r6Hmw2nWRX=3oihYCJenSr939T6DT9332V_4TKpA@mail.gmail.com>
Subject: Tracing Summit 2019 - Schedule Release
To:     diamon-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, linuxtools-dev@eclipse.org,
        lttng-dev <lttng-dev@lists.lttng.org>, lwn@lwn.net,
        tracecompass-dev@eclipse.org
Cc:     info@tracingsummit.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We're happy to announce the schedule for the Tracing Summit 2019 is now
available. We are going to have an amazing conference with diverse topics such
as trace analysis, GPU tracing, distributed systems tracing and more.

Checkout the schedule and talk abstracts on the website.[1]

Tracing Summit 2019 will be held in San Diego, California on August 20th, 2019,
Don't forget to register for the summit either when buying your Open Source
Summit ticket or using this link [2]!

See you in August!

The Tracing Summit Organizers
[1] https://tracingsummit.org/wiki/TracingSummit2019
[2] https://www.cvent.com/events/tracing-summit-2019/registration-63351d06945a46d890b8e5a200dbc0fc.aspx?fqp=true

-- 
Francis Deslauriers
Computer Engineer
EfficiOS inc.
