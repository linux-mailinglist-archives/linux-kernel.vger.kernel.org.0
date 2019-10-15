Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB0D825E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 23:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfJOVqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 17:46:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43677 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfJOVqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:46:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so15663508lfl.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ob5N5ZzOYqwWJlWtRK/QQr9teH3dlSPsAVI1F8bPf38=;
        b=Ls2Ydx/1fiuQCKLYCr6mZfYT53ylM0bwO8QLfmOr29RVIEWsNQvXoEyD7/28atloUG
         w+SNF88R+eUaHbdCKU6U17DXhOsSyLQK+W93/BhVqc1MTwofrvdbxA3OX0BP8484yWP6
         rquduhuB1DQ9TVPZMjcMgJRO4GQPDwTo2bq84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ob5N5ZzOYqwWJlWtRK/QQr9teH3dlSPsAVI1F8bPf38=;
        b=QZxBvYaHvH4jz9bYoZKz4edRaufTlf2vqfEJAii6apjwrnJgucs5gmySBWiP/N6Rbm
         apL+5mBEXzrHtbRpJLxeSiioIZjO2YoDc8cJwCu0a2SkArpadA0GXYF60RCxEM/fus8K
         3T6+Q4Ul/VVXuDqKDtdKvk0Ym2zFu2TptEGzk+WL7dRkx87CL3Y+XdNaEdUaXocRFRXS
         HDdyHmX6SNT8nRSCYqr/ZYrXaSWpIw3lcyA7hU1yREuS2i1BJ0XdezKqqdZbF6PlF8vx
         KPWkXT6SpD3ByxoDJs2jL3/TP4KavOQ8+xzVjjnKF2Y9RHuAp+LpNVybSlkUAn3Q1RSd
         hGMA==
X-Gm-Message-State: APjAAAUVzk8CFCX6ma8kthcpn6PrEskFQ1iGsMThrG1Ijc830VXx+Jma
        4E8z7ACS2SkA2rKGj1J5/1Mo6fi2kQM=
X-Google-Smtp-Source: APXvYqxJJAmvovEoNXsPCwHXM44Y2qIPITJUYBC2MMqD+e3MzejeYOsKxnwr4LTsAxzfsvjuge4qUA==
X-Received: by 2002:a05:6512:219:: with SMTP id a25mr22630078lfo.61.1571176005071;
        Tue, 15 Oct 2019 14:46:45 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k68sm5550987lje.86.2019.10.15.14.46.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 14:46:43 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id u28so15670497lfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:46:43 -0700 (PDT)
X-Received: by 2002:a05:6512:219:: with SMTP id a25mr22630003lfo.61.1571176002727;
 Tue, 15 Oct 2019 14:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191015191926.9281-1-vgupta@synopsys.com> <20191015191926.9281-3-vgupta@synopsys.com>
In-Reply-To: <20191015191926.9281-3-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 14:46:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtRuGdsm0BR50vpwJBRJgP3u6Suz0LNa6WzR9RMtJjbw@mail.gmail.com>
Message-ID: <CAHk-=whtRuGdsm0BR50vpwJBRJgP3u6Suz0LNa6WzR9RMtJjbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] asm-generic/tlb: stub out pud_free_tlb() if nopud ...
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 12:19 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat
> from this routine which is not required in a 2-level paging setup

Ack, looks good.

           Linus
