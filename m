Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA79D339C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 22:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfFCUdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 16:33:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38563 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfFCUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:33:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id o13so17530352lji.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QTzCtuviovIYfq8pTKDRR4SrKn6XoLJ/vPLJgFkB3w=;
        b=Vk8wrD/KBb3ropxiBzC/cMY5H7uBQDbPJ+/9qpdljtDZ2GWz77sCU3Cr488J/uqgoW
         hQY4/SQ04YkONghe61ER2V7f2oTZ/A4P2GGDSYSe+XGTOK631liT1TtW7STqA0a4VNiV
         MKTcy7TAgRj2ZrarOYhnbL/RCqzHjF7F5VAv9uVZ4ssFvEthgJrvGuUXNk7MW5f+N+dH
         5+2QbEEcMSj06UmRV5xKsYq0BqDU9E4dnO2GrRJbbwyJ7myCJv+33ABsjAmP4HYOLi0z
         6a0WI5mp6LQc6b+tG9pRnaU0tYOrWXSyMBKowuP0og2uYNxY3VfeNL2oBCWCA91757+l
         1Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QTzCtuviovIYfq8pTKDRR4SrKn6XoLJ/vPLJgFkB3w=;
        b=XaiUE8fIFBMHQl/NiostsI/1h8X5wHbsU7ecO8iV87HHXuP7LzS4sg3pTOoEqM9XJD
         E6lLPbvjIQ1wLwCvE2y26jNrH4NXyrbGOmIEpc4WOC87al/liX3w2fLigb54F9NrlDTJ
         Je0Fy6jZh1WDRjuIf+ItlRFatoGDZqo/8/iq4Fbktg53ppHGtE9WgsvEekPZPPx2eZtF
         OMISHsycO5rggW1yBHaTFfwWRuUTk4iOq9Vp2OgHw24BcYH9gMKSCyfC2Tx5QRa8/vdk
         y/OpiROASsQzZZDYYUzqC3S49MNFT6kMasD/N5ueakWGOwjdyFo5kUhiwOzNCWdnFqeK
         dTkw==
X-Gm-Message-State: APjAAAWa9WddPmsECH0FSjfSPbvtV0bZdZYp6Y1Mg4fXIPlnh4E6aDA0
        q4WKVi0OG3ipHoaCZoWBinWtfhH2F0xecePQ2dEKx/97KXfj8Q==
X-Google-Smtp-Source: APXvYqyGjcfLF23rJTiW8aVGJ6N1yjmEUfEYDArU7kaMrnqdGIB14pAkLyE5K3hc/DFNutaX3KbHgKKW1IAEYXLaLYg=
X-Received: by 2002:a2e:9f52:: with SMTP id v18mr14823781ljk.176.1559594000924;
 Mon, 03 Jun 2019 13:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190603214105.715a4072472ef4946123dc20@kernel.org> <155956708268.12228.10363800793132214198.stgit@devnote2>
In-Reply-To: <155956708268.12228.10363800793132214198.stgit@devnote2>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 3 Jun 2019 22:33:09 +0200
Message-ID: <CADYN=9+f9JQFUX74fhWm6CvMfvivVYhHrQ6mQ61mGH+NW4==DQ@mail.gmail.com>
Subject: Re: [PATCH] kprobes: Fix to init kprobes in subsys_initcall
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 at 15:04, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Since arm64 kernel initializes breakpoint trap vector in arch_initcall(),
> initializing kprobe (and run smoke test) in postcore_initcall() causes
> a kernel panic.
>
> To fix this issue, move the kprobe initialization in subsys_initcall()
> (which is called right afer the arch_initcall).
>
> In-kernel kprobe users (ftrace and bpf) are using fs_initcall() which is
> called after subsys_initcall(), so this shouldn't cause more problem.
>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Fixes: b5f8b32c93b2 ("kprobes: Initialize kprobes at postcore_initcall")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

> ---
>  kernel/kprobes.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 54aaaad00a47..5471efbeb937 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2289,7 +2289,7 @@ static int __init init_kprobes(void)
>                 init_test_probes();
>         return err;
>  }
> -postcore_initcall(init_kprobes);
> +subsys_initcall(init_kprobes);
>
>  #ifdef CONFIG_DEBUG_FS
>  static void report_probe(struct seq_file *pi, struct kprobe *p,
>
