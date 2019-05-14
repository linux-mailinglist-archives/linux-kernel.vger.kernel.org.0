Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E121CA19
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfENOPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 10:15:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46153 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENOPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:15:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id t187so8699223pgb.13;
        Tue, 14 May 2019 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fEJluj9EIVSnD/lWYbBU/Qd/kcfRPu6BkyMoBDhXzT8=;
        b=X/TlMi4YqUIx5Nbluv2LuL8oIc+hZkfOPu/7aLG64Ho3wg+7ZMs0IvWVog5Grz369c
         ZOrx8upNj2K2XRR+q7KFcIPfrwFMiOjQUu/J5REoRS9sWPAOWQQiuYzZVqInPkSlIsaj
         ci2/pxd4thaQf5Sm1Ma+rQ6XmcB2JbZkIPzUYl6mQOap7uDCOmigqqTTq5klmNdnw+Qc
         xJxMqbB7Ujjn1TxjCT3I0FAI0G87OClJFGCpq1pokc4yEN0V6RwjxGSocIlj2ZouscC0
         VY/tDFnZ1/JCURr8CZov6QkgZxZ/TCZBrLHWXxEbGm2eRFR4pP9L78h7LP4HzRkQb++h
         gQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fEJluj9EIVSnD/lWYbBU/Qd/kcfRPu6BkyMoBDhXzT8=;
        b=IIm4AySlliMf1c0PyCkY49paCM+BTefGPgb39nutA+lLSBOkcpAN2/Nv7Ca4efIBwj
         JRMaBDyDLesJSt/6RVYQ5NQB8Oyep/9H1VXgIa2D4mzcLQ+fSnqdN7r0/kp/yejmqiWI
         yAgHvq4bBzu1oDEbkoEZYyEBLsII11iEQ0gqkzXro0PPYYNcVR9xFm6eECETJNaYDNCl
         uf/iyCAASByzCSk/1bPFNRqy0k4ixdRgMo4uWXRkQRVBwGR4LWCNovJsR7R1JliRemwI
         sA9wrF1Hq3+LIehSstXJkqpfvCi6k9dYBCtdiYKhjnhDbRUFY+8HdpguY+5V80F2hmi3
         77Fg==
X-Gm-Message-State: APjAAAX6FvZdi3Y/SJtntSuT1V8aeO9jQVt24NRzJcOYaJVDCbbstjYE
        Acr2pqaHbpWxeHUQ5tr7eR8=
X-Google-Smtp-Source: APXvYqzTFB3xQvG3qOHN4QSXivugPG4rbujh0U0wxIzPl/686U+JyvfO9nQKapdVrTbLL6gLTMM9UQ==
X-Received: by 2002:a65:534b:: with SMTP id w11mr38410973pgr.210.1557843342355;
        Tue, 14 May 2019 07:15:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id v66sm25015125pfa.38.2019.05.14.07.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 07:15:41 -0700 (PDT)
Date:   Tue, 14 May 2019 07:15:33 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Talel Shenhar <talel@amazon.com>
Subject: Re: linux-next: manual merge of the thermal-soc tree with Linus' tree
Message-ID: <20190514141531.GA16968@localhost.localdomain>
References: <20190513104928.0265b40f@canb.auug.org.au>
 <20190514034409.GA5691@localhost.localdomain>
 <20190514144006.60df13bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514144006.60df13bb@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Stephen,

On Tue, May 14, 2019 at 02:40:06PM +1000, Stephen Rothwell wrote:
> Hi Eduardo,
> 
> On Mon, 13 May 2019 20:44:11 -0700 Eduardo Valentin <edubezval@gmail.com> wrote:
> >
> > Thanks for spotting this. I am re-doing the branch based off v5.1-rc7,
> > where the last conflict went in with my current queue.
> 
> Its really not worth the rebase.  Just fix the build problem and send it
> all to Linus.

Yeah, I think I was not super clear in my first email. I am about to
send the content of my branch to Linus.  This specific conflict was
because a change in MAINTAINERS went in before the change I have in it,
causing a conflict there. The rebase is simply to make it easier for him
to pull when I send the git pull.

> 
> -- 
> Cheers,
> Stephen Rothwell


