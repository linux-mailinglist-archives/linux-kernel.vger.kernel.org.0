Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC214C716
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 08:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgA2HzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 02:55:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55844 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgA2HzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 02:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580284511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Q8owHXy33XcrZBh1M4F84KS5rHbxiQ9XitaKX7L6ko=;
        b=X46e9thz8tD6FCvh2ETie8kDxVYrb7IOKQ3OxTdzyVPU3/+j8tHXd31zWU7uaAJ6ntVJWS
        c202SCMFrObIJF8hzIDQoVU31HWT9mabjiXvqem3v292VfEa+I47e73B2Pzp//BYwxNC5A
        htLOIKl/j00PjsOJfEVdj3lOY+WYqA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-jCmaGiM6PmmQ6HVA82EhkA-1; Wed, 29 Jan 2020 02:55:05 -0500
X-MC-Unique: jCmaGiM6PmmQ6HVA82EhkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0E741882CC9;
        Wed, 29 Jan 2020 07:55:03 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF6F4395;
        Wed, 29 Jan 2020 07:55:01 +0000 (UTC)
Date:   Wed, 29 Jan 2020 08:54:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sam Lunt <samueljlunt@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] perf: Support Python 3.8+ in Makefile
Message-ID: <20200129075459.GA1256499@krava>
References: <CAGn10uXOj3n2u01bzhCkUVi-n5dDMVV+Mze3_uLV1K6RC6ebJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGn10uXOj3n2u01bzhCkUVi-n5dDMVV+Mze3_uLV1K6RC6ebJQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 08:56:12AM -0600, Sam Lunt wrote:
> Python 3.8 changed the output of 'python-config --ldflags' to no longer
> include the '-lpythonX.Y' flag (this apparently fixed an issue loading
> modules with a statically linked Python executable).  The libpython
> feature check in linux/build/feature fails if the Python library is not
> included in FEATURE_CHECK_LDFLAGS-libpython variable.
> 
> This adds a check in the Makefile to determine if PYTHON_CONFIG accepts
> the '--embed' flag and passes that flag alongside '--ldflags' if so.
> 
> tools/perf is the only place the libpython feature check is used.

seems ok to me, but your patch came malformed, check below

jirka


> 
> Signed-off-by: Sam Lunt <samuel.j.lunt@gmail.com>
> ---
>  tools/perf/Makefile.config | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index c90f4146e5a2..ccf99351f058 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -228,8 +228,17 @@ strip-libs  = $(filter-out -l%,$(1))
> 
>  PYTHON_CONFIG_SQ := $(call shell-sq,$(PYTHON_CONFIG))
> 
> +# Python 3.8 changed the output of `python-config --ldflags` to not include the
> +# '-lpythonX.Y' flag unless '--embed' is also passed. The feature check for
> +# libpython fails if that flag is not included in LDFLAGS
> +ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>&1 1>/dev/null;
> echo $$?), 0)

patching file tools/perf/Makefile.config
patch: **** malformed patch at line 108: echo $$?), 0)


> +  PYTHON_CONFIG_LDFLAGS := --ldflags --embed
> +else
> +  PYTHON_CONFIG_LDFLAGS := --ldflags
> +endif
> +
>  ifdef PYTHON_CONFIG
> -  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
> +  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ)
> $(PYTHON_CONFIG_LDFLAGS) 2>/dev/null)

patching file tools/perf/Makefile.config
patch: **** malformed patch at line 116: $(PYTHON_CONFIG_LDFLAGS) 2>/dev/null)

>    PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
>    PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
>    PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
> 
> base-commit: d5d359b0ac3ffc319ca93c46a4cfd87093759ad6
> -- 
> 2.25.0
> 

