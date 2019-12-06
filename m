Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43915115307
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 15:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLFOV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 09:21:59 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36648 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfLFOV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:21:59 -0500
Received: by mail-vs1-f67.google.com with SMTP id m5so5133568vsj.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 06:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LsMPI+jZ4YNhiN6FwdaZWSk9yKIx7sFVc+DM655R9Cw=;
        b=gf48QX/QAIT+u20WLakoLpcaRiGjYExkN4PMv432iCTmSanP9Dm2958OCgMSnXHqQK
         L5UuMduZLs7OQpJChpevkxTy06x6HvvlQXbjLg6K3Gvq5o4ykgT9XsUltRwl4sdWyJI+
         /QDgLSx/wcZGoP1ZnCxS43MDURq1Hva8HULw8bedVV7Tm2MC3HYhmpKWsAWqJtoMYaPQ
         sW8Ayuxz1Jhn4dPFN6E42/p1TteyCLwZylfKNefEMF+cJ0OUmz8GsuP2kXQwQvyTf6Ta
         ijypuZuN6lADlZxVr8LaVQFMLpD3kPA8XnV0nfOx+IMaHBIO2phm+Nbs1CfcZnIFF+5X
         pDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LsMPI+jZ4YNhiN6FwdaZWSk9yKIx7sFVc+DM655R9Cw=;
        b=kcgDXrFKGV58nCR4D4xPUEAiGqojbvxcItmWLNiwxlJf4rwGSsswazeo30TMHlDcUB
         idyIqy5Ja+6c9w0C/92ejHTa9J00oyX/yOHfdsZjwCas+Xe3V9ZzxTpfwGpE5uFbMVWi
         FsuEjIoXkIj6LWet3QgXVk9M0p4lzGqcxax3kl3zO0GBa/7rNr/Z8+eLX8Q3OlfhGKHr
         hKc8ziFtornE6BVQUTOVfQfINaqFlSrxcfmj7CMRWWHpP1Q1fqrkn/3RCXHaYxyhloCR
         IdoGJ44JVgYT6vTYd964io1cVtRKrXgvmB+DE+h+S8GvIpgESGq4GNSr6CzYof/q+JUt
         vEKw==
X-Gm-Message-State: APjAAAWZ4uD12PtTqcsNl9mm2hatXCR66CjTgsMROz8NAfnNsswmn13J
        a7G+JaM/JsUxRsQ/+AkxVHiWGsO5
X-Google-Smtp-Source: APXvYqwd89uBZUqBQJ53al03cU7aKrtCI/bYrmqL+8jtlBqZxtc59zUoeRTf3fKD7Fk4uPgE8kOkdg==
X-Received: by 2002:a67:f496:: with SMTP id o22mr9687201vsn.9.1575642118159;
        Fri, 06 Dec 2019 06:21:58 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id q18sm1469192vsp.19.2019.12.06.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:21:57 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D19C240352; Fri,  6 Dec 2019 11:21:54 -0300 (-03)
Date:   Fri, 6 Dec 2019 11:21:54 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 0/3] perf/libperf move
Message-ID: <20191206142154.GA30698@kernel.org>
References: <20191206135513.31586-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206135513.31586-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 06, 2019 at 02:55:10PM +0100, Jiri Olsa escreveu:
> NOTE 'make perf-targz-src-pkg' works nicely with this change,
> but is currently failing because of recent bpf changes, I have
> a fix for that and will send it shortly

By any means it is one of:

"libbpf: Fix up generation of bpf_helper_defs.h"
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=1fd450f99272

And:

"libbpf: Fix sym->st_value print on 32-bit arches"
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=7c3977d1e804

?

I've been cherry-picking this to have my build-test and container builds
for some time waiting for those to get upstream.

- Arnaldo
