Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CC7188D92
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 20:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCQTA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 15:00:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39591 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgCQTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:00:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id f10so24194143ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y0VT78F3dxvDrSDRU0usDCfY5N57Y8ZF/aY+SJ6VytM=;
        b=OwjZi9XdTCjPbZ21iUQ+IU6Y08aeWbK57bHoTZtarsLaihwXamXErvGEo5E5/lfKQi
         JA0/JuuWsaMWjZsm2kvtbqaBaKj8T079+Yc5qX6+8BIheZJ69AlxqQfOHW2R04ErokWz
         qZ1JaoSphttl82iL+gNmJz/GLhogkmpLchnAEXx26muc/dAoSBImwlxEiMevGb0t4C4c
         bT4wrzepziqNgpVPnQtwgpGC3THGNnsgGrJj9GkpZ32OsQZ1kzLAjGyjmRtaVWL5RKs2
         06iaqxrEbgrz3QY1Uz1TCI6cA7I20q+3SYGou+DxBiFMstmHXJZCUc3iRzYKcT+rmgx5
         4koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0VT78F3dxvDrSDRU0usDCfY5N57Y8ZF/aY+SJ6VytM=;
        b=iFnRi/D+cBZ04wKSm1QdF47p1Js25TWkg70aAk7c1iP8dbNj27c0IKv8aVAsrGID8G
         HPcSSV8MSeGsp9T0JUiWRjCSxOuTMPIm6TMbzt5ANy4HNt88X5ubst7WRzswdXF35Oz4
         Jp72FBC1Iu7pm2B3hPH2cfY6ca8ZBqO1I/Y1fl9BXUqFejSlYG7M0XT0dCoycurCk8/g
         63JEgdIgl4O7pWdMUYaIZ3DOUz9X9y9QY51VIRxXg/qfAW/gLwj4vjq6i9KEtPNECzRd
         /abvyAuG65siP5S2fQqm7h+6YybHpSPq7Cn26mYiL3j/pYgyI+akH+rPlnU4BqL4pYwM
         miHg==
X-Gm-Message-State: ANhLgQ3g6ccaI48Ip6/1GGMKjBUiwkBwpdfm1lbe4oQk6itu1pr4WNNn
        xUB59uA+RnTKyMeVmC4Qd7QbYZXNawRrXi49bO6HLw==
X-Google-Smtp-Source: ADFU+vubEo1FoPiUFrFFOhisoKyjnOC4/HwIRLoy2w6txWLdz8YeKk8qBtOEaqefkrRGIstTHEo3U9SETX3VzvSur+M=
X-Received: by 2002:a2e:b0f7:: with SMTP id h23mr141835ljl.56.1584471656937;
 Tue, 17 Mar 2020 12:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com>
 <20200310221938.GF8447@dhcp22.suse.cz> <alpine.DEB.2.21.2003101547090.177273@chino.kir.corp.google.com>
 <CAJc0_fwDAKUTcYd_rga+jjDEE2BT7Tp=ViWdtiUeswVLUqC9CQ@mail.gmail.com>
In-Reply-To: <CAJc0_fwDAKUTcYd_rga+jjDEE2BT7Tp=ViWdtiUeswVLUqC9CQ@mail.gmail.com>
From:   Ami Fischman <fischman@google.com>
Date:   Tue, 17 Mar 2020 12:00:45 -0700
Message-ID: <CAHuR8a-PbmthrKYpY5-SM-MH39O39W2J1mXA48oy9nASmys0mg@mail.gmail.com>
Subject: Re: [patch] mm, oom: make a last minute check to prevent unnecessary
 memcg oom kills
To:     Robert Kolchmeyer <rkolchmeyer@google.com>
Cc:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 11:26 AM Robert Kolchmeyer
<rkolchmeyer@google.com> wrote:
>
> On Tue, Mar 10, 2020 at 3:54 PM David Rientjes <rientjes@google.com> wrote:
> >
> > Robert, could you elaborate on the user-visible effects of this issue that
> > caused it to initially get reported?
>
> Ami (now cc'ed) knows more, but here is my understanding.

Robert's description of the mechanics we observed is accurate.

We discovered this regression in the oom-killer's behavior when
attempting to upgrade our system. The fraction of the system that
went unhealthy due to this issue was approximately equal to the
_sum_ of all other causes of unhealth, which are many and varied,
but each of which contribute only a small amount of
unhealth. This issue forced a rollback to the previous kernel
where we ~never see this behavior, returning our unhealth levels
to the previous background levels.

Cheers,
-a
