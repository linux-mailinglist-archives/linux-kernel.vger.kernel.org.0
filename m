Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B429F19337
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfEIUNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 16:13:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38343 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEIUNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 16:13:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id 14so3137796ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3t0fHs/RWeFMshDhWS3M27ZDaMDmGQWEIuZaolYSKOY=;
        b=KFMGxiwHsz+TJTucdhyCO545Xe7K448QMKBYqhw+gBzzcF+dUnwn7vjWCPE/LF/LOP
         svKCJdzFU2X6nCXM8+xdHzEq+BncHOVnf1vpgRP3FR8lmREAimZ8dgpon5g/OAlbpykH
         6C5uNTsWZcnwMQbb+IgOUIsgOHr2PH1aQ6dB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3t0fHs/RWeFMshDhWS3M27ZDaMDmGQWEIuZaolYSKOY=;
        b=eHmBi26IYRtspHd8svuzGcHlYlmhKVWX7P+CyGYk7V7FUAckCjv5QpmxlAeLVLa4pH
         M24v2lhJyfUBglvWzBS0p4rJLSV2fVTnPGlMF98ubBJHOuqpcM5dmWg28QLUI9PBrk1W
         e4FDTWMdbS0aleuEDqqXxFpWeHTw35iFEYHyZjQ53fuO2ynqdt2mugphtMp0vaY2ShNS
         WWOOdb9zHhq8EHMJjl5FDAZYtTe7ut1y890acQmNxrsv4U6gjIpgmC339YXCAGvNoKuN
         JCBLFZX2tbB1/JFMbH//uIGLAKRvVNxFbWRZ8C8OT4Y5KYJlqm9KbuECUMv9TdbfVmwB
         dSeA==
X-Gm-Message-State: APjAAAU8iWRZtZE5GXRdjtcE09isdxPg+SlIxTXKM8peaYkzKRmZTLlg
        UxoLLdlNYUYl9a3CMbQlbf2prCgTMzs=
X-Google-Smtp-Source: APXvYqxpTZjiX5ZH0Pl5UU2s72iy11GBv1BC6F5cbnjjsTyD2c/QguasiCybE7d8A87jb3yoX8r9MQ==
X-Received: by 2002:a2e:9c89:: with SMTP id x9mr3453302lji.28.1557432794526;
        Thu, 09 May 2019 13:13:14 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v11sm606814lfb.68.2019.05.09.13.13.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 13:13:12 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id d15so3134820ljc.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 13:13:12 -0700 (PDT)
X-Received: by 2002:a2e:9044:: with SMTP id n4mr3436211ljg.94.1557432791964;
 Thu, 09 May 2019 13:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190509154902.34ea14f8@gandalf.local.home>
In-Reply-To: <20190509154902.34ea14f8@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 May 2019 13:12:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZGWpXdscUHyuoRqkJ8XD5Wh2Q-320KGFBhGoBJGzAWQ@mail.gmail.com>
Message-ID: <CAHk-=wgZGWpXdscUHyuoRqkJ8XD5Wh2Q-320KGFBhGoBJGzAWQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] ftrace/x86: Remove mcount support
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 12:49 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> diff --git a/arch/x86/include/asm/livepatch.h b/arch/x86/include/asm/livepatch.h
> index ed80003ce3e2..2f2bdf0662f8 100644
> --- a/arch/x86/include/asm/livepatch.h
> +++ b/arch/x86/include/asm/livepatch.h
> @@ -26,9 +26,6 @@
>
>  static inline int klp_check_compiler_support(void)
>  {
> -#ifndef CC_USING_FENTRY
> -       return 1;
> -#endif
>         return 0;
>  }

Please remove this entirely.

There are now three copies of klp_check_compiler_support(), and all
three are now trivial "return 0" functions.

Remove the whole thing, and remove the single use in kernel/livepatch/core.c.

The only reason for this function existing was literally "mcount isn't
good enough", so with mcount removed, the function should be removed
too.

                     Linus
