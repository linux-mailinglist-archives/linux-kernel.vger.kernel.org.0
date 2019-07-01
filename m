Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA71D049
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 22:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfENUEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 16:04:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35213 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfENUEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:04:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id a39so582533qtk.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2wZQ6xWxc+/+0XmEJfXIGreqSfh73KSQ5TKQRQXts58=;
        b=XtTEYKummlHi//ChjhE1VH9Y1m+spOUTqRcjCQJRhxc1cOI7N8azzbfCUibgdDWADS
         ANJ79xzwlFSQ0fLTcXSWIliRXwyKYRuzGQXm5iB1VnnPn6rU2FWTyqhcwrJyOaHLGnKz
         zNjoKmjsnu+PbBx40quKXVbVirwoJpsFDJ1ztemXfL2kARjy8F0n/4hRAWqSHQXr7VPX
         JQjjQHlDT7kqCaXzSrSyBxLNN6aIsi1WpejQpVm8nK8bG0B/LOaI2BrW28tDmKHC0RF6
         lZNuZ3/Nbto98YIEfekmGXa2NJuozk/TFBtWRCG6ce3ehpOiRdv8wS/AdhwJ1HCeBHPl
         Kvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2wZQ6xWxc+/+0XmEJfXIGreqSfh73KSQ5TKQRQXts58=;
        b=rAJJSXlunqUDKsrpk7apyF/NFbSUOMdeAXaxh//GQ67F49I1K/1a+F/j4jGdxhMse2
         zKe9Rmhq5gte3YEpzPSOZZ5OJNGuBcoeC79a3hFL4nElK4R14pILW3b5q/M5TuCOXt61
         GQEG/HHRvP9Sp8ROQ03v2cQYGGLm8ZBluy5TcX3LLbcafgR1IcnR4DyACuVhYMismI0U
         4Y3DtGHE0qN3o5tT9Z07Q6CSScdekvQozgd8q03bEDwWdIzi06u7Dqfg+DoCqDDST3Pk
         eaPpeZ4ya+ypv1pjeoKpqBxSu0Nq+tQGjTjbNaylfyUaTNYlXZxBljx6V3VYzOqEDQty
         0AAw==
X-Gm-Message-State: APjAAAXpXtBplEcjR9ZmcZYQPPU7J3nfuGkaTnqhhhqdEHu92l4Gu1wh
        7miU0hKCquXP40AdqPB4B6qN/b+J7ks=
X-Google-Smtp-Source: APXvYqwpOfuSsBF6JyzStVV467mNiQVNlv+ojmrBrZb+WJR08SIrxVKs7dbsMkUvqu+ZsUv/kzyf8w==
X-Received: by 2002:aed:2a25:: with SMTP id c34mr32386158qtd.62.1557864272534;
        Tue, 14 May 2019 13:04:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-182-78.3g.claro.net.br. [179.240.182.78])
        by smtp.gmail.com with ESMTPSA id o64sm9422001qke.61.2019.05.14.13.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:04:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B9F0C403AD; Tue, 14 May 2019 17:04:24 -0300 (-03)
Date:   Tue, 14 May 2019 17:04:24 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 09/12] perf record: implement
 -z,--compression_level[=<n>] option
Message-ID: <20190514200424.GB8945@kernel.org>
References: <12cce142-6238-475b-b9aa-236531c12c2b@linux.intel.com>
 <9ff06518-ae63-a908-e44d-5d9e56dd66d9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff06518-ae63-a908-e44d-5d9e56dd66d9@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 18, 2019 at 08:44:42PM +0300, Alexey Budankov escreveu:
> 
> Implemented -z,--compression_level[=<n>] option that enables compression
> of mmaped kernel data buffers content in runtime during perf record
> mode collection. Default option value is 1 (fastest compression).
> 
> Compression overhead has been measured for serial and AIO streaming
> when profiling matrix multiplication workload:
> 
>     -------------------------------------------------------------
>     | SERIAL			  | AIO-1                       |
> ----------------------------------------------------------------|

Please don't have lines starting with --- in the cset comment log
message, breaks scripts, fixing it up now.

- Arnaldo

> |-z | OVH(x) | ratio(x) size(MiB) | OVH(x) | ratio(x) size(MiB) |
> |---------------------------------------------------------------|
> | 0 | 1,00   | 1,000    179,424   | 1,00   | 1,000    187,527   |
> | 1 | 1,04   | 8,427    181,148   | 1,01   | 8,474    188,562   |
> | 2 | 1,07   | 8,055    186,953   | 1,03   | 7,912    191,773   |
> | 3 | 1,04   | 8,283    181,908   | 1,03   | 8,220    191,078   |
> | 5 | 1,09   | 8,101    187,705   | 1,05   | 7,780    190,065   |
> | 8 | 1,05   | 9,217    179,191   | 1,12   | 6,111    193,024   |
> -----------------------------------------------------------------
> 
> OVH = (Execution time with -z N) / (Execution time with -z 0)
> 
> ratio - compression ratio
> size  - number of bytes that was compressed
> 
> 	size ~= trace size x ratio
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt |  5 +++++
>  tools/perf/builtin-record.c              | 25 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 18fceb49434e..0567bacc2ae6 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -471,6 +471,11 @@ Also at some cases executing less trace write syscalls with bigger data size can
>  shorter than executing more trace write syscalls with smaller data size thus lowering
>  runtime profiling overhead.
>  
> +-z::
> +--compression-level[=n]::
> +Produce compressed trace using specified level n (default: 1 - fastest compression,
> +22 - smallest trace)
> +
>  --all-kernel::
>  Configure all used events to run in kernel space.
>  
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 2e083891affa..7258f2964a3b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -440,6 +440,26 @@ static int record__mmap_flush_parse(const struct option *opt,
>  	return 0;
>  }
>  
> +#ifdef HAVE_ZSTD_SUPPORT
> +static unsigned int comp_level_default = 1;
> +static int record__parse_comp_level(const struct option *opt,
> +				    const char *str,
> +				    int unset)
> +{
> +	struct record_opts *opts = (struct record_opts *)opt->value;
> +
> +	if (unset) {
> +		opts->comp_level = 0;
> +	} else {
> +		if (str)
> +			opts->comp_level = strtol(str, NULL, 0);
> +		if (!opts->comp_level)
> +			opts->comp_level = comp_level_default;
> +	}
> +
> +	return 0;
> +}
> +#endif
>  static unsigned int comp_level_max = 22;
>  
>  static int record__comp_enabled(struct record *rec)
> @@ -2169,6 +2189,11 @@ static struct option __record_options[] = {
>  	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
>  		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
>  		     record__parse_affinity),
> +#ifdef HAVE_ZSTD_SUPPORT
> +	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts, &comp_level_default,
> +		     "n", "Produce compressed trace using specified level (default: 1 - fastest compression, 22 - smallest trace)",
> +		     record__parse_comp_level),
> +#endif
>  	OPT_END()
>  };
>  
> -- 
> 2.20.1

-- 

- Arnaldo
