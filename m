Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C67B5469
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfIQRjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 13:39:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39197 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfIQRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:39:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so2384128pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yQGk0/8lgiYPogMBH7GGBJWsq/bIXk08DULJA4Ggl0k=;
        b=NtTZWOJ6sZPprJOVH0W4hwFThisJKK+mS/VHocfVHVb2P9H2l9T5aHpChwouDxkwmE
         P49mEJJBAVVcwAOr9zUQvc3TY6g7qH1YnPBmLL6C8kaZ+bVjQzQTzqDTut2MaiTkY9wl
         QF6VMIptGZdvKaN6CHCHDorvDVZ2wL8ePNFV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yQGk0/8lgiYPogMBH7GGBJWsq/bIXk08DULJA4Ggl0k=;
        b=KjkuauF9glcrZMM/DD5wpBrsXSXKekU226s3FLryycbkh+Zxm0NCHNFK3WzI7S2Dzh
         00dtNEAmToDQX9xte14Dh/+3v50oBWSbI3BiElezz2dt44q+HF+h+O4spEwn+4ifFHEO
         lGxEGabMUdyW/UMpK4RxDU+A1tl3qN0tw/EovajnXCIkLSrtf+vuRm4uL166KtgMn2Iw
         StDkq9bcyaXqij/sx+VK+XmHYEsCOjtNIrOJZVpPPQ+Jn1JHLOOBS71y3yUWRo7fX05U
         HsVqBXsNw5Sw0oPoHxfWvTbZuZsWqUWcWzS22A2fmqGX3mZcHA937IXyeocCHKFl50P6
         kZdA==
X-Gm-Message-State: APjAAAVx6+i01T2xzsBeh+ajXV4bun42KBqTh3m1EM9sPcafKvgJqgZL
        QTUOmq3uWB8s3iGIZqJ1byscvA==
X-Google-Smtp-Source: APXvYqy6+hMb62AAD7PQRSOuTFktsmPGOjE+m8dJyhXRgqu8ZVw0TdiA88ecI5b6khAzl2L7X7g00w==
X-Received: by 2002:a63:3585:: with SMTP id c127mr8016pga.93.1568741992410;
        Tue, 17 Sep 2019 10:39:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w7sm3008939pjn.1.2019.09.17.10.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 10:39:51 -0700 (PDT)
Date:   Tue, 17 Sep 2019 10:39:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] usercopy: Skip HIGHMEM page checking
Message-ID: <201909171039.09E75C2@keescook>
References: <201909161431.E69B29A0@keescook>
 <20190917003209.GS29434@bombadil.infradead.org>
 <201909162003.FEEAC65@keescook>
 <20190917163606.GU29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917163606.GU29434@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 09:36:06AM -0700, Matthew Wilcox wrote:
> If the copy has the correct bounds, the 'wholly within one base page'
> check will pass and it'll return.  If the copy does span a page,
> the virt_to_head_page(end) call will return something bogus, then the
> PageReserved and CMA test will cause the usercopy_abort() test to fail.
> 
> So I think your first patch is the right patch.

Okay, good points. I'll respin...

-- 
Kees Cook
