Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D79CA151D8C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 16:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgBDPnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 10:43:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36720 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgBDPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:43:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so19122433ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 07:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMNz4wJasUKgOXfbJm3ZdyJfRO3XX6VpUM83bUcb5lM=;
        b=SfAgXYTwadYPWOvT6zNtV2PJPdpph6rHkFV5XFWMDa4vcCw3pysV8q6wQ7nHYGjzU3
         1QN1UwhHQAP2hLGW5j8wHuOSJkUZqQRuFUznQZxmkwlhfR/gDn5WmBDaKLKotDnPoTJc
         wjxNr2I0OHgom+LmiTt99TczYVgzxZlJxllO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMNz4wJasUKgOXfbJm3ZdyJfRO3XX6VpUM83bUcb5lM=;
        b=YwxciK6rQNxRzqd/IWoMXJXrosMzQB9u6EX8Ncrs5dzSeTsD0UyssaiHnLo3BDx5Gj
         uPgf9VTV9GSBTi4QFGeHEKUziyzh4HkSgpBnvz30JquzU5P20/YR9L28pEmowQVRbSI2
         SBtyI+dG/32mg1Z6hwQgpFw5lyJEhlwxFddl/HnlxVhmn5EpLXExNmwZE55OgFGcfAHV
         CkczdI/6vUbxFY/Zi9xM792R2Dgtft0wpHZAoKl0LJWdn5bVZI9IpLaCRtFnkD9yS5gn
         3ikgg2ZsCfLbqf8rXIPJ7DNeJ3i3878GxegJH21stUArr5U8lG8N8vwZkZOEQ7ozla8D
         SgyQ==
X-Gm-Message-State: APjAAAVlWb8RnTPVvgG7XSrAn+sRneKjcM0NDs0My6QKoLr1JvcIYdBs
        nS0u0TDbjmqDXcYg7tbF8jBhKGYqd3U5Xg==
X-Google-Smtp-Source: APXvYqw2kfbcA/VhJy9InjlQxxtyIjuHmqmV37Qb22NKE17BGsfgpPO1Pw6+J6Q9MNC/Hr8q/C3Mow==
X-Received: by 2002:a2e:918c:: with SMTP id f12mr16472632ljg.66.1580830998626;
        Tue, 04 Feb 2020 07:43:18 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id t10sm11682477lji.61.2020.02.04.07.43.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 07:43:17 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id x7so19144788ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 07:43:17 -0800 (PST)
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr18023700lja.16.1580830997232;
 Tue, 04 Feb 2020 07:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20200204053155.127c3f1e@oasis.local.home> <CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com>
 <20200204072856.0da60613@oasis.local.home> <CAHk-=wg2Wk9ZgVBDCBHa3-b0fSfByiRJnGA_F8snMy=3HHg_gw@mail.gmail.com>
 <20200204084642.450b6ebd@oasis.local.home> <20200204092528.2dc8fba4@oasis.local.home>
 <20200204093302.593cb82e@oasis.local.home>
In-Reply-To: <20200204093302.593cb82e@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Feb 2020 15:43:00 +0000
X-Gmail-Original-Message-ID: <CAHk-=wjTT81QUTAEbDPY=dJE2E18M_K2RhxSUxWmcbMyZUpm5w@mail.gmail.com>
Message-ID: <CAHk-=wjTT81QUTAEbDPY=dJE2E18M_K2RhxSUxWmcbMyZUpm5w@mail.gmail.com>
Subject: Re: [PATCH v2] bootconfig: Only load bootconfig if
 "config=bootconfig" is on the kernel cmdline (was: bootconfig: Add
 "disable_bootconfig" cmdline option to disable bootconfig)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 2:33 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I wonder if we need the "config=" part. Would "bootconfig" be
> sufficient, or is it better to keep it for documentation purposes.

I suspect "bootconfig" is sufficient, if it's easier to parse.

            Linus
