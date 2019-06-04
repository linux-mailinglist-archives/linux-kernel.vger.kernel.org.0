Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373B433FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfFDHUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:20:25 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:55055 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFDHUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:20:22 -0400
Received: by mail-it1-f177.google.com with SMTP id h20so31816322itk.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zcQ0XCzyOuqSZq43SdsbTL7y6bYo0YRJAf0OBu/R2Gg=;
        b=jyc9jUmpnUgySHIKHOeizGxOD/ZSfhC9wTdSu9qr9XzcBxRDi3Wr8XHsdbph8QTBbd
         LQwPzHbnOuFogbzM8Dqb5yomDHmc8kyRkkAQaXUPCLuNcvBzGIht8u2owaX0Rp7wQvcH
         eXwwsTxdr8yrJ53YxILX1l/GgczfQi2loVe4WmtU07Awj37BNVnOPd20+FtrVDbBiRji
         LAws27Q5LwJN3ayHMA0qMwWiyMNdoGoavABtZ5LMHQCkdFS7sCdnW1NRPAtVYbFIQBG5
         toX6s/OLGXz2txpUw2n+HJWlm8RJXuVkIisW5fCBWtLIDk07nFEy2nFtaw6G8BvdMXsy
         GV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcQ0XCzyOuqSZq43SdsbTL7y6bYo0YRJAf0OBu/R2Gg=;
        b=Ovq9TKqSWnGM81M6SicYB5WMUAX64lIFF3evRVyKaHR5908KYH/DQOkKr6WWwKt8cV
         5IBMqLWYL6sFI9hN+cu3ToIBnPSj4/ZleSg0TxjnPQOE2fbE93FJc0rMSaem87VqYYrl
         HS8ZJWpBecUFT5iGmXFFA/fsZzVM6yxlgYeXp1uoaE+ihIid/Mp6jqdBeJG8PD/19RP/
         g6G03Lc8eFYDMOMOTF+TPwHxbOsidPumQ5RNIm/FD/n4dIyEDPJu3gA74eaoy5+mIB22
         sUVwLbt3YqmREy/DJuHoDlD4V2s+mkeY48/IQ1MtURSqzJkVXXSjSxqyQYLASe64uks8
         9qdg==
X-Gm-Message-State: APjAAAWdOjbjxXoyNM48CcBeu1e4lL9RDOEpp5vgoPvYz42vzbi/WeYO
        QY8xCEuEq+xGLtOvE2r3sOBdTpf1Cv8f/Hga7ArJ
X-Google-Smtp-Source: APXvYqwM9oK0yxIHGRN26q+wez3poxvIpKgP7P1vb0fH/ZVDzSvi9jMULHR3irpgfqNRNQT1Aovt0C0qpmXujcKGpRs=
X-Received: by 2002:a24:30d2:: with SMTP id q201mr12259268itq.100.1559632822036;
 Tue, 04 Jun 2019 00:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
 <20190603164206.GB29719@infradead.org> <CAFgQCTtUdeq=M=SrVwvggR15Yk+i=ndLkhkw1dxJa7miuDp_AA@mail.gmail.com>
 <20190604071731.GA10044@infradead.org>
In-Reply-To: <20190604071731.GA10044@infradead.org>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 4 Jun 2019 15:20:10 +0800
Message-ID: <CAFgQCTt1ggP6-_XSDyG7aqw-mg4-zSA6ZNQRb+ep8HkDqAikug@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 3:17 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 04, 2019 at 03:13:21PM +0800, Pingfan Liu wrote:
> > Is it a convention? scripts/checkpatch.pl can not detect it. Could you
> > show me some light so later I can avoid it?
>
> If you look at most kernel code you can see two conventions:
>
>  - double tabe indent
>  - indent to the start of the first agument line
>
> Everything else is rather unusual.
OK.
Thanks
