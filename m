Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1481CF8E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 13:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfJHLwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 07:52:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfJHLwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:52:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9B6D121D;
        Tue,  8 Oct 2019 11:52:42 +0000 (UTC)
Received: from krava (unknown [10.40.205.103])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8917B60BE0;
        Tue,  8 Oct 2019 11:52:41 +0000 (UTC)
Date:   Tue, 8 Oct 2019 13:52:40 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf data: Fix babeltrace detection
Message-ID: <20191008115240.GE10009@krava>
References: <20191007174120.12330-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007174120.12330-1-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 08 Oct 2019 11:52:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 10:41:20AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The symbol the feature file checks for is now actually in -lbabeltrace,
> not -lbabeltrace-ctf, at least as of libbabeltrace-1.5.6-2.fc30.x86_64
> 
> Always add both libraries to fix the feature detection.

well, we link with libbabeltrace-ctf.so which links with libbabeltrace.so

I guess we can link it as well, but where do you see it fail?

jirka

> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Makefile.config | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index bf8caa7d17f6..71638917e18a 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -155,7 +155,7 @@ ifdef LIBBABELTRACE_DIR
>    LIBBABELTRACE_LDFLAGS := -L$(LIBBABELTRACE_DIR)/lib
>  endif
>  FEATURE_CHECK_CFLAGS-libbabeltrace := $(LIBBABELTRACE_CFLAGS)
> -FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf
> +FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf -lbabeltrace
>  
>  ifdef LIBZSTD_DIR
>    LIBZSTD_CFLAGS  := -I$(LIBZSTD_DIR)/lib
> @@ -895,7 +895,7 @@ ifndef NO_LIBBABELTRACE
>    ifeq ($(feature-libbabeltrace), 1)
>      CFLAGS += -DHAVE_LIBBABELTRACE_SUPPORT $(LIBBABELTRACE_CFLAGS)
>      LDFLAGS += $(LIBBABELTRACE_LDFLAGS)
> -    EXTLIBS += -lbabeltrace-ctf
> +    EXTLIBS += -lbabeltrace-ctf -lbabeltrace
>      $(call detected,CONFIG_LIBBABELTRACE)
>    else
>      msg := $(warning No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev);
> -- 
> 2.21.0
> 
