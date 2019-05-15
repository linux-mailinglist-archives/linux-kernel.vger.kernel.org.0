Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B1A1E810
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 07:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfEOFzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 01:55:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44169 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfEOFzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:55:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so1112852wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 22:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fyK3fKkuobsxXIXQz219tKe2nbyhG82em9jRFn7cSFo=;
        b=LA4l8K6A+vHbdsc+Q6ROgYabK/xNk9OfO8y8YDe6bry557bPz64C8DhzJc18gaXXi9
         KEYZ0rPff9bRziiiKNPsayZuyd0KRrn9go0aPVztCVdc/64qjZc+pLPMI8SLasBdk1WJ
         UJ8nfmTITvmu4HoWLGYvoM3LgwH2o89/Qg0ucBntz7Ij1a+IOOs6HEKGOCG7VT1AojmY
         JTWE/yLxtF71iAJDgt3vRm11nOvAc+ep/qJo0ykU2kHtvNme09kc5FMEcL6jO0KYZ3ju
         MRGOE0+V9/Vvqo+5oaC5GTezpghp2LTTHmtGVUC5Ne/uYvhYh04DWz+7WpXrZIa5gdTg
         Ubvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fyK3fKkuobsxXIXQz219tKe2nbyhG82em9jRFn7cSFo=;
        b=ueMPqlWO+dWH2fWwnYGtOYPY8SPBfiwHSU1l9WdKYq31mAe6AExTaIFY7P4z4veztL
         QRLcWYZpCshZObWSmLTURWJ2WoIN7HPzIeeu6v3VvjuUHWOOjVsI8fgdBrYo6Sf654fC
         thC2cpYEjIp6hQyka92mDEljD+BLYGhlCsucDXDLJuJgD6BJGts9fllTSODhRJ328LKR
         JRV0w5l9NuuqC+2Ue9W74v+t+ZKaSeo9nJrQSlfub3WZNFuS08VUcBR6pkJBKV54qHOB
         mSpdwyoOa0paRqXcUnT0heD2toIoAkke84aKhIv0MSR1vbBZCIOj7YO/6WFLCRRLVl7s
         D6ig==
X-Gm-Message-State: APjAAAV/YiuAHLWYkYtzKqWYasuW9VAo4vdiG4D/3vQSvVnwmVfvoKea
        3/upehyr/J6VKL1bEkCFzx4=
X-Google-Smtp-Source: APXvYqxfLpBmiMjreUz0R4ubBQ7Z5QyEs3NJHcxPqJzkx1eiewypnOPSK8/Cj4Fq0MNIF4EkjPJYig==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr25145818wrj.66.1557899738163;
        Tue, 14 May 2019 22:55:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l14sm927407wrt.57.2019.05.14.22.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 22:55:37 -0700 (PDT)
Date:   Wed, 15 May 2019 07:55:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [PATCH -tip v9 0/6] tracing/probes: uaccess: Add support
 user-space access
Message-ID: <20190515055534.GA39270@gmail.com>
References: <155789866428.26965.8344923934342528416.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155789866428.26965.8344923934342528416.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the v9 series of probe-event to support user-space access.
> Previous version is here.
> 
> https://lkml.kernel.org/r/155741476971.28419.15837024173365724167.stgit@devnote2
> 
> In this version, I fixed more typos/style issues.
> 
> Changes in v9:
>  [3/6]
>       - Fix other style & coding issues (Thanks Ingo!)
>       - Update fetch_store_string() for style consistency.
>  [4/6]
>       - Remove an unneeded line break.
>       - Move || and && in if-condition at the end of line.

LGTM:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
