Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0FBE22A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 20:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389854AbfJWSnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 14:43:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35473 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJWSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:43:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so22211716lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 11:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ik1E3MEvEZSziI+iKa0yGe//Q0fMeFPrafPgekteUjI=;
        b=utNSMy9sMZtCeVIT91rkTSMc0qGjklgzwWr1fu48dn+qeTXT0G7ASGN0BPwlueUcEk
         ScUe63yVwJOK++LUYtRJIpKCiEA3+YW9CC65IPRQ4h7dCYjlVQ/x2ZNwSN+jXXWx9087
         tH42TIOqPq+yLxpxBN8zONMdo/nAb1CVNXHvvnHKuZPwTtTUrPzWA0vwIwgOKwwgzSXh
         O9d/TF6xD4Dc7oUESAaVxehfnOrhNcZOUzrzBVG4XfEraq2UIFBtoluFt8dTDn4cd0+q
         OpQfAXKVY8UkIZqPmvBJ3S/Tq8KcSuFXqcznCtfZTiw5HxxMlS3rUoA0sgkBGi7KwnwS
         KT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ik1E3MEvEZSziI+iKa0yGe//Q0fMeFPrafPgekteUjI=;
        b=F6JGCGVr7MVVCuyjTEyUGOIBoq9vzQrhfBqk7+LoPq2xt1S41Ip8UTakehPZrgBm10
         wHmCJHShfNZvb92Ej45w6IgBc8FeAYXcuVYZTLQL+1GWd/cLwLke1GpZ5ncmqsmq94m+
         twIeljM1lNJH/RfLyoXgUZQq2pJJmc1iSr7xZPQ3UeHHJcTdOWdvtoz73GjDQ02rGwa+
         qv++9JiZqGYlr2rysmftTKllKKechEPw2isxEbytZVMvbo/MHw0tJKLV9iCSImhUvvNa
         WwKhzw9ON6oemBF3My257+bLBRcIi1w3MZs1NxYREpDM8miqd49WOMPJjGE3t1q6GNU3
         t7Yg==
X-Gm-Message-State: APjAAAWSsMTEWw9APuwqXXsPbwGh3XN8dAJYKIuzovpPqr8hU63LyuhQ
        ZWNWIhGUbq7PdvSrwJpe9zx4FiUa
X-Google-Smtp-Source: APXvYqzz2G0VgawaCxiiPyHf9IAfT94XNVIjsDbWUffoNnW615HCW5ug3I/5Q+tUCpoTC3NfQPesoQ==
X-Received: by 2002:a2e:b52b:: with SMTP id z11mr6498271ljm.29.1571856217645;
        Wed, 23 Oct 2019 11:43:37 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id l24sm2542452lfc.53.2019.10.23.11.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 11:43:36 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 122F64610AC; Wed, 23 Oct 2019 21:43:36 +0300 (MSK)
Date:   Wed, 23 Oct 2019 21:43:36 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/dumpstack/64: Don't evaluate exception stacks before
 setup
Message-ID: <20191023184336.GL12121@uranus.lan>
References: <20191019114421.GK9698@uranus.lan>
 <20191022142325.GD12121@uranus.lan>
 <20191022145619.GE12121@uranus.lan>
 <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1910231533180.2308@nanos.tec.linutronix.de>
 <20191023135943.GK12121@uranus.lan>
 <alpine.DEB.2.21.1910231950590.1852@nanos.tec.linutronix.de>
 <20191023183140.GC2963@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023183140.GC2963@bombadil.infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:31:40AM -0700, Matthew Wilcox wrote:
> On Wed, Oct 23, 2019 at 08:05:49PM +0200, Thomas Gleixner wrote:
> > Prevent this by checking the validity of the cea_exception_stack base
> > address and bailing out if it is zero.
> 
> Could also initialise cea_exception_stack to -1?  That would lead to it
> being caught by ...
> 
> >  	end = begin + sizeof(struct cea_exception_stacks);
> >  	/* Bail if @stack is outside the exception stack area. */
> >  	if (stk < begin || stk >= end)
> 
> this existing check.

As to me this would be a hack and fragile :/ In turn the current explicit
test Thomas made is a way more readable.
