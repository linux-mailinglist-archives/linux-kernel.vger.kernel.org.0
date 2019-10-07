Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A33CE453
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 15:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfJGNx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 09:53:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46785 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfJGNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:53:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so15372455wrv.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yxsh/Lv4D+WFB8R96TOGp0vYzuyEaxpVwqrNo94+pgs=;
        b=NTzek7tRyc335tjrYdUraoMvDBNzZtJlW0LjJhYfYFuLfbnXxIRiJVo+Lnq2xDDnat
         t2Ol3pdlc61NlhFCPw+kZwg+dBe2ZVhFK26bHHejI03Um++tcowPzmjJxlAOP7bBU8+1
         g2hVUr+2ryQqa7hcgooGrwJ4FSQK0mxlxTylWdOFLrt5uaL9YCVawy0xGh84yXGo00MD
         ReoyAZX8nNj5pI7AKIQOZqZfvVX5G/3saa6KPOrNdVuKl4D/SPtE3MrDfIcXR4JWIUDC
         Jwz5IWCORbn2sLH1VU09d3r9FgyetxJv1AzXNWBPdwj46EvZyVjbYEPfxdUmHEehDwR1
         4KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yxsh/Lv4D+WFB8R96TOGp0vYzuyEaxpVwqrNo94+pgs=;
        b=bDujtBITvd9JPFD60tUIwuIGbfAsSl0MUKaslBgpYoHKF+xc7qLU6AV4XMIhC7PwP/
         NCfvCMJsNmaCplhhyh/wBN3DaJ+Cw2ymMfj9jyAJImHBcY5CgXl9p1Qh3tAlFxdUNM/1
         plkGHtVYlwyCkme6vXfN1BZNwDPfLRyAa0KcqGHGurtB139WaUdQTqpoW/R1T6kQtr+2
         9RHeSZKRl8/E9+yT0yUN5GKsOLhbMLTzBuQ2zkkR+GFPx62HHN5OYfDkLi1GsJ6hiuKF
         o9CBuNTreWtpi7kn8RbsQn1RIPeue6CeUyyfA0hLfnxoyX/NAWFK6eju7LC9lYND2m5L
         15/A==
X-Gm-Message-State: APjAAAUm0jrnFR08ilAFDQz8mSoeF9tyccAShUnL2Lo//bnCKNGWY+mM
        AITrJ3utk5P7WKmg0lCNqq7xZd5O
X-Google-Smtp-Source: APXvYqwdLgmFGjFwBfbxzAZXskeqxiY/q2uQ1V2oNRJTWKIuZNW0Zn8mSknzPjEWdlb00hlNImmuOA==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr23824773wru.227.1570456434775;
        Mon, 07 Oct 2019 06:53:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i1sm25463055wmb.19.2019.10.07.06.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:53:54 -0700 (PDT)
Date:   Mon, 7 Oct 2019 15:53:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kexec breaks with 5.4 due to memzero_explicit
Message-ID: <20191007135352.GA13172@gmail.com>
References: <20191007030939.GB5270@rani.riverdale.lan>
 <28f3d204-47a2-8b4f-f6a7-11d73c2d87c8@redhat.com>
 <0f083019-61e8-7ed5-dde7-99e1aa363d9c@redhat.com>
 <20191007130942.GA82950@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007130942.GA82950@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Hans de Goede <hdegoede@redhat.com> wrote:
> 
> > Hi,
> > 
> > On 07-10-2019 10:50, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 07-10-2019 05:09, Arvind Sankar wrote:
> > > > Hi, arch/x86/purgatory/purgatory.ro has an undefined symbol
> > > > memzero_explicit. This has come from commit 906a4bb97f5d ("crypto:
> > > > sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
> > > > according to git bisect.
> > > 
> > > Hmm, it (obviously) does build for me and using kexec still also works
> > > for me.
> > > 
> > > But it seems that you are right and that this should not build, weird.
> > 
> > Ok, I understand now, it seems that the kernel will happily build with
> > undefined symbols in the purgatory and my kexec testing did not hit
> > the sha256 check path (*) so it did not crash. I can reproduce this before my patch:
> > 
> > [hans@shalem linux]$ ld arch/x86/purgatory/purgatory.ro
> > ld: warning: cannot find entry symbol _start; defaulting to 0000000000401000
> > ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
> > sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
> 
> I've applied your fix, but would it make sense to also integrate this 
> linker test in the regular build with a second patch, to make sure 
> something similar doesn't occur again?

Note that I delayed the v1 fix and will wait for your v2 fix instead.

Thanks,

	Ingo
