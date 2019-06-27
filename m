Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC29457922
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 03:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfF0Bux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 21:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfF0Bux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:50:53 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C88A2182B;
        Thu, 27 Jun 2019 01:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561600252;
        bh=kCCG90D35IV6/JmLNcgUS4jnvzH9yFn+nds5+DI2754=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bi7erOcR7QL1tePUbWhxhRfVOdK7TUZAMULCWZL9xnLFzz30Srg/V8mE7CCxhLBK5
         WX11pFvjEm1RflWFQ6Jt/8NGtOslRE6425qqHv/RhKVUzUFXrCIoBgRS9v1Zx+DZGO
         g4JomsMEaY5kaE95S+ODC+MHKwIR5p6il9nIZ1RM=
Received: by mail-wr1-f41.google.com with SMTP id k11so524389wrl.1;
        Wed, 26 Jun 2019 18:50:52 -0700 (PDT)
X-Gm-Message-State: APjAAAUevrsFASnPdDROqGNGDSS0aQahtdNcmAxrnPCOewSrbMiJg8N0
        UPuluxoya7QpDpQ2SxMyscXpw+CRU/yw51+Epjg=
X-Google-Smtp-Source: APXvYqzSoiCCwTva2gZnnCXkLLyAW+tzKHN3GTfbeiNhlGr44n/II6VYQL1m25Vd73mFO8g1zpf1AARDHFO6xBB6VR0=
X-Received: by 2002:adf:f483:: with SMTP id l3mr626375wro.256.1561600251203;
 Wed, 26 Jun 2019 18:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561531557.git.han_mao@c-sky.com> <d874d7782d9acdad5d98f2f5c4a6fb26fbe41c5d.1561531557.git.han_mao@c-sky.com>
 <CAJF2gTRyma8sDMJaWCde1eOe6KSwn4_e=tJOT4d3kgmvzOxz8g@mail.gmail.com> <20190626185156.GC3902@kernel.org>
In-Reply-To: <20190626185156.GC3902@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 27 Jun 2019 09:50:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTGX-UO3WPJZHn0ANk=sgAqimfyq14bFbm-Kz=ydcX+YQ@mail.gmail.com>
Message-ID: <CAJF2gTTGX-UO3WPJZHn0ANk=sgAqimfyq14bFbm-Kz=ydcX+YQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf annotate csky: Add perf annotate support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mao Han <han_mao@c-sky.com>, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 2:52 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jun 26, 2019 at 02:56:55PM +0800, Guo Ren escreveu:
> > Thx Mao,
> >
> > Approved!
>
> I guess I can take this as a:
>
> Acked-by: Guo Ren <guoren@kernel.org>
>
> Or would this better be:
>
> Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by is OK.
Thx for help to merge.

Best regards
 Guo Ren
