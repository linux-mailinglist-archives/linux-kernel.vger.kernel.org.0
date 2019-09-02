Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2E3A58CB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfIBOHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 10:07:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbfIBOHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UZlFjh/Vr9Y31t3ktL+M4T4Quj9vWJpWpfcm5JWxNvk=; b=o5N4kGu1qDfvTB+SBbnjxBYpM
        bwHQFCjDy+miyB51bUwzUtfR9edjA79YYPQtlU4XS8cXuG+vjbh9p1GTGQHWsafyEn09a+V+j4nLu
        A9ZPFem6ubH/H3SKh07Sk3QO+Y+cc26LHNEFwU/jhhWf0L2HXG1K6qrcLvg80iSW0oPWEhOWkyAfB
        zA6v9kY1xJnXbd0Bv8bBV4PH3t+1lzShgZWfUGytIIhqnPKAQrIAQlsYy4lHyjxzJQlrXKI6i8eLG
        xgWngyP27BOrC0GjXXxMDgw32c8EcbRdlckZxgxG75wsej9LY7IQOezl2Ud7F+3W8JncK9vYZZSMN
        HiauCYaNg==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4mzR-0007kT-PX; Mon, 02 Sep 2019 14:07:29 +0000
Subject: Re: [PATCH v3] arch/microblaze: add support for get_user() of size 8
 bytes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <5a3e440f-4ec5-65d7-b2a4-c57fec0df973@infradead.org>
 <CAHk-=wg4mE8pSEdWViqJBC9Teh8h1c9LrqqP6=_g8ud5hvkfmA@mail.gmail.com>
 <CAHk-=whH+Wzj+h0WzgdLMu+xtFddokoVy8dWWvEJqJRGA_HLmw@mail.gmail.com>
 <6184ffdd-30bf-668a-cdee-88cc8eb2ead7@infradead.org>
 <98c83922-6ab1-98ca-7682-7796ae1facf4@infradead.org>
 <CAHk-=wg7BwJ7jFXxj5ZOU5VOw4Eg74TpTzip4P+LEJTYbZVhng@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8d17e0ae-5017-b883-96c0-ec4ebdfb4ab5@infradead.org>
Date:   Mon, 2 Sep 2019 07:07:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg7BwJ7jFXxj5ZOU5VOw4Eg74TpTzip4P+LEJTYbZVhng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/19 9:58 PM, Linus Torvalds wrote:
> On Sun, Sep 1, 2019 at 7:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> I guess we need a way to coerce that to call get_user_1(),
>> such as a typecast.  This _seems_ to work (i.e., call get_user_1()):
> 
> No, I oversimplified.
> 
> Try this slightly modified patch instead.
> 

Yes, that builds cleanly.

thanks.
-- 
~Randy
