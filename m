Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82FFA14C8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 11:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgA2Kut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 05:50:49 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46511 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2Kut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:50:49 -0500
Received: by mail-io1-f66.google.com with SMTP id t26so18059340ioi.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 02:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWJyJn0sfT0Zc5yi27vWrHQD81AWkTLfYCa1678fPLo=;
        b=Gf6CTpyTECKUTC/bnNsYZb4GH5leoYRRcnPTp/KFi5JNN2XMLYSfBihxGeTsEnp2ln
         C44X0C640MPWJZyTWqRyHbZRRHCdrh4gjmkUk63NkrWuXsI505/vERefKnBHYvNT0O3u
         n8U5fx/OyDpaZcvna3pGyEuw8SqEvSaEVn+Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWJyJn0sfT0Zc5yi27vWrHQD81AWkTLfYCa1678fPLo=;
        b=fEbAjxS09WWHOTEfVqfmylmwZvFzxPENsbZtiwDMxgdGSdNQZMZAhVWtBbh0Rbv1Mg
         25EUkC3I1W05WOeeBGhq/t8ACcCdOABduf9jWywQ/SGzLUoIK6x9emkePWuwb3Dbn3RZ
         /nZp83OBnKN0GiTdJ38eMyAEgbe51nIQuLKkyxJzQrNu8vk3yOWw/KFp6hbaIzKMNMhO
         Yk9YvSA9OTGiN/wMsT6EWqoFb7/ZIAxEwjFm7r+nF7tHMhNR5Bb9/hBrzPpnEg7t88hq
         vzPOt7xzedAbdOmn393M+orWAXJtTJmPL2ps2o8pN9P6GCFCsygP+7MpOitq7olNYHgW
         BawQ==
X-Gm-Message-State: APjAAAUpqTu/k1b2GdHo9nAKMVuTDTDmC4kyMpHpskQUxi1HIk03Itpj
        ZDANZq0t8a65fF7IlMjQSvwCAGxdRwRwQFt9tpq2ng==
X-Google-Smtp-Source: APXvYqyMwMa1EZLvilOnOqucjHfFowYylcPwKRIaPLXouVwygD13i61Qx/FolEShfxCTy2yX3s8VN1aTQydpbYCRsB8=
X-Received: by 2002:a05:6638:3b6:: with SMTP id z22mr21031873jap.35.1580295048355;
 Wed, 29 Jan 2020 02:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20200125013553.24899-1-willy@infradead.org> <20200125013553.24899-12-willy@infradead.org>
In-Reply-To: <20200125013553.24899-12-willy@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 29 Jan 2020 11:50:37 +0100
Message-ID: <CAJfpegvk2ZHzZCriAjdWoKvDXLtXi_c4mh34qLfy9O89+oAwhQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] fuse: Convert from readpages to readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 2:36 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Use the new readahead operation in fuse.  Switching away from the
> read_cache_pages() helper gets rid of an implicit call to put_page(),
> so we can get rid of the get_page() call in fuse_readpages_fill().
> We can also get rid of the call to fuse_wait_on_page_writeback() as
> this page is newly allocated and so cannot be under writeback.

Not sure.  fuse_wait_on_page_writeback() waits not on the page but the
byte range indicated by the index.

Fuse writeback goes through some hoops to prevent reclaim related
deadlocks, which means that the byte range could still be under
writeback, yet the page belonging to that range be already reclaimed.
 This fuse_wait_on_page_writeback() is trying to serialize reads
against such writes.

Thanks,
Miklos
