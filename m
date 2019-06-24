Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782FA51B09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 20:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfFXS6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 14:58:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44691 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfFXS6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:58:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id x47so15612111qtk.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/m3xpT0Zzv2GHzFiTiGnJSv3W48e1yVOEcmN0l3E8do=;
        b=JWzf97iC1A/24INnQwn18VqYi27rNOR3APpLstuCjnGlDEb8IYHgeX269da5haeJdl
         /2zzJDxlC1m0ywSZwvdd887RplaR5O81Y+sStGWuYT5OxVwzhGg3dyzsSnkqArERwoZR
         o42C6AdI9SqQOO1Pplup9OUt4dr+taK+MGEq69pUbzbeH02CUlClQEDfWcNBoT/0H0q/
         8kBSSOygsAku9DZ8gKuN+UoWjIW6g3iJprrPwcon3rkYsd5XR2pie8hQiamc8AKtKsi9
         C0mLJV4PUWkAEj65Tra0Hjrl4AA/y7NN4H5w6/YYvxBvHEUN4A1PSTDL+PVVFA/Vf9rQ
         AilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/m3xpT0Zzv2GHzFiTiGnJSv3W48e1yVOEcmN0l3E8do=;
        b=PIKbRahgP6MgJ2DKKofidYmQTQ06PeCfvP5G50gp7gXDAe6N1J16DulxzMpETjOzCx
         e0YH4M1u6QkVKvii/JJOi9sdfKztpghxrlmb3voYTBNRPi6KfIQy9bZiN44mH5XAo6ow
         6aIXyju3cz7hrf0AF810ZNcNdxZh4EIvAeZaG3LX1tFbfJJdu48+RY6wndoY0RV3SZfT
         caqqmFwErKcDg0YhHwz7zc2HZLdUHvFW7xOegsavGUXDMpkYnDCWVVUqTaHE2r29wfGh
         ajerxC+9/yf3c4uYVcVhA1cEjPppre+l2olpt6TGLiXujkjc8crvOSMx3f1sSSDUdYXG
         Rt3w==
X-Gm-Message-State: APjAAAX268LsUehZhIHjs6ZlNspk+9oH+RSfAEsfNmml7xXiUCybwoyI
        O6T9s/G8MNXQf5Rc3vV+vzo=
X-Google-Smtp-Source: APXvYqwaqvUbdrTOeXT6JlsKg89653rrnDkVgvnVWibNdFlEBWJcuMlxrzQz48xjO2sK1A9iA9pwbw==
X-Received: by 2002:a0c:f788:: with SMTP id s8mr14664836qvn.35.1561402682962;
        Mon, 24 Jun 2019 11:58:02 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id b23sm7460548qte.19.2019.06.24.11.58.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 11:58:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E48A141153; Mon, 24 Jun 2019 15:57:48 -0300 (-03)
Date:   Mon, 24 Jun 2019 15:57:48 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] perf intel-pt: CBR improvements
Message-ID: <20190624185748.GD4181@kernel.org>
References: <20190622093248.581-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622093248.581-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 22, 2019 at 12:32:41PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are some improvements for the handling of core-to-bus ratio (CBR),
> including exporting it.

Thanks, applied.
 
> 
> Adrian Hunter (7):
>       perf intel-pt: Decoder to output CBR changes immediately
>       perf intel-pt: Cater for CBR change in PSB+
>       perf intel-pt: Add CBR value to decoder state
>       perf intel-pt: Synthesize CBR events when last seen value changes
>       perf db-export: Export synth events
>       perf scripts python: export-to-sqlite.py: Export Intel PT power and ptwrite events
>       perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events
> 
>  tools/perf/scripts/python/export-to-postgresql.py  | 251 +++++++++++++++++++++
>  tools/perf/scripts/python/export-to-sqlite.py      | 239 ++++++++++++++++++++
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  24 +-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
>  tools/perf/util/intel-pt.c                         |  65 ++++--
>  .../util/scripting-engines/trace-event-python.c    |  46 +++-
>  6 files changed, 590 insertions(+), 36 deletions(-)a
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
