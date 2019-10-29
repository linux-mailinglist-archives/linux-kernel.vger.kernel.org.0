Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B465E8ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 15:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389299AbfJ2O0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 10:26:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42367 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfJ2O0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:26:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id m4so12371531qke.9;
        Tue, 29 Oct 2019 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Et2z5qe0gww5nqgWYNl+FcCZVQVC9Y2anbmZH+/VOVg=;
        b=NlTxx14rBUKSvk/9k5qGANUAX+KWtUKqH+cg4S/qcz5JjFnI0A6Vz6KQax+gAKome9
         F6aEFi7VwOKGaRnndjwy7XiN+eTZX5pmoCsPeaqhzd4Gi1dNLF455WZ7dRCpb0/NB7Cd
         ypVXxUgQiDs/2GoHbHLJ4myfFzG3uBGIyPlSN5TxGQIKCImKKcp60tGblYPY+8qv0ZwR
         Q4ksGQPLIG90YIGl75rrDUIif0Jj5KmEQCOGMW8patgrcY9nm6O1mxpOfNSG4963Nljq
         KGod75j8YzMhvQ3FS0Fhq3301USk87caT+HMedTQjqPR77paTI6dUEI+ELzZgs48IYWv
         Rp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Et2z5qe0gww5nqgWYNl+FcCZVQVC9Y2anbmZH+/VOVg=;
        b=d+L+QAaiOq+A4ujNF2YKg6FTrp+ORb7NvyRVj9Oak8uPDzeKxSHtC/Sqfuoj6sx65E
         owCn70oTihT/y7jvW6oQsX7x0MZBkbVcHNz/r6KHsvuWHA2/9MFNHgX1c8rLIiN/AMYK
         WtG5jYRmdymUMYxTPx/Hs8m76opzrkf3XFcyA260cITBE8N6lQC1NBrHcLFO03VF07+B
         Owknd5W1n2GPYqYwpAFGHcnlbFIc1zuVur26FhvjWutUXObvZvzm7UUdPoir881JcUb2
         n5NIIJOCMEb9URTI6mDyt7c1MDveE3pRrFeGN0jirS/A+Mh5upAvuVn0OU83XDaWbq4r
         amow==
X-Gm-Message-State: APjAAAWE1EJcpi9sqsSgAKHXEv3qZWr6rXsx+5ubRuHvd22kLZJWDQM0
        BKQNO2V/hFOL2jLEOCkZSvE=
X-Google-Smtp-Source: APXvYqz3/1oBuok7OO9jaWMKfvwjhWfCiAgZv0io3VazkIUzfbVyCPwrl7zA3UcTH60qHsQgQjLhwA==
X-Received: by 2002:a05:620a:1e1:: with SMTP id x1mr5125179qkn.133.1572359210721;
        Tue, 29 Oct 2019 07:26:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i25sm205488qtq.85.2019.10.29.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:26:50 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CA61140D5C; Tue, 29 Oct 2019 11:26:47 -0300 (-03)
Date:   Tue, 29 Oct 2019 11:26:47 -0300
To:     James Clark <James.Clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nd <nd@arm.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] Fixes issue when debugging debug builds of Perf.
Message-ID: <20191029142647.GD4922@kernel.org>
References: <20191028113340.4282-1-james.clark@arm.com>
 <20191029140052.GB4922@kernel.org>
 <20191029141852.GC4922@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029141852.GC4922@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 29, 2019 at 11:18:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> And here is the first patch out of your larger one, I changed the
> subject line to reflect that this is not tools/perf specific, as
> tools/objtool/ also uses libsubcmd, added Josh, objtool's maintainer so
> that he is made aware.

And the second patch:


commit d0381449fd9ab733ec2daf527263da9f73f1e94e
Author: James Clark <James.Clark@arm.com>
Date:   Mon Oct 28 11:34:01 2019 +0000

    libsubcmd: Use -O0 with DEBUG=1
    
    When a 'make DEBUG=1' build is done, the command parser is still built
    with -O6 and is hard to step through, fix it making it use -O0 in that
    case.
    
    Signed-off-by: James Clark <james.clark@arm.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: nd <nd@arm.com>
    Link: http://lore.kernel.org/lkml/20191028113340.4282-1-james.clark@arm.com
    [ split from a larger patch ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 352c6062deba..1c777a72bb39 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -27,7 +27,9 @@ ifeq ($(DEBUG),0)
   endif
 endif
 
-ifeq ($(CC_NO_CLANG), 0)
+ifeq ($(DEBUG),1)
+  CFLAGS += -O0
+else ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
 else
   CFLAGS += -O6
